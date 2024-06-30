#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Fun;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_fun);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '0% Eriksson',
  '1 1/2',
  '1-2-1',
  '2 Generations',
  '2 over 1',
  '246.5 Meters',
  '3 Baritona',
  '3 Frakkar',
  '3 Idiots + 1',
  '3 troll og en bukk',
  '3..2..1..Meins!',
  '4 Hjerter',
  '4 Jacks',
  '4 Nat',
  '4 Trèfles',
  '40 Årskrisa',
  '5 Ess',
  '50 med omnejd',
  '50 shades of cards',
  '6 Notrump',
  '6 Spades',
  '60 y 20',
  '8-5-0-0',
  '88 Loreng',
  '88 Red',
  '88 Merah Senior',
  '88 Senior',

  'A Team',
  'A2',
  'Aces & Deuces',
  'Adams Family',
  'AG laget',
  'Alex is Beautiful',
  'All In',
  'All Lions',
  'All Stars',
  'Alle presidentens menn',
  'Almost Famous',
  'Almost Juniors',
  'Also Changes',
  'Alzheimer Aces',
  'Andre boller',
  'Angel of Harlem',
  'Angels & Demons',
  'Angry Birds',
  'Annas Fans',
  'Anti Revenge',
  'Applied Math',
  'April 30',
  'Apollo Soyuz',
  'Arctic Farmers',
  'Arctic Powerchicks',
  'Atomic Bridge',
  'Awesome Avengers',

  'B Team',
  'Babes Amazones',
  'Bad Beat',
  'Bad Man',
  'Bara brudar',
  'Barny Army',
  'BBO Lovers',
  'Bea & Family',
  'Beer Card',
  'Bela e os Monstros',
  'Best i baren',
  'Best uten kort',
  'Beverly Hillbillies',
  'B.I.G.',
  'Big Bang',
  'Big Boss',
  'Big Chef',
  'Big Guns',
  'Big Makie',
  'Big Mi?',
  'Black Gold',
  'Black Hole',
  'Black Knife',
  'Black Label',
  'Black Pit',
  'Black Sea',
  'Black Swan',
  'Blanda drops',
  'Bleu Lights',
  'Blue Chip Swedes',
  'Bo Gulasch',
  'Boas disipler',
  'Bob Bob',
  'Boogie Knights',
  'Boro Boss',
  'Boye B Fan Club',
  "Boys'n' Girls",
  'Brian Is Beautiful',
  'Bridge am Grün',
  'Bridge Fan',
  'Bridge Friends',
  'Bridge Lovers',
  'Bridge Plus',
  'British Lions',
  'Brødrene & co',
  'Brødrene Dal',
  'Bullgalian All Star',
  'Butterfly from HK',

  'Ca. et halvt tonn',
  "Cai's Bird",
  'Californian Aces',
  'Captain Blood',
  "Captain's Four",
  'Card Warriors',
  'Casino Floor',
  'Cat Daddy',
  'Circle the World',
  'Cim Bom Bom',
  'Cheap Tricks',
  'Cold Light',
  'Counter Strike',
  'Country Boys',
  'Croatian Pirates',
  'Curry Eaters',

  "D'Artagnan",
  'Danish Guns',
  'Dark Blues',
  'Das Autobahn',
  'Das rote Pferd',
  'De edruelige',
  'De kontorsanställda',
  'De uovervinnelige',
  'Dead Pig Nerds',
  'Den gyldne omvei',
  'Den maskerte hevner',
  'Denktank 7',
  'Denmark Baby',
  'Der Untergang',
  'Der wilde Süden',
  'Desert Warriors',
  'Desperate Bridge Wives',
  'Det nappar på kroke',
  'Die Schönen und di',
  'Die vier vom Rhein',
  'Disco Ninjas',
  'Do You Fire?',
  'Don Julio',
  'Don Revival',
  'Double R',
  'Down Under',
  'Dracula 2',
  'Dragon Cartoon',
  'Dragon Kiddies',
  'Dragon Piggies',
  'Dream Team',

  'Ege2/1',
  'Eiydes discipler',
  'Elses Fanklubb',
  'Elusive 52',
  'Empty Vessels',
  'En bridgespiller ..',
  'En myra tre elefanter',
  'En passant',
  'En påse nötter',
  'Endless Highway',
  'England Swings',
  'E.T & the Dummies',
  'Et par sama og 2 ens',
  'EU oder so',
  'European Aces',
  'Eye of the Tiger',

  'F16',
  'f.d. Fröken Michiel',
  'Fairy Tale',
  'Fallega Folked',
  'Fanta 4',
  'Fast and Furious',
  'Fem på nya äventyr',
  'FF 69',
  'Filips Fanclub',
  'Finnmark Flyers',
  'Finways Sappers',
  'Fjoll uten fisk',
  'Fjords of Norway',
  'Flatt kjedelig',
  'Flora and Friends',
  'Flying Dutchess',
  'Four Aces',
  'Freak City',
  'Fuglen har fløyet',
  'Full House',
  'Full Moon',
  'Full Spectrum',

  'Game Over',
  'Gan Bei',
  'Gang of Wyk',
  "Gary's Boys",
  'Ghost of Red',
  'Girls and Boys',
  'Global Mix',
  'Glomma Raiders',
  'Glory Box',
  'Glory Mandarin',
  'Goan Curry',
  'Gogo Fans',
  'Golden Bombers',
  'Golden Bull',
  'Golden Retriever',
  'Goldy Ice',
  'Good Ball',
  'Good Men',
  'Good Oxygen',
  'Green Eyes',
  'Green Lines',
  'Gutta på tur',
  'Gyllene Prag',
  'Gøta-Hesten',

  "Hagen's Heroes",
  'Hands and Hearts',
  'Hannover Four',
  'Hansen Hurricanes',
  'Happy Bridge',
  'Happy Couples',
  'Hare Krishna',
  'Heldige Olav',
  "Hell's Angels",
  'Hi Charli',
  'Hillbilly Help Suit',
  'Hopp i sang',
  'Horten-14',
  'Hurlumhei',
  'Hvalen og tjukkasene', 
  'Hvor er mine babes',

  'I Doctors',
  'I Win',
  'Ikke akkurat kjedelig',
  'Il Fante di Fiori',
  'Ilhas & Aredores',
  'India Blues',
  'Indian Mavericks',
  'Ingen Bagge',
  'Inverted Minors',
  'Isolated Menaces',
  'Itinérants du bridge',

  'Jaipur Jewels',
  'Jamm & Co',
  'Jane Doe',
  'Jorunns disipler',
  'Josef and Cards',
  'Joy Division',
  'Juniors Disipler',
  'Juzz-Pete',

  'K1',
  'K2',
  'K4',
  'Kapten Krok Crew',
  'Karachi Aces',
  "Karl's Silence",
  'Karlstads vänner',
  'Kasimirs Dream Team',
  'Katt-Bridge',
  'Keep Walking',
  "Keni's Dream",
  'Kick Back',
  'Kipp O`Hoi',
  'Kippe et al',
  'KL 4',
  'Klara färdiga slam',
  'Klicks Dream Team',
  'K(l)ukken',
  'Kløver 5',
  'K-O',
  'Koridor 10',
  'Kronisk kusma',
  'Kurt quo vadis',
  'Kvalen og nissene',

  "L'Orange",
  'La Bomba',
  'LA Light',
  'La Vista',
  'Lady Da et ses Boys',
  'Lakk & Lær',
  'Langt mer enn ivrig',
  'Last Minute',
  'Last Arrival',
  'Lawrence of Arabia',
  'L.C. is Beautiful',
  'Les Girafes',
  'Les Zähringers',
  'Light Blues',
  'Light Cast',
  'Lindenthal und Freunde',
  'Lisbeth og gutta',
  'Lisbeths lakeier',
  "Lise (i)DA",
  'Little Meck',
  'Lovende ung',
  'Lucky 4',
  'Lucky Losers',
  'Lucky Seven',
  'Lucky Star',
  'Lucky 13',

  'M.O.',
  "M' Orange",
  'Ma-Cartoon',
  'Magic Eyes',
  'Man Harr det man har',
  'Manchester United',
  'Many Hands',
  'Master Minds',
  'Max 100',
  'Max-Nat',
  'Männer mit ELAN',
  'MC Toss',
  'Meins bleibt meins',
  'Missão Impossivel',
  'Moo York Nix',
  'Mostly Harmless',
  'Mountain Sea',
  'Ms. Guggenheim',
  'Murphys lag',
  'My Friends',
  'My Way',
  'Mystery Foursome',

  "Narcotic's What?",
  'Nat-Max',
  'Nice and Monsters',
  'Nilslands Crew',
  'Nilslands Slowfoxes',
  'Nilslands sväklinge',
  'No Fear',
  "No He Isn't",
  'No Limit',
  'No Problem',
  'Noe Rusk',
  'Non Problem',
  'Noname Can Can',
  'Nord og Syd',
  'Norrlands guld',
  'North Pole',
  'North Star',
  'Not the Empire',
  'Næsten Junior',

  'Oceans4',
  'Occupy Taksim',
  'odd-å-vi',
  'Odd Tore',
  'Oddskongen med rese',
  'Oh Ya!',
  'Ohne Respekt Crew',
  'Olavs utvalgte',
  'Om het hoekie',
  'One I S',
  'One + Khuching Tree',
  'One Hundred Eighty',
  'One More!',
  'Opp og ned',
  'Orange Dynamite',
  'Ottos Lotto',
  'Over stokk og stein',

  'Papa & Rabbits',
  'Papa and Rabids',
  'Papas & Puppies',
  'Paris Match',
  'Pearl of the Orient',
  'Piger og drenger',
  'Pink Panter',
  'Pinot Noir',
  'Plan B',
  'PO & JBGood Team',
  'Pola-Pola',
  'Powerpuff Pinglorna',
  'Plejans Plöjare',
  'Precision Marathon',
  "Priya's Four",
  'Pur Pur',

  'Quatro Bruxas',
  'Queen and Knights',
  'Queen of Hearts',

  'Ra Ma Ra Him',
  'Radio Communication',
  'Randers 2.0',
  'Randers 4.0',
  'Rapan & Jezus',
  'Red Ash',
  'Red Beach',
  'Red Pork Cutlet',
  'Red Soles',
  'Reidar reiser snart',
  'Renons Rimstedt',
  'Rimstedt Power!',
  'Rising Star',
  'River Blanco',
  'River Friend',
  'River Rojo',
  'Robin Hood',
  'Rotseknots Ernst',
  'Royal Flush',
  'Rubb og stubb',
  'Rudderless Ship',
  'R.U.F.F.',
  'Ruter 7',
  'Ruter 9',

  'Saint Titus',
  'Salten rundt',
  'Samfund Slingers',
  'Saras Friends',
  'Schall und Rauch',
  'Sektion UDV',
  'Seths vänner',
  'Seven Eleven',
  'SHE-D',
  'Shining Pig',
  'Shooting',
  'Shy Ant',
  'Siderkongen og kidz',
  'Silver Eagle',
  'Simple Minds',
  'Sivves straffdubbl',
  'Six Diamonds',
  'Six Samurai',
  'Sjiraffen Erik',
  'Slam Dunk',
  'Slam Hunters',
  'Smoking Guns',
  'Smooth Duck',
  'Småsamen med døler',
  "Soalitt`s disipler",
  'Space Mutants',
  'Spade Ace',
  'Spar K',
  'Spiders from Mars',
  'Spiel mir das Lied',
  'Spjett Spjong',
  'Stabby with Youngsters',
  'Stone Cutters',
  'Storm Gutta',
  'Storm Riders',
  'Strawberry Fields',
  'Stø pluss',
  'Super Pineapples',
  'Svag klöver',
  'Svanslös Skalman',
  'Svenske og ulykke',
  'Sweet Is Middle',
  'Syntax Error',
  'Søta bror',

  'Team Bo a berg',
  'Texan Aces',
  'Texan and Turks',
  'Texan and Yanks',
  'Team Awesome',
  'Team Mayhem',
  'Team Yoda',
  'Tempo-Knektene',
  'The Four Guys',
  'The A Team',
  'The Alliance',
  'The B Team',
  'The Beatles',
  'The Boss Is Back',
  'The Bratz',
  'The Clown',
  'The Colonies',
  'The Contractor',
  'The Crazies',
  'The Crucible',
  'The Daltons',
  'The Eagles',
  'The Fab Five',
  'The Fitness Boys',
  'The Flying Nudes',
  'The Good',
  'The Groovia',
  'The Jets',
  'The Latin',
  'The Lions',
  'The Ninjas',
  'The Palookas',
  'The Patron',
  'The Pirates',
  'The Real Team',
  'The Reco',
  'The Red Devils',
  'The Revokers',
  'The Sharks',
  'The Sheriff',
  'The Skilled',
  'The Stig',
  'The Stones',
  'The Tigers',
  'The Vampires',
  'The Werewolves',
  'The Young Ones',
  'The Palookas',
  'Thick Toast',
  'Thread & Needles',
  'Three Nations',
  'Tre Kn og en D',
  'Tre knekter og ett S',
  'To gamle og to gode',
  'Tommys tigre',
  'Top Flight',
  'Top Ruff',
  'Topbridge of course',
  'Tre hunkar en babe',
  'Tre rette og en vrang',
  'Tre sang',
  'Troll i eske',
  'Tut tut',

  'Unholy Alliance',
  'Usaklig Deigræv',

  'Vaddo Gliders',
  'Vegetable Hotpot',
  'Verden rundt',
  'Very Mixed',
  'Vi bygger stikk!',
  'Vi fyra',
  'Vi i femman',
  'Vickys Vikings',
  'Victorious Secret',
  'Vierde van links',
  'Viking Club',
  'Vitamin',
  'Volatile Company',
  'VP (b)anker IMP',

  'Walking Dead',
  'www guts com',
  'War of Roses',
  'We Are Bye',
  'We Are 6',
  'We Meet Again Mr A.',
  'Well Done',
  'Well Fitted',
  'Well Wise',
  'What the Heck',
  'Whisky Team',
  'White Bears',
  'Wild Griffins',
  'Winter Is Coming',

  'Y.Y.Y.D.',
  'Yarralumla Yabbies',
  'YOI Returns',
  'Young Guns',
  'Young Sharks',
  'Young Warriors',
  'Young Driver',
  'Young Swedes',
  'Your name?',

  'Zia and Friends',
  'Ziemlich gut',

  'Øst-Vest'
);

