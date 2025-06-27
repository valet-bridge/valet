#!perl
use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Fluff;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'a slam',
  'pas de'
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  about above academic accepte according advance advanced advice after 
  aggressive ailleurs all almost alone alternate always amours and 
  anfrage année answer anything anytime anyway apprentie around asap 
  ask asked aussi available avancée

  back bad basic bass be beautiful beauty beauté become been
  beginer beginners being believe belong belongs below besoin best
  bienvenue big bitte blues bonheur bonjour both bridgeopplevelser

  call cannot care careful cause championship chance change chat
  cheaters chocolat chocolate citizen class click closed coach cogito
  color comité comment comments common companion complain complicated
  computer connais connection conseils contact cool copy corner 
  correct criticism criticize curieux current

  days decisions details dies diesen difficile difficult direct 
  discipline disconnects discussion disiplin disponibile disponible 
  diversamente doesn't down dream drums drunk dunno dupli during

  earth ekspres elite else empty engineer enigma enjoy enough entame enter
  entre equal equilibrato errare error espoir eternal etre even every
  everybody everyday everyone everything everywhere excellence except
  excl exclusive exemplaire exp expat expect exper experienced experte
  experto experts express extra exuberant eye eyes 

  facteur fairplay fait false fans fantasy fast faster father fault 
  favorite favourite festiv festival festivali first flag flagless 
  flash flower focus follow for force forceing forever forget forgive 
  forgot former freedom freund freunde friendly friends friendship from 
  fruit full fun funny

  games gentleman glory goes good graduate great grincheux group
  grumpy guess guest 

  hallo handsome happiness happy have hazard head hear heard heaven help 
  here heureuse heute hidden hmmm hold holidays home homeless homour 
  honest hope horizon hospitable host human humanity humble humor 
  hunting hurt 

  idiot idioti idiots if imperial importance important importante 
  impossible inconnu inconnue independent info ingen inner inside 
  instead interesa interest interested interm intermed intermediaire 
  intermediate intermediates intermedio international inthe into 
  inutile invisible ipsum is island ist

  jacobsen jamais joke jump 

  keep kib kibitz kibitzer kibitzing kill kind kindness kiss knight
  know knows koran

  ladder language laughter lawless lawyer leader leads learn learned
  learner learning least leave lesson lessons level levels life line
  listed listen literal little live living lol long longer looking lose
  lot love loved lovely lover loving lowest luck lui

  magic magical majör makes making management manager mania manners 
  mardi martial
  masterpoints matter matters maybe me meet meilleure mentor merci
  message messager mester mestre mich mieux min mineure minors minus
  missing mistake mistakes modest moi moment moments monster more
  morning most mostly mother much music my myown myself mystery

  name national native naturel necessaire necessary need needed 
  negativ neither neli new next nicely nie night niveau no nobody 
  nombre non noname none nonmember noone not nothing nous novice 
  nowhere nuit null number

  of ok old on one only operator or oral orange ordinary other others 
  otherwise ou oublié oui our out over own

  panda
  paradis paradise parfois particular partout pass password patience 
  patient paulsen peace penalty pendant people perfect perso person 
  personal persone personnel petite peut phantom phoney pigeon pigeons 
  pique piques pirivate pivate place plaisir planet planets plata played 
  players plays pleasant please pleasure pls plse plus plusqueparfait 
  pnts point polite politely politeness poor porteur positive possible 
  pourquoi powered prefer prefered preferred prend present president
  prima primus principiante prior priv priva privado privare privat
  privata private privatem privates privati privative privato prive
  privee privet privite privte privé privée priwate problem prochaine
  professional profil profile profilo profl proud proxy prv prvate 
  prvt pryw präcise précisés prétention prývate pseudo pseudonyms
  psychic ptivate public pupet pupp pvt

  quadri quand quasi quel quelque question quick quiet quite quota

  rainbow random rapide rarely rating read realistic reason receive 
  register
  regular relative relax relaxe religion remarks remedios remember
  remove repetita reply reproches request requested require required
  resistance resisting respect respecte respond restons retired 
  revolution right rude rudeness réservé

  same science score scubadiving seconds secret see selfproclaimed 
  sense serious seulement seven should show side silence silent
  simpatici simple simplicity simply since skill skills slack slow 
  slowly smile smiles smiling some somebody someone something sometime 
  sometimes somewhere sorry sounds souriez spacewide spam speak 
  speaking special speedy sporklübü spreche squeeze standing stars 
  start steps still stolen stoned stop story straight stranded street 
  stress student stuff stupid stupidity style står subject sufficient 
  suggestions suis suite summer sunshine super sure sureté susy svp 
  swearing sweeney sweet sweety sweidan syd sympa sympatico

  take talk talking target teach teacher teaching team temple
  tempo temporary temporis temps test than thank thanks that the their
  them then there they thing things think thinking third this 
  those thought through time times tiny tired titles tks to today
  together tolerance tolerated tolérance tomorrow too top total
  toujours tournament tournaments tourney tout toute trees trine 
  trouble trust truth trykker très two

  unavailable under understand undisclosed universe unknown unless
  unlisted until unusual upon urgent use used user usually

  veritas very veux virtual viva vive vivre voted votre voulez vous
  vs vugraph véritable 

  walk want wanted wants war wasted watch we welcome were what 
  whatever whats when where which who whoami why wife will wine 
  winner winter wisdom with without wlc woman wonder wonderful word 
  words words work world worldclass worse would write writer wrong

  xx

  year years yes yet you you're your yourself yucel 

  zero 

  être

  bboer bteam cabin dalek email tante tartan tennis memory oracle 
  gmail masters bbo hi hello hola doc amigo amie alcatraz 
  anonim answers sashimi atheist abracadabra absolutely adidas
  adventuress airbus alchemy all'swell amulett anonimous
  annonnymouse anonym anonymus another arbeidsjern architect
  etc meme nope announcing anon anonymous nihao besta beste bestan
  bestefar betjenten blackout blacksea blonde blueberry bluemoon
  blueriver booboo boobs bonzo boozy borusse boxer brick buffoon
  buffy buffet bulls bullspread bum butchergirl calm calmness calculus
  cameraman cardshark caress fall fallacy fatboy firecrackers
  fivestar moonlight goal galaxy alcapone organizator overbid police
  polydor porche pops poop paleface panther blacknick peach pearly
  pebble perseverance pervert pessimist petal pharmacist picatchou
  piquant rasputin razorbacks reality reliable resilienza retiredmom
  rocks rockcat rubiksmagic rumpelstilzchen rumplestiltskin
  rumplestilksin zodiacpower røyksignaler seaweed incognito surgeon
  sailfish seabridge searching seasoned selvfølgelig seriously
  slugger smallfather snoopy snowflower solidarite spurs spring
  stratocaster sundance sunday symmetric tornado tormento tournier
  taifun teabridge terpsychora testspeler tetrahedron thansfer
  thedoctor thepunch theshipwright theskank transformer transfeer
  trueheart true voisin volcano sofistike wolves waldamsel waldlaufer
  walleye walkyria wasserfrosch watermelon weakling weltklasse
  wifwafwouf wildkatze wir wirt wino witch withdrawl wonderland
  xmas roguekiller arrester arrows arrow aspirant aspirante
  asterix attractive demander idem adv says dragon blue snow now
  nejdet like later joker robot shadow vip water wind avancé
  alien spock venus brain bmw bridger void tree zorro apple
  anonym glp golfer sourire lips dentist eagle erfahren xtreme
  titanic tolclub wdp fearless dawg dreamer feckless kid dogfish
  captainfiko provocator prezidenta summertime literati chocolate
  namenlos diehard abyss access almighty baby babybear bambi bamsefar
  beachside bigdog bighand biologist bipede blackwidow carpicornus
  hour claim pistolpit crazy candle clarkent conquest courage cowboy
  curious dracula zeitgeist deadlock dear debt debtgal deja demander
  demandez deutschlehrer dictatorergodan doggie domino dostoevskij
  drno dragonfly smellycat easter knucklehead enternasyonel eroica
  sandglass songbird eastwind edge einsiedeln eins imigrant eimer
  emacs emagine euro eurocauliflower eventyr fake fantasma diplomat
  facebook abuse fancazzist fortgeschritten freezing frog geologist
  goulash gazelle geezer gemini girlpower grammy gramps grams
  grandma grandpapa half happyland hawkster heineken høns ihaveone
  implied imprecision scapegoat jackswiss justplay jüpiter hippo
  killer kosmonauta lajeunesse lalala cute queen lifemaster
  lightening lightmare lightsword member masterchef mastermind
  matheducationprofessor microsoft misanthrope moneypenny morpheus
  never nekkidtruth neverland nevermind newbie newproject nightdream
  notransfer noway nochat nostalgie nuggets numbers obelix panzer
  passchen provins parknshop pianissimo laser qwerty rektorinn
  reptili rimrocksetters royalforce nightwish tallboy sunflower
  wickwire capricorn sevenheaven shogun sigma soldiers soulmate
  squireboy storfiskarn sweetie traverse thinkist trickmachine
  universel watcher coffeee coffee commendatore toucan flute grandprix
  zaunkoenig luck abuserr addict administrator aerobics alchemist
  seabird weinkauf bakwerk bambi banksy beaute begynder beginning
  blueadobe bluevista blueyes bonsoir boson brainbaby 
  bridgefriends bridgeplay bridgehi bridgefan bridgeforfun
  bridgevejen bridgeur brillantissime bêtise cafetière cafécafé
  campagne chooser chopper choppy cloudproject coconuts codnugget
  compatability confdentl confidencial confidential confidentiel
  confidentielle consolación contractor convivialite cosmiclove
  cosmos cranky symphony troubadour darksnow decourriere destout
  didn't déclassé
  
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
