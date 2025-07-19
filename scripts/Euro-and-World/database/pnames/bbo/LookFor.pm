#!perl

package LookFor;

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(look_for_opening look_for_bigrams
  look_for_ranges split_on_specifics);

my %BIGRAMS = (
  Benjamin  => { 'ACOL' => [ 'BASES', 'Benjamin ACOL' ] },
  Convenient => { 'minor' => [ 'BASES', 'Convenient Minor' ] },
  Standard => { 
    'American' => [ 'BASES', 'Standard American' ],
    'Carding' => [ 'CARDING', 'Standard Carding' ] },
  Reverse => { 
    'Bergen' => [ 'BERGEN', 'Reverse Bergen' ],
    'Cappelletti' => [ 'COMPETITIVE', 'Reverse Cappelletti' ] },
  Bergen => { 'Raise' => [ 'BERGEN', 'Bergen Raise' ] },
);

my %SPLITTORS = (
  'Benjamin ACOL' => 1,
  'Blue Club' => 1,
  'Bluejay Club' => 1,
  'Better Minor' => 1,
  'Convenient Minor' => 1,
  'Five Card Major' => 1,
  'German Forum D' => 1,
  'Magic Diamond' => 1,
  'Nordic Standard' => 1,
  'Polish ACOL' => 1,
  'Polish Club' => 1,
  'Power ACOL' => 1,
  'Power Precision' => 1,
  'Standard American' => 1,
  'Standard Italian' => 1,
  'Two Over One' => 1,

  'Bergen Raise' => 1,
  'Reverse Bergen' => 1,

  Blackwood => 1,

  'Ace from AK' => 1,
  'High Encouraging' => 1,
  'King from AK' => 1,
  'Lavinthal Against NT' => 1,
  'McKenney Signal' => 1,
  'Reverse Attitude' => 1,
  'Reverse Smith' => 1,
  'Roman Discards' => 1,
  'Schneider Signal' => 1,
  'Smith Echo' => 1,
  'Standard Carding' => 1,
  'Standard Count' => 1,
  'Standard Discards' => 1,

  'Balancing Double' => 1,
  'Balancing NT' => 1,
  'Competitive Double' => 1,
  'Fit Jump' => 1,
  'Flip Flop' => 1,
  'Game Try Double' => 1,
  'Good Bad NT' => 1,
  'Jump Shift' => 1,
  'Leaping Michaels' => 1,
  'Lightner Double' => 1,
  'Maximal Double' => 1,
  'Meckwell Against NT' => 1,
  'Michaels Cuebid' => 1,
  'Modified Hamilton' => 1,
  'Multi Landy' => 1,
  'Negative Double' => 1,
  'Negative Free Bid' => 1,
  'Penalty Double' => 1,
  'Pinpoint Astro' => 1,
  'Responsive Double' => 1,
  'Reverse Cappelletti' => 1,
  'Revised DONT' => 1,
  'Rosenkranz Double' => 1,
  'Sandwich NT' => 1,
  'SOS Redouble' => 1,
  'Sputnik Double' => 1,
  'Stolen Bid' => 1,
  'Strong Jump Shift' => 1,
  'Support Double' => 1,
  'System Off' => 1,
  'System On' => 1,
  'Takeout Double' => 1,
  'Unusual NT' => 1,
  'Unusual vs Unusual' => 1,
  'Weak Jump' => 1,
  'Weak Jump Shift' => 1,
  'Weak Jump Overcall' => 1,
  'Western Cuebid' => 1,

  'Brozel' => 1,
  'Ghestem' => 1,
  'Landik' => 1,
  'Lebensohl' => 1,
  'Rubensohl' => 1,
  'Woolsey' => 1,

  '2D Waiting' => 1,
  'Checkback Stayman' => 1,
  'Control Bid' => 1,
  'Forcing NT' => 1,
  'Inverted Minors' => 1,
  'Kokish Game Try' => 1,
  'Limit Raise' => 1,
  'New Minor Forcing' => 1,
  'Jacoby 2NT' => 1,
  'Jacoby Transfers' => 1,
  'Pattaya NT' => 1,
  'Quantitative NT' => 1,
  'Reverse Drury' => 1,
  'Slow Arrival' => 1,
  'Serious 3NT' => 1,
  'Slow Arrival' => 1,
  'South African Texas' => 1,
  'Super Accepts' => 1,
  'Texas Transfers' => 1,
  'Trial Bid' => 1,
  'Wolff Signoff' => 1,
  'XY NT' => 1,
  'XYZ NT' => 1,

  Baron => 1,
  Baz => 1,
  Crodo => 1,
  Gerber => 1,
  Ingberman => 1,
  Minisplinter => 1,
  Namyats => 1,
  Ogust => 1,
  Roudinesco => 1,
  Smolen => 1,
  Stenberg => 1,
  Walsh => 1,

  'Exclusion Keycard' => 1,
  'Keycard Responses' => 1,

  RKCB => 1,

  '2D Precision' => 1,
  '2D Multi' => 1,
  'Gambling 3NT' => 1,
  'Reverse Flannery' => 1,
  'Short Club' => 1,
  'Strong NT' => 1,
  'Three Level Preempts' => 1,
  'Variable NT' => 1,
  'Weak NT' => 1,
  'Weak Two' => 1,
  'Weak DHS' => 1,
  'Weak Major' => 1,

  'Minor Suit Stayman' => 1,
  'Nonforcing Stayman' => 1,
  'Puppet Stayman' => 1,
);