my %MULTI_TYPOS =
(
  '0% Eriksson' => ['0 eriksson'],
  '3 Idiots + 1' => ['3 idiots +1', '3 idiots + i'],
  '4 Trèfles' => ['4 trefles 1', '4 trefles1',
    '4trèfles', '4 treffles', '4trèfle'],
  '40 Årskrisa' => ['40-Årskrisa'],
  '5 Ess' => ['5-ess'],
  '6 Notrump' => ['6 no trump'],

  'AG laget' => ['ag-laget'],
  'Alex is Beautiful' => ['alex is beatiful'],
  'All Stars' => ['all-stars'],
  'Alle presidentens menn' => ['alle presidentens'],
  'Applied Math' => ['aplied math'],

  'Babes Amazones' => ['babes-amazones'],
  Baneet => ["Baneet's IV"],
  Begijntje => ['begijnt je'],
  'Best uten kort' => ['best uden kort'],
  'Beverly Hillbillies' => ['beverly hillbillie'],
  'Big Guns' => ['big gun'],
  'Big Makie' => ['big makie och co'],
  BNMR => ['b n m r'],
  'Boro Boss' => ['boro-boss'],
  'Brian Is Beautiful' => ['brian is beatiful'],
  'Bridge am Grün' => ['bridge am gruen'],
  'Butterfly from HK' => ['babochka s hk'],

  'Ca. et halvt tonn' => ['ca et halvt tonn'],
  'Californian Aces' => ['california aces'],
  "Captain's Four" => ['captains 4'],
  "Colonel's Team" => ["colonel's  team"],
  'Croatian Pirates' => ['cro pirates'],
  'Curry Eaters' => ['curry  eaters'],

  'Den gyldne omvei' => ['den gylne omvei'],
  'Desperate Bridge Wives' => ['desperate bw', 'desperate bridgewi'],
  'Down Under' => ['doun under'],
  'Dragon Kiddies' => ['dragon kiddie'],

  'Eiydes discipler' => ['eiydes disciple'],
  'Elses Fanklubb' => ["elze`s fanklubb"],
  'En myra tre elefanter' => ['en myra tre elefant'],
  'Et par sama og 2 ens' => ['et par sama og 2 en'],

  'Fast and Furious' => ['fast & furious'],
  'FF 69' => ['ff  69'],
  "Flint's Crew" => ["flint`s crew"],
  'Flora and Friends' => ['flora && friend'],
  'Fuglen har fløyet' => ['Foglen har fløyet'],
  'Freak City' => ['freak-city'],

  "Gary's Boys" => ['garys boys', 'gary´s boys'],
  'Good Men' => ['good man'],

  "Hagen's Heroes" => ["hagen`s heroes"],
  Hammershark => ['hammershark deluxe'],
  'Hands and Hearts' => ['hands & hearts'],
  'Heldige Olav' => ['heldige olav :)'],
  "Hell's Angels" => ['hells angels'],
  'Holmenkollen' => ['h-kollen'],
  'Hopp i sang' => ['hoppa i sang'],
  'Hurlumhei' => ['hurlumhei..'],
  'Hvalen og tjukkasene' => ['hvalen og tjukkasne', 'hvalen & tjukkasene'],

  'Ikke akkurat kjedelig' => ['ikke akkurat kjedel'],
  'India Blues' => ['indian blues'],
  'Indian Mavericks' => ['india mavericks', 'indian mavricks'],
  'Itinérants du bridge' => ['iti du bridge', 'itin du bridge'],

  'Jamm & Co' => ['jamm & co.', 'jamm && co.'],

  K1 => ['k01', 'k-1'],
  'Kasimirs Dream Team' => ['kasimirs dreamteam'],
  "Keni's Dream" => ["keni's"],
  'Kick Back' => ['kick-back'],

  "L'Orange" => ["l' orange"],
  'Lawrence of Arabia' => ['lawrence of arab'],
  'La Vista' => ['la vista team'],
  'Lakk & Lær' => ['lakk og lær', 'lek & lær', 'lokk & lur',
    'litt lakk og lær', 'lakk lær'],
  'L.C. is Beautiful' => ['l.c.is beautiful'],
  'Lindenthal und Freunde' => ['lindenthal und fre'],
  'Lucky 13' => ['lucky13'],

  'Magic Eyes' => ['majic eyes', 'm e'],
  'Man Harr det man har' => ['man harr det man ha'],
  'Manchester United' => ['man u', 'man utd'],
  'Männer mit ELAN' => ['2 männer mit elan'],
  'Missão Impossivel' => ['missão impossível'],
  'Ms. Guggenheim' => ['ms. gugenheim'],
  'Murphys lag' => ['murpyhs lag'],
  'Mystery Foursome' => ['mystery 4some'],

  'Nice and Monsters' => ['nice monsters'],
  'Nilslands Slowfoxes' => ['nilsland slowfoxes', 'nilsland slowfoxers'],
  "No He Isn't" => ['no he isnt'],

  'Oh Ya!' => ['oh ya'],

  'Queen and Knights' => ["queen's & knight"],

  'Rapan & Jezus' => ['rapan and ezis'],

  'Saint Titus' => ['st titus', 'st. titus'],
  'Sakurai' => ['japan sakurai'],
  'Sektion UDV' => ['section udv'],
  'Silver Eagle' => ['silver  eagle'],
  'Sivves straffdubbl' => ['sivves straffdubbl.', 'sivves straffdbl',
     'sivves...'],
  'Six Diamonds' => ['six diamond'],
  'Six Samurai' => ['six samurais'],
  'Slam Hunters' => ['slam hunter'],
  'Stabby with Youngsters' => ['stabby with youngst'],
  'Svanslös Skalman' => ['svanslos skalman'],

  'Tempo-Knektene' => ['tempo-knehtene'],
  'Texan Aces' => ['texa aces', 'texaan aces', 'texan  aces',
    'tn aces'],
  'The Four Guys' => ['the 4 guys'],
  'The Clown' => ['the_clown'],
  'The Palookas' => ['the_palookas'],
  'Tre knekter og ett S' => ['tre knekter og etts'],
  'Tre rette og en vrang' => ['tre rette og en vra'],
  'Troll i eske' => ['tre troll i eske', 'tre troll ...'],

  'Victorious Secret' => ['victorius secret'],

  'What the Heck' => ['whattheheck']
);

