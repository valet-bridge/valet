#!perl
use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Fluff;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes @SINGLE_WORDS);

my @MULTI_WORDS =
(
  '·Å·ÉÃÎÏë',
  '52/5 35/5',
  'a slam',
  'all conv',
  "all'swell",
  'bonne humeur',
  'cegetel.net',
  'count and think',
  "didn't",
  'dieu est amour',
  'do you know the pass',
  "doesn't",
  'e-mail',
  'fair play',
  'fair play please',
  'i am not here',
  'i dont speak english',
  'i just dunno',
  "it's just a game",
  'it is only a game',
  'fiat lux',
  'have fun',
  'hello everyone',
  'jeu rapide svp',
  'just for',
  'kiss@bridge',
  'no nt fit',
  'no profile no pay',
  'no profile,no play',
  'p',
  'pas de',
  'play nice bridge',
  'please profile',
  're-arrange',
  'rýze findikli baþköy',
  't',
  'tell me carding',
  'use most conventions',
  'vålerenga',
  'why havent u booted me yet',
  'x only for penalty.... even at level 1',
);

my %MULTI_TYPOS =
(
);

our @SINGLE_WORDS = qw(
  0123 0314@0314 

  1t 

  about abracadabra absolutely abuse abuserr abyss academic 
  accepte access according act addict adidas administrator adv 
  advance adventuress advice aerobics after aggressive ailleurs 
  airbus alcapone alcatraz alchemist alchemy alien all 
  almighty almost alone alternate always amie amigo amours amulett an 
  anadolu and anfrage announcing année anonim another answer answers 
  any anything anytime anyway apple apprentie arbeidsjern architect 
  are area around arrester arrow arrows as asap ask asked asterix 
  atheist attractive aussi available avancé avancée 

  baby babybear back bad bakwerk bambi bamsefar banksy basic bass bbo 
  bboer be beachside beaute beautiful beauty beauté become been beer 
  begin beginning being believe belong belongs below besoin 
  best besta bestan beste bestefar betjenten bien bienvenue big 
  bigdog bighand biologist bipede bitte blacknick blackout blacksea 
  blackwidow blessing blonde blue blueadobe blueberry bluemoon 
  blueriver blues bluevista blueyes bmw bonheur bonjour bonsoir bonzo 
  booboo boobs boozy borusse boson both boxer brain brainbaby bravo 
  brick bridgefan bridgeforfun bridgefriends bridgehi 
  bridgeopplevelser bridgeplay bridger bridgeur bridgevejen 
  brillantissime bteam buffet buffoon buffy bulls bullspread bum 
  butchergirl bye bêtise 

  cabin cafetière cafécafé calculus call calm calmness cameraman 
  campagne can candle cannot capricorn captainfiko cardshark care 
  careful caress carpicornus cause champion championship 
  chance change chat cheaters chocolat chocolate chooser chopper 
  choppy christmas citizen claim clarkent class click closed 
  cloudproject coach coconuts codnugget coffee coffeee cogito color 
  comfort comité commendatore comment comments common companion 
  compatability complain complicated computer con confdentl 
  confidencial confidential confidentiel confidentielle connais 
  connection conquest conseils consolación contact contractor 
  convivialite cool copy corner correct cosmiclove cosmos courage 
  cowboy cranky crazy criticism criticize curieux curious current 
  cute 

  dalek danger darksnow dawg days de deadlock dear debt debtgal 
  decisions decourriere deja del demander demandez dentist deny des 
  destout details deutschlehrer dictatorergodan diehard dies 
  diesen difficile difficult diplomat direct discipline disconnects 
  discussion disiplin disponibile disponible diversamente doc
  dogfish doggie domino dostoevskij down dracula dragon dragonfly 
  dream dreamer drno drums drunk dunno dupli during déclassé 

  eagle earth easter eastwind edge eimer eins einsiedeln 
  ekspres else emacs emagine email empty engineer enigma enjoy enough 
  enter enternasyonel entre equal equilibrato er eroica errare 
  error esp espoir est etc eternal etre euro eurocauliflower even 
  eventyr every everybody everyday everyone everything everywhere ex 
  excellence except exclusive exemplaire expat expect 
  experienced express extra exuberant eye eyes 

  facebook facteur fair fairplay fait faith fake fall fallacy false 
  fancazzist fancy fans fantasma fantasy fast faster fatboy father 
  fault favorite favourite fearless feckless festiv festival 
  festivali fine finesse firecrackers first fivestar flag flagless 
  flash flat flower flute focus follow for forever forget forgive 
  forgot former forti freedom freezing freund freunde friend friendly 
  friends friendship frog from fruit full fun funny 

  galaxy games gazelle geezer gemini gentleman geologist girlpower 
  glory glp gmail goal godt goes golfer good goulash graduate grammy 
  gramps grams grand grandma grandpapa grandprix great grincheux 
  group grumpy guess guest 

  half hallo handsome happiness happy happyland hard have hawkster 
  hazard he head hear heard heaven heineken hello help here heureuse 
  heute hi hidden him hippo hmmm hola hold holidays home 
  homeless homme homour honest hope horizon hospitable host hour 
  human humanity humble humor hunting hurt høns 

  idem idiot idioti idiots if ihaveone imigrant imperial implied 
  importance important importante impossible imprecision incognito 
  inconnu inconnue independent info ingen inner inside instead 
  interesa interest interested international inthe into inutile 
  invisible ipsum is island ist 

  jackswiss jacobsen jamais joke joker just juste justplay jüpiter 

  keep kib kibitz kibitzer kibitzing kid kill killer kind kindness 
  kiss knight know knows knucklehead koran kosmonauta 

  ladder lajeunesse lalala language laser later laughter lawless 
  lawyer learn learned learning least leave les lesson 
  lessons level levels life lifemaster lightening lightmare 
  lightsword like line lips listed listen lite literal literati 
  little live living logic lol long longer looking lose lot love 
  loved lovely lover loving lowest luck lucky lui 

  magic magical majör makes making management manager mania manners 
  mardi martial masterchef mastermind masterpoints masters 
  matheducationprofessor matter matters may maybe me meet
  member meme memory mentor merci message messager mich 
  microsoft mieux mine minus misanthrope missing mistake mistakes 
  modest moi moment moments moneypenny monster moonlight more morning 
  morpheus most mostly mother much music my myown myself mystery 

  name namenlos national native naturel necessaire necessary need 
  needed neither nejdet nekkidtruth neli never neverland nevermind 
  new newproject next nice nicely nie night nightdream nightwish 
  nihao niveau no nobody nochat nombre non noname none nonmember 
  noone nope nostalgie not nothing nous novice now noway nowhere 
  nuggets nuit null number numbers nur 

  obelix of ok old on one only operator or oracle oral orange 
  ordinary organizator oth other others otherwise ou oublié oui our 
  out over overbid own 

  paleface panda panther panzer paradis paradise parfois parknshop 
  part particular partout pas pass passchen password patience patient 
  paulsen peace peach pearly pebble pendant people perfect 
  perseverance perso person personal persone personnel pervert 
  pessimist petal peut phantom pharmacist phoney pianissimo 
  picatchou pigeon pigeons piquant pistolpit place plaisir planet 
  planets plata played player players plays pleasant please pleasure 
  pls plse plus plusqueparfait police polite politely politeness polydor 
  poop poor pops porche porteur possible pourquoi powered prefer 
  prefered preferred prend present president pretty prezidenta prima 
  primus principiante prior problem prochaine prof professional profil 
  profile profilo profl proud provins provocator proxy präcise précisés 
  prétention pseudo pseudonyms public

  quand quant quasi quel quelque question quick quiet quite quota 
  qwerty qèº 

  rainbow random rapide rarely rasputin rating razorbacks read 
  realistic reality reason receive register regular rektorinn 
  relative relax relaxe reliable religion remarks remedios remember 
  remove repetita reply reproches reptili request requested require 
  required resilienza resistance resisting respect respecte respond 
  restons retired retiredmom revolution right rimrocksetters robot 
  rockcat rocks roguekiller royalforce rubiksmagic rude rudeness 
  rumpelstilzchen rumplestilksin rumplestiltskin réservé røyksignaler 

  sailfish same sandglass sashimi say says scapegoat science score 
  scubadiving seabird seabridge searching seasoned seaweed seconds 
  secret see selfproclaimed selvfølgelig sense serious seriously 
  seulement seven sevenheaven shadow she shogun should show si side 
  sigma silence silent simpatici simple simplicity simply since skill 
  skills sky slack slow slowly slugger smallfather smart smellycat 
  smile smiles smiling snoopy snow snowflower sofistike soldiers 
  solidarite solo some somebody someone something sometime sometimes 
  somewhere songbird soon sorry soulmate sounds souriez sourire 
  spacewide spam speak speaking special speedy spock sporklübü 
  spreche spring spurs squeeze squireboy standing star stark stars 
  start steps still stolen stoned stop storfiskarn story straight 
  stranded stratocaster street stress student stuff stupid stupidity 
  style står subject sufficient suggestions suis suite summer 
  summertime sundance sunday sunflower sunshine super sure sureté 
  surgeon susy svp swearing sweeney sweet sweetie sweety sweidan syd 
  symmetric sympa sympatico symphony 

  taifun take talk talking tallboy tante target tartan tc teabridge 
  teach teacher teaching team telling temple tempo temporary temporis 
  temps tennis terpsychora test testspeler tetrahedron than thank 
  thanks thansfer that the thedoctor their them then thepunch there 
  theshipwright theskank they thing things think thinking thinkist 
  third this those thought through time times tiny tired titanic 
  titles tks to today together tolclub tolerance tolerated tolérance 
  tomorrow too top tormento tornado total toucan toujours tournament 
  tournaments tourney tournier tout toute transformer 
  traverse tree trees trickmachine trine troubadour trouble true 
  trueheart trust truth trykker très tu two 

  un under understand universe universel unless until unusual up upon 
  urgent use used user usually 

  venus veritas very veux vip virtual viva vive vivre void voisin 
  volcano voted votre voulez vous vs vugraph véritable 

  waldamsel waldlaufer walk walkyria walleye want wanted wants war 
  wasserfrosch wasted watch watcher water watermelon wdp we weinkauf 
  welcome were what whatever whats when where which who whoami why 
  wickwire wife wifwafwouf wildkatze will win wind wine winner wino 
  winter wir wirt wisdom wise witch with withdrawl without wlc wolves 
  woman wonder wonderful wonderland word words work worse would write 
  writer wrong 

  xmas xtreme xx 

  year years yes yet you you're your yourself yucel 

  zaunkoenig zeitgeist zero zodiacpower zorro 

  être 
);

my %SINGLE_TYPOS =
(
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
