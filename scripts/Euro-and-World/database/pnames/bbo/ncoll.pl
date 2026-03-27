#!perl
use strict;
use warnings;

use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use feature 'unicode_strings';

use lib '.';

use Geography;
use NameList;

my $geo_flag = 0;
my $namelist_flag = 0;
my $consolidate_flag = 1;

use Manual::SubLines;

# File of tags to delete, typically USER_ tags that aren't names.
my $POST_DESTROY = 'Manual/post_destroy.txt';

# File of tags to substitute, typically USER_ tags that are names.
my $POST_SUBSTITUTE = 'Manual/post_substitute.txt';

my @SKIP_LIST = qw(BEHAVIOR CODE DELETE FLUFF MAGIC PICKY PRIVATE
  PROFILE SYSTEM UNDO USER_NUMERICAL);

my %SKIPS;
$SKIPS{$_} = 1 for @SKIP_LIST;

# Work on CITY, COUNTRY, EMAIL_CITY, EMAIL_COUNTRY, EMAIL_REGION,
# EMAIL_UNIVERSITY, LOCALITY, REGION.

my %GEO_TAGS = (
  CITY  => 'CITY',
  COUNTRY  => 'COUNTRY',
  EMAIL_CITY => 'CITY',
  EMAIL_COUNTRY => 'COUNTRY',
  EMAIL_REGION => 'REGION',
  EMAIL_UNIVERSITY => 'UNIVERSITY',
  LOCALITY => 'LOCALITY',
  REGION => 'REGION'
);

my %NAMELIST_TAGS = (
  NAME_FIRST => 'NAME_FIRST',
  NAME_INITIAL => 'NAME_INITIAL',
  NAME_LAST => 'NAME_LAST',
  NAME_NICK => 'NAME_NICK',
  NAME_PARTICLE => 'NAME_PARTICLE'
);

my %IGNORE_SMALL = (
  CODE => 1,
  MAGIC => 1,
  PRIVATE => 1,
  SYSTEM => 1
);

my %PERMITTED_POST_SUBS_HASH = (
  USER_TITLE => 1,
  USER_ONE => 1,
  USER_FIRST => 1,
  USER_INITIALS => 1,
  USER_PARTICLES => 1,
  USER_TWO => 1,
  USER_LAST => 1,
  USER_UNPARSEABLE => 1
);

my @PERMITTED_POST_SUBS_LIST = qw(
  USER_TITLE USER_ONE USER_INITIALS USER_PARTICLES USER_TWO);

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


# ----- Instance-specific modification -----

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


# ----- Higher-level modification -----

my %post_destroy_hash;
read_post_destroy($POST_DESTROY, \%post_destroy_hash);

remap_post_destroy(\%bbodb, \%post_destroy_hash);

my %post_sub_hash;
read_post_substitute($POST_SUBSTITUTE, \%post_sub_hash);

remap_post_substitute(\%bbodb, \%post_sub_hash);



my %out_stats;
# write_file('temp_sort', \%bbodb, \%out_stats);
# write_particle_like('temp', \%bbodb, \%out_stats);

if ($geo_flag)
{
  write_geo_file('geotemp', \%bbodb, \%paragraphs, \%out_stats);
}

if ($namelist_flag)
{
  write_namelist_file('nltemp', \%bbodb, \%paragraphs, \%out_stats);
}

if ($consolidate_flag)
{
  write_consol_file('consol.txt', \%bbodb, \%paragraphs, \%out_stats);
}

print_stats('Inputs', \%stats);
print_stats('Outputs', \%out_stats);

exit;


sub append_to_name
{
  my ($bbodb, $handle, $instance, $tag, $value) = @_;

  my $anchor = \@{$bbodb->{$handle}[$instance]{NAME}};
  my $pos = 1 + $#$anchor;

  $anchor->[$pos]{TAG} = $tag;
  $anchor->[$pos]{VALUE} = $value;
}


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
      append_to_name($bbodb, $handle, $instance, $tag, $value);
      # my $anchor = \@{$bbodb->{$handle}[$instance]{NAME}};
      # my $pos = 1 + $#$anchor;

      # $anchor->[$pos]{TAG} = $tag;
      # $anchor->[$pos]{VALUE} = $value;
    }
    else
    {
      push @{$bbodb->{$handle}[$instance]{$tag}}, $value;
    }
