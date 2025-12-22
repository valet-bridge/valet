#!perl
use strict;
use warnings;

use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'unicode_strings';

use lib '.';

use Geography;

use Manual::SubLines;

my @SKIP_LIST = qw(BEHAVIOR CODE FLUFF MAGIC PICKY PRIVATE
  PROFILE SYSTEM UNDO);

my %SKIPS;
# $SKIPS{$_} = 1 for @SKIP_LIST;

# Work on CITY, COUNTRY, EMAIL_CITY, EMAIL_COUNTRY, EMAIL_REGION,
# EMAIL_UNIVERSITY, LOCALITY, REGION.

my %TAGS = (
  CITY  => 'CITY',
  COUNTRY  => 'COUNTRY',
  EMAIL_CITY => 'CITY',
  EMAIL_COUNTRY => 'COUNTRY',
  EMAIL_REGION => 'REGION',
  EMAIL_UNIVERSITY => 'UNIVERSITY',
  LOCALITY => 'LOCALITY',
  REGION => 'REGION'
);

if ($#ARGV < 0)
{
  die "Usage: perl ncoll.pl file";
}

# Get the binary file so really have the original in case of issues.
# This is duplicative code with reckon.pl, but never mind.

my $db_file = 'db';
my $data;
read_raw_file($db_file, \$data);

my @chunks = split /\x00+/, $data;
my %paragraphs;

raw_to_paragraphs(\@chunks, \%paragraphs);

my $sub_lines = Manual::SubLines->new();
$sub_lines->read_file('Manual/sub_lines.txt');


my (%bbodb, %stats);

my $file = shift;
read_file($file, \%bbodb, \%stats);

my %destroy_country;
read_destroy_file('Manual/destroy_country.txt', 
  \%destroy_country);

my %destroy_email_country;
read_destroy_file('Manual/destroy_email_country.txt', 
  \%destroy_email_country);

destroy(\%bbodb, \%destroy_country, 'COUNTRY');
destroy(\%bbodb, \%destroy_email_country, 'EMAIL_COUNTRY');

my %modify_hash;
read_modify_file('Manual/modify_tag.txt', 
  \%modify_hash);
modify(\%bbodb, \%modify_hash);

my %out_stats;
# write_file('temp_sort', \%bbodb, \%out_stats);
# write_particle_like('temp', \%bbodb, \%out_stats);

write_geo_file('temp', \%bbodb, \%paragraphs, \%out_stats);

print_stats('Inputs', \%stats);
print_stats('Outputs', \%out_stats);

exit;


sub read_file
{
  my ($fname, $bbodb, $stats) = @_;

  my ($handle, $instance);
  my $lno = 0;
  open(my $fh, "<", $fname) or die "Cannot open $fname $!";

  while (my $line = <$fh>)
  {
    $lno++;
    chomp $line;
    $line =~ s///g;

    if ($line =~ /^HANDLE (.+)$/)
    {
      $handle = $1;
      next;
    }
    elsif ($line =~ /^INSTANCE (\d+)$/)
    {
      $instance = $1;
      next;
    }
    elsif ($line eq '')
    {
      $handle = '';
      $instance = '';
      next;
    }

    my ($tag, $value);
    if ($line =~ /^([A-Z_]+) (.*)$/)
    {
      ($tag, $value) = ($1, $2);
    }
    else
    {
      die "Line $lno: $line";
    }

    next if exists $SKIPS{$tag};

    if ($tag =~ /^NAME_/)
    {
      my $anchor = \%{$bbodb->{$handle}[$instance]{NAME}};
      my $pos = 1 + $#{$anchor->{LIST}};

      push @{$anchor->{HASH}{$tag}}, $value;

      $anchor->{LIST}[$pos]{TAG} = $tag;
      $anchor->{LIST}[$pos]{VALUE} = $value;
    }
    else
    {
      push @{$bbodb->{$handle}[$instance]{$tag}}, $value;
    }
    $stats{$tag}++;
  }

  close $fh;
}


sub read_destroy_file
{
  my ($fname, $hash) = @_;

  my $lno = 0;
  open(my $fh, "<", $fname) or die "Cannot open $fname $!";

  while (my $line = <$fh>)
  {
    $lno++;
    chomp $line;
    $line =~ s///g;

    my @a = split /, /, $line;
    die "$lno: $line" unless ($#a == 2 && $a[1] =~ /^\d+$/);

    $hash->{$a[0]}{$a[1]} = $a[2];
  }

  close $fh;
}


sub destroy
{
  my ($bbodb, $hash, $tag) = @_;

  for my $handle (sort keys %$hash)
  {
    die "No $handle in bbodb" unless exists $bbodb->{$handle};

    for my $instance (sort keys %{$hash->{$handle}})
    {
      die "No instance $instance of $handle in bbodb" 
        unless exists $bbodb->{$handle}[$instance];

      if (! exists $bbodb->{$handle}[$instance]{$tag})
      {
        my %stats;
        print str_instance($bbodb->{$handle}[$instance], \%stats);
        warn "No tag $tag in $handle, $instance in bbodb";
      }

      my $value = $hash->{$handle}{$instance};

      my $removed = 
        grep {$_ eq $value} @{$bbodb->{$handle}[$instance]{$tag}};
        
      @{$bbodb->{$handle}[$instance]{$tag}} =
        grep {$_ ne $value} @{$bbodb->{$handle}[$instance]{$tag}};
      
      if ($removed == 0)
      {
        my %stats;
        print str_instance($bbodb->{$handle}[$instance], \%stats);
        warn "Tag $tag in $handle, $instance in bbodb: No $value";
      }
    }
  }
}


sub read_modify_file
{
  my ($fname, $hash) = @_;

  my $lno = 0;
  open(my $fh, "<", $fname) or die "Cannot open $fname $!";

  while (my $line = <$fh>)
  {
    $lno++;
    chomp $line;
    $line =~ s///g;

    my @a = split /, /, $line;
    die "$lno: $line" unless ($#a == 4 && $a[1] =~ /^\d+$/);

    $hash->{$a[0]}{$a[1]}{$a[2]} = 
      { TAG => $a[4], VALUE => $a[3] };
  }

  close $fh;
}


sub modify
{
  my ($bbodb, $hash) = @_;

  for my $handle (sort keys %$hash)
  {
    die "No $handle in bbodb" unless exists $bbodb->{$handle};

    for my $instance (sort keys %{$hash->{$handle}})
    {
      die "No instance $instance of $handle in bbodb" 
        unless exists $bbodb->{$handle}[$instance];

      for my $tag (sort keys %{$hash->{$handle}{$instance}})
      {
        if (! exists $bbodb->{$handle}[$instance]{$tag})
        {
          my %stats;
          print str_instance($bbodb->{$handle}[$instance], \%stats);
          warn "No tag $tag in $handle, $instance in bbodb";
        }

        my $value = $hash->{$handle}{$instance}{$tag}{VALUE};
        my $new_tag = $hash->{$handle}{$instance}{$tag}{TAG};

        my $removed = 
          grep {$_ eq $value} @{$bbodb->{$handle}[$instance]{$tag}};
        
        @{$bbodb->{$handle}[$instance]{$tag}} =
          grep {$_ ne $value} @{$bbodb->{$handle}[$instance]{$tag}};

        if ($#{$bbodb->{$handle}[$instance]{$tag}} < 0)
        {
          delete $bbodb->{$handle}[$instance]{$tag};
        }
      
        if ($removed == 0)
        {
          my %stats;
          print str_instance($bbodb->{$handle}[$instance], \%stats);
          warn "Tag $tag in $handle, $instance in bbodb: No $value";
        }

        push @{$bbodb->{$handle}[$instance]{$new_tag}}, $value;
      }
    }
  }
}


sub str_instance
{
  my ($hash, $stats) = @_;
  my $str = '';

  for my $key (sort keys %$hash)
  {
    if ($key ne 'NAME')
    {
      for my $v (@{$hash->{$key}})
      {
        $str .= "$key $v\n";
        $stats->{$key}++;
      }
    }
    else
    {
      my $list = \@{$hash->{NAME}{LIST}};
      for my $i (0 .. $#$list)
      {
        $str .= $list->[$i]{TAG} . ' ' . $list->[$i]{VALUE} . "\n";
        $stats->{$list->[$i]{TAG}}++;
      }
    }
  }

  return $str;
}


sub write_file
{
  my ($fname, $bbodb, $stats) = @_;

  open(my $fh, ">", $fname) or die "Cannot open $fname $!";

  for my $handle (sort keys %$bbodb)
  {
    for my $instance (1 .. $#{$bbodb->{$handle}})
    {
      print $fh "HANDLE $handle\n";
      print $fh "INSTANCE $instance\n";
      print $fh str_instance($bbodb->{$handle}[$instance]);
      print $fh "\n";
    }
  }
  close $fh;
}


sub str_db
{
  my ($orig_db, $handle, $instance) = @_;

  my $s = "ORIGINAL DB:\n\n";
  my $lno = 0;
  my $subs = '';
  for my $line (@{$orig_db->{$handle}[$instance]})
  {
    if (my $replace = $sub_lines->lookup($handle, $instance, $lno,
      $line))
    {
      $subs .= "$lno:\n$line\n$replace\n\n";
      
    }
    $s .= "$lno: $line\n";
    $lno++;
  }

  $s .= "\n" . $subs;

  return $s;
}


sub write_geo_file
{
  my ($fname, $bbodb, $orig_db, $stats) = @_;

  open(my $fh, ">", $fname) or die "Cannot open $fname $!";

  for my $handle (sort keys %$bbodb)
  {
    my $geo = Geography->new();

    for my $instance ( 0 .. $#{$bbodb->{$handle}})
    {
      next if (! exists $bbodb->{$handle}[$instance]);

      # my $geo = Geography->new();
      my $conflicts = '';
      for my $key (keys %{$bbodb->{$handle}[$instance]})
      {
        next if $key eq 'NAME';
        next unless exists $TAGS{$key};

        my $flag = 0;
        for my $v (@{$bbodb->{$handle}[$instance]{$key}})
        {
          if (! $geo->add($key, $v))
          {
            $flag = 1;
            last;
          }
        }
        
        if ($flag)
        {
          $conflicts .= "CONFLICT $key\n";
        }
        else
        {
          delete $bbodb->{$handle}[$instance]{$key};
        }
      }

      next if $conflicts eq '';

      my $identifier = "HANDLE $handle\nINSTANCE $instance\n";
      print $fh $identifier;
      print $fh $conflicts;

      print $fh str_instance($bbodb->{$handle}[$instance], $stats);

      my %hash;
      $geo->set_hash(\%hash);
      print $fh str_instance(\%hash, $stats);

      print $fh "\n";

      my $draft = "$handle, $instance, \n\n";

      print $fh str_db($orig_db, $handle, $instance), 
        $draft, '-' x 40, "\n\n";
    }
  }
  close $fh;
}


sub print_stats
{
  my ($text, $stats) = @_;

  print "\n$text\n\n";
  my $sum = 0;
  for my $key (sort keys %stats)
  {
    printf "%-16s %8d\n", $key, $stats{$key};
    $sum += $stats{$key};
  }
  print '-' x 25, "\n";
  printf "%-16s %8d\n", '', $sum;

}


sub read_raw_file
{
  my ($file, $data) = @_;

  open(my $fh, "<:raw", $file) or die "Cannot open $file$!";
  local $/;
  $$data = <$fh>;
  close $fh;
}


sub raw_to_paragraphs
{
  my ($chunks, $paragraphs) = @_;

  my %hcount;
  for my $cno (0 .. $#chunks)
  {
    if ($chunks[$cno] =~ /^P([A-Z0-9 _]+)$/)
    {
      my $handle = $1;
      if ($handle =~ /^ZZZZ_\d+$/)
      {
        # Skipping anonymous handle.
        $cno++;
        next;
      }

      if (exists $hcount{$handle})
      {
        $hcount{$handle}++;
      }
      else
      {
        $hcount{$handle} = 1;
      }
      my $instance = $hcount{$handle};

      for my $line (split /[\x00-\x1F]+/, $chunks[$cno+1])
      {
        next if $line =~ /^\s+$/;

        $line =~ s/^\s+//;
        $line =~ s/\s+$//;
        $line =~ s/\s{2,}/ /g;
        $line =~ s/^[!\-+:;'"@?\(\)\{\}\[\]<>*.,=#%&\/\$]+\s*//;
        $line =~ s/\s*[!\-+:;'"@?\(\)\{\}*.,=#%&\/\$]+$//;

        next if length($line) == 0;
        next if $line =~ /^[!_\-+:\(\)*.,=%\/\$'"@?#x\s]+$/;

        push @{$paragraphs{$handle}[$instance]}, $line;
      }
    }
  }
}
 
