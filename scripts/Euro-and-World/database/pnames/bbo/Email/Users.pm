#!perl

package Email::Users;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($USERS_HASH);

my %USERS =
(
  'ana_maria_gradinariu' => [ EMAIL_FIRST => 'Ana Maria', EMAIL_LAST => 'Gradinariu' ],
  'ann.karin.fuglestad' => [ EMAIL_FIRST => 'Ann Karin', EMAIL_LAST => 'Fuglestad' ],
  'marjou.marie.france' => [ EMAIL_FIRST => 'Marie France', EMAIL_LAST => 'Marjou' ],
  'big.john.douglas' => [ EMAIL_FIRST => 'John', EMAIL_LAST => 'Douglas' ],
  'geir.egil.bergheim' => [ EMAIL_FIRST => 'Geir Egil', EMAIL_LAST => 'Bergheim' ],
  'brunet.marie-jeanne' => [ EMAIL_FIRST => 'Marie-Jeanne', EMAIL_LAST => 'Brunet' ],
  'cornut.marie-jean' => [ EMAIL_FIRST => 'Marie-Jean', EMAIL_LAST => 'Cornut' ],
  'c.w.van.schouwenburg' => [ EMAIL_INITIALS => 'C. W.', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Schouwenburg' ],
  'garzena.jean-pierre' => [ EMAIL_FIRST => 'Jean-Pierre', EMAIL_LAST => 'Garzena' ],
  'eva.francoise.morel' => [ EMAIL_FIRST => 'Eva Francoise', EMAIL_LAST => 'Morel' ],
  'johan.de.ridder' => [ EMAIL_FIRST => 'Johan', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Ridder' ],
  'fred.de.smeth' => [ EMAIL_FIRST => 'Fred', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Smeth' ],
  'a.c.g.huiskamp' => [ EMAIL_INITIALS => 'A. C. G.', EMAIL_LAST => 'Huiskamp' ],
  'ana_p_f_cabral' => [ EMAIL_FIRST => 'Ana', EMAIL_INITIALS => 'P. F.', EMAIL_LAST => 'Cabral' ],
  'j.h.a.warmerdam' => [ EMAIL_INITIALS => 'J. H. A.', EMAIL_LAST => 'Warmerdam' ],
  'joop.van.der.harst' => [ EMAIL_FIRST => 'Joop', EMAIL_PARTICLES => 'van der', EMAIL_LAST => 'Harst' ],
  'dupont.jean_pierre' => [ EMAIL_FIRST => 'Jean-Pierre', EMAIL_LAST => 'Dupont' ],
  'orville_st.clair' => [ EMAIL_FIRST => 'Orville', EMAIL_LAST => 'St. Clair' ],
  'patrice_bernard.fontaine' => [ EMAIL_FIRST => 'Patrice Bernard', EMAIL_LAST => 'Fontaine' ],
  'georgi._rachev' => [ EMAIL_FIRST => 'Georgi', EMAIL_LAST => 'Rachev' ],
  'henk-alie.van.dijk' => [ EMAIL_FIRST => 'Henk Alie', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Dijk' ],
  'h.peter-mayr' => [ EMAIL_INITIALS => 'H.', EMAIL_LAST => 'Peter-Mayr' ],
  'olivier.de-mourgues' => [ EMAIL_FIRST => 'Olivier', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Mourgues' ],
  'gillet.jean-paul' => [ EMAIL_FIRST => 'Jean-Paul', EMAIL_LAST => 'Gillet' ],
  'rita.morbee-willems' => [ EMAIL_FIRST => 'Rita', EMAIL_LAST => 'Morbee-Williams' ],
  'robert.von-essen' => [ EMAIL_FIRST => 'Robert', EMAIL_PARTICLES => 'von', EMAIL_LAST => 'Essen' ],
  'alex.van.reenen' => [ EMAIL_FIRST => 'Alex', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Reenen' ],
  'bernt.ivar.amundsen' => [ EMAIL_FIRST => 'Bernt Ivar', EMAIL_LAST => 'Amundsen' ],
  'axel_kvist_nielsen' => [ EMAIL_FIRST => 'Axel', EMAIL_LAST => 'Kvist Nielsen' ],
  'simian.anne-marie' => [ EMAIL_FIRST => 'Anne-Marie', EMAIL_LAST => 'Simian' ],
  'nicole.van-poperinghe' => [ EMAIL_FIRST => 'Nicole', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Poperinghe' ],
  'moreaux.jean-michel' => [ EMAIL_FIRST => 'Jean-Michel', EMAIL_LAST => 'Moreaux' ],
  'andrea.de.marinis' => [ EMAIL_FIRST => 'Andrea', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Marinis' ],
  'else.marie.stuen' => [ EMAIL_FIRST => 'Else-Marie', EMAIL_LAST => 'Stuen' ],
  'bjorn.erik.eliassen' => [ EMAIL_FIRST => 'Bjorn Erik', EMAIL_LAST => 'Eliassen' ],
  'eva.lis.thuresson' => [ EMAIL_FIRST => 'Eva Lis', EMAIL_LAST => 'Thuresson' ],
  'erik.ten.oever' => [ EMAIL_FIRST => 'Erik', EMAIL_PARTICLES => 'ten', EMAIL_LAST => 'Oever' ],
  'steve_de_roos' => [ EMAIL_FIRST => 'Steve', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Roos' ],
  'jean.michel.moulin' => [ EMAIL_FIRST => 'Jean Michel', EMAIL_LAST => 'Moulin' ],
  'jan.roger.stromsvaag' => [ EMAIL_FIRST => 'Jan Roger', EMAIL_LAST => 'Stromsvaag' ],
  'arthur.r.w.hughes' => [ EMAIL_FIRST => 'Arthur', EMAIL_INITIALS => 'R. W.', EMAIL_LAST => 'Hughes' ],
  'c.van.der.meijden' => [ EMAIL_INITIALS => 'C.', EMAIL_PARTICLES => 'van der', EMAIL_LAST => 'Meijden' ],
  'f_van_der_loo' => [ EMAIL_INITIALS => 'F.', EMAIL_PARTICLES => 'van der', EMAIL_LAST => 'Loo' ],
  'erkki.juuri-oja' => [ EMAIL_FIRST => 'Erkki', EMAIL_LAST => 'Juuri-Oja' ],
  'pirjo.juuri-oja' => [ EMAIL_FIRST => 'Pirjo', EMAIL_LAST => 'Juuri-Oja' ],
  'm.roovers-goverde' => [ EMAIL_INITIALS => 'M.', EMAIL_LAST => 'Roovers-Goverde' ],
  'alexander.gb.gordy' => [ EMAIL_FIRST => 'Alexander', EMAIL_INITIALS => 'G. B.', EMAIL_LAST => 'Gordy' ],
  'c.christine.miller' => [ EMAIL_INITIALS => 'C.', EMAIL_FIRST => 'Christine', EMAIL_LAST => 'Miller' ],
  'guy.van.middelem' => [ EMAIL_FIRST => 'Guy', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Middelem' ],
  'hans.de.groot' => [ EMAIL_FIRST => 'Hans', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Groot' ],
  'j.ten.dam' => [ EMAIL_INITIALS => 'J.', EMAIL_PARTICLES => 'ten', EMAIL_LAST => 'Dam' ],
  'mieke.van.meyel' => [ EMAIL_FIRST => 'Mieke', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Meyel' ],
  'miren.jean.marie' => [ EMAIL_FIRST => 'Jean Marie', EMAIL_LAST => 'Miren' ],
  'ole.jorgen.olsen' => [ EMAIL_FIRST => 'Ole Jorgen', EMAIL_LAST => 'Olsen' ],
  'palle.holm.pedersen' => [ EMAIL_FIRST => 'Palle', EMAIL_LAST => 'Holm Pedersen' ],
  'rem.van.hooff' => [ EMAIL_FIRST => 'Rem', EMAIL_PARTICLES => 'van', EMAIL_LAST => 'Hooff' ],
  's_james_elliott' => [ EMAIL_INITIALS => 'S.', EMAIL_FIRST => 'James', EMAIL_LAST => 'Elliott' ],
  'vincent_de_pagter' => [ EMAIL_FIRST => 'Vincent', EMAIL_PARTICLES => 'de', EMAIL_LAST => 'Pagter' ],
);

our $USERS_HASH = \%USERS;

sub lookup
{
  my ($user) = @_;
  if (exists $USERS_HASH->{$user})
  {
    return $USERS_HASH->{$user};
  }
  else
  {
    return '';
  }
}

1;
