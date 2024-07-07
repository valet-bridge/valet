#!perl

package Whole;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib './Tags';

use Tags::Abbr;
use Tags::Age;
use Tags::Ambiguous;
use Tags::Bot;
use Tags::Captain;
use Tags::City;
use Tags::Club;
use Tags::Color;
use Tags::Country;
use Tags::Destroy;
use Tags::First;
use Tags::Form;
use Tags::Fun;
use Tags::Gender;
use Tags::Iterator;
use Tags::Meet;
use Tags::Month;
use Tags::Movement;
use Tags::Nationality;
use Tags::Numeral;
use Tags::Ordinal;
use Tags::Origin;
use Tags::Organization;
use Tags::Other;
use Tags::Particle;
use Tags::Person;
use Tags::Quarter;
use Tags::Region;
use Tags::Roman;
use Tags::Scoring;
use Tags::Sponsor;
use Tags::Stage;
use Tags::Time;
use Tags::Tname;
use Tags::Tword;
use Tags::University;
use Tags::Weekday;
use Tags::Zone;


my %TAGS =
(
  ABBR => \&Tags::Abbr::set_hashes,
  AGE => \&Tags::Age::set_hashes,
  AMBIGUOUS => \&Tags::Ambiguous::set_hashes,
  BOT => \&Tags::Bot::set_hashes,
  CAPTAIN => \&Tags::Captain::set_hashes,
  CITY => \&Tags::City::set_hashes,
  CLUB => \&Tags::Club::set_hashes,
  COLOR => \&Tags::Color::set_hashes,
  COUNTRY => \&Tags::Country::set_hashes,
  DESTROY => \&Tags::Destroy::set_hashes,
  FIRST => \&Tags::First::set_hashes,
  FORM => \&Tags::Form::set_hashes,
  FUN => \&Tags::Fun::set_hashes,
  GENDER => \&Tags::Gender::set_hashes,
  ITERATOR => \&Tags::Iterator::set_hashes,
  MEET => \&Tags::Meet::set_hashes,
  MONTH => \&Tags::Month::set_hashes,
  MOVEMENT => \&Tags::Movement::set_hashes,
  NATIONALITY => \&Tags::Nationality::set_hashes,
  NUMERAL => \&Tags::Numeral::set_hashes,
  ORDINAL => \&Tags::Ordinal::set_hashes,
  ORIGIN => \&Tags::Origin::set_hashes,
  ORGANIZATION => \&Tags::Organization::set_hashes,
  OTHER => \&Tags::Other::set_hashes,
  PARTICLE => \&Tags::Particle::set_hashes,
  PERSON => \&Tags::Person::set_hashes,
  QUARTER => \&Tags::Quarter::set_hashes,
  REGION => \&Tags::Region::set_hashes,
  ROMAN => \&Tags::Roman::set_hashes,
  SCORING => \&Tags::Scoring::set_hashes,
  SPONSOR => \&Tags::Sponsor::set_hashes,
  STAGE => \&Tags::Stage::set_hashes,
  TIME => \&Tags::Time::set_hashes,
  TNAME => \&Tags::Tname::set_hashes,
  TWORD => \&Tags::Tword::set_hashes,
  UNIVERSITY => \&Tags::University::set_hashes,
  WEEKDAY => \&Tags::Weekday::set_hashes,
  ZONE => \&Tags::Zone::set_hashes
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
    my $tilded = $multi =~ s/ /\~/gr;
    $self->{MWORDS}{$key}{lc($multi)} = $multi;
    $self->{SWORDS}{$key}{lc($multi)} = 
      { CATEGORY => $key, VALUE => $multi };
  }

  # Any typos.
  for my $multi (keys %$multi_typos)
  {
    my $tilded = $multi =~ s/ /\~/gr;
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
      print "$tag: $value\n" unless exists $self->{HITS}{$tag}{lc($value)};
    }
  }

  print "\nSingle-word unused:\n\n";
  for my $tag (sort keys %{$self->{SWORDS}})
  {
    next if $tag eq 'ORGANIZATION'; # Unused on purpose
    for my $value ($self->sorted_swords($tag))
    {
      print "$tag: $value\n" unless exists $self->{HITS}{$tag}{lc($value)};
    }
  }
  print "\n";
}


1;