if ($tag eq 'FLUFF')
{
  print "HERE\n";
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


sub normalize
{
  my ($tag, $text) = @_;

  if ($tag eq 'NAME_FIRST')
  {
    $text =~ s/^(\p{L})(.*)$/\u$1\L$2/;
    return $text;
  }
  elsif ($tag eq 'NAME_INITIALS')
  {
    my @a = split /\s+/, $text;
    my $res = '';
    for my $i (0 .. $#a)
    {
      my $v = $a[$i];
      $v =~ s/\.$//;
      if (length($v) != 1)
      {
        die "$v: " . length($v);
      }
      if ($i == $#a)
      {
        $res .= uc($v) . '.';
      }
      else
      {
        $res .= uc($v) . '. '
      }
    }
    return $res;
  }
  elsif ($tag eq 'NAME_PARTICLES' || $tag eq 'NAME_LAST')
  {
    $text = uc($text);
    $text =~ s/^MC/Mc/g;
    return $text;
  }
  elsif ($tag eq 'NAME_TITLE')
  {
    if ($text eq 'Dr.')
    {
      return $text;
    }
    else
    {
      die "$tag, $text";
    }
  }
  else
  {
    die "$tag, $text";
  }
}


sub read_post_destroy
{
  my ($fname, $hash) = @_;

  my $lno = 0;
  open(my $fh, "<", $fname) or die "Cannot open $fname $!";

  my $handle = '';
  my $state = 0; # Looking for handle

  while (my $line = <$fh>)
  {
    $lno++;
    chomp $line;
    $line =~ s///g;

    if ($line =~ /^HANDLE (.*)$/)
    {
      die "HANDLE timing" unless $state == 0;
      $handle = $1;
      $state = 1;
    }
    elsif ($line eq '')
    {
      $handle = '';
      $state = 0;
    }
    else
    {
      if ($line !~ /^([A-Z_]+) (.*)$/)
      {
        die "$lno: $line"
      }

      my ($tag, $value) = ($1, $2);
      warn "$lno: $line" unless 
        ($tag =~ /^USER_/ || $tag eq 'EMAIL' ||
        $tag eq 'NAME_INITIAL');

      push @{$hash->{$handle}{$tag}}, $value;
    }
  }

  close $fh;
}


sub read_post_substitute
{
  my ($fname, $hash) = @_;

  my $lno = 0;
  open(my $fh, "<", $fname) or die "Cannot open $fname $!";

  my $handle = '';
  my $state = 0; # Looking for handle

  while (my $line = <$fh>)
  {
    $lno++;
    chomp $line;
    $line =~ s///g;

    if ($line =~ /^HANDLE (.*)$/)
    {
      die "HANDLE timing" unless $state == 0;
      $handle = $1;
      $state = 1;
    }
    elsif ($line eq '')
    {
      $handle = '';
      $state = 0;
    }
    else
    {
      if ($line =~ /^([A-Z_]+) ([\w-]+) ([A-Z_]+) ([\w '.]+)$/)
      {
        my ($tag_old, $value_old, $tag_new, $value_new) = ($1, $2, $3, $4);
        warn "$lno: $line" unless 
          ($tag_old =~ /^USER_/ && $tag_new =~ /^NAME_/);

        die "$lno: $line ($tag_old, $value_old, $tag_new, $value_new)" 
          unless exists $PERMITTED_POST_SUBS_HASH{$tag_old};

        push @{$hash->{$handle}{$tag_old}{VALUE_OLD}}, $value_old;
        push @{$hash->{$handle}{$tag_old}{VALUE_NEW}}, $value_new;
        push @{$hash->{$handle}{$tag_old}{TAG}}, $tag_new;
      }
      elsif ($line =~ /^([A-Z_]+) ([\w .-]+) ([A-Z_]+)$/)
      {
        my ($tag_old, $value, $tag_new) = ($1, $2, $3);
        warn "$lno: $line" unless 
          ($tag_old =~ /^USER_/ && $tag_new =~ /^NAME_/);

        die unless exists $PERMITTED_POST_SUBS_HASH{$tag_old};

        push @{$hash->{$handle}{$tag_old}{VALUE_OLD}}, $value;
        push @{$hash->{$handle}{$tag_old}{VALUE_NEW}}, $value;
        push @{$hash->{$handle}{$tag_old}{TAG}}, $tag_new;
      }
      else
      {
        die "$lno: $line";
      }
    }
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


sub remap_post_destroy
{
  my ($bbodb, $post_sub_hash) = @_;

  for my $handle (sort keys %$bbodb)
  {
    for my $instance (0 .. $#{$bbodb->{$handle}})
    {
      next if (! exists $bbodb->{$handle}[$instance]);

      for my $key (keys %{$bbodb->{$handle}[$instance]})
      {
        next unless exists $post_sub_hash->{$handle}{$key};

        my $vlist = $bbodb->{$handle}[$instance]{$key};
        my $destroy = $post_sub_hash->{$handle}{$key};

        my %destroy_hash = map { $_ => 1 } @$destroy;

        my @shortened_list = grep {! $destroy_hash{$_}} @$vlist;

        if ($#shortened_list < 0)
        {
          delete $bbodb->{$handle}[$instance]{$key};
        }
        else
        {
          @{$bbodb->{$handle}[$instance]{$key}} = @shortened_list;
        }
      }
    }
  }
}


sub remap_post_substitute
{
  my ($bbodb, $post_sub_hash) = @_;

  for my $handle (sort keys %$bbodb)
  {
    for my $instance (0 .. $#{$bbodb->{$handle}})
    {
      next if (! exists $bbodb->{$handle}[$instance]);

      for my $key (@PERMITTED_POST_SUBS_LIST)
      {
        next unless exists $post_sub_hash->{$handle}{$key};

        my $vlist = $bbodb->{$handle}[$instance]{$key};
        my $modify = $post_sub_hash->{$handle}{$key};

        # modify has a TAG, a VALUE_OLD list and a VALUE_NEW list
        # with the same length.

        my %modify_hash = map { $_ => 1 } @{$modify->{VALUE_OLD}};

        my @shortened_list = grep {! $modify_hash{$_}} @$vlist;

        if ($#$vlist < $#{$modify->{VALUE}} + $#shortened_list)
        {
          die "Destruction might not be there";
        }

        if ($#shortened_list < 0)
        {
          delete $bbodb->{$handle}[$instance]{$key};
        }
        else
        {
          @{$bbodb->{$handle}[$instance]{$key}} = @shortened_list;
        }

        for my $i (0 .. $#{$post_sub_hash->{$handle}{$key}{VALUE_NEW}})
        {
          my $new_val = normalize(
            $post_sub_hash->{$handle}{$key}{TAG}[$i],
            $post_sub_hash->{$handle}{$key}{VALUE_NEW}[$i]);
          append_to_name($bbodb, $handle, $instance, 
            $post_sub_hash->{$handle}{$key}{TAG}[$i], $new_val);
        }
      }
    }
  }
}


sub add_to_list
{
  my ($master, $addition) = @_;

  for my $a (@$addition)
  {
    for my $m (@$master)
    {
      last if $a eq $m;
    }
    push @$master, $a;
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
      my $list = \@{$hash->{NAME}};
      for my $i (0 .. $#$list)
      {
        $str .= $list->[$i]{TAG} . ' ' . $list->[$i]{VALUE} . "\n";
        $stats->{$list->[$i]{TAG}}++;
      }
    }
  }

  return $str;
}


sub str_instance_small
{
  my ($hash, $stats) = @_;
  my $str = '';

  for my $key (sort keys %$hash)
  {
    next if exists $IGNORE_SMALL{$key};
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
      my $list = \@{$hash->{NAME}};
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


sub str_first_non_private
{
  my ($orig_db, $handle, $instance) = @_;

  my $lno = 0;
  for my $line (@{$orig_db->{$handle}[$instance]})
  {
    if (my $replace = $sub_lines->lookup($handle, $instance, $lno,
      $line))
    {
      $line = $replace;
    }

    if ($line ne 'Private')
    {
      my $s = "$handle, $instance, $lno\n";
      $s .= "$line\n";
      $s .= "Private\n\n";
      return $s;
    }

    $lno++;
  }

  return '';
}


sub write_geo_file
{
  my ($fname, $bbodb, $orig_db, $stats) = @_;

  open(my $fh, ">", $fname) or die "Cannot open $fname $!";

  for my $handle (sort keys %$bbodb)
  {
    my $geo = Geography->new();
    my $gstr = '';
    my $conflict_flag = 0;

    for my $instance ( 0 .. $#{$bbodb->{$handle}})
    {
      next if (! exists $bbodb->{$handle}[$instance]);

      # my $geo = Geography->new();
      my $conflicts = '';
      for my $key (keys %{$bbodb->{$handle}[$instance]})
      {
        next if $key eq 'NAME';
        next unless exists $GEO_TAGS{$key};

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
          $conflict_flag = 1;
        }
        else
        {
          delete $bbodb->{$handle}[$instance]{$key};
        }
      }

      $gstr .= "HANDLE $handle\nINSTANCE $instance\n";
      if ($conflicts)
      {
        $gstr .= "***** $conflicts";

        my %hash;
        $geo->set_hash(\%hash);
        $gstr .= "***** " . str_instance(\%hash, $stats) . "\n";
      }

      $gstr .= str_instance_small($bbodb->{$handle}[$instance], $stats);
      $gstr .= "\n" . str_db($orig_db, $handle, $instance);
      $gstr .= '-' x 10 . "\n\n";
    }

    if ($conflict_flag)
    {
      print $fh $gstr;

      print $fh "$handle, \n\n" .  '=' x 40 . "\n\n";
    }
  }
  close $fh;
}


sub write_namelist_file
{
  my ($fname, $bbodb, $orig_db, $stats) = @_;

  open(my $fh, ">", $fname) or die "Cannot open $fname $!";

  for my $handle (sort keys %$bbodb)
  {
    my $namelist = NameList->new();
    my $nstr = '';
    my $conflict_flag = 0;

    for my $instance (0 .. $#{$bbodb->{$handle}})
    {
      next if (! exists $bbodb->{$handle}[$instance]);
      next if (! exists $bbodb->{$handle}[$instance]{NAME});

      my @list;
      for my $elem (@{$bbodb->{$handle}[$instance]{NAME}})
      {
        push @list, $elem->{TAG}, $elem->{VALUE};
      }

      $nstr .= "HANDLE $handle\nINSTANCE $instance\n";
      if ($namelist->add_list(\@list))
      {
        delete $bbodb->{$handle}[$instance]{NAME};
      }
      else
      {
        $conflict_flag = 1;

        $nstr .= "*****\n";
        $nstr .= $namelist->str() . "\n";
      }

      $nstr .= str_instance_small($bbodb->{$handle}[$instance], $stats);
      $nstr .= "\n" . str_db($orig_db, $handle, $instance);
      $nstr .= '-' x 10 . "\n\n";
    }

    if ($conflict_flag)
    {
      print $fh $nstr;

      for my $instance (0 .. $#{$bbodb->{$handle}})
      {
        print $fh str_first_non_private($orig_db, $handle, $instance);
      }

      print $fh "\n" . '=' x 40 . "\n\n";
    }
  }
  close $fh;
}


sub write_consol_file
{
  my ($fname, $bbodb, $orig_db, $stats) = @_;

  open(my $fh, ">", $fname) or die "Cannot open $fname $!";

  for my $handle (sort keys %$bbodb)
  {
    my $geo = Geography->new();
    my $namelist = NameList->new();
    my %rest;

    for my $instance (0 .. $#{$bbodb->{$handle}})
    {
      next if (! exists $bbodb->{$handle}[$instance]);

      if (exists $bbodb->{$handle}[$instance]{NAME})
      {
        my @list;
        for my $elem (@{$bbodb->{$handle}[$instance]{NAME}})
        {
          push @list, $elem->{TAG}, $elem->{VALUE};
        }

        die "$handle, $instance: Clear namelist first\n" unless 
          $namelist->add_list(\@list);

        delete $bbodb->{$handle}[$instance]{NAME};
      }

      for my $key (keys %{$bbodb->{$handle}[$instance]})
      {
        if (exists $GEO_TAGS{$key})
        {
          for my $v (@{$bbodb->{$handle}[$instance]{$key}})
          {
            die "$handle, $instance: Clear geo first\n" unless 
              $geo->add($key, $v);
          }
          delete $bbodb->{$handle}[$instance]{$key};
          next;
        }

        if (! exists $rest{$key})
        {
          @{$rest{$key}} = @{$bbodb->{$handle}[$instance]{$key}};
        }
        else
        {
          add_to_list($bbodb->{$handle}[$instance]{$key},
            \@{$rest{$key}});
        }
      }
    }

    my $rstr = str_instance(\%rest, $stats);
    next unless $rstr =~ /USER_/;

# TMP
    # Name.
    my $nstr = $namelist->str();
    # next if $nstr !~ /^NAME_/;
    next if $nstr =~ /^NAME_/;

    print $fh "HANDLE $handle\n";

    # Everything except name and geography.
    print $fh $rstr;

    print $fh $nstr;
    $namelist->update_stats($stats);

    # Geography.
    my %hash;
    $geo->set_hash(\%hash);
    print $fh str_instance(\%hash, $stats) . "\n";
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
    next unless exists $stats->{$key};
    printf "%-16s %8d\n", $key, $stats->{$key};
    $sum += $stats->{$key};
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
 
