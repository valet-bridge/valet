#!perl

package Email::Email;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use lib '.';
use Email::Deletions;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(looks_like);

my @PRIVATES = (
  '@no.spam',
  'ask.me@tellyou',
  'bruce.springsteen@no',
  'dont.use@com',
  'i.am@not',
  'your.request@will.be.considered',
  'ask me@o2.pl',
  'ask me@hotmail.com',
  'baboun@pourmes amis.com',
  'be cool@bbo.com',
  'be happy@fun.com',
  'be nice @ crazy . com',
  'chameleon @,hotmail.com',
  'kau tanya lah@ku.com',
  'no @no.com',
  'non ricordo@quale.it',
  'private.kol@hotmail.com',
  'private@Private.com',
  'private@gmail..com',
  'private@gmail.com',
  'private@hotmail.com',
  'private@no.spam',
  'private@private.com',
  'wong ilang@yahoo.co',
);

my %PRIVATES_HASH;
$PRIVATES_HASH{$_} = 1 for @PRIVATES;

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

my %MULTIPLES =
(
  '05353 olgierd.rb@gmail.com' => [ EMAIL => 'olgierd.rb@gmail.com' ],
  '2/1 sapanca@hotmail.com' => [ EMAIL => 'sapanca@hotmail.com' ],
  '3pik@wp.pl 5606' => [ EMAIL => '3pik@wp.pl' ],
  '6egil ( egil@nerheim.nu' => [ OPEN => 'Egil', EMAIL => 'egil@nerheim.nu' ],
  '798686368 @.qq.com' => [ EMAIL => '798686368@qq.com' ],
  '88  @ yaman.com2breslau' => [ EMAIL => '88@yaman.com', CITY => 'Wroclaw', COUNTRY => 'Poland' ],
  'abe@iki.fi, living in germany' => [ EMAIL => 'abe@iki.fi', COUNTRY => 'Germany' ],
  'ajay (28) bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'al@morglia.net - bbo italia' => [ EMAIL => 'al@morglia.net', COUNTRY => 'Italy' ],
  'al1919 @ hotmail . fr' => [ EMAIL => 'al1919@hotmail.fr' ],
  'alex ------@llibero.it' => [ EMAIL => 'alex@libero.it' ],
  'aquapharm@hotmail.com stars' => [ EMAIL => 'aquapharm.hotmail.com' ],
  'associazionebridgepotenza@gmail.com b&b' => [ EMAIL => 'associazionebridgepotenza@gmail.com'],
  'atayayaz@live.com p' => [ EMAIL => 'atayazaz@live.com' ],
  'b.holl@hccnet.nl heya sven (kramer' => [ EMAIL => 'b.holl@hccnet.nl' ],
  'bactriam@gmail.com 16794' => [ EMAIL => 'bactriam@gmail.com' ],
  'beniopszczola@o2.pl olsztyn' => [ EMAIL => 'beniopszczola@o2.pl', CITY => 'Olsztyn', COUNTRY => 'Poland' ],
  'bogdan1012@hotmail.com, ilacy member' => [ EMAIL => 'bogdan1012@hotmail.com' ],
  'bohdan.pliszka@op.pl cezar8052' => [ EMAIL => 'bohdan.pliszka@op.pl' ],
  'bruno uno@hotmail.it' => [ EMAIL => 'bruno@hotmail.it' ],
  'bulova@nyct.net lessons avl' => [ EMAIL => 'bulova@nyct.net', LEVEL => 'Expert' ],
  'c/-  admin@bilbridge.com' => [ EMAIL => 'admin@bilbridge.com' ],
  'c/- admin@bilbridge.com' => [ EMAIL => 'admin@bilbridge.com' ],
  'carlcsc@yahoo.com glm' => [ EMAIL => 'carlcsc@yahoo.com glm', 'LEVEL' => 'Life Master' ],
  'cat_shit@hotmail.com nazilli' => [ CITY => 'Nazilli', COUNTRY => 'Turkey' ],
  'cilegon city@kota.com' => [ CITY => 'Cilegon', COUNTRY => 'Indonesia' ],
  'clpirro@tin.it ilacy member' => [ EMAIL => 'clpirro@tin.it' ],
  'cpt64@free.fr biarritz' => [ EMAIL => 'cpt64@free.fr', CITY => 'Biarritz', COUNTRY => 'France' ],
  'crossft@gmail.com - 8902023' => [ EMAIL => 'crossft@gmail.com' ],
  'danmar@adinet.com.uy (uruguay' => [ EMAIL => 'danmar@adinet.com.uy' ],
  'diko65@abv.bg. kostenetc' => [ EMAIL => 'diko65@abv.bg', CITY => 'Kostenets', COUNTRY => 'Bulgaria' ],
  'drzaferjarrar@gmail.com  p' => [ EMAIL => 'drzaferjarrar@gmail.com' ],
  'dursunyildiz101@hotmail.com www.major' => [ EMAIL => 'dursunyildiz101@hotmail.com' ],
  'e-mail mark massa @yahoo.com' => [ EMAIL => 'markmassa@yahoo.com' ],
  'fantoine: tonino947@hotmail.com' => [ OPEN => 'Antoine', EMAIL => 'tonino947@hotmail.com' ],
  'fjarang dibelai jablaigtbc@y.co' => [ COUNTRY => 'Indonesia' ],
  'franmo@gmail.com junior' => [ OPEN => 'Junior', EMAIL => 'franmo@gmail.com' ],
  'gadi gadischwartz1957@gmail.c' => [ EMAIL => 'gadischwartz1957@gmail.com' ],
  'genting island@yahoo.my.com' => [ REGION => 'Genting Highlands', COUNTRY => 'Malaysia' ],
  'gervais.arlette@ wanadoow .fr' => [ EMAIL => 'gervais.arlette@wanadoo.fr' ],
  'gezi@bravosize.com tr' => [ EMAIL => 'gezo@bravosize.com.tr' ],
  'giasmpierodionigiregione @alice.it' => [ OPEN => 'Giampiero Dionigi', COUNTRY => 'Italy' ],
  'gjs@autograf.pl  7725  kraków' => [ EMAIL => 'gjs@autograf.pl', CITY => 'Krakow', COUNTRY => 'Poland' ],
  'gjay (29) bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'gosh59@abv.bg;sofia mladost1' => [ EMAIL => 'gosh59@abv.bg', CITY => 'Sofia', COUNTRY => 'Bulgaria' ],
  'grb@taigabridge.net (bil hon. dementor' => [ EMAIL => 'grb@taigabridge.net' ],
  'gsanna35@hotmail.it tolclub' => [ EMAIL => 'gsanna35@hotmail.it' ],
  'haavard7355@msn.com. low card3-5 hight' => [ EMAIL => 'haavard7355@msn.com' ],
  'hsoysuren@hotmail.com- lebenshol' => [ EMAIL => 'hsoysuren@hotmail.com' ],
  'igraia ponqkoga@gankinoto.bg' => [ COUNTRY => 'Bulgaria' ],
  'ina 64666@yahoo.co.id' => [ EMAIL => '64666@yahoo.co.id', COUNTRY => 'Indonesia' ],
  'insolar@onet.pl pid:06387' => [ EMAIL => 'insolar@onet.pl' ],
  'ireksiem1@wp.pl 08144' => [ EMAIL => 'ireksiem1@wp.pl' ],
  'ireland muriel@hotmail.com' => [ EMAIL => 'muriel@hotmail.com', COUNTRY => 'Ireland' ],
  'jagodzinski.d@wp.pl, ma, miksty' => [ EMAIL => 'jagodzinski.d@wp.pl' ],
  'jakob_k@gmx.ch st karniej 1428' => [ EMAIL => 'jakob_k@gmx.ch' ],
  'jakub_mitke@wp.pl pzbs 3856' => [ EMAIL => 'jakub_mitke@wp.pl' ],
  'janula36@wp.pl id08518' => [ EMAIL => 'janula36@wp.pl' ],
  'jay (28) bridgegoth@yahoo.fi' => [ OPEN => 'Jay', EMAIL => 'bridgegoth@yahoo.fi' ],
  'jbm@mail.bg gusto maina' => [ EMAIL => 'jbm@mail.bg' ],
  'jemmabe@yahoo.fr (liege-belgium' => [ EMAIL => 'jemmabe@yahoo.fr', CITY => 'Liège', COUNTRY => 'Belgium' ],
  'jglasspiegel @ol.com' => [ EMAIL => 'jglasspiegel@aol.com' ],
  'jmalawski@onet.pl 11153' => [ EMAIL => 'jmalawski@onet.pl' ],
  'kamal kumar naguri 1950@g mail . com' => [ OPEN => 'Kamal Kumar', EMAIL => 'naguri1950@gmail.com' ],
  'kbisson@usa.net bil member' => [ EMAIL => 'kbisson@usa.net' ],
  'keith.randall@outlook.com. p' => [ EMAIL => 'keith.randall@outlook.com' ],
  'krandall33@rogers.com  p' => [ EMAIL => 'krandall33@rogers.com' ],
  'kuhnication@msn.com-sa+ 2dwait' => [ EMAIL => 'kuhnication@msn.com' ],
  'l.ther@hotmaol .com' => [ EMAIL => '.lther@hotmail.com' ],
  'margokw@aol.com socal' => [ EMAIL => 'margokw@aol.com', REGION => 'Southern California' ],
  'mariana @ sin estrellas. com' => [ EMAIL => 'mariana@sinestrellas.com' ],
  'marisa.@ cantabria infinita' => [ OPEN => 'Marisa', REGION => 'Cantabria' ],
  'marsal24@wp.pl pzb 01845' => [ EMAIL => 'marsal24@wp.pl' ],
  'mas@tortue.fr 83' => [ EMAIL => 'mas@tortue.fr' ],
  'matarani11@yahoo.com (never pass 1 club' => [ EMAIL => 'matarani11@yahoo.com' ],
  'mertbolver@hotmail.com fn' => [ EMAIL => 'mertbolver@hotmail.com' ],
  'mietek_a49@wp.pl 05562' => [ EMAIL => 'mietek_a49@wp.pl' ],
  'msn : r_segev@hotmail.com' => [ EMAIL => 'r_segev@hotmail.com' ],
  'msn : schoi00@hotmail.com' => [ EMAIL => 'schoi00@hotmail.com' ],
  'msn: yuval_yener@hotmail.com' => [ EMAIL => 'yuval_yener@hotmail.com' ],
  'muhso_@hotmail.com salvo31 ocak 3 subar' => [ EMAIL => 'muhso_@hotmail.com' ],
  'nana1321@wp.pl 15227' => [ EMAIL => 'nana1321@wp.pl' ],
  'neo@ jeo time.com' => [ COUNTRY => 'Indonesia' ],
  'nikijan1@abv.bg u2nt pupp' => [ EMAIL => 'nikijan1@abv.bg' ],
  'nk@long.hideung / 012' => [ COUNTRY => 'Indonesia' ],
  'nur ..nurem@hotmail .com' => [ EMAIL => 'nurem@hotmail.com' ],
  'pairs sbc@qmail.com' => [ EMAIL => 'sbc@qmail.com' ],
  'pbf001@aol.com 3 way trans' => [ EMAIL => 'pbf001@aol.com' ],
  'players in uae, ing.akem@gmail.com' => [ EMAIL => 'ing.akem@gmail.com', COUNTRY => 'United Arab Emirates'],
  'popavasilebebe@yahoo.com ilacy' => [ EMAIL => 'popavasilebebe@yahoo.com' ],
  'progsign@hotmail.com or' => [ EMAIL => 'progsign@hotmail.com' ],
  'qualche.volta.la indovino@.it' => [ COUNTRY => 'Italy' ],
  'real expert, jan.gronlund3@getmail.no' => [ EMAIL => 'jan.gronlund3@getmail.no', LEVEL => 'Expert' ],
  'rechtsanwalt yetkinadar@hotmail.com' => [ EMAIL => 'yetkinadar@hotmail.com', COUNTRY => 'Germany'],
  'rgpune@yahoo.com,iit-b 95' => [ EMAIL => 'rgpune@yahoo.com', COUNTRY => 'India' ],
  'rmalda@hotmail.it b&b' => [ EMAIL => 'rmalda@hotmail.it' ],
  'roger---- @libero.it' => [ EMAIL => 'roger@libero.it' ],
  'rreggi@wp.pl bydgoszcz' => [ EMAIL => 'rreggi@wp.pl', CITY => 'Bydgoszcz', COUNTRY => 'Poland' ],
  'ruthacher@hotmail.com unusual nt' => [ EMAIL => 'ruthacher@hotmail.com' ],
  'sam aka showle@aol.com' => [ OPEN => 'Sam', EMAIL => 'showle@aol.com' ],
  'sehb23@aol.com.. fsf, bergen, sup x' => [ EMAIL => 'sehb23@aol.com' ],
  'seterah saja@up2u.com' => [  COUNTRY => 'Indonesia' ],
  'slaoun@vtr.cl checkback' => [ EMAIL => 'slaoun@vtr.cl' ],
  'sneil-glm- timm@pitt.edu' => [ OPEN => 'Neil TIMM', 'EMAIL' => '@timm@pitt.edu', LEVEL => 'Life Master'],
  'sometimes expert@advanced.com' => [LEVEL => 'Advanced' ],
  'sono permaloso@.na' => [ COUNTRY => 'Italy' ],
  'srruppuut .@y com' => [ EMAIL => 'srruppuut@y.com' ],
  'st. joseph kleak @yahoo.com' => [ EMAIL => 'kleak@yahoo.com', CITY => 'Manado', COUNTRY => 'Indonesia' ],
  'suemason@tigo.com py' => [ EMAIL => 'suemason@tigo.com py' ],
  'sukrukaya52@hotmail.com 2/1' => [ EMAIL => 'sukrukaya52@hotmail.com' ],
  'syaloom tondano.@ com' => [ CITY => 'Tondano', COUNTRY => 'Indonesia' ],
  'szekla23@vp.pl ilacy member' => [ EMAIL => 'szekla@wp.pl' ],
  'szunaj31@wp.pl pid-10500' => [ EMAIL => 'szunaj31@wp.pl' ],
  'tahir osman taos_tr@yahoo.com' => [ OPEN => 'Tahir Osman', EMAIL => 'taos_tr@yahoo.com' ],
  'this id is used by many  to make broadcasts, host tourneys- any queries send to admin@bilbridge.com' => [ EMAIL => 'admin@bilbridge.com' ],
  'tonsea tondano,kendis,gorontalo,.@.com' => [ CITY => 'Tondano', COUNTRY => 'Indonesia' ],
  'toulouse @ville rose .com' => [ CITY => 'Toulouse', COUNTRY => 'France' ],
  'ufum@hotmail.com bbo td' => [ EMAIL => 'utum@hotmail.com' ],
  'umypoppy@gmail.com. e' => [ EMAIL => 'umypoppy@gmail.com' ],
  'v ayhan325@gmail.com' => [ EMAIL => 'ayhan325@gmail.com' ],
  'vasvirv@otenet.gr sk.:vasmar44' => [ EMAIL => 'vasvir@otenet.gr' ],
  'vic (vastj@wanadoo.fr' => [ EMAIL => 'vastj@wanadoo.fr' ],
  'vic sartor/vsartor77@aol.com' => [ OPEN => 'Vic Sartor', EMAIL => 'vsartor77@aol.com' ],
  'w.reszelski@o2.p 05348' => [ EMAIL => 'w.reszelski@o2.pl' ],
  'w.roj@wp.pl,pid 16248' => [ EMAIL => 'w.roj@wp.pl' ],
  'wojchr@op.pl warszawa' => [ EMAIL => 'wojchr@op.pl', CITY => 'Warsaw', COUNTRY => 'Poland' ],
  'wylly@interia.pl 10821' => [ EMAIL => 'wylly@interia.pl' ],
  'x ayhan325@gmail.com' => [ EMAIL => 'ayhan325@gmail.com' ],
  'yaaay@wp.pl 10056' => [ EMAIL => 'yaaay@wp.pl' ],
  'yaegermbgc@aol.com leb;inv mn' => [ EMAIL => 'yaegermbgc@aol.com' ],
  'yaseca@hotmail.com ( van' => [ EMAIL => 'yaseca@hotmail.com' ],
  'ymfolan@yahoo.com bil' => [ EMAIL => 'ymfolan@yahoo.com' ],
  'yolande watelet.@yahoo.fr' => [ EMAIL => 'yolande watelet.@yahoo.fr' ],
  'zbynieks@op.pl, cezar 07936' => [ EMAIL => 'zbynieks@op.pl' ],
  'zetim@op.pl pid 1751' => [ EMAIL => 'zetim@op.pl' ],
  'zkrzepkowski@wp.pl 4329' => [ EMAIL => 'zkrzepkowski@wp.pl' ],
  'zoesa i x @ yahoo.com' => [ EMAIL => 'zoesaix@yahoo.com' ],
  'zubyz@seznam.cz mám i skype zdenda1202' => [ EMAIL => 'zubyz@seznam.cz' ],
  '0272244@fudan.edu.c' => [ EMAIL => '0272244@fudan.edu.cn' ],
  '13875318390@163.con' => [ EMAIL => '13875318390@163.com' ],
  '505394947@qq.c' => [ EMAIL => '505394947@qq.com' ],
  '87362535@qq.ocm' => [ EMAIL => '87362535@qq.com' ],
  'a.frietema@upcmail.nll' => [EMAIL => 'a.frietema@upcmail.nl' ],
  'addy.tex@wanadoo.dr' => [ EMAIL => 'addy.tex@wanadoo.fr' ],
  'agusia74@poczta.onet' => [ EMAIL => 'agusia74@poczta.onet.pl' ],
  'ah.vandyk@sympatico/ca' => [ EMAIL => 'ah.vandyk@sympatico.ca' ],
  'alam@t.palsu.oom' => [ EMAIL => 'alam@t.palsu.com' ],
  'alie_196616@yahoo.acom' => [ EMAIL => 'alie_196616@yahoo.com' ],
  'antun.matana@optinet' => [ EMAIL => 'antun.matana@optinet.hr' ],
  'ap2410@ns.sympatico.can' => [ EMAIL => 'ap2410@ns.sympatico.ca' ],
  'ayik.dagci16@gmail' => [ EMAIL => 'ayik.dagci16@gmail.com' ],
  'badman@jahil.oom' => [ EMAIL => 'badman@jahil.com' ],
  'bevbernie@att.nett' => [ EMAIL => 'bevbernie@att.net' ],
  'bobr5555@yahoo.comcom' => [ EMAIL => 'bobr5555@yahoo.com' ],
  'bridgemasuksekolah@grp.comm' => [ COUNTRY => 'Indonesia' ],
  'bstitch562@hotmailc.om' => [ EMAIL => 'bstitch562@hotmail.com' ],
  'canadadan@gmail.coma' => [ EMAIL => 'canadadan@gmail.com' ],
  'cangurcan48@hotmail.comtr' => [ EMAIL => 'cangurcan48@hotmail.com.tr' ],
  'carlaaprile52@libero.itivate' => [ EMAIL => 'carlaaprile52@libero.it' ],
  'ccdr@dgfood.gov,bd' => [ EMAIL => 'ccdr@dgfood.gov.bd' ],
  'celavitali@gmail.coml' => [ EMAIL => 'celavitali@gmail.com' ],
  'cenver@msn.comtr' => [ EMAIL => 'cenver@msn.com.tr' ],
  'commbruggen@hotmail.come' => [ EMAIL => 'commbruggen@hotmail.com' ],
  'chb.langer@t-online' => [ EMAIL => 'chb.langer@t-online.de' ],
  'chicciola@chiocciolo.ino' => [ EMAIL => 'chicciola@chiocciolo.info' ],
  'daniel.raimbault@wanadoo.frd' => [ EMAIL => 'daniel.raimbault@wanadoo.fr' ],
  'dazuker@zahav.net/il' => [ EMAIL => 'dazuker@zahav.net.il' ],
  'de.luten@versatel,nl' => [ EMAIL => 'de.luten@versatel.nl' ],
  'delia.carotenuto@libero-it' => [ EMAIL => 'delia.carotenuto@libero.it' ],
  'donald.caton@yahoo' => [ EMAIL => 'donald.caton@yahoo.com' ],
  'erm19@juno.come' => [ EMAIL => 'erm19@juno.com' ],
  'frami.laurence@orange.frl.' => [ EMAIL => 'frami.laurence@orange.fr' ],
  'francois.louis15@fr.sfr' => [ EMAIL => 'francois.louis15@sfr.fr' ],
  'frederic.lacroix@web.ffbridge' => [ EMAIL => 'frederic.lacroix@web.ffbridge.fr' ],
  'g.rosca@yahoo' => [ EMAIL => 'g.rosca@yahoo.bg' ],
  'gabrielmassut@hotmail.comm' => [ EMAIL => 'gabrielmassut@hotmail.com' ],
  'giorggi@sawas.arg' => [ EMAIL => 'giorggi@sawas.ar' ],
  'glevin5228@aol.xim' => [ EMAIL => 'glevin5228@aol.com' ],
  'goubet.hubert@wanadoo' => [ EMAIL => 'goubet.hubert@wanadoo.fr' ],
  'grasool1337@yahoo.c0m' => [ EMAIL => 'grasool1337@yahoo.com' ],
  'guciogg@poczta.onet' => [ EMAIL => 'guciogg@poczta.onet.pl' ],
  'guiyotambella@yahoo.com,ar' => [ EMAIL => 'guiyotambella@yahoo.com.ar' ],
  'hamdysimillawi@hotmail.comm' => [ EMAIL => 'hamdysimillawi@hotmail.com' ],
  'hel2004.kraus@t-online.e' => [ EMAIL => 'hel2004.kraus@t-online.de' ],
  'helko05@verizon.netvate' => [ EMAIL => 'helko05@verizon.net' ],
  'hexi5@yahoo.mail' => [ EMAIL => 'hexi5@yahoo.com' ],
  'hiae1@bezeqint.netl' => [ EMAIL => 'hiae1@bezeqint.net' ],
  'hzbb@mindspring.comvate' => [ EMAIL => 'hzbb@mindspring.com' ],
  'janjoris@hotmail.coml' => [ EMAIL => 'janjoris@hotmail.com' ],
  'jea@jea.comm' => [ EMAIL => 'jea@jea.com' ],
  'jean.claude.tremel@wanadoo;fr' => [ EMAIL => 'jean.claude.tremel@wanadoo.fr' ],
  'jean-marie.verry@orange' => [ EMAIL => 'jean-marie.verry@orange.fr' ],
  'jeanbaptiste.kerebel@sfr' => [ EMAIL => 'jeanbaptiste.kerebel@sfr.fr' ],
  'jerzy@op.pl1234' => [ EMAIL => 'jerzy@op.pl' ],
  'jeter2827@yahoo.comtw' => [ EMAIL => 'jeter2827@yahoo.com.tw' ],
  'jjanovic@epm.net,com' => [ EMAIL => 'jjanovic@epm.net.com' ],
  'jjmsaa@planet.nll' => [ EMAIL => 'jjmsaa@planet.nl' ],
  'jochem.pingel@t-online' => [ EMAIL => 'jochem.pingel@t-online.de' ],
  'justesen@greennet.gl' => [ EMAIL => 'justesen@greennet.dk' ],
  'kaju@gmail.gom' => [ EMAIL => 'kaju@gmail.com' ],
  'keith.randall@outlook.com.' => [ EMAIL => 'keith.randall@outlook.com' ],
  'kkayagil@hotmail.com...4wxfer' => [ EMAIL => 'kkayagil@hotmail.com' ],
  'kuailpshou@sina.con' => [ EMAIL => 'kuailpshou@sina.com' ],
  'leswood@dodo.com,au' => [ EMAIL => 'leswood@dodo.com.au' ],
  'lizajaneb@hotmail.cm' => [ EMAIL => 'lizajaneb@hotmail.com' ],
  'lorgou_law@g.mail' => [ EMAIL => 'lorgou_law@gmail.com' ],
  'lornaperkins@comcast.ne' => [ EMAIL => 'lornaperkins@comcast.net' ],
  'louis.boisgelot@orange' => [ EMAIL => 'louis.boisgelot@orange.fr' ],
  'louis.jule@uregina,ca' => [ EMAIL => 'louis.jule@uregina.ca' ],
  'luigifilippo.tinellidigorla@fastwebnet.i' => [ OPEN => 'Luigi Filippo TINELLI', CITY => 'Milan', COUNTRY => 'Italy' ],
  'lydie.trajman@.gmail;com' => [ EMAIL => 'lydie.trajman@.gmail.com' ],
  'malensantander@hotmail.con' => [ EMAIL => 'malensantander@hotmail.com' ],
  'maluyao@gmail.comnospam' => [ EMAIL => 'maluyao@gmail.comn' ],
  'manny2d2@yahoo.coom' => [ EMAIL => 'manny2d2@yahoo.com' ],
  'marcosarazi@yahoo.cm' => [ EMAIL => 'marcosarazi@yahoo.com' ],
  'marie-luce.giacobetti@orange.frp' => [ EMAIL => 'marie-luce.giacobetti@orange.fr' ],
  'marilynohlson@iprimus.c' => [ EMAIL => 'marilynohlson@iprimus.com.au' ],
  'mario.taveira@hotmail-com' => [ EMAIL => 'mario.taveira@hotmail.com' ],
  'maryhall333@btinternet.comj' => [ EMAIL => 'maryhall333@btinternet.com' ],
  'mialoganann@yahoo.cm' => [ EMAIL => 'mialoganann@yahoo.com' ],
  'mmherron@aol.om' => [ EMAIL => 'mmherron@aol.com' ],
  'mohsen.kamel@entrag,com' => [ EMAIL => 'mohsen.kamel@entrag.com' ],
  'mohsen.kamel@entrag,org' => [ EMAIL => 'mohsen.kamel@entrag,org' ],
  'monica.connollyi@icloudri' => [ EMAIL => 'monica.connolly@icloud.com' ],
  'mselcuk.20@hotmail' => [ EMAIL => 'mselcuk.20@hotmail.com' ],
  'musi78@abv.gd' => [ EMAIL => 'musi78@abv.bg' ],
  'mvanwaardhuizen@kpnplanet.n' => [ EMAIL => 'mvanwaardhuizen@kpnplanet.nl' ],
  'nanddperkins@aol.come' => [ EMAIL => 'nanddperkins@aol.com' ],
  'nicolebouvier@neuf.f' => [ EMAIL => 'nicolebouvier@neuf.fr' ],
  'noella@omantel.net.om' => [ EMAIL => 'noella@omantel.com' ],
  'o.parry@t-online,de' => [ EMAIL => 'o.parry@t-online.de' ],
  'onur.tutar@hotmai' => [ EMAIL => 'onur.tutar@hotmail.com.tr' ],
  'pad@wanadoo.ir' => [ EMAIL => 'pad@wanadoo.fr' ],
  'panjang_lama@yahoo.co.iid' => [ EMAIL => 'panjang_lama@yahoo.co.id' ],
  'philippe.choquart@orange.fe' => [ EMAIL => 'philippe.choquart@orange.fr' ],
  'piapeleg.@netvisione.ne/il' => [ EMAIL => 'piapeleg.@netvisione.net.il' ],
  'piero.randi@libero.itquinta' => [ EMAIL => 'piero.randi@libero.it' ],
  'posky12238@aol.cm' => [ EMAIL => 'posky12238@aol.com' ],
  'princesaestigarribia@hotmail.comtreboles' => [ CITY => 'Princesa Estigarribia', COUNTRY => 'Paraguay' ],
  'r.schol.r@gmail?com' => [ EMAIL => 'r.schol.r@gmail.com' ],
  'r.smeehuijzen@xs4all' => [ EMAIL => 'r.smeehuijzen@xs4all.nl' ],
  'ramaraoj2000@yahoo.c0m' => [ EMAIL => 'ramaraoj2000@yahoo.com' ],
  'raquelita_1936@hotmail.comr' => [ EMAIL => 'raquelita_1936@hotmail.com' ],
  'robert.beudard@wanadoo' => [ EMAIL => 'robert.beudard@wanadoo.fr' ],
  'roger.loisel34@orange.frl' => [ EMAIL => 'roger.loisel34@orange.fr' ],
  'rosario.manca@alice,it' => [ EMAIL => 'rosario.manca@alice.it' ],
  'sarel.king@013netnot' => [ OPEN => 'Sarel King' ],
  'semrab@hotmail.comm' => [ EMAIL => 'semrab@hotmail.com' ],
  'shokot@walla.con' => [ EMAIL => 'shokot@walla.co,' ],
  'sirop.georgette@akeonet;com' => [ EMAIL => 'sirop.georgette@akeonet.com' ],
  'sylvie.ekmark@gmail' => [ EMAIL => 'sylvie.ekmark@gmail.com' ],
  'tetea@speedy.com,ar' => [ EMAIL => 'tetea@speedy.com.ar' ],
  'thomas.b.ekblom@gmail,com' => [ EMAIL => 'thomas.b.ekblom@gmail.com' ],
  'vecdi.sezer@hotmail.comm' => [ EMAIL => 'vecdi.sezer@hotmail.com' ],
  'viren2512@yahoo.co,in' => [ EMAIL => 'viren2512@yahoo.co.in' ],
  'wake.advies@kpnmail' => [ EMAIL => 'wake.advies@kpnmail.nl' ],
  'wkrzem51@wp.pl,td-ns6' => [ EMAIL => 'wkrzem51@wp.pl' ],
  'xiao.bizi@163' => [ EMAIL => 'xiao.bizi@163.com' ],
  'xyshen@hotmail.c0m' => [ EMAIL => 'xyshen@hotmail.com' ],
  'yaffad@013.net.ii' => [ EMAIL => 'yaffad@013.net.il' ],
  'yhq3776@126.gom' => [ EMAIL => 'yhq3776@126.com' ],
  'zbs001@126.c0m' => [ EMAIL => 'zbs001@126.com' ],
  'eat@vmg2.bekasi' => [ 'CITY' => 'Bekasi', COUNTRY => 'Indonesia' ],
  'hehe@hehe.pl.wroclaw-raj' => [ CITY => 'Wroclaw', COUNTRY => 'Poland' ],
  'mti.@bg' => [ COUNTRY => 'Bulgaria' ],
  'au.pl@isir' => [ COUNTRY => 'France' ],
  'liz//neg.dble/jac2nt/gerber@nt' => [ OPEN => 'Liz' ],
  'duchessofomaha@aol.comacbl' => [ COUNTRY => 'USA' ],
  'watford@around.m25.london' => [ CITY => 'Watford', COUNTRY => 'England' ],
  'guy@warwick.hm' => [ CITY => 'Watford', COUNTRY => 'England' ],
  '163.@com' => [ COUNTRY => 'China' ],
  'y.ww@orange' => [ COUNTRY => 'France' ],
  'sido@p\'titcoeurd\'amour.gmail' => [ COUNTRY => 'France' ],
  'burdigala@port.de.la.lune' => [ CITY => 'Bordeaux', COUNTRY => 'France' ],
  'nazmul.haq@physics' => [ OPEN => 'Nazmul Haq' ],
  'patrice.pauly@muret' => [ OPEN => 'Patrice Pauly', CITY => 'Muret', COUNTRY => 'France' ],
  'fe@ugm.yk' => [ UNIVERSITY => 'Universitas Gadjah Mada', COUNTRY => 'Indonesia' ],
  'pablo.valencia@anti.gua' => [ OPEN => 'Pablo Valencia', COUNTRY => 'Antigua and Barbuda' ],
  'g.virchick@verizon.net(boston' => [ CITY => 'Boston', COUNTRY => 'USA', EMAIL => 'g.virchick@verizon.net' ],
  'poland@junior.bridge_capital' => [ OPEN => 'Junior', COUNTRY => 'Poland' ],
  'sono.amoroso@bergamo' => [ CITY => 'Bergamo', COUNTRY => 'Italy' ],
  'mascleta@maica.ok' => [ COUNTRY => 'Spain' ],
  'morau.con@vasteprogramme' => [ COUNTRY => 'France' ],
  'milangrandemilan@2110.qui' => [ COUNTRY => 'Italy' ],
  'milan.italy@march.1963' => [ CITY => 'Milan', COUNTRY => 'Italy' ],
  'gilberto.figatalamanca@fastweb.neti' => [ EMAIL => 'gilberto.figatalamanca@fastwebnet.it' ],
  'la.sulmurosale@la.bavosa' => [ COUNTRY => 'Italy' ],
  'n.hikmet/antalyaspor@salvo' => [ COUNTRY => 'Turkey' ],
  'pringgondani@gatut.koco' => [ COUNTRY => 'Indonesia' ],
  'sonopermaloso@.na' => [ COUNTRY => 'Italy' ],
  'avec.jac@mennecy' => [ CITY => 'Mennecy', COUNTRY => 'France' ],
  'laroche@lso.vendee' => [ COUNTRY => 'France' ],
  'dogustanexper@ahmetizm.xxx' => [ LEVEL => 'Expert' ],
);


