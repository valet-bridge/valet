#!perl

package Whole;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib './Components';

use Components::Abbr;
use Components::Age;
use Components::Ambiguous;
use Components::Bot;
use Components::Captain;
use Components::City;
use Components::Club;
use Components::Color;
use Components::Country;
use Components::Destroy;
use Components::First;
use Components::Form;
use Components::Fun;
use Components::Gender;
use Components::Iterator;
use Components::Meet;
use Components::Nationality;
use Components::Organization;
use Components::Other;
use Components::Particle;
use Components::Person;
use Components::Quarter;
use Components::Region;
use Components::Scoring;
use Components::Sponsor;
use Components::Stage;
use Components::Time;
use Components::Tname;
use Components::Tword;
use Components::University;
use Components::Zone;


my %TAGS =
(
  ABBR => \&Components::Abbr::set_hashes,
  AGE => \&Components::Age::set_hashes,
  AMBIGUOUS => \&Components::Ambiguous::set_hashes,
  BOT => \&Components::Bot::set_hashes,
  CAPTAIN => \&Components::Captain::set_hashes,
  CITY => \&Components::City::set_hashes,
  CLUB => \&Components::Club::set_hashes,
  COLOR => \&Components::Color::set_hashes,
  COUNTRY => \&Components::Country::set_hashes,
  DESTROY => \&Components::Destroy::set_hashes,
  FIRST => \&Components::First::set_hashes,
  FORM => \&Components::Form::set_hashes,
  FUN => \&Components::Fun::set_hashes,
  GENDER => \&Components::Gender::set_hashes,
  ITERATOR => \&Components::Iterator::set_hashes,
  MEET => \&Components::Meet::set_hashes,
  NATIONALITY => \&Components::Nationality::set_hashes,
  ORGANIZATION => \&Components::Organization::set_hashes,
  OTHER => \&Components::Other::set_hashes,
  PARTICLE => \&Components::Particle::set_hashes,
  PERSON => \&Components::Person::set_hashes,
  QUARTER => \&Components::Quarter::set_hashes,
  REGION => \&Components::Region::set_hashes,
  SCORING => \&Components::Scoring::set_hashes,
  SPONSOR => \&Components::Sponsor::set_hashes,
  STAGE => \&Components::Stage::set_hashes,
  TIME => \&Components::Time::set_hashes,
  TNAME => \&Components::Tname::set_hashes,
  TWORD => \&Components::Tword::set_hashes,
  UNIVERSITY => \&Components::University::set_hashes,
  ZONE => \&Components::Zone::set_hashes
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
  return $self->{SWORDS}{$tag}{$part};
}


sub get_multi
{
  my ($self, $tag, $part) = @_;
  return $self->{MWORDS}{$tag}{$part};
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


1;
