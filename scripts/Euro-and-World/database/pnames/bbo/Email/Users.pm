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
  'ana_maria_gradinariu' => [ USER_FIRST => 'Ana Maria', USER_LAST => 'Gradinariu' ],
  'ann.karin.fuglestad' => [ USER_FIRST => 'Ann Karin', USER_LAST => 'Fuglestad' ],
  'marjou.marie.france' => [ USER_FIRST => 'Marie France', USER_LAST => 'Marjou' ],
  'big.john.douglas' => [ USER_FIRST => 'John', USER_LAST => 'Douglas' ],
  'geir.egil.bergheim' => [ USER_FIRST => 'Geir Egil', USER_LAST => 'Bergheim' ],
  'brunet.marie-jeanne' => [ USER_FIRST => 'Marie-Jeanne', USER_LAST => 'Brunet' ],
  'cornut.marie-jean' => [ USER_FIRST => 'Marie-Jean', USER_LAST => 'Cornut' ],
  'c.w.van.schouwenburg' => [ USER_INITIALS => 'C. W.', USER_PARTICLES => 'van', USER_LAST => 'Schouwenburg' ],
  'garzena.jean-pierre' => [ USER_FIRST => 'Jean-Pierre', USER_LAST => 'Garzena' ],
  'eva.francoise.morel' => [ USER_FIRST => 'Eva Francoise', USER_LAST => 'Morel' ],
  'johan.de.ridder' => [ USER_FIRST => 'Johan', USER_PARTICLES => 'de', USER_LAST => 'Ridder' ],
  'fred.de.smeth' => [ USER_FIRST => 'Fred', USER_PARTICLES => 'de', USER_LAST => 'Smeth' ],
  'a.c.g.huiskamp' => [ USER_INITIALS => 'A. C. G.', USER_LAST => 'Huiskamp' ],
  'ana_p_f_cabral' => [ USER_FIRST => 'Ana', USER_INITIALS => 'P. F.', USER_LAST => 'Cabral' ],
  'j.h.a.warmerdam' => [ USER_INITIALS => 'J. H. A.', USER_LAST => 'Warmerdam' ],
  'joop.van.der.harst' => [ USER_FIRST => 'Joop', USER_PARTICLES => 'van der', USER_LAST => 'Harst' ],
  'dupont.jean_pierre' => [ USER_FIRST => 'Jean-Pierre', USER_LAST => 'Dupont' ],
  'orville_st.clair' => [ USER_FIRST => 'Orville', USER_LAST => 'St. Clair' ],
  'patrice_bernard.fontaine' => [ USER_FIRST => 'Patrice Bernard', USER_LAST => 'Fontaine' ],
  'georgi._rachev' => [ USER_FIRST => 'Georgi', USER_LAST => 'Rachev' ],
  'henk-alie.van.dijk' => [ USER_FIRST => 'Henk Alie', USER_PARTICLES => 'van', USER_LAST => 'Dijk' ],
  'h.peter-mayr' => [ USER_INITIALS => 'H.', USER_LAST => 'Peter-Mayr' ],
  'olivier.de-mourgues' => [ USER_FIRST => 'Olivier', USER_PARTICLES => 'de', USER_LAST => 'Mourgues' ],
  'gillet.jean-paul' => [ USER_FIRST => 'Jean-Paul', USER_LAST => 'Gillet' ],
  'rita.morbee-willems' => [ USER_FIRST => 'Rita', USER_LAST => 'Morbee-Williams' ],
  'robert.von-essen' => [ USER_FIRST => 'Robert', USER_PARTICLES => 'von', USER_LAST => 'Essen' ],
  'alex.van.reenen' => [ USER_FIRST => 'Alex', USER_PARTICLES => 'van', USER_LAST => 'Reenen' ],
  'bernt.ivar.amundsen' => [ USER_FIRST => 'Bernt Ivar', USER_LAST => 'Amundsen' ],
  'axel_kvist_nielsen' => [ USER_FIRST => 'Axel', USER_LAST => 'Kvist Nielsen' ],
  'simian.anne-marie' => [ USER_FIRST => 'Anne-Marie', USER_LAST => 'Simian' ],
  'nicole.van-poperinghe' => [ USER_FIRST => 'Nicole', USER_PARTICLES => 'van', USER_LAST => 'Poperinghe' ],
  'moreaux.jean-michel' => [ USER_FIRST => 'Jean-Michel', USER_LAST => 'Moreaux' ],
  'andrea.de.marinis' => [ USER_FIRST => 'Andrea', USER_PARTICLES => 'de', USER_LAST => 'Marinis' ],
  'else.marie.stuen' => [ USER_FIRST => 'Else-Marie', USER_LAST => 'Stuen' ],
  'bjorn.erik.eliassen' => [ USER_FIRST => 'Bjorn Erik', USER_LAST => 'Eliassen' ],
  'eva.lis.thuresson' => [ USER_FIRST => 'Eva Lis', USER_LAST => 'Thuresson' ],
  'erik.ten.oever' => [ USER_FIRST => 'Erik', USER_PARTICLES => 'ten', USER_LAST => 'Oever' ],
  'steve_de_roos' => [ USER_FIRST => 'Steve', USER_PARTICLES => 'de', USER_LAST => 'Roos' ],
  'jean.michel.moulin' => [ USER_FIRST => 'Jean Michel', USER_LAST => 'Moulin' ],
  'jan.roger.stromsvaag' => [ USER_FIRST => 'Jan Roger', USER_LAST => 'Stromsvaag' ],
  'arthur.r.w.hughes' => [ USER_FIRST => 'Arthur', USER_INITIALS => 'R. W.', USER_LAST => 'Hughes' ],
  'c.van.der.meijden' => [ USER_INITIALS => 'C.', USER_PARTICLES => 'van der', USER_LAST => 'Meijden' ],
  'f_van_der_loo' => [ USER_INITIALS => 'F.', USER_PARTICLES => 'van der', USER_LAST => 'Loo' ],
  'erkki.juuri-oja' => [ USER_FIRST => 'Erkki', USER_LAST => 'Juuri-Oja' ],
  'pirjo.juuri-oja' => [ USER_FIRST => 'Pirjo', USER_LAST => 'Juuri-Oja' ],
  'm.roovers-goverde' => [ USER_INITIALS => 'M.', USER_LAST => 'Roovers-Goverde' ],
  'alexander.gb.gordy' => [ USER_FIRST => 'Alexander', USER_INITIALS => 'G. B.', USER_LAST => 'Gordy' ],
  'c.christine.miller' => [ USER_INITIALS => 'C.', USER_FIRST => 'Christine', USER_LAST => 'Miller' ],
  'guy.van.middelem' => [ USER_FIRST => 'Guy', USER_PARTICLES => 'van', USER_LAST => 'Middelem' ],
  'hans.de.groot' => [ USER_FIRST => 'Hans', USER_PARTICLES => 'de', USER_LAST => 'Groot' ],
  'j.ten.dam' => [ USER_INITIALS => 'J.', USER_PARTICLES => 'ten', USER_LAST => 'Dam' ],
  'mieke.van.meyel' => [ USER_FIRST => 'Mieke', USER_PARTICLES => 'van', USER_LAST => 'Meyel' ],
  'miren.jean.marie' => [ USER_FIRST => 'Jean Marie', USER_LAST => 'Miren' ],
  'ole.jorgen.olsen' => [ USER_FIRST => 'Ole Jorgen', USER_LAST => 'Olsen' ],
  'palle.holm.pedersen' => [ USER_FIRST => 'Palle', USER_LAST => 'Holm Pedersen' ],
  'rem.van.hooff' => [ USER_FIRST => 'Rem', USER_PARTICLES => 'van', USER_LAST => 'Hooff' ],
  's_james_elliott' => [ USER_INITIALS => 'S.', USER_FIRST => 'James', USER_LAST => 'Elliott' ],
  'vincent_de_pagter' => [ USER_FIRST => 'Vincent', USER_PARTICLES => 'de', USER_LAST => 'Pagter' ],
  'jean-paul-fremery' => [ USER_FIRST => 'Jean-Paul', USER_LAST => 'Fremery' ],
  'stephen_yk_liu' => [ USER_FIRST => 'Stephen', USER_INITIALS => 'Y. K.', USER_LAST => 'Liu' ],
  'mehmet_ali_gunduz' => [ USER_FIRST => 'Mehmet Ali', USER_LAST => 'Gunduz' ],
  'jack_kl_wong' => [ USER_FIRST => 'Jack', USER_INITIALS => 'K. L.', USER_LAST => 'Wong' ],
  'j_tom_edwards' => [ USER_INITIALS => 'J.', USER_FIRST => 'Tom', USER_LAST => 'Edwards' ],
  'jean.claude.tremel' => [ USER_FIRST => 'Jean-Claude', USER_LAST => 'Tremel' ],
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
