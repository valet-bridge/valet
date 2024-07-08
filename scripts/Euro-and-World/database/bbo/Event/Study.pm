#!perl

package Event::Study;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

our @ISA = qw(Exporter);
our @EXPORT = qw(study);

use lib '.';
use lib '..';

use Separators;
use Token;
use Util;

my @TAG_ORDER = qw(
  ROMAN
  TNAME
  DESTROY
  TWORD
  ORIGIN
  CLUB

  ORGANIZATION
  SPONSOR
  COUNTRY
  NATIONALITY
  REGION
  CITY
  FORM
  MOVEMENT
  GENDER
  AGE
  SCORING
  PERSON
  ITERATOR
  COLOR
  STAGE
  TIME
  MONTH
  WEEKDAY
  NUMERAL
  ORDINAL
  PARTICLE
  AMBIGUOUS
);

my $PREFIX = 'EVENT_';
our $histo_event;

my %HARD_SUBS =
(
  'I A' => ['ia'],
  'I B' => ['ib'],
  'II A' => ['iia'],
  'II B' => ['iib'],
  'III A' => ['iiia'],
  'III B' => ['iiib'],
  'IV A' => ['iva'],
  'IV B' => ['ivb'],
  'V A' => ['va'],
  'V B' => ['vb'],
  'VI A' => ['via'],
  'VI B' => ['vib'],
  'VII A' => ['viia'],
  'VII B' => ['viib'],
  'VIII A' => ['viiia'],
  'VIII B' => ['viiib'],
  'IX A' => ['ixa'],
  'IX B' => ['ixb'],

  'Final Segment' => ['fs'],
  'First Half' => ['1emt', '1mt', 'andata'],
  'Group A' => ['groupa'],
  'Group B' => ['groupb'],
  'Open A' => ['opena'],
  'Open B' => ['openb'],
  'Open Round Robin' => ['orr'],
  'QF A' => ['qfa'],
  'QF B' => ['qfb'],
  'Second Half' => ['2emt', '2mt', 'ritorno', 'retur'],
  'Semifinal A' => ['sfa'],
  'Semifinal B' => ['sfb'],
  'SF A' => ['semia'],
  'SF B' => ['semib'],
  'Table A' => ['ta'],
  'Table B' => ['tb'],
  'Women Round Robin' => ['wrr']
);

# This is like a tag substitution, but it is just a hard substitution
# without the attachment of any tag, so it's rather direct and primitive.

my %FLAT_HARD_SUBS;
while (my ($key, $ref) = (each %HARD_SUBS))
{
  $FLAT_HARD_SUBS{$_} = $key for @$ref;
}

my $HARD_MREGEX_DIRECT = join('|', map { quotemeta }
  sort { length($b) <=> length($a) } keys %FLAT_HARD_SUBS);

my $HARD_MREGEX = qr/(?<!\p{L})($HARD_MREGEX_DIRECT)(?=\P{L}|\z)/i;


sub sub_hard_fragments
{
  my ($text) = @_;
  $text =~ s/$HARD_MREGEX/$FLAT_HARD_SUBS{lc($1)}/gi;
  return $text;
}


sub event_specific_inline
{
  my ($text) = @_;

  $text =~s/#(\d)/$1/g; # Remove hash

  $text =~ s/(\d)([a-zA-Z]{2,})/$1 $2/g; # Digit, then 2+ letters
  $text =~ s/([a-zA-Z]{2,})(\d)/$1 $2/g; # Other way round
  $text =~ s/(\d)([g-zG-Z])/$1 $2/g;
  $text =~ s/([g-zG-Z])(\d)/$1 $2/g;

  # Various ordinals.
  $text =~ s/(\d)\s+th/$1th /gi;
  $text =~ s/(\d)\s+rth/$1rth /gi;
  $text =~ s/(\d)\s+nd/$1nd /gi;
  $text =~ s/(\d)\s+rd/$1rd /gi;
  $text =~ s/(\d)\s+st(?=\b|_)/$1st /gi; # Either \b or _
  $text =~ s/(\d)\s+er/$1th /gi;
  $text =~ s/(\d)\s+eme/$1th /gi;

  $text =~ s/n°(\d)/ $1/gi;
  $text =~ s/(\d)ª/${1}th /gi;
  $text =~ s/(\d)°/${1}th /gi;

  $text =~ s/\bF(\d)([AB])\b/F $1$2/g;
  $text =~ s/\bF(\d+)_(\d+)\b/F $1_$2/g;

  $text =~ s/\b([FQ])([ABRSabrs])\b/$1 $2/g;
  $text =~ s/\bORR\b/Open RR/g;
  $text =~ s/\bWRR\b/Women RR/g;

  $text =~ s/^FO([\s-]|\z)/Final Open$1/;
  $text =~ s/^OF([\s-]|\z)/Open Final$1/;

  return $text;
}


