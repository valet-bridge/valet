#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamFun;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_fun);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '0% Eriksson',
  '2 Generations',
  '246.5 Meters',
  '3 Baritona',
  '3 Frakkar',
  '3 Idiots + 1',
  '3 troll og en bukk',
  '3..2..1..Meins!',
  '4 Hjerter',
  '4 Jacks',
  '4 Trèfles',
  '40 Årskrisa',
  '5 Ess',
  '6 Notrump',
  '6 Spades',
  '60 y 20',
  'ABA Nuno Paz',
  'Aces & Deuces',
  'Adams Family',
  'AG laget',
  'Air Traffic Management',
  'Alex is Beautiful',
  'Alizee',
  'All In',
  'All Lions',
  'All Stars',
  'Alle presidentens menn',
  'Almost Famous',
  'Almost Juniors',
  'Also Changes',
  'Alunand Plus',
  'Alzheimer Aces',
  'Andre boller',
  'Angel of Harlem',
  'Angels & Demons',
  'Angry Birds',
  'Annas Fans',
  'Anti Revenge',
  'April 30',
  'Apollo Soyuz',
  'Arctic Farmers',
  'Arctic Powerchicks',
  "Asha's 4",
  'Asketické samice',
  'Aso Pika',
  'Atomic Bridge',
  'Avesta',
  'Awesome Avengers',
  'Aylan Kurdý',
  'Azure Hooda',
  'Babes Amazones',
  'Bad Beat',
  'Bad Man',
  'Baltic Club',
  'Banteng Selatan',
  'Bara brudar',
  'Barny Army',
  'Bate Tot',
  'BBE Hungary',
  'BBO Lovers',
  'Bea & Family',
  'Beer Card',
  'Bela e os Monstros',
  'Best i baren',
  'Best uten kort',
  'Beverly Hillbillies',
  'Big Bang',
  'Big Boss',
  'Big Chef',
  'Big Guns',
  'Big Makie',
  'Big Mi?',
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
  'Boye B Fan Club',
  "Boys'n' Girls'",
  'Brian Is Beautiful',
  'Bridge am Grün',
  'Bridge Friends',
  'Bridge Plus',
  'Bridgerama Milan',
  'British Lions',
  'Brødrene & co',
  'Brødrene Dal',
  'Ca. et halvt tonn',
  "Cai's Bird",
  'Californian Aces',
  'Captain Blood',
  'Card Warriors',
  'Casino Floor',
  'Cat Daddy',
  'Cemara Putra',
  "Chairman's Choice",
  'Circle the World',
  'Cliff Wake',
  "Colonel's Team",
  'Cheap Tricks',
  'City Bridge',
  'Cold Light',
  'Contact 1',
  'Cookie Potter',
  'Counter Strike',
  'Country Boys',
  'Croatian Pirates',
  'Curry Eaters',
  'Curt-Lennart',
  'D-MaTK',
  "D'Artagnan",
  "D'Coup",
  'D POK',
  'Dalian ABC',
  'Dalian BA',
  'Dalian Hong',
  'Danish Guns',
  'Dark Blues',
  'Das Autobahn',
  'Das rote Pferd',
  'Daqin Shihua',
  'Daqin Xinghan',
  'Daqin Xinghua',
  'Daqing Xinghan',
  'De edruelige',
  'De kontorsanställda',
  'De uovervinnelige',
  'Dead Pig Nerds',
  'Deccan Chargers',
  'Deceptive AHM',
  'Delhi Diamonds',
  'Delhi Gym Aces',
  'DELTA 2',
  'Den gyldne omvei',
  'Den maskerte hevner',
  'Denktank 7',
  'Denmark Baby',
  'Der Untergang',
  'Der wilde Süden',
  'Dersim38',
  'Desert Warriors',
  'Desperate Bridge Wives',
  'Det nappar på kroke',
  'Deutsche Senioren',
  'Die Schönen und di',
  'Die vier vom Rhein',
  'Diren Noname',
  'Disco Ninjas',
  'DK Notus',
  'DK Nationalchampion',
  'DK-Tworzywa',
  'DKI Maesa',
  'Do You Fire?',
  'domwaluty.pl',
  'Don Julio',
  'Don Revival',
  'Dongfang Tairong',
  'Dong Ming',
  'Dong Qi 9',
  'Double R',
  'Down Under',
  'Dr. Gittipatq',
  'Dracula 2',
  'Dragon Cartoon',
  'Dragon Kiddies',
  'Dragon Piggies',
  'Dream Team',
  'DS 1',
  'Ege & Besli Major',
  'Eiydes discipler',
  'El Gezira',
  'El Hazem',
  'El Play',
  'El Yamo',
  'Ella-Jamie',
  'Elses Fanklubb',
  'Elusive 52',
  'Empty Vessels',
  'EM-76',
  'En bridgespiller ..',
  'En myra tre elefanter',
  'En passant',
  'En påse nötter',
  'Endless Highway',
  'England and Pharon',
  'England Swings',
  'Equator 1771',
  'Erdal Abi',
  'Erdal Tekin',
  'Esso-sveitin',
  'E.T & the Dummies',
  'Et par sama og 2 ens',
  'Etna Bridge',
  'EU oder so',
  'European Aces',
  'Eviza Plambata',
  'Eye of the Tiger',
  'f.d. Fröken Michiel',
  'Fairy Tale',
  'Fallega Folked',
  'Fast and Furious',
  'Four Aces',
  'Fem på nya äventyr',
  'Filips Fanclub',
  'Finnmark Flyers',
  'Finways Sappers',
  'Fjoll uten fisk',
  'Fjords of Norway',
  'Flatt kjedelig',
  "Flint's Crew",
  'Flora and Friends',
  'Flying Dutchess',
  'Four Aces',
  'Frankie Holidays',
  'Freak City',
  'Friends of Lalit',
  'Fuglen har fløyet',
  'Full House',
  'Full Moon',
  'Full Spectrum',
  'Game Over',
  'Gan Bei',
  'Gang of Wyk',
  'Garuda Sakti',
  "Gary's Boys",
  'Gerganin Izvor',
  'Ghost of Red',
  'Global Mix',
  'Glomma Raiders',
  'Glory Box',
  'Glory Mandarin',
  'Goan Curry',
  'Gogo Fans',
  'Gold Cup',
  'Golden Bombers',
  'Golden Bull',
  'Golden Retriever',
  'Goldy Ice',
  'Good Ball',
  'Good Men',
  'Good Oxygen',
  'Green Eyes',
  'Green Lines',
  'Grefstad and co',
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
  'Hungarian Olympic',
  'Hurlumhei',
  'Hvalen og tjukkasene', 
  'Hvor er mine babes',
  'I Doctors',
  'Ikke akkurat kjedelig',
  'Il Fante di Fiori',
  'Ilhas & Aredores',
  'India Blues',
  'Indian Mavericks',
  'Ingen Bagge',
  'Inverted Minors',
  'Isen Mulang',
  'Isolated Menaces',
  'Jai Ganesh',
  'Jaipur Jewels',
  'Jamm & Co',
  'Jan Wellem',
  'Jane Doe',
  'Japan SARA',
  'Japan SAYN',
  'Jarum LA',
  'Jenny-Chang',
  'Jie Fang He Ji',
  'Jiu Jiu',
  'Jorunns disipler',
  'Josef and Cards',
  'Joy Division',
  'JT2',
  'Juniors Disipler',
  'Juras Ezi',
  'Juzz-Pete',
  'K1',
  'K2',
  'K4',
  'Kacho Fugetsu',
  'KaiCheng RL',
  'Kapten Krok Crew',
  'Karachi Aces',
  "Karl's Silence",
  'Karlstads vänner',
  'Kasimirs Dream Team',
  'Katt-Bridge',
  'Ke Da',
  'Keep Walking',
  "Keni's Dream",
  "Keni's Team",
  'Kent Romeos venner',
  'Kick Back',
  'Kipp O`Hoi',
  'Kippe et al',
  "Kitty's",
  'KL 4',
  'Klara färdiga slam',
  'Klicks Dream Team',
  'K(l)ukken',
  'Kløver 5',
  'KM 23',
  'K-O',
  'KOC67',
  'Koridor 10',
  'Kozyrnye Oleni',
  'Kronisk kusma',
  'Kurt quo vadis',
  'Kvalen og nissene',
  'KM AT',
  "L'Orange",
  'La Bomba',
  'La Vista',
  'Lady Da et ses Boys',
  'Lakk & Lær',
  'Langt mer enn ivrig',
  'Las Olas',
  'Last Minute',
  'Lawrence Allstars',
  'Lawrence of Arabia',
  'Last Arrival',
  'Late S.S. Jain',
  'Le Colonial',
  'Leromain boys',
  'Les Girafes',
  'Les Zähringers',
  'Light Blues',
  'Light Cast',
  'Lindenthal und Freunde',
  'Lisbeth og gutta',
  'Lisbeths lakeier',
  'Little Meck',
  'Los Feos',
  'Los Malos',
  'Los Tollos',
  'Lovende ung',
  'Loy Krathong',
  'Lucky 4',
  'Lucky Losers',
  'Lucky Seven',
  'Lucky Star',
  'Lucky 13',
  'Lucy-Ellena',
  "M' Orange",
  'Ma-Cartoon',
  'Magic Eyes',
  'Mal - Phi',
  'Malatya Basket',
  'Man Harr det man har',
  'Manchester United',
  'Manny Herrings',
  'Many Hands',
  'Master Minds',
  'Max 100',
  'Max-Nat',
  'Männer mit ELAN',
  'Meins bleibt meins',
  'Meng Qing Xin',
  'Minas Trith',
  'Missão Impossivel',
  'Mo i Raneran',
  'Moo York Nix',
  'Mostly Harmless',
  'Ms. Guggenheim',
  'Mumbai Indians',
  'Murphys lag',
  'My Friends',
  'My Way',
  'Mystery Foursome',
  'Møllers Team',
  "Narcotic's What?",
  'Nav Chaitanya',
  'Nazar Boncugu',
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
  'Nord og Syd',
  'Norrlands guld',
  'North Pole',
  'North Star',
  'Not the Empire',
  'Novi Tim',
  'Næsten Junior',
  'Oceans4',
  'Occupy Taksim',
  'odd-å-vi',
  'Odd Tore',
  'Oddskongen med rese',
  'Oh Ya!',
  'Ohne Respekt Crew',
  'Ojasta Ahoon',
  'Olavs utvalgte',
  'Old Sports Jarov',
  'Om het hoekie',
  'One Hundred Eighty',
  'One More!',
  'Opp og ned',
  'Orange Dynamite',
  'Oruva Eesti',
  'Ottos Lotto',
  'Over stokk og stein',
  'Ööklubi Strand',
  'Øst-Vest',
  'Papa & Rabbits',
  'Papa and Rabids',
  'Papas & Puppies',
  'Paris Match',
  'Park Bridge',
  'Pearl of the Orient',
  'Piger og drenger',
  'Pink Panter',
  'Pinot Noir',
  'Plan B',
  'Poismenon Vaari',
  'Pola-Pola',
  'Pontiac 7',
  'Powerpuff Pinglorna',
  'Plejans Plöjare',
  "Pradeep's Four",
  'Precision Marathon',
  "President's Team",
  'Quatro Bruxas',
  'Queen and Knights',
  'Queen of Hearts',
  'Radio Communication',
  "Rajjan's",
  'Ram Charan',
  'Randers 2.0',
  'Randers 4.0',
  'Red Ash',
  'Red Pork Cutlet',
  'Red Sea Festival',
  'Red Soles',
  'Reidar reiser snart',
  'Renons Rimstedt',
  'Rimstedt Power!',
  'Rising Star',
  'River Friend',
  'Robin Hood',
  'Roheline Lammas',
  'Rotseknots Ernst',
  'Royal Flush',
  'Rubb og stubb',
  'Rudderless Ship',
  'Ruter 7',
  'Ruter 9',
  'Saint Titus',
  'Saevar Karl',
  'Salten rundt',
  'Samfund Slingers',
  'Sang ae',
  'Saras Friends',
  'Schall und Rauch',
  'Scottish President',
  'Semangat Baru',
  'Seths vänner',
  'Seven Eleven',
  'Shining Pig',
  'Shooting',
  'Shy Ant',
  'Si Fu Te',
  'Siderkongen og kidz',
  'Silver Eagle',
  'Simple Minds',
  'Sivves straffdubbl',
  'Six Diamonds',
  'Six Samurai',
  'Slam Dunk',
  'Slam Hunters',
  'slaveykov.bg',
  'Smoking Guns',
  'Smooth Duck',
  'Småsamen med døler',
  "Soalitt`s disipler",
  'South Zone',
  'Space Mutants',
  'Spade Ace',
  'Spar K',
  'Spiders from Mars',
  'Spiel mir das Lied',
  'Spjett Spjong',
  'Spring Foursomes',
  'Sree Priya',
  'Stabby with Youngsters',
  'Stall Dieden',
  'Stis Multivariant',
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
  'Syabas Gabrial UI',
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
  'The Groovia',
  'The Jets',
  'The Latin',
  'The Lions',
  'The Lombard',
  'The Ninjas',
  'The Palookas',
  'The Patron',
  'The Pirates',
  'The Real Team',
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
  'The Good',
  'The Palookas',
  'Thick Toast',
  'Thread & Needles',
  'Three Nations',
  'Tinutuan Manado',
  'Tre knekter og ett S',
  'To gamle og to gode',
  'Tommys tigre',
  'Top Ruff',
  "Tor Ivar's",
  'Tre hunkar en babe',
  'Tre rette og en vrang',
  'Tre sang',
  'Troll i eske',
  'Tupac Amaru',
  'Tut tut',
  'Ucurtma Avcisi',
  'Umisen Yamasen',
  'Unholy Alliance',
  'Usaklig Deigræv',
  'Vaddo Gliders',
  'Valar Morghulis',
  'Vegetable Hotpot',
  'Verden rundt',
  'Very Mixed',
  'Vickys Vikings',
  'Victorious Secret',
  'Vierde van links',
  'Vi bygger stikk!',
  'Vi fyra',
  'Vi i femman',
  'Viking Club',
  'Visoki Napon',
  'Volatile Company',
  'Walking Dead',
  'www guts com',
  'War of Roses',
  'We Are Bye',
  'We Are 6',
  'We Meet Again Mr A.',
  'Wei De',
  'Well Done',
  'Well Fitted',
  'Well Wise',
  'What the Heck',
  'Whisky Team',
  'White Bears',
  'Wild Griffins',
  'Winter Is Coming',
  'XiBu VIP',
  'Xin Yuan',
  'Yarralumla Yabbies',
  'Yitang QIAO',
  'YOI Returns',
  'Young Guns',
  'Young Sharks',
  'Young Warriors',
  'Young Driver',
  'Your name?',
  'Zara Bridge',
  'Zen Ho',
  'Zia and Friends',
  'Ziemlich gut',
  '50 med omnejd',
  '50 shades of cards'
);

