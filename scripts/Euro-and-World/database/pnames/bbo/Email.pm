#!perl

package Email;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(looks_like);

my @DELETIONS =
(
  '*_* ) @ kiss. com',
  '1 po @std.ca',
  '1100@mot.ingenting.urk',
  '111@111.111',
  '12345@.qq',
  '1@2.3',
  '2/1gf@play your card.gl',
  '2/1@modern.approach',
  '2/1@playurcard.gl',
  '2/1@playurcard.per agre pl',
  '2/1@playurcard.per agreemt',
  '2maj@retraite.sud ouest',
  '22@acacia.avenue',
  '3@14159.26535',
  '3rd palm tree on left@oasis.com',
  '7@wad.t',
  '8030 @ precision..also..ok',
  '@  :) .com',
  '@ :) :) . com',
  'a@a.aa',
  'a@b.c',
  'aaa@aa.aa',
  'aaa@aaa.aaa',
  'aaa@bbb.ccc',
  'aaa@ss.cr',
  'aaaaa@nie.mam',
  'abc @ .com',
  'abcd@def.online',
  'abcdefg@hijk.lmnop',
  'akqj.1098@765.432',
  'akqj.1098@7654.321',
  'amirom2@good.score',
  'andy@askme.dot',
  'anywhere@no.where',
  'appo@sorry.boom',
  'arctic@ex.mexicogulfen',
  'ask @whois.me',
  'ask me@.comcast',
  'ask.me@if.required',
  'ask@email.emi',
  'ateþ@03.10.2014',
  'away@from.kom',
  'b@wp.p',
  'babbo@a.spass',
  'bad.attitude@let.home',
  'batco@ batco.comt',
  'bbo@experts.fun',
  'be nice@popp.su',
  'bestdummy@award.ok',
  'better let@.as net',
  'bidlousy@playworse.twit',
  'big zero @yahoo.com',
  'birisi@hot.hot',
  'bisc@rosse.pin',
  'bob @hotmail.cm',
  'bonnehumeur@niania.hein',
  'bonsoir@tous.hi',
  'bornfree @ bridge.com',
  'boson@quark.bottom',
  'bridge&bridge@slam.rc',
  'bridgeking @sky.com',
  'burning_spear@kingston.town',
  'bush bush@hotmail.com',
  'caeces @g.mail',
  'calimero@oeuf.dur',
  'camicidelbridgeonl. b@b',
  'can @can.com',
  'carpe diem@bbo.com',
  'chakaay @ bridge.com',
  'colaps@brain.mu',
  'cold@foggy.north',
  'constant sleeper@.yes',
  'dammilatua@ grazie.smack',
  'dark.side@the.moon',
  'dddd @ aol.com',
  'directorcovertops@cia.gov',
  'discrak@com.mon',
  'do.not@fooled.yourself',
  'don\'t worry@be happy.com',
  'don@don.don',
  'don\'t@have.one',
  'dontberude@bridge.table',
  'dorla @.com',
  'dot@dot.dot',
  'duss man.@. quasi',
  'eagle@19th hole.com',
  'egmby@kwa.kwa',
  'ehehehhehe@acc.lol',
  'elis@...elis',
  'end.of@the.line',
  'enjoy your life @life.com',
  'errare @humanum.est',
  'ex@bogus.dom',
  'expert is@relative.com',
  'expert@spectat.or',
  'f.@.france 2010',
  'f@ belly.go please',
  'fake0@terra.cl1d try 4 cards jacoby',
  'fbear@sesame.street',
  'fff@hgh.mo',
  'fi @gama. dus elklae ba',
  'format_internet:@dos.prompt',
  'fors@le.10k',
  'frag.doch@einfach.mal',
  'friendly@bridge.table',
  'friends:winbeerclub@freeland.star',
  'fromrussia@blow.out',
  'fuel@gasoline.oil',
  'furia@wj.2011',
  'ga@the office.org',
  'gama@neutron.space',
  'gingersnaps in oven@tx.com',
  'glass@straw.drink',
  'gs @ uefa.com',
  'guess@who.i.am',
  'half@stoned.jam',
  'handsome@nighttime.wow',
  'hanneke is nooit thuis@nietthuis.com',
  'have a laugh @fun.ie',
  'here i am@nowhere.com',
  'hgfgh@h.c',
  'hogsmeadehogwarts@diagon.alley.brw',
  'hoss@cartwright.ranch',
  'i love womans@mauri.com',
  'i love you@perfectman.com',
  'i love@ big .ziz',
  'i love@ whale.com',
  'i use.rule.of.20@opening',
  'i. love.c@ndroz',
  'i.am@not.yet',
  'ica @gmail.comp',
  'i.play@with.friends',
  'i@am.lar',
  'iespert @ balta.bbo',
  'if tomorrow never comes@carpediem.com',
  'if@you.asking',
  'ifnecessary@giganet.com.uc',
  'in vino@veritas.com',
  'info@top-secret.cc',
  'inv.minor@invit.stenberg',
  'invinoveritas@pauillac.medoc',
  'it hurts@doctor.com',
  'jack_d@martell.chivas',
  'johnny@dime.bags',
  'keep cool@just for.fun',
  'kindness@pls.ty',
  'know@little.2over1',
  'ksk@35 1/2.com',
  'l.m.@.s.f',
  'lage tuk na hole tak@hauhau.co',
  'lazzi .@.abv',
  'learner@bridgebase.online',
  'leszek b. 20 yrs after @-ask',
  'light@defense.bids',
  'lm@us.nat.chump',
  'lol@yahoo.com, learn to be an',
  'lolol@lol.lol',
  'love & peace @.com',
  'love@bridge.play',
  'm uta.... be nice@smile',
  'ma mgorumna@vaskiriskuri.vor',
  'marie concots @.com',
  'me and you@bbo.bridge',
  'men@mars.planet',
  'michaels@capp.neg x',
  'mir@tour.eiffel',
  'misplay@ndmisdefense.all',
  'miss you @hotmail.com',
  'mistakes ok but not@silly.com',
  'miyabi@ official tv patner.com',
  'mmm@mm.m',
  'muaie@.ihuaie',
  'nacht-squawk@game.bb0',
  'nice. guy@sky',
  'nihilist@hedonist.komns',
  'no  @no.com',
  'no answer.not@computer',
  'no critic @ no. press.me',
  'no transfer@return lead.com',
  'no@lessons.pls',
  'none@available.yet',
  'none@nothinghere.goaway',
  'none@your.biz',
  'normally i play like@expert.com',
  'now everyone can fly@air asia.com',
  'number@4.om',
  'o cabaret@y.com',
  'oil@engine.camshaft',
  'ola.hello@be.nice.lol',
  'oliba@toxicplanet.info',
  'p uta.... be nice@smile',
  'pan@libero.son',
  'papu@bps.statistics',
  'paradiso@con.me',
  'pls.no.lessons@fed.up',
  'poker p@s.admis',
  'poor.judgement @goingdown.com',
  'ppp@ppp.ppp',
  'president@whitehouse.gov',
  'provis@cdickens.lit',
  'quark.bottom@boson.higgs',
  'qwertyuiop@asdfghjkl.zxcvbnm',
  'reve@. cool',
  'roaring@to.go',
  'round table@camelot.com',
  'rue@griffin.club',
  's t.c.dr.s_@lp',
  's.snape@slytherin.hogwarts.ac',
  'sbocchi@latazza.team',
  'sef.@ variante cote d\'azur',
  'self expart@bridgelove.com',
  'serious player@bbo.com',
  'small@card.enf',
  'smile@don\'t worry.happy',
  'smile@ny.time',
  'so very much in love@pipit.com',
  'sometime@some.ware',
  'sorry p.npp.@grrrrrrrrrrr',
  'sourires@carpe diem.smile',
  'sss@hotmail.com van',
  'suckmy@sshole.pk',
  'surf@itte.her',
  'synpathy!@friends.rsm',
  'targeted@teammate.go',
  'td@dev.null',
  'team@bridge.ffb',
  'the  queen  @ hot.com',
  'theverybest@i am hot.com',
  'think_distribution@alltimes.glp',
  'thoroughbred horse@saudi.com',
  'tibet free @ will.com',
  'tinlifemaster@smile.dot',
  'try 2 play good bridge@bbo.com',
  'turnip@baldrick.cunningplan',
  'violet.violet.@ gmail.com',
  'w.earp@tombstone.ww',
  'waiting@planet.earth',
  'walletsize@global.space',
  'way.up.in.harlem@a.table.4.2',
  'weakest@player.bbo',
  'why@ pityme.com',
  'wild.animal@large-look.out',
  'winds of light@fun.live.com',
  'wonderwoman@dany.extra',
  'worldclass@dream.ok',
  'www.health@safety a class',
  'x carrier pilot@aol.com',
  'xolaria@ y.com',
  'xxx.@ .no',
  'xyzt@acus.sic',
  'y @hotmail.com',
  'yes@i.do',
  'yes@i.have',
  'ynwa@liverpool. forever',
  'your friendlypartner@it only bytes.com',
  'z+p@p.x',
  'zo0clitor"s @y.com',
  'zzzzzzz @hotmail.com',
);

my %DELETIONS_HASH;
$DELETIONS_HASH{$_} = 1 for @DELETIONS;

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


  return if exists $DELETIONS_HASH{$text};

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
  elsif (exists $COUNTRIES{$text})
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

  $text =~ s/^\s+//;
  $text =~ s/\s+$//;

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
    print "MAILMISS $text\n";
    return;
  }
}

1;


