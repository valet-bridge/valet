#!perl

package WholeBBO2;

# Effectively the same as Whole, but with different TAGS.

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '../../bbo';
use lib '.';
use lib './Swords';

use Swords::Denominations;
use Swords::Ranks;
use Swords::RanksFRA;
use Swords::RanksGER;
use Swords::Strengths;
use Swords::StrengthsFRA;
use Swords::StrengthsGER;
use Swords::Shapes;
use Swords::Lengths;
use Swords::LengthsFRA;
use Swords::LengthsGER;

use Swords::Bases;
use Swords::Openings;
use Swords::Constructive;
use Swords::Competitive;
use Swords::Bergen;
use Swords::Blackwood;
use Swords::Misc;
use Swords::Keycard;
use Swords::Stayman;
use Swords::Carding;


my %TAGS =
(
  DENOMINATIONS => \&Swords::Denominations::set_hashes,

  RANKS => \&Swords::Ranks::set_hashes,
  RANKS_FRA => \&Swords::RanksFRA::set_hashes,
  RANKS_GER => \&Swords::RanksGER::set_hashes,

  STRENGTHS => \&Swords::Strengths::set_hashes,
  STRENGTHS_FRA => \&Swords::StrengthsFRA::set_hashes,
  STRENGTHS_GER => \&Swords::StrengthsGER::set_hashes,

  SHAPES => \&Swords::Shapes::set_hashes,

  LENGTHS => \&Swords::Lengths::set_hashes,
  LENGTHS_FRA => \&Swords::LengthsFRA::set_hashes,
  LENGTHS_GER => \&Swords::LengthsGER::set_hashes,

  BASES => \&Swords::Bases::set_hashes,
  OPENINGS => \&Swords::Openings::set_hashes,
  CONSTRUCTIVE => \&Swords::Constructive::set_hashes,
  COMPETITIVE => \&Swords::Competitive::set_hashes,
  BERGEN => \&Swords::Bergen::set_hashes,
  BLACKWOOD => \&Swords::Blackwood::set_hashes,
  MISC => \&Swords::Misc::set_hashes,
  KEYCARD => \&Swords::Keycard::set_hashes,
  STAYMAN => \&Swords::Stayman::set_hashes,
  CARDING => \&Swords::Carding::set_hashes,
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub set_overall_hashes
{
  my ($self,
    $multi_words, $multi_typos, $single_words, $single_typos, $key) = @_;

  # The words themselves.
  for my $multi (@$multi_words)
  {
    # my $tilded = $multi =~ s/ /\~/gr;
    $self->{MWORDS}{$key}{lc($multi)} = $multi;
    $self->{SWORDS}{$key}{lc($multi)} = 
      { CATEGORY => $key, VALUE => $multi };
  }

  # Any typos.
  for my $multi (keys %$multi_typos)
  {
    # my $tilded = $multi =~ s/ /\~/gr;
    for my $typo (@{$multi_typos->{$multi}})
    {
      $self->{MWORDS}{$key}{lc($typo)} = $multi;
      $self->{SWORDS}{$key}{lc($multi)} = 
        { CATEGORY => $key, VALUE => $multi };
    }
  }

  if (keys %{$self->{MWORDS}{$key}})
  {
    my $multi_pattern_direct = join('|', map { quotemeta }
      sort { length($b) <=> length($a) } keys %{$self->{MWORDS}{$key}});

    $self->{MREGEX}{$key} = 
      qr/(?<!\p{L})($multi_pattern_direct)(?=\P{L}|\z)/i;
  }
  else
  {
    $self->{MREGEX}{$key} = '';
  }

  # Similarly for the single words.
  for my $single (@$single_words)
  {
    $self->{SWORDS}{$key}{lc($single)} = 
      { CATEGORY => $key, VALUE => $single };
  }

  for my $single (keys %$single_typos)
  {
    for my $typo (@{$single_typos->{$single}})
    {
      $self->{SWORDS}{$key}{lc($typo)} = 
        { CATEGORY => $key, VALUE => $single };
    }
  }
}


sub init_hashes
{
  my ($self) = @_;
  my $callback_method = sub { $self->set_overall_hashes(@_); };

  while (my ($key, $set_method) = each %TAGS)
  {
    $set_method->($callback_method, $key);
  }
}


sub set_matrix_link
{
  # 'to' might be TEAM_COUNTRY, 'from' might be TEAM_REGION.
  my ($self, $link, $to, $from) = @_;

  my $mlink = \%{$self->{MATRIX}{$from}{$to}};
  for my $key (keys %$link)
  {
    for my $entry (@{$link->{$key}})
    {
      $mlink->{lc($entry)} = $key;
    }
  }
}


sub get_matrix_element
{
  my ($self, $from, $to, $value) = @_;
  # 'to' might be 'NATIONALITY', 'from' might be 'COUNTRY'.
  # 'value' would be a possible nationality.
  return $self->{MATRIX}{$from}{$to}{$value} // '';
}


sub check_consistency_scalar
{
  my ($self, $tag_from, $tag_to, $value_from, $value_to, $errstr) = @_;

  return unless defined $value_from;
  return unless defined $value_to;

  my $c = $self->{MATRIX}{$tag_from}{$tag_to}{lc($value_from)};
  if (! defined $c)
  {
    print "$errstr: ",
      "($value_from, $value_to) not in matrix ($tag_from, $tag_to)\n";
  }
  elsif ($c eq $value_to)
  {
    return;
  }
  elsif ($tag_from eq 'CLUB' && $tag_to eq 'CITY' && $c =~ /-Pan$/)
  {
    # Special case.
    return;
  }
  else
  {
    print "$$errstr: $value_to vs lookup $c for ($tag_from, $tag_to)\n";
  }
}


sub matrix_pair_is_in_tags
{
  my ($self, $m_from, $m_to) = @_;

  # Example: (m_from, m_to) = (REGION, COUNTRY).
  # Check that the country we look up is really a country.

  for my $value_from (sort keys %{$self->{MATRIX}{$m_from}{$m_to}})
  {
    my $lcv = lc($value_from);
    if (! exists $self->{SWORDS}{$m_from}{$lcv} &&
        ! exists $self->{MWORDS}{$m_from}{$lcv})
    {
      print "($m_from, $m_to): $value_from is not in Tags ($m_from).\n";
    }

    my $c = $self->{MATRIX}{$m_from}{$m_to}{$lcv};

    if (! exists $self->{SWORDS}{$m_to}{lc($c)} &&
        ! exists $self->{MWORDS}{$m_to}{lc($c)})
    {
      print "($m_from, $m_to): $c (from $value_from) is not in Tags ($m_to).\n";
    }
  }
}


sub tag_is_in_matrix
{
  my ($self, $t_from, $t_to) = @_;

  # Example: (m_from, m_to) = (REGION, COUNTRY).
  # Check that every region in Tags is also in the matrix.

  for my $value (sort keys %{$self->{MWORDS}{$t_from}})
  {
    my $cval = lc($self->{MWORDS}{$t_from}{lc($value)});
    if (! exists $self->{MATRIX}{$t_from}{$t_to}{$cval})
    {
      print "($t_from, $t_to): Mwords $cval not in matrix.\n"
       unless $cval =~ /-pan$/;
    }
  }

  for my $value (sort keys %{$self->{SWORDS}{$t_from}})
  {
    my $cval = lc($self->{SWORDS}{$t_from}{lc($value)}{VALUE});
    if (! exists $self->{MATRIX}{$t_from}{$t_to}{$cval})
    {
      print "($t_from, $t_to): Swords $cval not in matrix.\n"
       unless $cval =~ /-pan$/;
    }
  }
}


sub check_static_consistency
{
  my ($self) = @_;

  $self->matrix_pair_is_in_tags('REGION', 'COUNTRY');
  $self->matrix_pair_is_in_tags('CITY', 'COUNTRY');
  $self->matrix_pair_is_in_tags('SPONSOR', 'COUNTRY');
  $self->matrix_pair_is_in_tags('NATIONALITY', 'COUNTRY');

  $self->matrix_pair_is_in_tags('LOCALITY', 'CITY');
  $self->matrix_pair_is_in_tags('UNIVERSITY', 'CITY');
  $self->matrix_pair_is_in_tags('CLUB', 'CITY');

  $self->tag_is_in_matrix('REGION', 'COUNTRY');
  $self->tag_is_in_matrix('CITY', 'COUNTRY');
  $self->tag_is_in_matrix('SPONSOR', 'COUNTRY');
  $self->tag_is_in_matrix('NATIONALITY', 'COUNTRY');

  $self->tag_is_in_matrix('LOCALITY', 'CITY');
  $self->tag_is_in_matrix('UNIVERSITY', 'CITY');
  $self->tag_is_in_matrix('CLUB', 'CITY');
}


sub get_single
{
  my ($self, $tag, $part) = @_;

  my $res = $self->{SWORDS}{$tag}{$part};

  if (exists $res->{CATEGORY})
  {
    $self->{HITS}{$tag}{$part}++;
    $self->{HITS}{$tag}{lc($res->{VALUE})}++;
  }

  return $res;
}


sub get_multi
{
  my ($self, $tag, $part) = @_;

  my $res = $self->{MWORDS}{$tag}{$part};

  if (defined $res)
  {
    $self->{HITS}{$tag}{$part}++;
    $self->{HITS}{$tag}{lc($res)}++;
  }

  return $res;
}


sub get_multi_regex
{
  my ($self, $tag) = @_;
  return $self->{MREGEX}{$tag};
}


sub sorted_swords
{
  my ($self, $tag) = @_;
  return sort keys %{$self->{SWORDS}{$tag}};
}


sub sorted_mwords
{
  my ($self, $tag) = @_;
  return sort keys %{$self->{MWORDS}{$tag}};
}


sub print_misses
{
  my ($self) = @_;

  print "Multi-word unused:\n\n";
  for my $tag (sort keys %{$self->{MWORDS}})
  {
    next if $tag eq 'ORGANIZATION'; # Unused on purpose
    for my $value ($self->sorted_mwords($tag))
    {
      next if exists $self->{HITS}{$tag}{lc($value)};
      my $found = 0;
      for my $tag2 (sort keys %{$self->{MATRIX}{$tag}})
      {
        if (exists $self->{MATRIX}{$tag}{$tag2}{lc($value)})
        {
          $found = 1;
          last;
        }
      }
      print "$tag: $value\n" unless $found;
    }
  }

  print "\nSingle-word unused:\n\n";
  for my $tag (sort keys %{$self->{SWORDS}})
  {
    next if $tag eq 'ORGANIZATION'; # Unused on purpose
    for my $value ($self->sorted_swords($tag))
    {
      next if exists $self->{HITS}{$tag}{lc($value)};
      my $found = 0;
      for my $tag2 (sort keys %{$self->{MATRIX}{$tag}})
      {
        if (exists $self->{MATRIX}{$tag}{$tag2}{lc($value)})
        {
          $found = 1;
          last;
        }
      }
      print "$tag: $value\n" unless $found;
    }
  }
  print "\n";
}


1;