my %MULTI_TYPOS =
(
  '3 Idiots + 1' => ['3 idiots +1', '3 idiots + i'],
  '4 Trèfles' => ['4 trefles 1', '4 trefles1', '4 trefles ii',
    '4trèfles', '4 treffles'],
  '40 Årskrisa' => ['40-Årskrisa'],
  '5 Ess' => ['5-ess'],
  '6 Notrump' => ['6 no trump'],
  'ABA Nuno Paz' => ['ABA - Nuno Paz', 'ABA-Nuno Paz'],
  'AG laget' => ['ag-laget'],
  'Air Traffic Management' => ['air traffic managem'],
  'Alex is Beautiful' => ['alex is beatiful'],
  'Alle presidentens menn' => ['alle presidentens'],
  Arnab => ["arnab's"],
  Azores => ['açores team'],
  Ayan => ["ayan's"],
  'Babes Amazones' => ['babes-amazones'],
  'Best uten kort' => ['best uden kort'],
  'Beverly Hillbillies' => ['beverly hillbillie'],
  'Big Guns' => ['big gun'],
  'Big Makie' => ['big makie och co'],
  'Brian Is Beautiful' => ['brian is beatiful'],
  'Bridge am Grün' => ['bridge am gruen'],
  'Bridgerama Milan' => ['bridgerama mi'],
  'Ca. et halvt tonn' => ['ca et halvt tonn'],
  'Californian Aces' => ['california aces'],
  "Chairman's Choice" => ["chairman's team"],
  'Croatian Pirates' => ['cro pirates'],
  'Curry Eaters' => ['curry  eaters'],
  'Deceptive AHM' => ['deceptive  ahm'],
  'Delhi Gym Aces' => ['d g aces', 'dgc aces'],
  'Den gyldne omvei' => ['den gylne omvei'],
  'Desperate Bridge Wives' => ['desperate bw', 'desperate bridgewi'],
  'Down Under' => ['doun under'],
  'Dragon Kiddies' => ['dragon kiddie'],
  DSM => ['d s m'],
  'Eiydes discipler' => ['eiydes disciple'],
  'El Gezira' => ['el-gezira'],
  'Elses Fanklubb' => ["elze`s fanklubb"],
  'En myra tre elefanter' => ['en myra tre elefant'],
  'England and Pharon' => ['england plus pharon'],
  'Equator 1771' => ['equator1771'],
  'Esso-sveitin' => ['esso - sveitin', 'esso -sveitin'],
  'Et par sama og 2 ens' => ['et par sama og 2 en'],
  'Eviza Plambata' => ['evita_plambata'],
  'Fast and Furious' => ['fast & furious'],
  "Flint's Crew" => ["flint`s crew"],
  'Flora and Friends' => ['flora && friend'],
  'FOS' => ['f o s'],
  'Fuglen har fløyet' => ['Foglen har fløyet'],
  'Frankie Holidays' => ['frankie hollydays'],
  'Freak City' => ['freak-city'],
  "Gary's Boys" => ['garys boys', 'gary´s boys'],
  'Good Men' => ['good man'],
  "Hagen's Heroes" => ["hagen`s heroes"],
  Hammershark => ['hammershark deluxe'],
  'Hands and Hearts' => ['hands & hearts'],
  'Heldige Olav' => ['heldige olav :)'],
  "Hell's Angels" => ['hells angels'],
  'Hopp i sang' => ['hoppa i sang'],
  Huamen => ['hua men'],
  'Hungarian Olympic' => ['hungar olimp', 'hungarian olimp',
    'hungar olimpics', 'hungar olimpic'],
  'Hurlumhei' => ['hurlumhei..'],
  'Hvalen og tjukkasene' => ['hvalen og tjukkasne', 'hvalen & tjukkasene'],
  'Ikke akkurat kjedelig' => ['ikke akkurat kjedel'],
  'India Blues' => ['indian blues'],
  'Indian Mavericks' => ['india mavericks', 'indian mavricks'],
  'Jamm & Co' => ['jamm & co.', 'jamm && co.'],
  'Jan Wellem' => ['jan wel'],
  K1 => ['k01', 'k-1'],
  'Kasimirs Dream Team' => ['kasimirs dreamteam'],
  'Kent Romeos venner' => ['kent romeos veenner'],
  'Kick Back' => ['kick-back'],
  'KM 23' => ['km23'],
  'Late S.S. Jain' => ['late ss jain', 'lss jain', 'l s s jain',
     'late sssk jain'],
  'Lawrence of Arabia' => ['lawrence of arab'],
  'La Vista' => ['la vista team'],
  'Lakk & Lær' => ['lakk og lær', 'lek & lær', 'lokk & lur'],
  'Leromain boys' => ["leroumain's boys"],
  'Lindenthal und Freunde' => ['lindenthal und fre'],
  'Lucky 13' => ['lucky13'],
  'Magic Eyes' => ['majic eyes'],
  'Man Harr det man har' => ['man harr det man ha'],
  'Manchester United' => ['man u', 'man utd'],
  'Missão Impossivel' => ['missão impossível'],
  'Mo i Raneran' => ['mo i raneran :)'],
  'Ms. Guggenheim' => ['ms. gugenheim'],
  'Murphys lag' => ['murpyhs lag'],
  'Mystery Foursome' => ['mystery 4some'],
  'Møllers Team' => ['møllers t'],
  'Nice and Monsters' => ['nice monsters'],
  'Nilslands Slowfoxes' => ['nilslands slowfoxers', 'nilsland slowfoxes',
    'nilsland slowfoxers'],
  "No He Isn't" => ['no he isnt'],
  "Pradeep's Four" => ["pradeep's 4", "Pradeep's Team"],
  "President's Team" => ["president's", 'presidents teams'],
  'Queen and Knights' => ["queen's & knight"],
  'Saevar Karl' => ['svaer karl'],
  'Saint Titus' => ['st titus', 'st. titus'],
  'Sakurai' => ['japan sakurai'],
  'Semangat Baru' => ['semangat br'],
  'Sivves straffdubbl' => ['sivves straffdubbl.', 'sivves straffdbl',
     'sivves...'],
  'Six Diamonds' => ['six diamond'],
  'Six Samurai' => ['six samurais'],
  'Slam Hunters' => ['slam hunter'],
  'slaveykov.bg' => ['slaveikov.bg'],
  'Spring Foursomes' => ['spring 4s', 'spring fours', "spring 4's"],
  'Stabby with Youngsters' => ['stabby with youngst'],
  'Svanslös Skalman' => ['svanslos skalman'],
  'Syabas Gabrial UI' => ['syabas gabrial-ui', 'syabas gabrial - ui'],
  'Tempo-Knektene' => ['tempo-knehtene'],
  'Texan Aces' => ['texa aces', 'texaan aces'],
  'The Four Guys' => ['the 4 guys'],
  'The Clown' => ['the_clown'],
  'The Palookas' => ['the_palookas'],
  'Tre knekter og ett S' => ['tre knekter og etts'],
  'Tre rette og en vrang' => ['tre rette og en vra'],
  'Troll i eske' => ['tre troll i eske', 'tre troll ...'],
  'Valar Morghulis' => ['valar morgulis'],
  'Victorious Secret' => ['victorius secret'],
  'What the Heck' => ['whattheheck'],
  'Yitang QIAO' => ['qiao yi tang']
);

