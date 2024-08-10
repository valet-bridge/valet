#!perl

package Chain;

use v5.10;
use strict;
use warnings;
use Exporter;

# A Chain consists of:
# - LIST of Token's
# - STATUS: OPEN, COMPLETE or KILLED
# - LAST: Number of the last token (for convenience)
# - PRECURSOR: If present, a token that must be a SEPARATOR.
# - SENTINEL: If present, a token that must be a SEPARATOR.

sub new
{
  my $class = shift;
  my $self = bless {LAST => -1, STATUS => 'COMPLETE'}, $class;
  return $self;
}


sub append
{
  my ($self, $token) = @_;
  push @{$self->{LIST}}, $token;
  $self->{LAST} = $#{$self->{LIST}};
  $self->{STATUS} = 'OPEN';
}


sub append_general
{
  my ($self, $category, $tag, $value, $text, $pos) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  $token->set_general($category, $tag, $value);
  $self->append($token);
}


sub append_separator
{
  my ($self, $value, $text, $pos) = @_;

  my $token = Token->new();
  $token->set_origin($pos, $text);
  if (! Separators::set_token($value, $token))
  {
    die "Not really a separator";
  }
  $self->append($token);
}


sub insert_at
{
  my ($self, $index, $token) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST}+1;
  if ($index > $self->{LAST})
  {
    $self->append($token);
  }
  else
  {
    splice @{$self->{LIST}}, $index, 0, $token;
  }
  $self->{LAST} = $#{$self->{LIST}};
  $self->{STATUS} = 'OPEN';
}


sub check_out
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST};
  return $self->{LIST}[$index];
}


sub swap
{
  my ($self, $index1, $index2) = @_;
  die "Index $index1 out of bounds" unless $index1 <= $self->{LAST};
  die "Index $index2 out of bounds" unless $index2 <= $self->{LAST};
  my $tmp = $self->{LIST}[$index1];
  $self->{LIST}[$index1] = $self->{LIST}[$index2];
  $self->{LIST}[$index2] = $tmp;
}


sub collapse_elements
{
  my ($self, $first, $last) = @_;

  for my $index ($first+1 .. $last)
  {
    $self->{LIST}[$first]->merge_origin($self->{LIST}[$index]);
  }
}


sub find_first_separator_run
{
  my ($self, $first_ref, $last_ref) = @_;

  for my $index ($$first_ref .. $self->{LAST}-1)
  {
    next unless $self->{LIST}[$index]->category() eq 'SEPARATOR';
    next unless $self->{LIST}[$index+1]->category() eq 'SEPARATOR';

    $$first_ref = $index;

    $index += 2;
    while ($index <= $self->{LAST} &&
      $self->{LIST}[$index]->category() eq 'SEPARATOR')
    {
      $index++;
    }

    $$last_ref = ($index > $self->{LAST} ? $self->{LAST} : $index-1);

    return 1;
  }

  return 0;
}


sub find_next_non_separator
{
  my ($self, $index) = @_;

  while ($index <= $self->{LAST} && 
      $self->{LIST}[$index]->category() eq 'SEPARATOR')
  {
    $index++;
  }

  return $index; # May be > $self->{LAST}
}


sub clean_separators
{
  my ($self) = @_;

  # This is not super-efficient, but it seems easier than trying to
  # keep track of the numbering.  We merge runs of separators into
  # one.  There could still be separators at the beginning or end
  # of the chain.  There are no bindings or sentinels yet.
  
  return unless $self->{LAST} >= 0;

  my ($first, $last);
  $first = 0;

  while (1)
  {
    last unless $self->find_first_separator_run(\$first, \$last);

    $self->collapse_elements($first, $last);
    splice(@{$self->{LIST}}, $first+1, $last-$first);
    $self->{LAST} = $#{$self->{LIST}};
    $first++;
  }

  # Don't start with a separator.
  if ($self->{LIST}[0]->category() eq 'SEPARATOR')
  {
    $self->{PRECURSOR} = $self->{LIST}[0];
    splice(@{$self->{LIST}}, 0, 1);
    $self->{LAST} = $#{$self->{LIST}};
    $self->{STATUS} = 'COMPLETE' if ($self->{LAST} == -1);
  }

  # Don't end with a separator.
  $last =$self->{LAST};
  return if $last == -1;

  if ($self->{LIST}[$last]->category() eq 'SEPARATOR')
  {
    $self->{SENTINEL} = $self->{LIST}[$last];
    splice(@{$self->{LIST}}, $last);
    $self->{LAST} = $#{$self->{LIST}};
    $self->{STATUS} = 'COMPLETE' if ($self->{LAST} == -1);
  }
}


sub status
{
  my ($self) = @_;
  return $self->{STATUS};
}


sub complete_if_last_is
{
  my ($self, $last, $status) = @_;
  $self->{STATUS} = $status if $self->{LAST} == $last;
}


sub complete
{
  my ($self, $status) = @_;
  $self->{STATUS} = $status;
}


sub category
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST};
  return $self->{LIST}[$index]->category();
}


sub field
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST};
  return $self->{LIST}[$index]->field();
}


sub value
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST};
  return $self->{LIST}[$index]->value();
}


sub text
{
  my($self) = @_;
  return join('|', map { $_->text() } @{$self->{LIST}});
}


