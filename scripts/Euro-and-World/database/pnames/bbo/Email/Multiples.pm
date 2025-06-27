#!perl

package Email::Multiples;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($MULTIPLES_HASH);

my %MULTIPLES =
(
  '2/1@paragragh22.com' => [ SYSTEM => '2/1@paragragh22.com' ],
  '2/1gf@km.com' => [ SYSTEM => '2/1gf@km.com' ],
  '6egil(egil@nerheim.nu' => [ OPEN => 'Egil', EMAIL => 'egil@nerheim.nu' ],
  '88@yaman.com2breslau' => [ EMAIL => '88@yaman.com', CITY => 'Wroclaw', COUNTRY => 'Poland' ],
  'abe@iki.fi,livingingermany' => [ EMAIL => 'abe@iki.fi', COUNTRY => 'Germany' ],
  'advanced++@abv.bg' => [ LEVEL => 'Advanced', COUNTRY => 'Bulgaria' ],
  'ajay(28)bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'al@morglia.net-bboitalia' => [ EMAIL => 'al@morglia.net', COUNTRY => 'Italy' ],
  'ali@ali.com' => [ OPEN => 'Ali' ],
  'anna@anna.com' => [ OPEN => 'Anna' ],
  'avec.jac@mennecy' => [ CITY => 'Mennecy', COUNTRY => 'France' ],
  'beniopszczola@o2.plolsztyn' => [ EMAIL => 'beniopszczola@o2.pl', CITY => 'Olsztyn', COUNTRY => 'Poland' ],
  'bulova@nyct.netlessonsavl' => [ EMAIL => 'bulova@nyct.net', LEVEL => 'Expert' ],
  'burdigala@port.de.la.lune' => [ CITY => 'Bordeaux', COUNTRY => 'France' ],
  'carlcsc@yahoo.comglm' => [ EMAIL => 'carlcsc@yahoo.com glm', 'LEVEL' => 'Life Master' ],
  'cat_shit@hotmail.comnazilli' => [ CITY => 'Nazilli', COUNTRY => 'Turkey' ],
  'cilegoncity@kota.com' => [ CITY => 'Cilegon', COUNTRY => 'Indonesia' ],
  'cpt64@free.frbiarritz' => [ EMAIL => 'cpt64@free.fr', CITY => 'Biarritz', COUNTRY => 'France' ],
  'dan@whoknows.com' => [ OPEN => 'Dan' ],
  'diko65@abv.bg.kostenetc' => [ EMAIL => 'diko65@abv.bg', CITY => 'Kostenets', COUNTRY => 'Bulgaria' ],
  'dogustanexper@ahmetizm.xxx' => [ LEVEL => 'Expert' ],
  'eat@vmg2.bekasi' => [ 'CITY' => 'Bekasi', COUNTRY => 'Indonesia' ],
  'expert.@.com' => [ LEVEL => 'Expert' ],
  'expert\'@expert.com' => [ LEVEL => 'Expert' ],
  'fantoine:tonino947@hotmail.com' => [ OPEN => 'Antoine', EMAIL => 'tonino947@hotmail.com' ],
  'fe@ugm.yk' => [ UNIVERSITY => 'Universitas Gadjah Mada', COUNTRY => 'Indonesia' ],
  'franmo@gmail.comjunior' => [ OPEN => 'Junior', EMAIL => 'franmo@gmail.com' ],
  'g.virchick@verizon.net(boston' => [ CITY => 'Boston', COUNTRY => 'USA', EMAIL => 'g.virchick@verizon.net' ],
  'gentingisland@yahoo.my.com' => [ REGION => 'Genting Highlands', COUNTRY => 'Malaysia' ],
  'giasmpierodionigiregione@alice.it' => [ OPEN => 'Giampiero Dionigi', COUNTRY => 'Italy' ],
  'gjay(29)bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'gjs@autograf.pl7725kraków' => [ EMAIL => 'gjs@autograf.pl', CITY => 'Krakow', COUNTRY => 'Poland' ],
  'gosh59@abv.bg;sofiamladost1' => [ EMAIL => 'gosh59@abv.bg', CITY => 'Sofia', COUNTRY => 'Bulgaria' ],
  'guy@warwick.hm' => [ CITY => 'Watford', COUNTRY => 'England' ],
  'harry@bridge.com' => [ OPEN => 'Harry' ],
  'hehe@hehe.pl.wroclaw-raj' => [ CITY => 'Wroclaw', COUNTRY => 'Poland' ],
  'improving@bridge.com' => [ LEVEL => 'Intermediate' ],
  'ina64666@yahoo.co.id' => [ EMAIL => '64666@yahoo.co.id', COUNTRY => 'Indonesia' ],
  'irelandmuriel@hotmail.com' => [ EMAIL => 'muriel@hotmail.com', COUNTRY => 'Ireland' ],
  'jay(28)bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'jemmabe@yahoo.fr(liege-belgium' => [ EMAIL => 'jemmabe@yahoo.fr', CITY => 'Liège', COUNTRY => 'Belgium' ],
  'kamalkumarnaguri1950@g mail . com' => [ OPEN => 'Kamal Kumar', EMAIL => 'naguri1950@gmail.com' ],
  'liz//neg.dble/jac2nt/gerber@nt' => [ OPEN => 'Liz' ],
  'luigifilippo.tinellidigorla@fastwebnet.i' => [ OPEN => 'Luigi Filippo TINELLI', CITY => 'Milan', COUNTRY => 'Italy' ],
  'margokw@aol.comsocal' => [ EMAIL => 'margokw@aol.com', REGION => 'Southern California' ],
  'marisa.@cantabriainfinita' => [ OPEN => 'Marisa', REGION => 'Cantabria' ],
  'milan.italy@march.1963' => [ CITY => 'Milan', COUNTRY => 'Italy' ],
  'nazmul.haq@physics' => [ OPEN => 'Nazmul Haq' ],
  'notalways@exp.com' => [ LEVEL => 'Advanced' ],
  'olivier@40.fr' => [ OPEN => 'Olivier', COUNTRY => 'France' ],
  'pablo.valencia@anti.gua' => [ OPEN => 'Pablo Valencia', COUNTRY => 'Antigua and Barbuda' ],
  'patrice.pauly@muret' => [ OPEN => 'Patrice Pauly', CITY => 'Muret', COUNTRY => 'France' ],
  'playersinuae,ing.akem@gmail.com' => [ EMAIL => 'ing.akem@gmail.com', COUNTRY => 'United Arab Emirates' ],
  'poland@junior.bridge_capital' => [ OPEN => 'Junior', COUNTRY => 'Poland' ],
  'princesaestigarribia@hotmail.comtreboles' => [ CITY => 'Princesa Estigarribia', COUNTRY => 'Paraguay' ],
  'realexpert,jan.gronlund3@getmail.no' => [ EMAIL => 'jan.gronlund3@getmail.no', LEVEL => 'Expert' ],
  'rechtsanwaltyetkinadar@hotmail.com' => [ EMAIL => 'yetkinadar@hotmail.com', COUNTRY => 'Germany' ],
  'rgpune@yahoo.com,iit-b95' => [ EMAIL => 'rgpune@yahoo.com', COUNTRY => 'India' ],
  'rreggi@wp.plbydgoszcz' => [ EMAIL => 'rreggi@wp.pl', CITY => 'Bydgoszcz', COUNTRY => 'Poland' ],
  'sam aka showle@aol.com' => [ OPEN => 'Sam', EMAIL => 'showle@aol.com' ],
  'sarel.king@013netnot' => [ OPEN => 'Sarel King' ],
  'seterahsaja@up2u.com' => [  COUNTRY => 'Indonesia' ],
  'simone@lovethegame.com' => [ OPEN => 'Simone' ],
  'sneil-glm-timm@pitt.edu' => [ OPEN => 'Neil TIMM', 'EMAIL' => '@timm@pitt.edu', LEVEL => 'Life Master' ],
  'sometimesexpert@advanced.com' => [ LEVEL => 'Advanced' ],
  'sono.amoroso@bergamo' => [ CITY => 'Bergamo', COUNTRY => 'Italy' ],
  'st.josephkleak@yahoo.com' => [ EMAIL => 'kleak@yahoo.com', CITY => 'Manado', COUNTRY => 'Indonesia' ],
  'syaloomtondano.@com' => [ CITY => 'Tondano', COUNTRY => 'Indonesia' ],
  'tahirosmantaos_tr@yahoo.com' => [ OPEN => 'Tahir Osman', EMAIL => 'taos_tr@yahoo.com' ],
  'tonseatondano,kendis,gorontalo,.@.com' => [ CITY => 'Tondano', COUNTRY => 'Indonesia' ],
  'toulouse@villerose.com' => [ CITY => 'Toulouse', COUNTRY => 'France' ],
  'vicsartor/vsartor77@aol.com' => [ OPEN => 'Vic Sartor', EMAIL => 'vsartor77@aol.com' ],
  'watford@around.m25.london' => [ CITY => 'Watford', COUNTRY => 'England' ],
  'wojchr@op.plwarszawa' => [ EMAIL => 'wojchr@op.pl', CITY => 'Warsaw', COUNTRY => 'Poland' ],

  'neg=dbl/1nt@bbo.ro' => [ SYSTEM => 'neg=dbl/1nt', COUNTRY => 'Romania' ],

  'abural@(hotmail)(gmail).com' => [ EMAIL => 'abural@gmail.com'  ],

  'massimomongini@.it' => [ USER_ONE => 'Massimo', USER_TWO => 'Mongoni', COUNTRY => 'Italy' ],
  'marcelvilleneuve@.ca' => [ USER_ONE => 'Marcel', USER_TWO => 'Villeneuve', COUNTRY => 'Canada' ],
  'luigidagmarmiele@.com' => [ USER_ONE => 'Luigi', USER_TWO => 'Miele', COUNTRY => 'Italy' ],
  'roger.squarcioni@.fr' => [ USER_ONE => 'Roger', USER_TWO => 'Squarcioni', COUNTRY => 'France' ],
  'bjorn.ahlm@comhem.nospam.se' => [ USER_ONE => 'Bjorn', USER_TWO => 'Ahlm', COUNTRY => 'Sweden' ],
  'ministre@impots.gouv.fr' => [ COUNTRY => 'France' ],

  'mlandy/woolsey@j2st.nmf.4ºsf.rjo' => [ SYSTEM => 'mlandy/woolsey@j2st.nmf.4ºsf.rjo' ],
  'mosher/mlandy@j2st.nmf.4ºsf.rjo' => [ SYSTEM => 'mosher/mlandy@j2st.nmf.4ºsf.rjo' ],

);

our $MULTIPLES_HASH = \%MULTIPLES;

1;
