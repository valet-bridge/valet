#!perl

package Read;

use strict;
use warnings;
use Exporter;
use v5.10;

use HeaderT;
use TeamT;
use PairT;
use IndivT;
use Util;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  read_names_into_players
  read_combined
  read_tournaments
  read_tournament_headers);


sub read_names_into_players
{
  # tourn_ref is an array where the first dimension is the
  # tournament number.  Unlike in the previous method, we capture
  # the partner/team information for reference.  So if it's a 
  # team tournament:
  # {actual team name}[list of player indices]
  # If it's a pairs tournament:
  # {pairs as fixed string}[list of up to two player indices]
  #
  # tourn_info_ref is a constant input.  We need it in order to
  # tell whether a tournament is for teams or for pairs.
  #
  # players_ref is a reference to a class of Player's.

  my ($fname, $tourn_headers_ref, $players_ref, $tourn_ref) = @_;

  open my $fh, '<', $fname or die "Cannot read $fname: $!";

  my $line;
  my %record;

  while ($line = <$fh>)
  {
    chomp $line;
    if ($line =~ /^\s*$/)
    {
      die "No number" unless defined $record{EBL};
      my $no = $record{EBL}[0];

      if (! defined $record{NAME})
      {
        # Basically ignore the players without names.
        if (defined $record{EBL_PREFERRED})
        {
          if ($#{$record{EBL_PREFERRED}} != 0)
          {
            die "Expected exactly one redirect";
          }
        }
        elsif (defined $record{DELETED})
        {
        }
        else
        {
          die "Confusing record";
        }

        %record = ();
        next;
      }

      $players_ref->add($no, \%record);

      if (defined $record{TOURNAMENT})
      {
        for my $t (@{$record{TOURNAMENT}})
        {
          my @a = split /\|/, $t;
          if ($#a != 2)
          {
            die "Tournament syntax";
          }

          my ($tno, $year, $tag) = ($a[0], $a[1], $a[2]);

          if (! defined $tourn_headers_ref->[$tno])
          {
            die "Player $no: Tournament $tno not in info";
          }

          my $is_teams = $tourn_headers_ref->[$tno]->is_teams();

          if ($is_teams)
          {
            if ($tag eq '-')
            {
              die "Player $no: No real team name";
            }
            push @{$tourn_ref->[$tno]{$tag}}, $no;
          }
          else
          {
            # We ought to know the partner, but we may not have
            # read that name yet, so we cannot yet translate it
            # into an ID.
            my $ctag = Util::reverse_name($tag);
            push @{$tourn_ref->[$tno]{pairs}}, [ $no, $ctag ];
          }
        }
      }

      %record = ();
    }
    else
    {
      my ($tag, $content);
      if ($line =~ /^(\S+)\s+(.*)$/)
      {
        ($tag, $content) = ($1, $2);
        push @{$record{$tag}}, $content;
      }
      elsif ($line eq 'DELETED')
      {
        push @{$record{DELETED}}, -1;
      }
    }
  }

  # Now we have to clean up the pairs entries

  for my $tno (1 .. $#$tourn_ref)
  {
    next unless defined $tourn_ref->[$tno];
    next unless defined $tourn_ref->[$tno]{pairs};

    my @matches;
    my @deletions;

    for my $i (0 .. $#{$tourn_ref->[$tno]{pairs}})
    {
      my ($id, $symb) = @{$tourn_ref->[$tno]{pairs}[$i]};
      if ($symb eq '-')
      {
        $matches[$i] = -1;
        $tourn_ref->[$tno]{pairs}[$i][1] = -1;
      }
      else
      {
        if (! $players_ref->has_name($symb))
        {
          die "Player $id, tournament $tno: $symb not known";
        }

        my $pno = $players_ref->name_to_id($symb);
        $matches[$id] = $pno;
        if (defined $matches[$pno])
        {
          if ($matches[$pno] != $id)
          {
            die "Player $id, tournament $tno: " .
              "$symb already matched to $matches[$pno]";
          }
          push @deletions, $i;
        }
        else
        {
          $matches[$pno] = $i;
        }

        if ($i < $pno)
        {
          $tourn_ref->[$tno]{pairs}[$i][1] = $pno;
        }
        else
        {
          # Smallest one first
          $tourn_ref->[$tno]{pairs}[$i][0] = $pno;
          $tourn_ref->[$tno]{pairs}[$i][1] = $id;
        }
      }
    }

    # Remove duplicates
    for my $i (reverse @deletions)
    {
      splice(@matches, $i, 1);
    }
  }

  # Just sort the tournament entries
  for my $tno (1 .. $#$tourn_ref)
  {
    next unless defined $tourn_ref->[$tno];
    next if defined $tourn_ref->[$tno]{pairs};

    for my $tname (keys %{$tourn_ref->[$tno]})
    {
      @{$tourn_ref->[$tno]{$tname}} = sort {$a <=> $b}
        @{$tourn_ref->[$tno]{$tname}};
    }
  }

  close $fh;
}


sub read_combined
{
  # We need tourn_headers_ref to tell whether it is teams or pairs.

  my ($fname, $players, $tourn_headers_ref, $tournaments_ref) = @_;

  open my $fh, '<', $fname or die "Cannot read $fname: $!";

  my %chunk;
  my $team_flag;
  my $pair_flag;
  my $indiv_flag;
  my $tno;

  while (my $line = <$fh>)
  {
    if ($line =~ /^\s*$/)
    {
      if (defined $chunk{TITLE} && 
          defined $chunk{ID} &&
          defined $chunk{DETAILS})
      {
        $tno = $chunk{ID};

        $tourn_headers_ref->[$tno]->check_from_details(
          $chunk{TITLE}, $chunk{DETAILS}, $tno);

        my $form = $tourn_headers_ref->[$tno]->form();
        if ($form eq 'Teams')
        {
          $tournaments_ref->[$tno] = TeamT->new();
        }
        elsif ($form eq 'Pairs')
        {
          $tournaments_ref->[$tno] = PairT->new();
        }
        elsif ($form eq 'Individual')
        {
          $tournaments_ref->[$tno] = IndivT->new();
        }
        else
        {
          die "Unknown tournament form";
        }
      }
      else
      {
        $tournaments_ref->[$tno]->add_from_chunk(
          $tourn_headers_ref->[$tno],
          \%chunk,
          $players, 
          $tno);
      }

      %chunk = ();
    }
    elsif ($line !~ /\s/)
    {
      die "Line $line has no space to split on";
    }
    else
    {
      $line =~ /^(\S+)\s+(.*)$/;
      $chunk{$1} = $2;
    }
  }

  close $fh;
}


sub read_tournament_headers
{
  my ($fname, $tourn_headers_ref) = @_;

  open my $fh, '<', $fname or die "Cannot read $fname: $!";

  my $line;
  my %buffer = ();

  while ($line = <$fh>)
  {
    chomp $line;
    if ($line =~ /^\s*$/)
    {
      if (! defined $buffer{ID})
      {
        print "No ID?\n";
      }

      $tourn_headers_ref->[$buffer{ID}] = HeaderT->new();
      $tourn_headers_ref->[$buffer{ID}]->set_from_buffer(\%buffer, $fname);

      %buffer = ();
    }
    elsif ($line =~ /^(\S+)\s+(.*)/)
    {
      $buffer{$1} = $2;
    }
    else
    {
      print "Format error: $line\n";
    }
  }

  close $fh;
}

1;