sub catcat
{
  my($self) = @_;
  return join('|', map { $_->category() } @{$self->{LIST}});
}


sub fields
{
  my($self) = @_;
  return join('|', map { $_->field() } @{$self->{LIST}});
}


sub last
{
  my ($self) = @_;
  return $self->{LAST};
}


sub copy_from
{
  my ($self, $index, $chain2) = @_;

  # The new chain gets the tokens from index on.

  @{$chain2->{LIST}} = @{$self->{LIST}}[$index .. $self->{LAST}];
  $chain2->{LAST} = $#{$chain2->{LIST}};
  $chain2->{STATUS} = 'OPEN';

  if (exists $self->{SENTINEL})
  {
    $chain2->{SENTINEL} = $self->{SENTINEL};
    delete $self->{SENTINEL};
    return;
  }

  my $last = $chain2->{LAST};
  if ($chain2->{LIST}[$last]->category() eq 'SEPARATOR')
  {
    $chain2->{SENTINEL} = $chain2->{LIST}[$last];
    splice( @{$chain2->{LIST}}, $last);
    $chain2->{LAST}--;
  }
}


sub truncate_before
{
  my ($self, $index) = @_;

  # The old chain gets truncated one before the index.

  my $last = $self->{LIST}[$index-1];
  die "Not a separator" unless $last->category() eq 'SEPARATOR';

  $self->{SENTINEL} = $last;

  splice @{$self->{LIST}}, $index-1, $self->{LAST};
  $self->{LAST} = $index-2;
}


sub split_on
{
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST};
  die "Splitting on front" if $index == 0;

  die "Splitting on a separator" 
    if $self->{LIST}[$index]->category() eq 'SEPARATOR';

  my $chain2 = Chain->new();

  $self->copy_from($index, $chain2);
  $self->truncate_before($index);

  return $chain2;
}


sub truncate_directly_before
{
  my ($self, $index) = @_;

  # The old chain gets truncated one before the index.

  splice @{$self->{LIST}}, $index, $self->{LAST};
  $self->{LAST} = $index-1;
}


sub split_directly_on
{
  # Without separators.
  my ($self, $index) = @_;
  die "Index $index out of bounds" unless $index <= $self->{LAST};
  die "Splitting on front" if $index == 0;

  my $chain2 = Chain->new();

  $self->copy_from($index, $chain2);
  $self->truncate_directly_before($index);

  return $chain2;
}


sub kill_on
{
  my ($self, $index) = @_;

  # Returns a new chain, or possibly undef.

  if ($index <= 1)
  {
    $self->{STATUS} = 'KILLED';

    my $nonsep = $self->find_next_non_separator($index+1);
    if ($nonsep > $self->{LAST})
    {
      # A single KILL and perhaps some separators.
      return undef;
    }
    else
    {
      return $self->split_on($nonsep);
    }
  }
  else
  {
    return $self->split_on($index);
  }
}


sub delete
{
  my ($self, $first, $last) = @_;
  die "Last $last out of bounds" if $last > $self->{LAST};
  die "Bad order" if $first > $last;

  splice(@{$self->{LIST}}, $first, $last-$first+1);
  $self->{LAST} = $#{$self->{LIST}};
  $self->{STATUS} = 'OPEN';
}


sub index_match
{
  my ($self, $pattern, $plen, $index) = @_;

  for my $p (0 .. $plen)
  {
    return 0 unless 
      $self->{LIST}[$index+$p]->match($pattern->[$p]);
  }
  return 1;
}


sub match
{
  my ($self, $pattern, $anchor) = @_;

  # Returns -1 if no match, otherwise the index of the first match.

  my $plen = $#$pattern;

  if ($anchor eq 'ANY')
  {
    my $index = 0;
    while ($index + $plen <= $self->{LAST})
    {
      return $index if $self->index_match($pattern, $plen, $index);
      $index++;
    }
  }
  elsif ($anchor eq 'BEGIN')
  {
    if ($plen <= $self->{LAST})
    {
      return 0 if $self->index_match($pattern, $plen, 0);
    }
  }
  elsif ($anchor eq 'END')
  {
    if ($plen <= $self->{LAST})
    {
      my $index = $self->{LAST} - $plen;
      return $index if $self->index_match($pattern, $plen, $index);
    }
  }
  elsif ($anchor eq 'EXACT')
  {
    if ($plen == $self->{LAST})
    {
      return 0 if $self->index_match($pattern, $plen, 0);
    }
  }

  return -1;
}


sub print
{
  my ($self, $prefix) = @_;

  my $status = $self->status();
  return if $status eq 'KILLED';

  my $l = $self->last();
  return if $l == -1;

  if ($status eq 'OPEN')
  {
    print "OPENCHAIN ", $l+1, ": $prefix\n";
  }
  elsif ($status eq 'COMPLETE' && $prefix =~ /^EVENT/)
  {
    print "COMPLETE_CHAIN ", $l+1, ": $prefix, ",
      $self->check_out(0)->str(0, $prefix), "\n";
  }

  for my $i (0 .. $l)
  {
    my $token = $self->check_out($i);
    print $token->str(0, $prefix) unless
      $token->category() eq 'SEPARATOR';
  }

}


1;
