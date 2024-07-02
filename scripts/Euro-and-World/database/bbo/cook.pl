#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Time::HiRes qw(time);

use lib '.';
use lib './Title';
use lib './Event';
use lib './Patterns';

use Chains;
use Chain;

use TeamBBO;
use EventBBO;
use ScoringBBO;

use Title::Study;
use Title::Preprocess;
use Title::Postprocess;

use Event::Despace;
use Patterns::Chainify;

use Reductions::Event;
use Reductions::Title;

use Whole;
my $whole = Whole->new();
$whole->init_hashes();

use Histo;
our $histo_title = Histo->new();


# Parse the raw output of
# ./reader -I ... -Q 9=4=0=0 -v 63

die "perl cook.pl raw.txt" unless $#ARGV == 0;

my $do_events = 1; # 1 if we parse EVENT
my $do_tournaments = 1; # 1 if we parse TITLE

my $print_chains = 1; # 1 if we dump results for further analysis

my @RAW_FIELDS = qw(BBONO TITLE EVENT SCORING TEAMS);

TeamBBO::init_hashes();
read_cities();

my $file = $ARGV[0];
open my $fh, '<', $file or die "Cannot read tfile: $!";

my %chunk;
my $line;

my $lno = 0;
my (@chain_team_stats, @chain_event_stats, @chain_title_stats,
  @chain_title_num_stats);
my (@reduction_event_stats, @reduction_title_stats);
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

  if ($chunk{BBONO} == 218)
  {
    print "HERE\n";
  }

  print_chunk(\%chunk) if $print_chains;

  # TEAMS

  my $chain_team1 = Chain->new();
  my $chain_team2 = Chain->new();
  my %result;
  study_teams($chunk{TEAMS}, \%result, 
    $chain_team1, $chain_team2, $chunk{BBONO});

  update_chain_team_stats($chain_team1, \@chain_team_stats);
  update_chain_team_stats($chain_team2, \@chain_team_stats);

  if ($print_chains)
  {
    print_chain($chain_team1, 1, "");
    print_chain($chain_team2, 2, "");
  }


  if ($do_events)
  {
    # EVENT: Fix some space-related issues.
    my $mashed = despace($chunk{EVENT});
    $mashed = unteam($mashed, \%result);

    my $chain_event = Chain->new();
    my @chains_event;
    push @chains_event, $chain_event;

    study_event($mashed, \%chunk, \%result, $chain_event, \$unknown_events);
    process_event(\@chains_event);
    Patterns::Chainify::process(\@EVENT_REDUCTIONS, \@chains_event, 
      1, \@reduction_event_stats);

    update_chain_stats(\%chunk, \@chains_event, \@chain_event_stats);

    print_chains_by_tag(\@chains_event, "EVENT") if $print_chains;
  }

  my $scoring;
  study_scoring($chunk{SCORING}, \%result, $chunk{BBONO});

  if ($print_chains)
  {
    print "SCORING ", $chunk{SCORING}, "\n";
  }

  if ($do_tournaments)
  {
    my $chain_title = Chain->new();
    my @chains_title;
    push @chains_title, $chain_title;

    Title::Study::study($whole, $chunk{BBONO}, $chunk{TITLE}, 
      $chain_title, \$unknown_titles);

    Title::Preprocess::pre_process(\@chains_title);

    Patterns::Chainify::process(\@TITLE_REDUCTIONS, \@chains_title, 
      0, \@reduction_title_stats);

    Title::Postprocess::post_process(\@chains_title);

    update_chain_stats(\%chunk, \@chains_title, \@chain_title_stats);
    update_num_chain_stats(\%chunk, 
      \@chains_title, \@chain_title_num_stats);

    print_chains_by_tag(\@chains_title, "TITLE") if $print_chains;
  }

  print "\n" if ($print_chains);
}

close $fh;

print_team_stats();
print_team_chain_stats(\@chain_team_stats);

if ($do_events)
{
  print_chain_stats("Event", \@chain_event_stats);
  print_reduction_stats("Event", \@reduction_event_stats);
  print "\nTotal unknown events: $unknown_events\n\n";
}

if ($do_tournaments)
{
  $histo_title->print();
  print_chain_stats("Title chain lengths", \@chain_title_stats);
  print_chain_stats("Title chain numbers", \@chain_title_num_stats);
  print "\nTotal unknown titles $unknown_events\n\n";
}

# $whole->print_misses();


exit;


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