my @SINGLE_WORDS = qw(
   2Q2K 6L 10CC 7heart

   AABC Aces Acolvik Adventure Aditya Aeras Agamemnon Agressor Ahmetizm 
   Ahornet Aida Akenobo Akinom Alertplus Alex Alfredo Ali Alioth 
   Allam Alliance Alliansen Allstars Alpha Alternativlos Ambassador 
   Amrapali Amul Andromeda Anglian Andrzejki Anglers Anglophones 
   Aniket Anna Anuj Apaçý Appellkameratene Apples Aquarius Arachfobia 
   Arangan Archies Aristos Armani Arnab Arno Arunas Aslanli Aspe 
   Asparagus Astro Astronotlar Atlantic Atom Atrium Augerne Auni 
   Aurora AUTBUL AUTHOL Autostrada Avagard Avalanche Avatar Ayan
   Aytalus Azores Azure

   Bacch Bachelor Bade Badger Badminton Bager Baias Bajozero Balti 
   Bananasplit Baneet BarDeZi BARP Barracuda Baryton Bato Bauhinia 
   BBO Beauty Begigütje Begijntje Ben Beniaminek Berik Beton Bhinneka 
   Biachite Bilal Bingbang Binkie Biriceri Blackwood Blandat Bling 
   Blondie Blueberry Boek Bolero Boogies Boomz Boriana Borko BOVE 
   Breno Bricklayer Bridgebutikken Bridgekameratene Bridgeministeriet 
   Brother Brudarna Buaigh Bubba Bubu Buddies Bumerangas Bunnies 
   Bulldozer Busiaki

   Cabal Cabriole Calaca Cammello Canadonia Cancan Canukusa 
   Cardtossers Cargo Cartoon Casuals Cathy Cavelieri Censored 
   Center Challengers Changes Chass Chicks Chime Chiranjeev 
   Chokladmåndag Claim Claudili Coaches Cogito Colorado Commandos 
   Comrade Concurrent Conie Contact Contra Coopers Corner 
   Costantina Counterstrike Couples Crash Cremaster Croanglopol
   Crockfords Crossfatek Czteropak

   Dada Dadya Dallas DanEng DanFar Danger Daniel Dash Dauna Dawn 
   Debonecos Debutantes Deceptive Defne Demony DenmarS Deppo 
   Desperados Destroyers Dialect Diana Dido Diego Dieter Dilligaf 
   Dimmat Dingyuan Dinos Doctors Doki Donjulio Donvito Dracula Dragon 
   DSM DuckNDales Dukens Duros Dusteforbundet Dvizhenie Dyret

   Eagles Ece Econ Edi Efsane Egesarpdoruk Eikka Ekenboda Ekoap 
   Elektrownia Elio Eliminator Elips Eliza Ellen Emerald Emre Engelen 
   Engineers Enigma Enjoy Ephesus Epsilon Equator Era Eren Eric 
   Erikas Ertým Esperanza Everest Evil Ewa

   Fakel Fantasia Fant4stic Farmen Farmers Felix Fenghuang Fenia 
   Fenix Ferfi Feszek Fharon Fifi Fil Filosofene Filur Finest Fisk 
   Forfot Formidables Formosa Fortuna FOS Foundation Francest Frank 
   Franz Frenemies Frieolt Friends Frirond Francophones Freak 
   Frivolt Frusci Fundacja

   Gabrisem Galaxy Galim Gambitas Gamma Garry Garuda Gata Gelim 
   Gelin Gentle George Geriatrix Gewanna Geysir Gesi Giants Gibs 
   Gjesp Gkobra GloryGlory Goldcat Goroco Gosho Grand Greecoura 
   Grup Guayacos Gudok Guests Gulce Gulebjorn Gullberg Gullvi 
   Gunsmoke Guptas Gürsel

   Hade Hanan Hande Hangarounds Hansa Harlequins Havin Hawks HayirlisI
   Hayet Hästpojkarna Heis Hel Helgeness Hellé Heliopolis HengSha 
   HERZdame HeSa Hey Hiiimmm Hilda Hobbits Holders Holifera Hollywood 
   Holport Honeymoon Hopfenkönig Hridhaan Huamen Hubsi Huhu Hunaja
   Huispaus Hurra

   IBE Ida Ijseide Ikarus Ilya IMAN Imanual Imponderables InFran
   Instructor Invicta Iris Irukangi Ismo Israbel Isrmany Itnoraunz 
   IVAR

   Jagg Jaiganesh Janko Jans JAPCAN JAS JASS Jassica Javel Jelena 
   Jernbaneverket Jessi Jessica Jirin Jiujiu Jóannes Job Jocker
   JoJo Joker Journalists Juanval Jugermaister Juice Juls 
   Juniorklubben Jupiter Juste Justplay Justyna Justynka Jutek 
   Juubilar JuuTools

   Kaardivägi Kagama Kalbar Kalka Kalkarn Kaltim Kamelåså Kamikaze 
   Kamlakars Kamyk Kangaroo Kanin Karaarslan Karin Karo Kartel 
   Kasiyahan Kasty Kasuang Katipunan Kebiya Keni Kenji Kenlong 
   Kerasus Kibe Kinga Kingkong Kings KISS Kjelskos Klasik Klio
   KMC Knösel Kodin Koiraperhe Kokoelma Kolbasti Komleposs
   Kompisarna Konga Kordam Korsikalý Kortai Koukouselis KrASK Kratos 
   Krem Kris Kriston Krisztina Ksenia Kuglana Kuhmilch Kultur
   Kvazar

   Lahjattomat Langy Laplanders Laplas Larry Lasse Lataka Lateria LatSwe 
   Lazy Lebensohl Lebron Legeanka Lema Lemanus Leta Letve Leveni
   Lianas Liggeunderlaget Lili Lillebaluba Lions Lipa Lira Livius 
   Lirarna Liverbird Ljónin LNWers Logos Lolly Loloc Lowel Löparn 
   Lucky LVBridgeBums Lyubcho Løwene

   Mach Madhav Mads Maestroi Magic Magister Maharaja Maija Major MajorB
   Majorn Majority Malinka Malmölaget Manashda Manena Mano Manu Manywar
   Margitta Marianne Marosamitawa Mars Marvelous Marynarz Masdjävlar 
   Masters Matilde Matrix Mats Matujona Maven Mavs Mayamira Maxi 
   Mercury Mesna Meta Mia Midas Mihai Mikke Miguel Milady Minut 
   Mirage Miro Mismatch Mixarna Mjøskameratne Mochu Monaconf
   Moritz Mostingan Movember Mölnlycke Munawar Mýna Myoni Møremix Måsen

   Nabil Nadide Narbisk Narre Natalia Nathans Natural Naturalists Neduk 
   Nemesis Nessuno Neverclaim Nico Nightingale Nikita Nikitopoulos Niko 
   Nikos Nikotiimi Nis Nislije NMRT Noctis Noralia Noriko Norsu 
   NTiosagutta Nula

   Obezit Octopussy Ognisty Okay Oksijen Olavsfestdagene Olena 
   Olrudbanden Olsenbanden Omega Omelas Onirepsou Onnela Onu Onyx 
   Opal Opera Oprosti Orakulas Orthodoxi Orthodox Osam OSMO Osss
   Oto Otters Outsiders Overivrig Oyzum Ozbiljni

   Pacers Paco Pagonia Palukas Panteros Paoli Paradigma Partizan
   Pasanci Passé Patron Paulette Paulina Paulistas Pegasus 
   Perestrojka Perjuangan Peter Petra Pia Piast Piryoli Piter 
   Pjäxa Pleschi Pleyada Plia Pojat Polirish Pompapompa Pontiac 
   Potlimit Potteplante Powerchicks Prapar Prasetya Preempters 
   Pretendents Prijatelj Prosan Proteus Proto Ptacol Pude Pusten 
   Pyon Pyton Påskevennene

   Quantum Quasar Quattro Quinze

   Radhey Rafael Raifles Rakinnett Ramkumar Rampage Raskasammen 
   Real Recaptan Regeldur Reklamtrion Reloaded Rene Rob Ribitas 
   Rima Robertinho Robi Robocop Rosajora Rovers Royston Rozle Rylai 
   Rylal

   Sabari Sabina Sabres Saga Sailor Sakurai Saladmasters Salokin Salost
   Salvo Sansouci SANY Sapphire Sara Sarp Saturn Sbambi Scapros 
   Schmuckles Schneewittchen Scientists Scot Secure Selin Senaattorit 
   Senator Severin Sevil Shane Shavaz Sherdils Shona Show Shrikant 
   Shushi Siddheshwar Sigdonnemann Sigma Sigrid Silbersee Silverfox 
   Simonetta Simple Simpleksas Sindbad Sindhu Sirius SISU Sivves 
   Siyabend Sjøsamen Skalman Skaronga Skip Skitur Skotii Þlem 
   Slappfisker Slostria Slufsa Småveitjan SNAP Snapper Snipers 
   Sober Sobers Sogn Soho Solo Sonata Sonchel Soumitra Spamirs
   Spandan Spark Spartans Specialist Spekkhogger Spektr Spring 
   Squeeze Srimapuna Srykeir Stafani Stagge Stampede Star Starmen 
   Starsbridge Statusquo Stayman Steinars Steinlager Steliana 
   Stifinnern Storeslemmen Strata Strategen Streamline Studentene 
   Stålfarfar Sucharek Sue Sunshine Suz Svetla Swanand SweDanes 
   SweNor Swest Syly Syttisju Sømnakameratene Sør Såpeopera

   Tadeu Take Takeoff Takk Takým Taksim Tally Tamae Tangra Tannlegene 
   Task Taurus Tbone Tefo Tempo Tibetmunkene Tigers Tiglatpalasar
   Tihkur Titanik Titans Tiz Toar Todremor Tofi Tohundre Tolerant 
   Tollemache Toma Tongxin Topozero Torpedo Tosca Totani Totoro Tömör 
   Traker Triks Troll Trøndermøringen Tsunami Tulip Tulipano Turuncu 
   Tushar Tutu Tvist

   Udarnik UFO Ugh Úlfurinn Ulvene Underdogs Unexpected Ungdomslaget
   Upplyfting Utkantnorge UTU

   Vahakabinetti Vakrandi Valen Valentino Valyo Vanko Varan Varoslu 
   Vasallid Västanfläkten Veegees Vega* Veggen Verder Verons Vibrant 
   Vicho Vicky Victor Victory Vietcong Villmarksgutta
   Vilttiketju Vilttiukko Viña Vintage Virginia Vivi Volta Vucko 
   Vulcano Vurgun Vürst Vytas

   Wael Wafa Wala Waldi Walpurga WBack WDP Wengens Winatalya 
   Windrunners Winkiboy Winterfell Wizards

   Xatzopoulos Xman Xtrouble

   Ybs Yaðmur Yamata Yansimasiz Yelena Ylajai Yogakshema Yokozuna

   Zabavljaci Zamek Zana Zeerob Zen Zeyno Ziggy Zimmkonis Zivac
   Zlatan Zombi Zorro Zozoura Zugzwang Zurzits Zvanger

   Øssur
);

