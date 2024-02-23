#!perl

package TeamT;

use strict;
use warnings;
use Exporter;
use v5.10;

use Team;
use Players;
use Util;

# Mixed teams, 6 player split 4-2 or 2-4 (M-F), where it seems legitimate
my %FOUR_TWO_MIXED = (
  '44, LIPPO BANK II' => 1,     '44, PALESTINE' => 1,
  '44, VOLHEJN' => 1,           '44, ZENIT' => 1,
  '51, BOUVERESSE' => 1,        '51, CERVI' => 1,
  '51, DERI' => 1,              '51, FILIPPI' => 1,
  '51, HEATHER' => 1,           '51, HENDRICKX' => 1,
  '51, KOWALSKI' => 1,          '51, MIDSKOPG' => 1,
  '51, SAUNDERS' => 1,          '51, SOLAKOGLOU' => 1,
  '95, ALLIX' => 1,             '238, KREMER' => 1,
  '238, SUSSEL' => 1,           '240, BLOUQUIT' => 1,
  '240, BEAUVILLAIN' => 1,      '240, MOYET' => 1,
  '240, SUSSEL' => 1,           '240, BURNET' => 1,
  '242, LISE' => 1,             '242, BURGAY' => 1,
  '242, DELEVA' => 1,           '242, COURTY' => 1,
  '459, HKHZ' => 1,             '459, SALMAN' => 1,
  '459, KANTARCI' => 1,         '459, YENER' => 1,
  '484, ZIMMERMANN' => 1,       '484, SERF' => 1,
  '594, GELIN' => 1,            '688, RUSSIA' => 1,
  '688, TOPBRIDGE' => 1,        '688, DONGFENG' => 1,
  "688, SHENZHEN WOMEN'S WORLD" => 1, '717, DARKMOON' => 1,
  '832, PIN AN' => 1,           '935, KENYA' => 1,
  '935, DJARUM2' => 1,          '942, GOTTLIEB' => 1,
  '942, EIDE' => 1,             '969, MANO' => 1,
  '1030, PING AN CHINA' => 1,   '1030, SHENZHEN' => 1,
  '1030, SHENZHEN NANGANG POWER' => 1, '1030, HEY YO' => 1,
  '1030, QINGHAI BRIDGE ASSOCIATION' => 1,
  '1030, SANSHA SATELLITE TV' => 1, 
  '1256, DERI MIXED' => 1,      '1256, FILIPPI MIXED' => 1,
  '1256, HEATHER MIXED' => 1,   '1256, HENDRICKX MIXED' => 1,
  '1256, KOWALSKI MIXED' => 1,  '1256, MIDSKOPG MIXED' => 1,
  '1256, SAUNDERS MIXED' => 1,  '1400, CALANDRA' => 1,
  '1256, BOUVERESSE MIXED' => 1, '1256, CERVI MIXED' => 1,
  '1412, CALANDRA' => 1,        '1412, SEWIL' => 1,
  '1542, KENYA TT MIXED' => 1,  '1542, DJARUM2 TT MIXED' => 1,
  '1543, FEIXIANG' => 1,        '1600, BOSPHORUS' => 1,
  '1643, CHINESE TAIPEI' => 1,  '1643, CHINA' => 1
);

# Mixed teams, 4 players split 3-1 or 1-3, maybe players missing?
my %THREE_ONE_MIXED = (
  '3, MAURY' => 1,              '3, DAVIES' => 1,
  '3, HOBSON' => 1,             '3, GUNTHER' => 1,
  '3, KRIEGER' => 1,            '3, LARSSON' => 1,
  '3, YALMAN' => 1,             '3, ZOBU' => 1,
  '12, LABAERE A.' => 1,        '44, ARMSTRONG' => 1,
  '44, GERARD' => 1,            '51, FAIVRE' => 1,
  '95, McGOWAN' => 1,           '238, BURTON' => 1,
  '240, AUKEN' => 1,            '240, OLIVIERI' => 1,
  '240, NILSSON KA' => 1,       '240, HANSEN' => 1,
  '242, WINTER' => 1,           '242, ASSAEL' => 1,
  '242, PETRIGNANI' => 1,       '242, SUSSEL' => 1,
  '242, YALMAN' => 1,           '431, MORSE' => 1,
  '459, FALAY' => 1,            '459, KAMEL' => 1,
  '459, HACKETT' => 1,          '688, BEIJING HENGSHA' => 1,
  '942, DENMARK' => 1,          '942, CMN' => 1,
  '1030, NORCO' => 1,           '1030, ZHEJIANG JINJIANG BRIDGE CLUB' => 1,
  '1030, BRIDGE ASSOCIATION OF FUJIAN P' => 1,
  '1030, BEIJING CENTURY WEIDA' => 1,
  '1030, WUHAN' => 1,           '1101, LEGEANKA' => 1,
  '1101, I SISTE ELITEN' => 1,  '1256, FAIVRE MIXED' => 1,
  '1256, BOUVERESSE MIXED' => 1, '1256, CERVI MIXED' => 1,
  '1400, BREMNES' => 1,         '1412, DYRKORN' => 1,
  '1412, LOLA' => 1
);