my @DOMAINS = qw(
  ae af ag ai am an ar as at au bd be bg bh biz bl bm bn bo br by 
  ca cat cc ch cl cn co com cr cz cy de dk edu ee eg es eu fi fm fo fr 
  ge gov gr hk hr hu id ie il info is it in jo jp kg kr ku kz
  la lb lc li lk ls lt lu lv ma mc me mk mu mx mz 
  na name net ni nl no nu nz org pe pf ph pk pl pt py ro rs ru 
  sa se sg si sk sm st su th tn tr tt tv tw ua uk us uy vu world yu za
);

my %DOMAINS_HASH;
$DOMAINS_HASH{$_} = 1 for @DOMAINS;


sub looks_like
{
  # There could be multiple pieces of information on a line.
  # We attempt to return all of them.  The caller must then process
  # @$matches.

  my ($text, $matches) = @_;

  my @a = split '@', $text;
  return '' unless $#a == 1;

  my $dots = ($text =~ tr/\.//);
  return '' unless $dots >= 1 && $dots <= 4;

  $text =~ s/^\s+//;
  $text =~ s/\s+$//;

  return if exists $DELETIONS_HASH->{$text};

if ($text =~ /vandyk/)
{
  print "HERE\n";
}

  if ($text =~ s/\s*private$//)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif ($text =~ s/^pri(.+)vate$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif ($text =~ s/^p(.+)rivate$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif ($text =~ s/^(.+)rivate$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }
  elsif (exists $PRIVATES_HASH{$text})
  {
    push @$matches, 'PRIVATE', 'Private';
    return;
  }
  elsif ($text =~ s/^private*(.+)$/$1/)
  {
    push @$matches, 'PRIVATE', 'Private';
  }

  if (exists $COUNTRIES{$text})
  {
    push @$matches, 'COUNTRY', $COUNTRIES{$text};
    return;
  }
  elsif (exists $MULTIPLES{$text})
  {
    push @$matches, @{$MULTIPLES{$text}};
    return;
  }

  my $spaces = ($text =~ tr/ //);
  if ($spaces > 3)
  {
    push @$matches, 'SYSTEM', $text;
    return;
  }

  if ($text =~ /[\x80-\xFF]/)
  {
    print "CHARSET $text\n";
    return;
  }

  if ($text =~ /\s/)
  {
    $text =~ s/\s//g;
    return;
  }
  elsif ($text =~ /\.([a-z]+)$/ && exists $DOMAINS_HASH{$1})
  {
    print "EMAILX $text\n";
    return;
  }
  else
  {
    # Effectively there is only the guy who entered a regex left here.
    print "MAILMISS $text\n";
    return;
  }
}

1;


