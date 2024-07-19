#!perl

use v5.10;
use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';
use lib './Team';
use lib './Title';
use lib './Event';
use lib './Patterns';

use Title::Study;
use Title::Preprocess;
use Title::Postprocess;

use Team::Clean;
use Team::Study;
use Team::Preprocess;
use Team::Postprocess;
use Team::Interpret;

use Event::Preprocess;
use Event::Study;
use Event::Postprocess;
use Event::Interpret;

use Scoring::Study;

use Patterns::Chainify;

use Reductions::Team;
use Reductions::Event;
use Reductions::Title;

use Chain;

use Whole;
my $whole = Whole->new();
$whole->init_hashes();

use Histo;
our $histo_team = Histo->new();
our $histo_title = Histo->new();
our $histo_event = Histo->new();
my $histo_event_final = Histo->new();

use Stats;
my $stats_team = Stats->new();
my $stats_event = Stats->new();
my $stats_title = Stats->new();


# Parse the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63

die "perl cook.pl raw.txt [bbono]" unless ($#ARGV == 0 || $#ARGV == 1);

my $print_chains = 1; # 1 if we dump results for further analysis

my @RAW_FIELDS = qw(BBONO TITLE EVENT SCORING TEAMS);

Team::Study::init_hashes();
Team::Interpret::init_hashes();
Event::Interpret::init_hashes();

Connections::Matrix::set_matrix($whole);
$whole->check_static_consistency();

my $debug_flag = 0;
my $debug_bbono;
if ($#ARGV == 1)
{
  $debug_flag = 1;
  $debug_bbono = $ARGV[1];
}

my $file = $ARGV[0];
open my $fh, '<', $file or die "Cannot read tfile: $!";

my %chunk;
my $line;

my $lno = 0;
my (@reduction_team_stats, @reduction_event_stats, @reduction_title_stats);
my $unknown_teams = 0;
my $unknown_events = 0;
my $unknown_titles = 0;

while ($line = <$fh>)
{
  chomp $line;
  $line =~ s///g;
  $lno++;

  if ($line =~ /^([A-Za-z]+)\s+(.*)$/)
  {
    $chunk{$1} = $2;
    next;
  }
  elsif ($line !~ /^\s*$/)
  {
    print "$lno: CAN'T PARSE $line\n";
    next;
  }

  if (defined $chunk{Input} || ! defined $chunk{BBONO})
  {
    %chunk = ();
    next;
  }

  if ($debug_flag)
  {
    next unless $chunk{BBONO} == $debug_bbono;
    print "HERE\n";
  }


  # TITLE

  my $chain_title = Chain->new();
  my @chains_title;
  push @chains_title, $chain_title;

  Title::Study::study($whole, $chunk{BBONO}, $chunk{TITLE}, 
    $chain_title, \$unknown_titles);

  Title::Preprocess::pre_process(\@chains_title);

  Patterns::Chainify::process(\@TITLE_REDUCTIONS, \@chains_title, 
    0, \@reduction_title_stats);

  Title::Postprocess::post_process(\@chains_title);

  $stats_title->incr(\@chains_title);


  # SCORING

  my %teams;
  Scoring::Study::study($chunk{SCORING}, \%teams, $chunk{BBONO});



  # TEAMS

  Team::Clean::clean_teams($whole, $chunk{TEAMS}, \%teams);
  my %chains_team;
  for my $team (qw(TEAM1 TEAM2))
  {
    my $chain_team = Chain->new();
    push @{$chains_team{$team}}, $chain_team;

    Team::Study::study($whole, $teams{$team}, 
      $chain_team, $chunk{BBONO}, \$unknown_teams);

    Team::Preprocess::pre_process(\@{$chains_team{$team}});

    Patterns::Chainify::process(\@TEAM_REDUCTIONS, \@{$chains_team{$team}}, 
      0, \@reduction_team_stats);

    Team::Postprocess::post_process(\@{$chains_team{$team}});

    Team::Interpret::interpret($whole, \@{$chains_team{$team}}, 
     \$chunk{SCORING}, $chunk{BBONO});

    $stats_team->incr(\@{$chains_team{$team}});
  }


  # EVENTS

  my $chain_event = Chain->new();
  my @chains_event;
  push @chains_event, $chain_event;

  Event::Study::study($whole, \%chunk, \%teams, 
    $chain_event, \$unknown_events);

  Event::Preprocess::pre_process(\@chains_event);

  Patterns::Chainify::process(\@EVENT_REDUCTIONS, \@chains_event, 
    1, \@reduction_event_stats);

  Event::Postprocess::post_process(\@chains_event);

  Event::Interpret::interpret($whole, \@chains_event,
   \$chunk{SCORING}, $chunk{BBONO});

  refill_histo($histo_event_final, \@chains_event);

  $stats_event->incr(\@chains_event);


  if ($print_chains)
  {
    print_chunk(\%chunk);
    print_chains_by_tag(\@chains_title, "TITLE");
    print "SCORING ", $chunk{SCORING}, "\n";
    for my $team (qw(TEAM1 TEAM2))
    {
      print_chains_by_tag(\@{$chains_team{$team}}, $team);
    }
    print_chains_by_tag(\@chains_event, "EVENT");
  }
  print "\n";
}

close $fh;

$histo_team->print();
$stats_team->print("Team");
print "\nTotal unknown teams: $unknown_events\n\n";

$histo_event->print();

print "\nHisto open part\n\n";
$histo_event_final->print();

$stats_event->print("Event");
print_reduction_stats("Event", \@reduction_event_stats);
print "\nTotal unknown events: $unknown_events\n\n";

$histo_title->print();
$stats_title->print("Title");
print_reduction_stats("Title", \@reduction_title_stats);
print "\nTotal unknown titles $unknown_titles\n\n";

# Don't need to eliminate all of these.
# $whole->print_misses();


exit;


sub refill_histo
{
  my ($histo, $chains) = @_;
  for my $chain (@$chains)
  {
    next if $chain->status() eq 'KILLED' ||
      $chain->status() eq 'EXPLAINED';

    for my $i (0 .. $chain->last())
    {
      my $token = $chain->check_out($i);
      next if $token->category() eq 'SEPARATOR';
if ($token->field() eq 'GENDER')
{
  print "HERE\n";
}
      $histo->incr($token->field());
    }
  }
}


sub print_chunk
{
  my $cref = pop;

  for my $field (@RAW_FIELDS)
  {
    if (defined $cref->{$field} && $cref->{$field} ne '')
    {
      print "$field $cref->{$field}\n";
    }
  }
  print "\n";
}


sub print_chains_by_tag
{
  my ($chains, $prefix) = @_;
  for my $chain (@$chains)
  {
    $chain->print($prefix);
  }
}


sub print_reduction_stats
{
  my ($header, $reduction_stats) = @_;

  print "$header reduction matches\n\n";
  for my $i (0 .. $#$reduction_stats)
  {
    next unless defined $reduction_stats->[$i];
    printf("%6d%10d\n", $i, $reduction_stats->[$i]);
  }
}