my %SINGLE_TYPOS =
(
  Acolvik => ['acolvick'],
  'Adams Family' => ['adamsfamily'],
  Aditya => ['aaditya'],
  Agressor => ['aggressor'],
  Alizee => ['alize'],
  'Alunand Plus' => ['alunand'],
  Ambassador => ['ambassadors', 'ambassdor'],
  Anglers => ['anglelers'],
  'Apollo Soyuz' => ['apollosoyuz', 'apollosoyouz'],
  Appellkameratene => ['apellkameratene'],
  'Atomic Bridge' => ['atomic'],
  Barracuda => ['barakuda', 'baracuda'],
  Bhinneka => ['bhineka', 'bhinneke'],
  'Bleu Lights' => ['bleulights'],
  Bilal => ['balil'],
  Boriana => ['boryana'],
  Bridgekameratene => ['bridgekam'],
  Buaigh => ['buaijh'],
  Bulldozer => ['buldozer'],
  Dilligaf => ['dilligraf'],
  Dingyuan => ['dinyuan'],
  Eikka => ['eikkaa'],
  'El Gezira' => ['elgezira'],
  'England Swings' => ['englandswings'],
  Erikas => ['ericas'],
  Fant4stic => ['fant4stc'],
  Feszek => ['Fészek'],
  Formidables => ['formidable', 'formidabble', 'formidabels',
    'formiddable', 'formiddables', 'formadibles', 'formadeble',
    'formadables', 'fromidables'],
  Gelin => ['gelýn'],
  'Green Eyes' => ['greeneyes'],
  Gunsmoke => ['gunnsmoke'],
  Hästpojkarna => ['hastpojkarna'],
  Hridhaan => ['hridhan', 'haridhaan', 'hrridhaan', 'hrridhaan',
    'hridaan'],
  Imponderables => ['impoderables'],
  'India Blues' => ['indiablues'],
  'Jamm & Co' => ['jamm'],
  'Joy Division' => ['joydivision'],
  Juls => ['julst'],
  'Last Arrival' => ['lastarrival'],
  'Late S.S. Jain' => ['lssjain'],
  Lebensohl => ['lebenshol'],
  'Loy Krathong' => ['longkatong'],
  Löparn => ['loparn'],
  Maharaja => ['maharaj', 'maharaaj'],
  'Meng Qing Xin' => ['mengqingxin'],
  Mismatch => ['missmatch'],
  Mjøskameratne => ['Mjöskameratene'],
  Måsen => ['Måsan'],
  Naturalists => ['nature', 'naturalistene'],
  'Nav Chaitanya' => ['navchaitanya'],
  'Occupy Taksim' => ['occupytaksim'],
  Onyx => ['onix'],
  'Paris Match' => ['parismatch', 'parimatch'],
  Paulistas => ['paulistanas'],
  'Pontiac 7' => ['pontiac7'],
  Preempters => ['preemptors'],
  "President's Team" => ['president', 'presidents'],
  Pretendents => ['pretendentas'],
  'Ram Charan' => ['ramcharan'],
  Quantum => ['qantum'],
  'River Friend' => ['riverfriend'],
  Scientists => ['science'],
  Shrikant => ['srikant'],
  Sigdonnemann => ['sigdonneman'],
  Skotii => ['skoti'],
  Soumitra => ['soumtra'],
  Spartans => ['spartan'],
  Squeeze => ['squeze'],
  'Stall Dieden' => ['dieden'],
  Starmen => ['starman'],
  'Stone Cutters' => ['stonecutters'],
  Strategen => ['stratagen'],
  'Syabas Gabrial UI' => ['syabas'],
  Syttisju => ['sytti7'],
  'Texan Aces' => ['texanaces'],
  Titans => ['titan'],
  'Vegetable Hotpot' => ['vegetable'],
  Vürst => ['vuerst'],
  'Wei De' => ['weide'],
  'Wild Griffins' => ['wildgriffin', 'wildgriffins'],
  'Winkiboy' => ['winkyboy'],
  'Xin Yuan' => ['xinyuan'],
  Yogakshema => ['yogakhema', 'yogakshem'],
  'YOI Returns' => ['yoi'],
  Zvanger => ['zvunger']

);


sub set_hashes_team_fun
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
