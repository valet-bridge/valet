#!perl

package Email::Countries;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($COUNTRIES_HASH);

my %COUNTRIES =
(
  'all @ sea.co.uk' => 'Great Britain',
  'amor y pasion @ argentina. com' => 'Argentina',
  'askme@suis.ici' => 'France',
  'bak@ein stein.no' => 'Norway',
  'bohhhh ? @ . sicily' => 'Italy',
  'bridge @tout va.com' => 'France',
  'bridge la nuit @wa dodo.fr' => 'France',
  'confit@cépes.foiegras' => 'France',
  'confiture@l.orange' => 'France',
  'coucou.toi @ bjr' => 'France',
  'crazy boards @ goulash.fr' => 'France',
  'dans les airs@.fr' => 'France',
  'dior j\'adore@aol.com' => 'France',
  'faffing about @ home.co.uk' => 'Great Britain',
  'fair play@orange.fr' => 'France',
  'felixthecat@libero come l\'aria.it' => 'Italy',
  'fete vot choix @serie.com' => 'France',
  'giscard.dieu@ wanadoo.fr' => 'France',
  'goro profesora@abv.bg' => 'Bulgaria',
  'heia viking@.no' => 'Norway',
  'hope 4@majorbogazici.com' => 'Turkey',
  'i have @ ask me.de' => 'Germany',
  'ici et ailleurs@on earth.com' => 'France',
  'il bacio@anna.provence' => 'France',
  'in the wind@hotmail.it' => 'Italy',
  'itaca@tiscali. it' => 'Italy',
  'j-aime-les-chats@la.folie' => 'France',
  'je respecte@je suis.com' => 'France',
  'jerzys @. pl' => 'Poland',
  'jura...@la vie est belle' => 'France',
  'jura@poligny.comtévinjaune' => 'France',
  'kisifrotte@6 piques.fr' => 'France',
  'labouteillealamer@ocean.flotte' => 'France',
  'lapin@clapier.terrier' => 'France',
  'le boson@de higgs.fr' => 'France',
  'le bout du monde@free.fr' => 'France',
  'le pont des soupirs@venise.it' => 'Italy',
  'le sourire@wanadoo.fr' => 'France',
  'le-seul-vrai-l@pin-de.bbo' => 'France',
  'les pouces verts @ .fr' => 'France',
  'linguist @.edu.tr' => 'Turkey',,
  'mina vagante@.it' => 'Italy',
  'moi @free.fr' => 'France',
  'muscadet s et m@vertou.com' => 'France',
  'my nick here@wp.pl' => 'Poland',
  'namo govinda@!heart.in' => 'India',
  'nettoyeur@oudini.nébuleuse' => 'France',
  'niveau mondain.net@ubridge.fr' => 'France',
  'no press.me@ thx.fr' => 'France',
  'none@.italia' => 'Italy',
  'oida @ouden. eidos' => 'Greece',
  'old soldiers@just fade away.de' => 'Germany',
  'on apprend@tous les jours.com' => 'France',
  'on request@libero.it' => 'Italy',
  'on the road again @ here . nl' => 'Netherlands',
  'on_the_way@forum.de (~sef' => 'Germany',
  'or@nge.fr 1 t' => 'France',
  'oubliez.moi@la poste' => 'France',
  'paradis @ciel.com' => 'France',
  'pasdem@uxentre.nous' => 'France',
  'pffff@.colle pas' => 'France',
  'phil.tag@ unexprt vry malheureux' => 'France',
  'plaisir de jouer@free.fr' => 'France',
  'poussinet@tout mignon.love' => 'France',
  'prince castle @ wp.pl' => 'Poland',
  'private@fit.fr' => 'France',
  'private@sm.pl' => 'Poland',
  'progresse@vue.d\'oeil' => 'France',
  'prudence@sureté.jeu' => 'France',
  'på@forespørsel.no' => 'Norway',
  'qq part @orange.fr' => 'France',
  'rarasoft @org.mokba.russki' => 'Russia',
  'rosas sin espinas @.com' => 'Spain',
  'se non ora, quando?@.it' => 'Italy',
  'se proprio serve@ladico.it' => 'Italy',
  'smile smile@smile.nl' => 'Netherlands',
  'soleil @.com' => 'France',
  'sotto come un rospo@tin.it' => 'Italy',
  'stars  express@club.bg' => 'Bulgaria',
  'sur @wanadoo.fr' => 'France',
  'team f.asso.@orange.fr' => 'France',
  'www @.it' => 'Italy',
  'www bohhhh?@.it' => 'Italy',
  'x gli amici@.it' => 'Italy',
  'xxx@xxx com.tr' => 'Turkey',
  'xxx@xyz.it ilacy member' => 'Italy',
  'youpi@bonheur.libre' => 'France',
);

our $COUNTRIES_HASH = \%COUNTRIES;

1;