sub look_for_opening
{
  my ($units, $denom, $name, $lower, $upper, $hash, $chain_stats) = @_;

  my $index = 0;
  while ($index <= $units->last())
  {
    my $pos = $units->force_first_equal_forward($index,
      'DENOMINATIONS', $denom, $hash);
    return if $pos < 0;
    if ($pos == 0)
    {
      $index = $pos + 1;
      next;
    }

    my $level_pos = $units->find_first_cat_backward(
      $pos-1, 'INT_SMALL', {});
    if ($level_pos < 0)
    {
      $index = $pos + 1;
      next;
    }

    my $level = $units->value($level_pos);
    if ($level >= $lower && $level <= $upper)
    {
      my $opening = "OPENING_${level}${name}";
      $units->collapse($level_pos, $pos, $opening, '', $chain_stats);
      $index = $level_pos + 1;
    }
    else
    {
      $index = $pos + 1;
    }
  }
}


sub look_for_bigrams
{
  my ($units, $chain_stats) = @_;

  my $first_pos = $units->find_next_substantial(0);
  return if $first_pos < 0;

  my $first_value = $units->value($first_pos);

  while (1) 
  {
    my $second_pos = $units->find_next_substantial($first_pos + 1);
    last if $second_pos < 0;

    my $second_value = $units->value($second_pos);

    if (exists $BIGRAMS{$first_value} && 
        exists $BIGRAMS{$first_value}{$second_value}) 
    {
      print "MATCHING $first_value $second_value\n";
      my ($category, $value) = 
        @{ $BIGRAMS{$first_value}{$second_value} };

      $units->collapse($first_pos, $second_pos, $category, $value, 
        $chain_stats);

      $first_pos = $units->find_next_substantial($second_pos + 1);
      last if $first_pos < 0;
      $first_value = $units->value($first_pos);
    } 
    else 
    {
      # No match: shift window forward
      $first_pos = $second_pos;
      $first_value = $second_value;
    }
  }
}


sub look_for_ranges
{
  my ($units, $streaks, $chain_stats, $identifier) = @_;

  for my $streak_no (reverse 0 .. $#$streaks)
  {
    my $streak = $streaks->[$streak_no];
    next unless $#$streak == 1;

    my $first = $units->value($streak->[0]);
    my $second = $units->value($streak->[1]);

    next unless $first >= 12 && $second <= 24 &&
      $first < $second && $second <= $first + 4;

    $units->collapse($streak->[0], $streak->[1], 'RANGE', 
      "$first to $second", $chain_stats);
  }
}


sub split_on_specifics
{
  my ($battery, $chain_stats, $identifier) = @_;

  for (my $bno = 0; $bno <= $#$battery; $bno++)
  {
    my $units = $battery->[$bno];
    next if $units->is_complete();

    for (my $uno = 0; $uno <= $units->last(); $uno++)
    {
      my $value = $units->value($uno);
      next unless exists $SPLITTORS{$value};

      if ($uno == 0)
      {
        my $pos = $units->find_next_substantial($uno+1);

        if ($pos > 0)
        {
          my $units2 = Units->new();
          $units->copy_from($pos, $units2);
          splice @$battery, $bno+1, 0, $units2;

        }
        $units->truncate_after($uno);
        $units->set_status('COMPLETE') if $uno == 0;
      }
      else
      {
        my $pos = $units->find_previous_substantial($uno-1);

        if ($pos >= 0)
        {
          my $units2 = Units->new();
          $units->copy_from($uno, $units2);
          $units2->set_status('COMPLETE') if $units2->last() == 0;
          splice @$battery, $bno+1, 0, $units2;
          $units->truncate_before($uno);
          $units->set_status('COMPLETE') if $units->last() == 0;
        }
        else
        {
          print "HOW?";
          print $identifier;
        }
      }
    }
  }
}


1;