my @SINGLE_WORDS = qw(
   2Q2K 3D 6L 10CC 7heart

   Aces Adventure Agamemnon Agressor Ahornet Aida Alliance Alliansen 
   Allstars Alternativlos Amarillo Ambassador Andromeda Anglian 
   Anglers Anglophones Appellkameratene Apples Apply Aquarius 
   Arachfobia Archies Aristos Armani Asparagus Astra Astro 
   Astronotlar Atlantic Atom Autostrada Avalanche Avatar 

   Bachelor Badger Badminton Bager Banana Bananasplit BarDeZi 
   Barracuda Barsss Baryton Beauty BeRe Bingbang Binkie Blackwood 
   Bling Blondie Blues Blueberry Blues Bolero Boogies Boomz 
   BOVE Bricklayer Bridgekameratene Bridgeministeriet Brigada Brother 
   Brudarna Bubba Buddies Bulldozer Bumerangas Bunnies

   Cancan Cardtossers Cargo Cartoon Casuals Censored Challengers 
   Changes Chicks Chokladmåndag Claim Coaches Cogito Commandos 
   Comrade Contact Contra Corner Counterstrike Crash Cremaster 
   
   Danger Debutantes Deceptive Desperados Destroyers Dialect Doctors 
   Donjulio Donvito Dracula Dragon DuckNDales Dusteforbundet Dyret

   Eagles Eliminator Emerald Engineers Enigma Enjoy Everest Evil 

   Fantasia Fant4stic Farmen Farmers Filosofene Finest Fisk Forfot 
   Formidables Frenemies Friends Francophones Freak Frivolt 

   Galaxy Gentle Geriatrix Geysir Giants GloryGlory Goldcat Gosho 
   Grand Grads Gris Guests Gulebjorn Gunsmoke 

   Hangarounds Harlequins Hawks Hästpojkarna HERZdame HeSa Hey 
   Hiiimmm Hjerterdamer Hobbits Hollywood Holmenkollen Honeymoon 
   Hopfenkönig Hornet Huhu Hunhun Hurra Hybrid

   Ikarus Imponderables Instructor 

   Jernbaneverket JJJ Job Jocker JoJo Joker Journalists Jugermaister 
   Juice Jupiter Juubilar 

   Kamelåså Kamikaze Kangaroo Kanin Karo Kartel Kat Kingkong Kings 
   KISS KKKQ Kompisarna Kuglana Kuhmilch 

   Laplanders Lazy Lebensohl Liggeunderlaget Lion Lions Lirarna 
   Liverbird Lucky LVBridgeBums Løwene

   Maestroi Magi Magic Magister Maharaja Major MajorB Majorn Majority 
   Mars Marvelous Masdjävlar Mask Masters Matrix Maven Maxi Mercury 
   Meta Midas Milady Mirage Mismatch Mixarna Mjøskameratne MMMM 
   Mongos Multivariant Mustang Måsen

   Natural Naturalists Nemesis Neverclaim Nightingale Noctis 

   Octopussy Okay Olavsfestdagene Olrudbanden Olsenbanden Onyx 
   Opal Opera Opps Optimus Orthodoxi Orthodox Osss Outsiders Overivrig 

   Pacers Paradigma Partizan
   Patriot Patron 
   Pegasus Perestrojka 
   Pontiac Potlimit Potteplante Powerchicks 
   Preempters Pretendents Proteus 
   Pusten Påskevennene

   Quasar Quattro Quintet Quinze

   Rampage Rapid Real Reklamtrion Reloaded Robocop Rollers Rovers 

   Sabres Saga Sailor Sakura Sakurai Saladmasters Salokin Sapphire 
   Saturn Schneewittchen Scientists Secure Senator Show Silence 
   Silverfox Simple Sindbad Singapole Sirius Sjøsamen Skip Skitur 
   Slappfisker Slufsa Småveitjan Snapper Snipers Soho Sonata Spark 
   Spartans Specialist Spekkhogger Squeeze Stampede Star Starmen 
   Statusquo Stayman Stifinnern Storeslemmen Strategen Streamline 
   Stålfarfar Sunset Sunshine Syttisju Sømnakameratene Såpeopera

   Takeoff Tannlegene Taurus Tbone Tempo Tequendama Theme Tibetmunkene 
   Tigers Titanik Titans Tohundre Tolerant Torpedo Tosca Trèfles 
   Triton Tsunami Tulip Tusio Tutu Tvist

   UFO Ugh Ulvene Underdogs Unexpected Ungdomslaget Upplyfting 
   Utkantnorge 

   Vibrant Victory Vietcong Viking Villmarksgutta Vintage Vulcano

   Walpurga Windrunners Winkiboy Wizards 

   Xman Xtrouble XXX XXXL XXXSL XXXXXYXY

   Zombi Zorro Zugzwang 
);