# Not enough knowledge to delete these odd mixed teams completely.
my %ODDS_AND_ENDS = (
  '3, BEAUMIER' => 1,           '51, GILBOA' => 1,
  '242, SIDAR' => 1,            '272, GODFREY' => 1,
  '1256, GILBOA MIXED' => 1,    '10018, BRAZIL' => 1
);


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub add_from_chunk
{
  my ($self, $tourn_header, $chunk_ref, $players_ref, $errstr) = @_;

  die "Team has no name" unless defined $chunk_ref->{NAME};
  my $team_name = $chunk_ref->{NAME};

  my $team_restriction = Util::get_unit_restriction(
    $tourn_header, $chunk_ref->{RESTRICTION}, $errstr);
    
  die "Name $team_name already seen for restriction $team_restriction" 
    if defined $self->{$team_restriction}{$team_name};

  $self->{$team_restriction}{$team_name} = Team->new();

  for my $key (keys %$chunk_ref)
  {
    next if $key eq 'NAME' || $key eq 'RESTRICTION';

    $self->{$team_restriction}{$team_name}->add_key_value(
      $key, $chunk_ref->{$key});
  }

  $self->{$team_restriction}{$team_name}->check_basics(
    $players_ref, "$errstr, $team_name");

  $self->{$team_restriction}{$team_name}->fill_player_map(
    \%{$self->{_players}}, $team_name, $team_restriction);
  
  $self->{$team_restriction}{$team_name}->analyze_gender(
    $players_ref, $errstr);
  
  if (! $self->{$team_restriction}{$team_name}->check_gender(
    $team_restriction))
  {
    if (defined $FOUR_TWO_MIXED{"$errstr, $team_name"} &&
      $self->{$team_restriction}{$team_name}->size() == 6)
    {
      # Skip
    }
    elsif (defined $THREE_ONE_MIXED{"$errstr, $team_name"} &&
      $self->{$team_restriction}{$team_name}->size() == 4)
    {
      # Skip
    }
    elsif (defined $ODDS_AND_ENDS{"$errstr, $team_name"})
    {
      # Skip
    }
    else
    {
      print "$errstr, $team_name: Team gender mismatch\n";
      print "Restriction $team_restriction\n";
      print "Profile ",
        $self->{$team_restriction}{$team_name}->str_gender(), "\n";
      print $self->{$team_restriction}{$team_name}->str($players_ref), 
        "\n";
    }
  }
}


sub check_non_uniques
{
  my ($self, $players, $errstr) = @_;
  Util::check_non_uniques(\%{$self->{_players}}, $players, $errstr);
}


sub make_teams_histo
{
  my ($self, $name_team_ref, $players,
    $tourn_teams_ref, $active_ref, $errstr) = @_;

  my $minus_ones = 0;

  $$active_ref = 0;

  for my $ebl (@$name_team_ref)
  {
    if ($ebl == -1)
    {
      $minus_ones++;
      next;
    }
    $$active_ref++;

    my $hit = 0;
    for my $restriction (keys %{$self->{_players}{$ebl}})
    {
      $hit++;
      for my $tourn_team_no (@{$self->{_players}{$ebl}{$restriction}})
      {
        $tourn_teams_ref->{$restriction}{$tourn_team_no}++;
      }
    }

    if (! $hit)
    {
      print "$errstr: Player ", $players->id_to_name($ebl),
        " (EBL $ebl) missing from teams tournament\n\n";
    }
  }

  return ($minus_ones == 0);
}


sub check_against_name_data
{
  my ($self, $name_data_ref, $players, $errstr) = @_;

  for my $team_name (sort keys %$name_data_ref)
  {
    my $active = 0;
    my %tourn_teams;

    if (! $self->make_teams_histo(
      \@{$name_data_ref->{$team_name}},
      $players, \%tourn_teams, \$active, $errstr))
    {
      print "$errstr, $team_name: At least one team player is -1";
      next;
    }

    my %num_by_restriction;
    my $highest = 0;
    Util::histo_to_collisions(\%tourn_teams, $active,
      \%num_by_restriction, \$highest);

    next if $highest == 1;

    print "$errstr, $team_name:\n";
    print $highest == 0 ?
      "No team covers all player data in any restriction\n" :
      "$highest teams cover all player data in some restriction\n";

    print $players->str_ebl_list(\@{$name_data_ref->{$team_name}});

    if ($highest > 1)
    {
      print Util::str_collisions(\%num_by_restriction);
    }
  }
}


sub team_name_compatible
{
  my ($self, $team_name, $tourn_hit) = @_;

  return 1 if $team_name eq $tourn_hit;

  for my $restriction (qw(OPEN MIXED WOMEN SENIORS
      JUNIORS YOUNGSTERS GIRLS RAND))
  {
    return 1 if "$team_name $restriction" eq $tourn_hit;
  }

  return 0;
}


sub str_gender_stats_new
{
  my ($self, $players) = @_;

  my %counts;
  for my $restriction (keys %$self)
  {
    next if $restriction eq '_players';
    for my $team_name (keys %{$self->{$restriction}})
    {
      $self->{$restriction}{$team_name}->
        update_gender_count(\%{$counts{$restriction}});
    }
  }

  return Util::count_to_tourn_stats(\%counts);
}


1;