sub print_chain
{
  my ($chain, $no, $prefix) = @_;

  return if $chain->status() eq 'KILLED';

  my $l = $chain->last();
  return if $l == -1;

  if ($prefix eq 'TITLE')
  {
    for my $i (0 .. $l)
    {
      my $token = $chain->check_out($i);
      print $token->str(0, $prefix);
    }
    return;
  }

  my $token = $chain->check_out(0);
  if ($token->field() =~ /^TEAM_/)
  {
    # Can be just a team chain.
    # TODO Probably the TEAM chains should be prefixed before they get here.
    for my $i (0 .. $l)
    {
      my $t = $chain->check_out($i);
      my $tag = $t->field();
      $tag =~ s/^TEAM_/TEAM${no}_/;
      print $tag, ' ', $t->value(), "\n";
    }
    return;
  }
  elsif ($l == 0)
  {
    print $token->str(0, $prefix);
    return;
  }
  elsif ($prefix eq 'EVENT' && $l == 2)
  {
    my $token0 = $chain->check_out(0);
    my $token2 = $chain->check_out(2);

    if ($token0->category() eq 'ITERATOR' &&
        $token2->category() eq 'COUNTER')
    {
      my $synth = Token->new();
      $synth->set_singleton($token0->field(), $token2->value());
      print $synth->str(0, $prefix);
    }
    elsif ($token0->field() eq 'EXPANSION' &&
        $token2->category() eq 'COUNTER')
    {
      my $synth = Token->new();
      $synth->set_singleton($token0->field(), 
        $token0->value() . ' ' . $token2->value());
      print $synth->str(0, $prefix);
    }
    elsif ($token0->category() eq 'ITERATOR' &&
        $token2->field() eq 'LETTER')
    {
      my $synth = Token->new();
      $synth->set_singleton($token0->field(), $token2->value());
      print $synth->str(0, $prefix);
    }
    else
    {
      print "Haven't learned this yet (A $l):\n";
      print "  ", $chain->text(), " # ", $chain->fields(), "\n";
    }
    return;
  }

  print "Haven't learned this yet (C $l):\n";
  print "  ", $chain->text(), " # ", $chain->fields(), "\n";
}


sub print_chains
{
  my $chains = pop;

  for my $chain_no (0 .. $#$chains)
  {
    my $chain = $chains->[$chain_no];
    printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->text());
      printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->catcat());
  }
  printf "\n";
}


sub print_chains_full
{
  my $chains = pop;

  for my $chain_no (0 .. $#$chains)
  {
    my $chain = $chains->[$chain_no];
    printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->text());
      printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->catcat());
      printf("Chain %d %2d %8s: %s\n",
      $chain_no,
      $chain->last()+1,
      $chain->status(),
      $chain->fields());
  }
  printf "\n";
}


sub print_chains_by_tag
{
  my ($chains, $prefix) = @_;
  for my $chain_no (0 .. $#$chains)
  {
    print_chain($chains->[$chain_no], 0, $prefix);
  }
}


sub update_chain_team_stats
{
  my ($chain, $chain_team_stats) = @_;

  $chain_team_stats->[$chain->last()+1]++;

  if ($chain->last() > 100)
  {
    print $chunk{BBONO}, ":\n";
    print $chain->text(), "\n";
    print $chain->catcat(), "\n";
    print $chain->fields(), "\n\n";
  }
}


sub update_chain_stats
{
  my ($chunk, $chains, $chain_stats) = @_;

  my $open_flag = 0;
  for my $chain (@$chains)
  {
    my $status = $chain->status();
    $chain_stats->[$chain->last()+1]{$status}++;
    $open_flag = 1 if $status eq 'OPEN';
  }

  if ($open_flag)
  {
    print_chunk($chunk);
    print_chains_full($chains);
  }
}


sub update_num_chain_stats
{
  my ($chunk, $chains, $chain_stats) = @_;

  $chain_stats->[$#$chains+1]{COMPLETE}++;

  if ($#$chains >= 99)
  {
    print_chunk($chunk);
    print_chains_full($chains);
  }
}


sub print_team_chain_stats
{
  my ($chain_team_stats) = @_;

  print "\nTeam chain stats\n\n";
  for my $i (0 .. $#$chain_team_stats)
  {
    printf ("%4d %6d\n", $i, $chain_team_stats->[$i]);
  }
}


sub print_chain_stats
{
  my ($header, $chain_stats) = @_;

  my %csum;
  print "\n$header chain stats\n\n";
  printf("%6s%10s%10s%10s\n", "", "OPEN", "COMPLETE", "KILLED");

  for my $i (0 .. $#$chain_stats)
  {
    my %h;
    for my $key (qw(OPEN COMPLETE KILLED))
    {
      if (exists $chain_stats->[$i]{$key})
      {
        $h{$key} = $chain_stats->[$i]{$key};
      }
      else
      {
        $h{$key} = 0;
      }
      $csum{$key} += $h{$key};
    }
    printf("%6d%10d%10d%10d\n", $i, $h{OPEN}, $h{COMPLETE}, $h{KILLED});
  }

  print '-' x 36, "\n";
  printf("%6s%10d%10d%10d\n\n", "Sum",
    $csum{OPEN}, $csum{COMPLETE}, $csum{KILLED});
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