my %SINGLE_TYPOS =
(
  'Adams Family' => ['adamsfamily'],
  Ambassador => ['ambassadors', 'ambassdor'],
  Anglers => ['anglelers'],
  'Apollo Soyuz' => ['apollosoyuz', 'apollosoyouz'],
  Appellkameratene => ['apellkameratene'],
  'Atomic Bridge' => ['atomic'],

  Barracuda => ['barakuda', 'baracuda'],
  'Bleu Lights' => ['bleulights'],
  Buaigh => ['buaijh'],
  Bulldozer => ['buldozer'],

  'England Swings' => ['englandswings'],

  Fant4stic => ['fant4stc'],
  Formidables => ['formidable', 'formidabble', 'formidabels',
    'formiddable', 'formiddables', 'formadibles', 'formadeble',
    'formadables', 'fromidables'],

  'Green Eyes' => ['greeneyes'],
  Gunsmoke => ['gunnsmoke'],

  Hästpojkarna => ['hastpojkarna'],

  Imponderables => ['impoderables'],
  'India Blues' => ['indiablues'],

  'Jamm & Co' => ['jamm'],
  'Joy Division' => ['joydivision'],
  Jupiter => ['jupitor'],

  'Last Arrival' => ['lastarrival'],
  Lebensohl => ['lebenshol'],

  Maharaja => ['maharaj', 'maharaaj'],
  Mismatch => ['missmatch'],
  Mjøskameratne => ['Mjöskameratene'],
  Måsen => ['Måsan'],

  Naturalists => ['nature', 'naturalistene'],

  'Occupy Taksim' => ['occupytaksim'],
  Onyx => ['onix'],
  Opps => ['opsy'],

  'Paris Match' => ['parismatch', 'parimatch'],
  Preempters => ['preemptors'],
  Pretendents => ['pretendentas'],

  'River Friend' => ['riverfriend'],

  Scientists => ['science'],
  Spartans => ['spartan'],
  Squeeze => ['squeze'],
  Starmen => ['starman'],
  'Stone Cutters' => ['stonecutters'],
  Strategen => ['stratagen'],
  Syttisju => ['sytti'],

  'Texan Aces' => ['texanaces', 'tnaces'],
  Titans => ['titan'],

  'Vegetable Hotpot' => ['vegetable'],

  'Wild Griffins' => ['wildgriffin', 'wildgriffins'],
  'Winkiboy' => ['winkyboy'],

  'YOI Returns' => ['yoi']
);


sub set_hashes_team_fun
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
