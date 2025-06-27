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
  '88@yaman.com2breslau' => [ EMAIL_CITY => 'Wroclaw', EMAIL_COUNTRY => 'Poland', EMAIL => '88@yaman.com'  ],
  'abe@iki.fi,livingingermany' => [ EMAIL => 'abe@iki.fi', COUNTRY => 'Germany' ],
  'abural@(hotmail)(gmail).com' => [ EMAIL => 'abural@gmail.com'  ],
  'advanced++@abv.bg' => [ LEVEL => 'Advanced', EMAIL_COUNTRY => 'Bulgaria' ],
  'ajay(28)bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'al@morglia.net-bboitalia' => [ EMAIL_COUNTRY => 'Italy', EMAIL => 'al@morglia.net' ],
  'ali@ali.com' => [ OPEN => 'Ali' ],
  'anna@anna.com' => [ OPEN => 'Anna' ],
  'avec.jac@mennecy' => [ EMAIL_CITY => 'Mennecy', EMAIL_COUNTRY => 'France' ],
  'beniopszczola@o2.plolsztyn' => [ EMAIL_CITY => 'Olsztyn', EMAIL_COUNTRY => 'Poland', EMAIL => 'beniopszczola@o2.pl' ],
  'bjorn.ahlm@comhem.nospam.se' => [ USER_ONE => 'Bjorn', USER_TWO => 'Ahlm', EMAIL_COUNTRY => 'Sweden' ],
  'bulova@nyct.netlessonsavl' => [ EMAIL => 'bulova@nyct.net', LEVEL => 'Expert' ],
  'burdigala@port.de.la.lune' => [ EMAIL_CITY => 'Bordeaux', EMAIL_COUNTRY => 'France' ],
  'carlcsc@yahoo.comglm' => [ EMAIL => 'carlcsc@yahoo.com glm', 'LEVEL' => 'Life Master' ],
  'cat_shit@hotmail.comnazilli' => [ EMAIL_CITY => 'Nazilli', EMAIL_COUNTRY => 'Turkey' ],
  'cilegoncity@kota.com' => [ EMAIL_CITY => 'Cilegon', EMAIL_COUNTRY => 'Indonesia' ],
  'cpt64@free.frbiarritz' => [ EMAIL_CITY => 'Biarritz', EMAIL_COUNTRY => 'France', EMAIL => 'cpt64@free.fr' ],
  'dan@whoknows.com' => [ OPEN => 'Dan' ],
  'diko65@abv.bg.kostenetc' => [ EMAIL_CITY => 'Kostenets', EMAIL_COUNTRY => 'Bulgaria', EMAIL => 'diko65@abv.bg' ],
  'dogustanexper@ahmetizm.xxx' => [ LEVEL => 'Expert' ],
  'eat@vmg2.bekasi' => [ 'EMAIL_CITY' => 'Bekasi', EMAIL_COUNTRY => 'Indonesia' ],
  'expert.@.com' => [ LEVEL => 'Expert' ],
  'expert\'@expert.com' => [ LEVEL => 'Expert' ],
  'fantoine:tonino947@hotmail.com' => [ OPEN => 'Antoine', EMAIL => 'tonino947@hotmail.com' ],
  'fe@ugm.yk' => [ EMAIL_COUNTRY => 'Indonesia', EMAIL_UNIVERSITY => 'Universitas Gadjah Mada' ],
  'franmo@gmail.comjunior' => [ OPEN => 'Junior', EMAIL => 'franmo@gmail.com' ],
  'g.virchick@verizon.net(boston' => [ EMAIL_CITY => 'Boston', EMAIL_COUNTRY => 'USA', EMAIL => 'g.virchick@verizon.net' ],
  'gentingisland@yahoo.my.com' => [ EMAIL_REGION => 'Genting Highlands', EMAIL_COUNTRY => 'Malaysia' ],
  'giasmpierodionigiregione@alice.it' => [ OPEN => 'Giampiero Dionigi', EMAIL_COUNTRY => 'Italy' ],
  'gjay(29)bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'gjs@autograf.pl7725kraków' => [ EMAIL_CITY => 'Krakow', EMAIL_COUNTRY => 'Poland', EMAIL => 'gjs@autograf.pl' ],
  'gosh59@abv.bg;sofiamladost1' => [ EMAIL_CITY => 'Sofia', EMAIL_COUNTRY => 'Bulgaria', EMAIL => 'gosh59@abv.bg' ],
  'guy@warwick.hm' => [ EMAIL_CITY => 'Watford', EMAIL_COUNTRY => 'England' ],
  'harry@bridge.com' => [ OPEN => 'Harry' ],
  'hehe@hehe.pl.wroclaw-raj' => [ EMAIL_CITY => 'Wroclaw', EMAIL_COUNTRY => 'Poland' ],
  'improving@bridge.com' => [ LEVEL => 'Intermediate' ],
  'ina64666@yahoo.co.id' => [ EMAIL_COUNTRY => 'Indonesia', EMAIL => '64666@yahoo.co.id' ],
  'irelandmuriel@hotmail.com' => [ EMAIL_COUNTRY => 'Ireland', EMAIL => 'muriel@hotmail.com' ],
  'jay(28)bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'jemmabe@yahoo.fr(liege-belgium' => [ EMAIL_CITY => 'Liège', EMAIL_COUNTRY => 'Belgium', EMAIL => 'jemmabe@yahoo.fr' ], 
  'kamalkumarnaguri1950@g mail . com' => [ OPEN => 'Kamal Kumar', EMAIL => 'naguri1950@gmail.com' ],
  'liz//neg.dble/jac2nt/gerber@nt' => [ OPEN => 'Liz' ],
  'luigidagmarmiele@.com' => [ USER_ONE => 'Luigi', USER_TWO => 'Miele', EMAIL_COUNTRY => 'Italy' ],
  'luigifilippo.tinellidigorla@fastwebnet.i' => [ OPEN => 'Luigi Filippo TINELLI', EMAIL_CITY => 'Milan', EMAIL_COUNTRY => 'Italy' ],
  'marcelvilleneuve@.ca' => [ USER_ONE => 'Marcel', USER_TWO => 'Villeneuve', EMAIL_COUNTRY => 'Canada' ],
  'margokw@aol.comsocal' => [ EMAIL_REGION => 'Southern California', EMAIL => 'margokw@aol.com' ],
  'marisa.@cantabriainfinita' => [ OPEN => 'Marisa', EMAIL_REGION => 'Cantabria' ],
  'massimomongini@.it' => [ USER_ONE => 'Massimo', USER_TWO => 'Mongoni', EMAIL_COUNTRY => 'Italy' ],
  'milan.italy@march.1963' => [ EMAIL_CITY => 'Milan', EMAIL_COUNTRY => 'Italy' ],
  'ministre@impots.gouv.fr' => [ EMAIL_COUNTRY => 'France' ],
  'mlandy/woolsey@j2st.nmf.4ºsf.rjo' => [ SYSTEM => 'mlandy/woolsey@j2st.nmf.4ºsf.rjo' ],
  'mosher/mlandy@j2st.nmf.4ºsf.rjo' => [ SYSTEM => 'mosher/mlandy@j2st.nmf.4ºsf.rjo' ],
  'nazmul.haq@physics' => [ OPEN => 'Nazmul Haq' ],
  'neg=dbl/1nt@bbo.ro' => [ SYSTEM => 'neg=dbl/1nt', EMAIL_COUNTRY => 'Romania' ],
  'notalways@exp.com' => [ LEVEL => 'Advanced' ],
  'olivier@40.fr' => [ OPEN => 'Olivier', EMAIL_COUNTRY => 'France' ],
  'pablo.valencia@anti.gua' => [ OPEN => 'Pablo Valencia', EMAIL_COUNTRY => 'Antigua and Barbuda' ],
  'patrice.pauly@muret' => [ OPEN => 'Patrice Pauly', EMAIL_CITY => 'Muret', EMAIL_COUNTRY => 'France' ],
  'playersinuae,ing.akem@gmail.com' => [ EMAIL_COUNTRY => 'United Arab Emirates', EMAIL => 'ing.akem@gmail.com' ],
  'poland@junior.bridge_capital' => [ OPEN => 'Junior', EMAIL_COUNTRY => 'Poland' ],
  'princesaestigarribia@hotmail.comtreboles' => [ EMAIL_CITY => 'Princesa Estigarribia', EMAIL_COUNTRY => 'Paraguay' ],
  'realexpert,jan.gronlund3@getmail.no' => [ EMAIL => 'jan.gronlund3@getmail.no', LEVEL => 'Expert' ],
  'rechtsanwaltyetkinadar@hotmail.com' => [ EMAIL_COUNTRY => 'Germany', EMAIL => 'yetkinadar@hotmail.com' ],
  'rgpune@yahoo.com,iit-b95' => [ EMAIL_COUNTRY => 'India', EMAIL => 'rgpune@yahoo.com' ],
  'roger.squarcioni@.fr' => [ USER_ONE => 'Roger', USER_TWO => 'Squarcioni', EMAIL_COUNTRY => 'France' ],
  'rreggi@wp.plbydgoszcz' => [ EMAIL_CITY => 'Bydgoszcz', EMAIL_COUNTRY => 'Poland', EMAIL => 'rreggi@wp.pl' ],
  'sam aka showle@aol.com' => [ OPEN => 'Sam', EMAIL => 'showle@aol.com' ],
  'sarel.king@013netnot' => [ OPEN => 'Sarel King' ],
  'seterahsaja@up2u.com' => [  EMAIL_COUNTRY => 'Indonesia' ],
  'simone@lovethegame.com' => [ OPEN => 'Simone' ],
  'sneil-glm-timm@pitt.edu' => [ OPEN => 'Neil TIMM', 'EMAIL' => '@timm@pitt.edu', LEVEL => 'Life Master' ],
  'sometimesexpert@advanced.com' => [ LEVEL => 'Advanced' ],
  'sono.amoroso@bergamo' => [ EMAIL_CITY => 'Bergamo', EMAIL_COUNTRY => 'Italy' ],
  'st.josephkleak@yahoo.com' => [ EMAIL_CITY => 'Manado', EMAIL_COUNTRY => 'Indonesia', EMAIL => 'kleak@yahoo.com' ],
  'syaloomtondano.@com' => [ EMAIL_CITY => 'Tondano', EMAIL_COUNTRY => 'Indonesia' ],
  'tahirosmantaos_tr@yahoo.com' => [ OPEN => 'Tahir Osman', EMAIL => 'taos_tr@yahoo.com' ],
  'tonseatondano,kendis,gorontalo,.@.com' => [ EMAIL_CITY => 'Tondano', EMAIL_COUNTRY => 'Indonesia' ],
  'toulouse@villerose.com' => [ EMAIL_CITY => 'Toulouse', EMAIL_COUNTRY => 'France' ],
  'vicsartor/vsartor77@aol.com' => [ OPEN => 'Vic Sartor', EMAIL => 'vsartor77@aol.com' ],
  'watford@around.m25.london' => [ EMAIL_CITY => 'Watford', EMAIL_COUNTRY => 'England' ],
  'wojchr@op.plwarszawa' => [ EMAIL_CITY => 'Warsaw', EMAIL_COUNTRY => 'Poland', EMAIL => 'wojchr@op.pl' ],
);

our $MULTIPLES_HASH = \%MULTIPLES;

1;