sub is_lettered_number
{
  my ($part, $token, $chain) = @_;

  my ($number, $letter);
  if ($part =~ /^(\d+)([A-Fa-f])$/)
  {
    ($number, $letter) = ($1, $2);
  }
  elsif ($part =~ /^([A-Fa-f])(\d+)$/)
  {
    ($number, $letter) = ($2, $1);
  }
  else
  {
    return 0;
  }

  $token->set_general('COUNTER', 'NL', $number . $letter);
  return 1;
}


sub study_value
{
  my ($whole, $value, $result, $pos, $chain, $unsolved_flag) = @_;

  return if singleton_non_tag_matches($value, $pos, $chain,
    $main::histo_event, $PREFIX);

  return if singleton_tag_matches($whole, \@TAG_ORDER, 
    $pos, $value, 1, $chain, $main::histo_event, $PREFIX);

  my $token = Token->new();
  $token->set_origin($$pos, $value);
  $chain->append($token);
  $$pos++;

  return if Separators::set_token($value, $token);

  return 0 if is_lettered_number($value, $token);

  print "EEE value $value\n";
  $$unsolved_flag = 1;

  $token->set_unknown($value);
}


sub study
{
  my ($whole, $chunk, $result, $chain, $histo, $unknowns) = @_;

  if ($chunk->{BBONO} >= 4790 && $chunk->{BBONO} <= 4860 &&
      $chunk->{TITLE} =~ /^Buffet/)
  {
    # I think we can discard these.  I don't understand what they mean.
    return;
  }

  my $utext = unteam($chunk->{EVENT}, $result);
  my $htext = sub_hard_fragments($utext);
  my $ctext = split_on_capitals($htext);
  my $etext = event_specific_inline($ctext);

  my @tags = (0);
  my @values = ();
  my @texts = ();
  split_on_dates($etext, \@tags, \@values, \@texts, 1);
  split_on_multi($whole, \@TAG_ORDER, 1, \@tags, \@values, \@texts);

  # Split on separators.
  my $sep = qr/([\s+\-\+._:;"\/\(\)\|])/;

  my $token_no = 0;
  my $unsolved_flag = 0;

  # Make a semantic, studied version of the event.

  for my $i (0 .. $#values)
  {
    if ($tags[$i] ne '0')
    {
      # We had a hit.
      if ($tags[$i] eq 'SEPARATOR')
      {
        $chain->append_separator($values[$i], $texts[$i], $token_no);
      }
      else
      {
        $chain->append_general('SINGLETON', $tags[$i], $values[$i],
          $texts[$i], $i);
      }
      $token_no++;
    }
    else
    {
      my @a = grep { $_ ne '' } split(/$sep/, $values[$i]);
      foreach my $value (@a)
      {
        study_value($whole, $value, $result, \$token_no, 
          $chain, \$unsolved_flag);
      }
    }
  }

  if ($unsolved_flag)
  {
    $$unknowns++;
    print "EEE $chunk->{BBONO}: $chunk->{EVENT}\n" if $chain->last() > 0;
    print "\n";
  }

  my $delta = $chain->last() - $token_no + 1;
  print "DELTA EVENT $delta\n";

}

1;
