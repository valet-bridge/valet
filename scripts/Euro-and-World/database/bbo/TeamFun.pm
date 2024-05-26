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
  '6 Notrump',
  '6 Spades',
  '60 y 20',
  'A.C.L.A.',
  'A.z.f.e.n.a',
  'A Takimi',
  'ABA Nuno Paz',
  'ABB Tomas',
  'Aces & Deuces',
  'Adams Family',
  'AG laget',
  'Ai Bait',
  'Air Traffic Management',
  'Aka Maru',
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
  'Andrea L.',
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
  "Archie's",
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
  'Balkanski Minior',
  'Baltic Club',
  'Bandhav Samity',
  'Banteng Selatan',
  'Banteng Sitaro',
  'Bara brudar',
  'Barny Army',
  'Bate Tot',
  'Batterfly with HK',
  'BBE Hungary',
  'BBO Lovers',
  'Bea & Family',
  'Beer Card',
  'Bela e os Monstros',
  'Best i baren',
  'Best uten kort',
  'Beto BO',
  'Beverly Hillbillies',
  'Bez Nazwy',
  'B.I.G.',
  'Big Bang',
  'Big Boss',
  'Big Chef',
  'Big Guns',
  'Big Makie',
  'Big Mi?',
  'Bimal Sicca',
  'Black Hole',
  'Black Knife',
  'Black Label',
  'Black Pit',
  'Black Sea',
  'Black Swan',
  'Blanda drops',
  'Bleu Lights',
  'Blue Chip Swedes',
  'BMW J',
  'Bo Gulasch',
  'Boas disipler',
  'Bob Bob',
  'Boogie Knights',
  'Boye B Fan Club',
  "Boys'n' Girls",
  'Brian Is Beautiful',
  'Bridge am Grün',
  'Bridge Fan',
  'Bridge Friends',
  'Bridge Lovers',
  'Bridge Plus',
  'Bridgerama Milan',
  'British Lions',
  'Brødrene & co',
  'Brødrene Dal',
  'Bullgalian All Star',
  'Buyur Teyze',
  'Butterfly from HK',
  'Ca. et halvt tonn',
  "Cai's Bird",
  'Californian Aces',
  'Can Aren',
  'Captain Blood',
  "Captain's Four",
  'Card Warriors',
  'Casino Floor',
  'Cat Daddy',
  'Cemara Putra',
  "Chairman's Choice",
  'Czarna Papuga Plus',
  'Chicho Itsi',
  'Circle the World',
  'Cim Bom Bom',
  'Cliff Wake',
  'Coca Joja',
  "Colonel's Team",
  'Cheap Tricks',
  'City Bridge',
  'Cold Light',
  'Contact 1',
  'Cookie Potter',
  'Counter Strike',
  'Country Boys',
  'Croatian Pirates',
  "Crockford's Cup",
  'Curry Eaters',
  'Curt-Lennart',
  'Czarna Owca',
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
  'F16',
  'f.d. Fröken Michiel',
  'Fairy Tale',
  'Fallega Folked',
  'Fanta 4',
  'Fast and Furious',
  'Fem på nya äventyr',
  'FF 69',
  'Figo-Fago',
  'Filips Fanclub',
  'Finnmark Flyers',
  'Finways Sappers',
  'Fjoll uten fisk',
  'Fjords of Norway',
  'Flatt kjedelig',
  "Flint's Crew",
  'Flora and Friends',
  'Flying Dutchess',
  'Former J',
  'Four Aces',
  'Frankie Holidays',
  'Freak City',
  'Friends of Academy',
  'Friends of Lalit',
  'FT 79',
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
  'Girls and Boys',
  'Global Mix',
  'Glomma Raiders',
  'Glory Box',
  'Glory Mandarin',
  'Goan Curry',
  'Gobbi San Siro',
  'Gogo Fans',
  'Gold Cup',
  'Golden Bombers',
  'Golden Bull',
  'Golden Retriever',
  'Goldy Ice',
  'Good Ball',
  'Good Men',
  'Good Oxygen',
  'Goyancho Sayeba',
  'Green Eyes',
  'Green Lines',
  'Grefstad and co',
  'Greswe Axon',
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
  'HKHZ Connection',
  'Hong Chou',
  'Hopp i sang',
  'Horten-14',
  'Hum Paanch',
  'Hummer & Kanari',
  'Hungarian Olympic',
  'Hurlumhei',
  'Hvalen og tjukkasene', 
  'Hvor er mine babes',
  'HZ Connection',
  'I Doctors',
  'I Win',
  'Idea Bridge Torino',
  'IGB sports.com',
  'Ikke akkurat kjedelig',
  'Il Fante di Fiori',
  'Ilhas & Aredores',
  'India Blues',
  'Indian Mavericks',
  'Ingen Bagge',
  'Institute of Chemical Technology',
  'Inverted Minors',
  'Isen Mulang',
  'Isolated Menaces',
  'Itinérants du bridge',
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
  'Kong Chou',
  'Koridor 10',
  'Kozyrnye Oleni',
  'Kronisk kusma',
  'Kurt quo vadis',
  'Kvalen og nissene',
  'KM AT',
  "L'Orange",
  'La Bomba',
  'LA Light',
  'La Vista',
  'Lady Da et ses Boys',
  'Lakk & Lær',
  'Langt mer enn ivrig',
  'Las Olas',
  'Last Minute',
  'Las Overum',
  'Last Arrival',
  'Late S.S. Jain',
  'Lawrence Allstars',
  'Lawrence of Arabia',
  'L.C. is Beautiful',
  'Le Colonial',
  'Le Romain boys',
  'Leonardonun Robotu',
  'Les Girafes',
  'Les Zähringers',
  'Lew Lodzki',
  'Light Blues',
  'Light Cast',
  'Limo Puzzi',
  'Lindenthal und Freunde',
  'Lisbeth og gutta',
  'Lisbeths lakeier',
  "Lise (i)DA",
  'Little Meck',
  'Los Feos',
  'Los Malos',
  'Los Salgado',
  'Los Tollos',
  'Lovende ung',
  'Loy Krathong',
  'Lucky 4',
  'Lucky Losers',
  'Lucky Seven',
  'Lucky Star',
  'Lucky 13',
  'Lucy-Ellena',
  'M.O.',
  "M' Orange",
  'Ma-Cartoon',
  'Magic Eyes',
  'MAJB Lommorna',
  'Mal - Phi',
  'Malatya Basket',
  'Man Harr det man har',
  'Manchester United',
  'Manny Herrings',
  'Many Hands',
  'Marki-Macki',
  'Massachusetts Association',
  'Master Minds',
  'Max 100',
  'Max-Nat',
  'Männer mit ELAN',
  'MC Toss',
  'Meins bleibt meins',
  'Meng Qing Xin',
  'Minas Trith',
  'Missão Impossivel',
  'Mo i Raneran',
  'Monte Carlos',
  'Moo York Nix',
  'Mostly Harmless',
  'Mountain Sea',
  'Ms. Guggenheim',
  'Multi Gen Indonesia',
  'Mumbai Indians',
  'Murphys lag',
  'My Friends',
  'My Way',
  'MY-Bridge',
  'Mystery Foursome',
  'myvatnhotel.is',
  'Møllers Team',
  "'n Vidar & Andersen",
  'N.O.Seniori',
  "Narcotic's What?",
  'Nat-Max',
  'Nav Chaitanya',
  'Nazar Boncugu',
  'Nazionale Cantanti',
  'NBS Lind',
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
  'NT-iosa-gutta',
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
  'One I S',
  'One + Khuching Tree',
  'One Hundred Eighty',
  'One More!',
  'Oni-Taka',
  'OPF Meets Nepal',
  'Opp og ned',
  'Orange Dynamite',
  'Oruva Eesti',
  'os.se',
  'Ottos Lotto',
  'Over stokk og stein',
  'Oze Ckis',
  'Ööklubi Strand',
  'Paak Festival',
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
  'PO & JBGood Team',
  'Poismenon Vaari',
  'POL-CH',
  'Pola-Pola',
  'Pontiac 7',
  'Powerpuff Pinglorna',
  'Plejans Plöjare',
  "Pradeep's Four",
  'Precision Marathon',
  "President's Team",
  "Priya's Four",
  'P.S.',
  'Pu De',
  'Pur Pur',
  'Quatro Bruxas',
  'Queen and Knights',
  'Queen of Hearts',
  'Ra Ma Ra Him',
  'Raag Brigeshwari',
  'Radik-Medik',
  'Radio Communication',
  'Rajjan',
  'Ram Charan',
  'Randers 2.0',
  'Randers 4.0',
  'Rapan & Jezus',
  'Red Ash',
  'Red Beach',
  'Red Pork Cutlet',
  'Red Sea Festival',
  'Red Soles',
  'Reidar reiser snart',
  'Renons Rimstedt',
  'Rimstedt Power!',
  'Rising Star',
  'River Blanco',
  'River Friend',
  'River Rojo',
  'Robin Hood',
  'Rodos Suns',
  'Roheline Lammas',
  'Rotseknots Ernst',
  'Royal Flush',
  'RPB Leader',
  'Rubb og stubb',
  'Rudderless Ship',
  'R.U.F.F.',
  'Ruter 7',
  'Ruter 9',
  'Saint Titus',
  'Saevar Karl',
  'Salten rundt',
  'Samfund Slingers',
  'San3PDX',
  'Sang ae',
  'Sanghi Tivoli',
  'Saras Friends',
  'Sarunta Toar',
  'Saruntawaya Minahas',
  'S.B.F.',
  'Schall und Rauch',
  'Scottish President',
  'Seckin C',
  'Sektion UDV',
  'Sengkol Lombok',
  'Seths vänner',
  'Seven Eleven',
  'Sham Sharma',
  'SHE-D',
  'Shegoestobadat8',
  'Shining Pig',
  'Shooting',
  'Shy Ant',
  'Si Fu Te',
  'Siderkongen og kidz',
  'Silver Eagle',
  'Simple Minds',
  'Sing-Sunn',
  'Sir Bhalchandra',
  'Sivves straffdubbl',
  'Six Diamonds',
  'Six Samurai',
  'Sjiraffen Erik',
  'Slam Dunk',
  'Slam Hunters',
  'slaveykov.bg',
  'Sliven Haiduci',
  'Smoking Guns',
  'Smooth Duck',
  'Småsamen med døler',
  'So-Va',
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
  'Stone Cutters',
  'Storm Gutta',
  'Storm Riders',
  'Strawberry Fields',
  'Stø pluss',
  'Super Pineapples',
  'Svag klöver',
  'Svanslös Skalman',
  'Svenske og ulykke',
  'Swami Samarth',
  'Sweet Is Middle',
  'Syntax Error',
  'Søta bror',
  'Såpjohansen & co',
  'Tasher Desh',
  'Team Bo a berg',
  'Team Bru',
  'Team Zang',
  'Texan Aces',
  'Texan and Turks',
  'Texan and Yanks',
  'Team Awesome',
  'Team Lanka',
  'Team Mayhem',
  'Team Yoda',
  'Team Z',
  'Tempo-Knektene',
  'Teyzenin Yeri',
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
  "The Naising's",
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
  'The Good',
  'The Palookas',
  'Thick Toast',
  'Thread & Needles',
  'Three Nations',
  'Til Valhall',
  'Tim Team',
  'Tinutuan Manado',
  'Tre Kn og en D',
  'Tre knekter og ett S',
  'TRK - V',
  'To gamle og to gode',
  'Tommys tigre',
  'Top Flight',
  'Top Ruff',
  'Topbridge of course',
  "Tor Ivar's",
  'Tre hunkar en babe',
  'Tre rette og en vrang',
  'Tre sang',
  'Troll i eske',
  'Tupac Amaru',
  'Turk Kahvesi',
  'Tut tut',
  'Tzoko-Mokko',
  'Ucurtma Avcisi',
  'Umisen Yamasen',
  'Umut Baris',
  'Unelmien Piina',
  'Unholy Alliance',
  'Usaklig Deigræv',
  'Vaddo Gliders',
  'Valar Morghulis',
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
  'Villi Jr.',
  'Visoki Napon',
  'Vitamin',
  'Volatile Company',
  'VP (b)anker IMP',
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
  'X.D.X.J',
  'XiBu VIP',
  'Xin Yuan',
  'Y.Y.Y.D.',
  'Yarralumla Yabbies',
  'Yitang QIAO',
  'YOI Returns',
  'Young Guns',
  'Young Sharks',
  'Young Warriors',
  'Young Driver',
  'Young Swedes',
  'Your name?',
  "Yttakjær`s",
  'Yura Taschit',
  'Zara Bridge',
  'Zen Ho',
  'Zia and Friends',
  'Ziemlich gut',
  'Øst-Vest',
  '50 med omnejd',
  '50 shades of cards'
);

my %MULTI_TYPOS =
(
  '3 Idiots + 1' => ['3 idiots +1', '3 idiots + i'],
  '4 Trèfles' => ['4 trefles 1', '4 trefles1', '4 trefles ii',
    '4trèfles', '4 treffles', '4trèfle'],
  '40 Årskrisa' => ['40-Årskrisa'],
  '5 Ess' => ['5-ess'],
  '6 Notrump' => ['6 no trump'],
  'ABA Nuno Paz' => ['ABA - Nuno Paz', 'ABA-Nuno Paz'],
  'AG laget' => ['ag-laget'],
  'Air Traffic Management' => ['air traffic managem'],
  'Alex is Beautiful' => ['alex is beatiful'],
  'All Stars' => ['all-stars', 'all star'],
  'Alle presidentens menn' => ['alle presidentens'],
  'Applied Math' => ['aplied math'],
  Arnab => ["arnab's"],
  Azores => ['açores team'],
  Ayan => ["ayan's"],
  'Babes Amazones' => ['babes-amazones'],
  Baneet => ["Baneet's IV"],
  Begijntje => ['begijnt je'],
  'Best uten kort' => ['best uden kort'],
  'Beto BO' => ['beto b o'],
  'Beverly Hillbillies' => ['beverly hillbillie'],
  'Big Guns' => ['big gun'],
  'Big Makie' => ['big makie och co'],
  BNMR => ['b n m r'],
  'Brian Is Beautiful' => ['brian is beatiful'],
  'Bridge am Grün' => ['bridge am gruen'],
  'Bridgerama Milan' => ['bridgerama mi'],
  'Butterfly from HK' => ['babochka s hk'],
  'Ca. et halvt tonn' => ['ca et halvt tonn'],
  'Californian Aces' => ['california aces'],
  "Captain's Four" => ['captains 4'],
  "Chairman's Choice" => ["chairman's team", "chairman's"],
  'Chicho Itsi' => ['chicho ici'],
  "Colonel's Team" => ["colonel's  team"],
  'Croatian Pirates' => ['cro pirates'],
  Crossfatek => ['cross fatek'],
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
  'Eviza Plambata' => ['eviza_plambata'],
  'Fast and Furious' => ['fast & furious'],
  'FF 69' => ['ff  69'],
  "Flint's Crew" => ["flint`s crew"],
  'Flora and Friends' => ['flora && friend'],
  'FOS' => ['f o s'],
  'Friends of Academy' => ['friends of akademy'],
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
  'Holmenkollen' => ['h-kollen'],
  'Hopp i sang' => ['hoppa i sang'],
  'Hum Paanch' => ['hum paach'],
  'Hungarian Olympic' => ['hungar olimp', 'hungarian olimp',
    'hungar olimpics', 'hungar olimpic'],
  'Hurlumhei' => ['hurlumhei..'],
  'Hvalen og tjukkasene' => ['hvalen og tjukkasne', 'hvalen & tjukkasene'],
  'Idea Bridge Torino' => ['idea br.', 'gs idea br. to', 'idea bridge'],
  'Ikke akkurat kjedelig' => ['ikke akkurat kjedel'],
  'India Blues' => ['indian blues'],
  'Indian Mavericks' => ['india mavericks', 'indian mavricks'],
  'Institute of Chemical Technology' => ['inst.of.chem.techn.',
    'inst.of.chem.tech.', 'inst.of chem.tech.', 'inst.of chem.techn.'],
  'Itinérants du bridge' => ['iti du bridge', 'itin du bridge'],
  'Jamm & Co' => ['jamm & co.', 'jamm && co.'],
  'Jan Wellem' => ['jan wel'],
  K1 => ['k01', 'k-1'],
  'Kasimirs Dream Team' => ['kasimirs dreamteam'],
  "Keni's Dream" => ["keni's"],
  'Kent Romeos venner' => ['kent romeos veenner'],
  'Kick Back' => ['kick-back'],
  'KM 23' => ['km23'],
  "L'Orange" => ["l' orange"],
  'Late S.S. Jain' => ['late ss jain', 'lss jain', 'l s s jain',
     'late sssk jain'],
  'Lawrence Allstars' => ['ml allstars'],
  'Lawrence of Arabia' => ['lawrence of arab'],
  'La Vista' => ['la vista team'],
  'Lakk & Lær' => ['lakk og lær', 'lek & lær', 'lokk & lur',
    'litt lakk og lær', 'lakk lær'],
  'L.C. is Beautiful' => ['l.c.is beautiful'],
  'Le Romain boys' => ["leroumain's boys", 'le romain',
    'le roumains'],
  'Lew Lodzki' => ['new lodzki'],
  'Lindenthal und Freunde' => ['lindenthal und fre'],
  'Lucky 13' => ['lucky13'],
  'Magic Eyes' => ['majic eyes', 'm e'],
  'Man Harr det man har' => ['man harr det man ha'],
  'Manchester United' => ['man u', 'man utd'],
  'Massachusetts Association' => ['massachussets assoc'],
  'Missão Impossivel' => ['missão impossível'],
  'Mo i Raneran' => ['mo i raneran :)'],
  'Ms. Guggenheim' => ['ms. gugenheim'],
  'Multi Gen Indonesia' => ['multi gen ina'],
  'Murphys lag' => ['murpyhs lag'],
  'Mystery Foursome' => ['mystery 4some'],
  'Møllers Team' => ['møllers t'],
  NAD => ['n a d'],
  'Nice and Monsters' => ['nice monsters'],
  'Nilslands Slowfoxes' => ['nilslands slowfoxers', 'nilsland slowfoxes',
    'nilsland slowfoxers'],
  "No He Isn't" => ['no he isnt'],
  'Oh Ya!' => ['oh ya'],
  Polýsgücü => ['polýs gücü s', 'polýs gücü', 'polis gucu', 'polisgucu'],
  "Pradeep's Four" => ["pradeep's 4", "Pradeep's Team"],
  "President's Team" => ["president's", 'presidents teams'],
  "Priya's Four" => ["priya's iv", "priya's4"],
  'P.S.' => ['p. s.'],
  'Queen and Knights' => ["queen's & knight"],
  'Rajjan' => ["rajjan's"],
  'Rapan & Jezus' => ['rapan and ezis'],
  'Saevar Karl' => ['svaer karl'],
  'Saint Titus' => ['st titus', 'st. titus'],
  'Sakurai' => ['japan sakurai'],
  'S.B.F.' => ['s.b.f'],
  'Sektion UDV' => ['section udv'],
  'Silver Eagle' => ['silver  eagle'],
  'Sivves straffdubbl' => ['sivves straffdubbl.', 'sivves straffdbl',
     'sivves...'],
  'Six Diamonds' => ['six diamond'],
  'Six Samurai' => ['six samurais'],
  'Slam Hunters' => ['slam hunter'],
  'slaveykov.bg' => ['slaveikov.bg'],
  SMBC => ['s m b c'],
  'Spring Foursomes' => ['spring 4s', 'spring fours', "spring 4's"],
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
  'Valar Morghulis' => ['valar morgulis'],
  'Victorious Secret' => ['victorius secret'],
  'What the Heck' => ['whattheheck'],
  'Yitang QIAO' => ['qiao yi tang']
);

my @SINGLE_WORDS = qw(
   1den1e 2Q2K 3D 6L 10CC 7heart

   AABC ABBK ABBKI ABC Aces Acolvik ACR Adventure Aditya Aeras 
   Agamemnon 
   Agressor Ahmetizm 
   Ahornet Aida Akenobo Akinom Alertplus Alex Alf Alfredo Ali Alioth 
   Allam Alliance Alliansen Allstars Alpha Alternativlos Ambassador 
   Amrapali Amul Andromeda Anglian Andrzejki Anglers Anglophones 
   Aniket Anna Anni Anol Anuj Apaçý Apek Appellkameratene Apples Apply
   Aquarius Arachfobia 
   Arangan Archies Aristos Armani Arnab Arno Arunas ASDBB Aslanli Aspe 
   Asparagus Astra Astro Astronotlar Asya Atlantic Atom Atrium 
   AUE Augerne Auni 
   Aurora AUTBUL AUTHOL Autostrada Avagard Avalanche Avatar Ayan
   Aytalus Azores Azure

   BAB BABK Bacch Bachelor Bade Badger Badminton Bager BAHABAWI
   Baias Bajm Bajozero BAK Balti Baltic
   Banana Bananasplit Baneet BarDeZi BARC BARP Barracuda Barsss
   Baryton BAST 
   Bat Batmix Bato Batusida Bauhinia 
   BBE BBN BBO BCBR Beauty Begigütje Begijntje BEIH BELSPA Ben Beniaminek 
   BeRe Berik Beton 
   BHDM Bhide Bhinneka Biachite Bilal BIN Bingbang Binkie Biriceri 
   BKSE
   Blackwood Blandat Bling Blondie Blues Blund Blueberry Blues
   BMAL BMP BNMR BNS BNT
   BOC Boek 
   Bolero 
   Boogies Boomz Boriana 
   Borko BOVE Breno Bricklayer Bridgebutikken Bridgekameratene 
   Bridgeministeriet Brigada Brigida BRK Brother Brudarna Buaigh 
   Bubba Bubu 
   Buddies Bulldozer Bumerangas Bunnies Busiaki Butler

   Cabal Cabriole Calaca Cammello Camrose Canadonia Cancan Canukusa 
   Cardtossers Cargo Carlitos Carsi Cartoon Casuals Cask Cathy Catz
   Cavelieri Cavendish CBLTI Cem Cendrawasih Censored Center Cerkez 
   Challengers Changes Chass Chateau Chicks Chime Chiranjeev 
   Chokladmåndag CHPIK Chuanpit Cité Claim Claudili CMN Coaches 
   Cogito Colorado Commandos Comrade Concurrent Conie Contact 
   Contra Coopers Coor Corner Costantina Counterstrike Couples 
   Crash Cremaster Croanglopol Crockfords Crossfatek CS CSTO 
   Czteropak

   Dada Dadya Dahsyat Dallas DanEng DanFar Danger Daniel Dash Dauna Dawn 
   Debonecos Debutantes Deceptive DeeJee Defne Demony Demýrbaþ
   DenmarS Deppo 
   Desperados Destroyers Dialect Diana Didi Dido Diego Dieter Dilligaf 
   Dimmat Dingyuan Dino Dinos Dion DJB Doctors Doki Donjulio Donvito 
   Dora Dracula Dragon 
   DSM DuckNDales Dukens Duros Dusteforbundet Dvizhenie Dyret

   Eagles Ece Econ Edi Efsane Egesarpdoruk Eikka Ekenboda Ekoap 
   Elektrownia Elio Eliminator Elips Eliza Ellen EMA Emerald Emre Engelen 
   Engineers Enigma Enjoy Ephesus Epsilon Equator Era Eren Eric 
   Erikas Erla Ertým ErUS ESA Eses Esesss Esperanza Everest Evil Ewa

   Fakel FAM² FAMA Fantasia Fant4stic Farmen Farmers Felix 
   Fenghuang Fenia Fenix Ferfi Feszek Fharon Fifi Fil Filosofene 
   Filur Finest Fisk Flagship FNCC Forfot Formidables Formosa 
   Fortuna Fortune FOS Foundation Francest 
   Frank Franz Frenemies Frieolt Friends Frirond Francophones Freak 
   Frivolt Frusci Fundacja FWK

   Gabrisem Galaxy Galim Gambitas Gamma Garry Garp Garuda Gata Gelim 
   Gelin Gentle George Geriatrix Gewanna Geysir Gesi Gezi Giants Gibs 
   Gjesp Gkobra GloryGlory GMM Goldcat Goroco Gosho Göktürk GP 
   Grand Grads Greecoura Greta Gris GRNC Grup Guayacos Gudok Guests 
   Gulce Gulebjorn 
   Gullberg 
   Gullvi Gunsmoke Guptas Gürsel

   Hade Hai Hakl Hanan Hande Hangarounds Hansa Harlequins Harvin 
   Havin Hawks 
   HayirlisI Hayet Hästpojkarna Hebat Heino Heis Hel Helgeness Hellé 
   Heliopolis HengSha 
   HERZdame HeSa Hey Hiiimmm Hilda Hist Hjerterdamer HKES Hobbits Holders 
   Holifera Hollywood Holmenkollen
   Holport Honeymoon Hopfenkönig Hornet House Hridhaan Hubsi Huhu 
   Hunaja Huispaus Hunhun Hurra Hybrid

   IBBSK IBE Ida Iff Ijseide Ikarus Ilya IMAN Imanuel IMLUK Imponderables 
   InFran Instructor Iris Irukangi Ismo Israbel Isrmany ITB
   Itnoraunz ITS IVAR

   Jagg Jaiganesh Janko Jans JanTC JAPCAN JAS JASS Jassica Javel Jaya
   Jelena Jernbaneverket Jessi Jessica Jecization JHIC Jinjing 
   Jirin Jiujiu JJJ Jóannes Job Jocker
   JoJo Joker Jonathan Joter Journalists Juanval Jugermaister Juice 
   Juls 
   Juniorklubben Jupiter Juste Justplay Justyna Justynka Jutek 
   Juubilar JuuTools

   Kaardivägi Kagama Kalbar Kalca Kalkarna Kaltim Kamelåså Kamikaze 
   Kamlakars Kamyk Kangaroo Kanin Karaarslan Karin Kark Karo Kartel 
   Kasiyahan Kasty Kasuang Kat Katipunan KBA KBC Kebiya Keni Kenji Kenlong 
   Kerasus Kibe Kinga Kingkong Kings KISS Kitty Kjelskos KKKQ
   Klasik Klio
   KMC Knösel Kodin Koiraperhe Kokoelma Kolbasti Komleposs
   Kompisarna Konga Kordam Korsikalý Kortai Koru Koukouselis KPPM
   KrASK 
   Kratos 
   Krem Kris Kriston Krisztina Ksenia KSOS Kuglana Kuhmilch Kultur
   Kvazar Kwiecisty

   Lahjattomat LAKT Laleler Langy Laplanders Laplas Larry Lasse Lataka 
   Lateria LatSwe Lazy LBC LBSK LCF Lebensohl Lebron Legeanka Lema 
   Lemanus Lenz Leszek Leta Letve Leveni Lianas Liggeunderlaget Lili 
   Lillebaluba Lion Lions Lipa Lira Livius Lirarna Liverbird Ljónin 
   LNWers Lo Loaknath Logos Lolly Loloc Longzhu Loreng LOS Lowel 
   Löparn LPMS Lucky LVBridgeBums LXA Lyubcho Løwene

   Macak Mach Madhav Mads Maestroi Magi Magic Magister Magnus Maharaja 
   MAHÝR ÞENOL Maija Maj
   Major MajorB Majorn Majority Makara Makriköy Mali Malinka Malmölaget 
   Manashda Manena Manno Mano 
   Manu Manywar Margitta Marianne Mark Marosamitawa Mars Marvelous 
   Marynarz Masdjävlar Mask Masters Matilde Matrix Mats Matujona Maven 
   Mavi Mavs Mayamira Maxi 
   Mer Mercury Mesna Meta MGM MGTH Mia Michal Midas Mihai Mikke Miguel 
   Milady Milo Minut 
   Mirage Miro Mismatch Mixarna Mjøskameratne MMMM MMRMC
   Mochu Moki Monaconf Mongos
   Moritz Mostingan Movember Mölnlycke MPEC MRSMC Multivariant
   Munawar Mustang Muumio 
   Mýna Myoni 
   Møremix Måsen

   Nabil NAD Nadide Narbisk Narre Natalia Nathans Natural Naturalists 
   NBB Necos Neduk 
   Nemesis Nessuno Neverclaim Nico Nightingale Nik Nikita Nikitopoulos 
   Niko Nikos Nikotiimi Nina Nis Nislije NMRT Noctis NoNed
   Noralia Noriko 
   Norsu NOS NTiosagutta Nula

   Obezit Octopussy OEI Ognisty Okay Oksijen Olavsfestdagene Olena 
   Olimp Olrudbanden Olsenbanden OMC Omega Omelas Onirepsou Onnela 
   Onu Onyx Opal Opera Opps Oprosti Optimus Orakulas Orthodoxi 
   Orthodox OSA Osam OSMO Osss Oto Otta Outsiders Overivrig 
   Oyku Oyzum Ozbiljni

   Öncü

   Pacers Paco Pagonia Pal Palukas Panteros Paoli Paradigma Partizan
   Pasam Pasanci Passé Patriot Patron Paulette Paulina Paulistas 
   PBL PCBA PDC Pegasus Pennant Perestrojka Perjuangan Pero Peter 
   Petra Pia Piast Piryoli Piter Pjäxa PKB PKBS PK3 PKM Pleschi Pleyada 
   Plia PMS Pojat Polirish Polus Polýsgücü
   Pompapompa 
   Pontiac Poss Potlimit Potteplante Powerchicks Prapar Prasetya 
   Preempters Pretendents Prijatelj Prim Prosan Proteus Proto Ptacol 
   PTT
   Pude Pusten Pyon Pyton PZIM Påskevennene

   QLJB Quantum Quasar Quattro Quintet Quinze

   Radhey Radikk Rafael RAG Raifles Rakinnett RAM Ramkumar Rampage 
   Rapid RASH Raskasammen RBP Real Recaptan Regeldur Reklamtrion 
   Reloaded Rem Rene Rica Rob Ribitas Rike Rima RKK Robertinho Robi 
   Robocop Rollers Rosajora Rovers Royston Rozle RS Rüya Rylai Rylal 
   Ryo

   Sabari Sabina Sabres Saga SAGG Sailor Sakurai Saladmasters Salokin 
   Salost Salvo Sansouci SANY Sapphire Sara Sargam Sarp SaTu Saturn 
   Saty Sbamby Sbanda Scapros Schmuckles Schneewittchen Scientists 
   Scot SDK Secure Selin Senaattorit Senator Severin Sevil SFG SGG 
   Shan Shane Shankars
   Shaoshen Shavaz Sherdils SHHG Shona Show Shrikant Shuai
   Shushi Sid Siddheshwar Sigdonnemann Sigma Sigrid Sihai Silbersee 
   Silence Silverfox 
   Simonetta Simple Simpleksas Sindbad Sindhu Singapole Sirius SISU Sivves 
   Siyabend Sjøsamen Skalman Skaronga SKB SKBS Skip Skitur Skotii SKR Þlem 
   Slappfisker Slostria Slufsa SMBC SMJ SMK Småveitjan SNAP Snapper 
   Snipers 
   SNP
   Soba Sober Sobers Sogn Soho Solo Sonata Sonchel Soumitra Spamirs
   Spandan Spark Spartak Spartans Specialist Spekkhogger Spektr Spin 
   Spring 
   Squeeze Srimapuna Srykeir SSBC SSSR Stafani Stagge Stampede Star 
   Starmen 
   Starsbridge Statusquo Stayman STB Stefany Steinars Steinlager 
   Steliana Steve Stifinnern Storeslemmen Strata Strategen Streamline 
   Studentene StZ Stålfarfar St?vel Sucharek Sue SuHuQiaoYou
   Sunset Sunshine Suz Svetla Swanand SweDanes 
   SweNor Swest Syabas SYL Syly SYT Syttisju SZPAK SZPAR Sømnakameratene 
   Sør Såpeopera

   TAC Tadeu Take Takeoff Takk Takým Taksim Tally Tamae Tangra Tannlegene 
   Task Taurus Tbone Tefo Tempo Theme Tibetmunkene Tigers Tiglatpalasar
   Tihkur Tita Titanik Titans Tiz Toar Todremor Tofi Tohundre Tolerant 
   Tollemache Toma Tongxin Topozero Torpedo Tosca Totani Totoro Tömör 
   TPI Traker Trèfles Triks Troll Trøndermøringen Tsunami Tuason
   Tulip Tulipano Turuncu Tushar Tusio Tutu Tvist

   UAB Udarnik UFO Ugh Úlfurinn Ulvene Underdogs Unexpected Ungdomslaget
   Unlu Upplyfting Utkantnorge UTU

   Vahakabinetti Vakrandi Valen Valentino Valyo Vanko Varan Varoslu 
   Vasallid Västanfläkten Veegees Vega* Veggen Verder Verons Vibrant 
   Vicho Vicky Victor Victory Vietcong Viking Villmarksgutta
   Vilttiketju Vilttiukko Viña Vintage Virginia Vivi Volta Vucko 
   Vulcano Vurgun Vürst Vytas

   Wael Wafa Wala Waldi Walpurga Wanghong WBack WBBA WBFIT WBGO WDP 
   Weiqun Wengens Winatalya Windrunners Winkiboy Winterfell Wizards
   WLKP Wolf WSWT

   Xatzopoulos XC XFIP Xinhai Xman XMing Xtrouble XXX XXXL XXXSL 
   XXXXXYXY

   Ybs YBM Yaðmur Yamata Yansimasiz YeJun Yelena Yichuang Ylajai 
   Yogakshema Yokozuna YSD YYD YYY

   Zabavljaci Zamek Zana Zara Zen Zeyno Zhihaole Ziggy 
   Zimmkonis Zivac ZKS Zlatan Zmaj Zombi Zorro Zozoura Zugzwang Zurzits 
   Zvanger

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
  Begijntje => ['begijnt'],
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
  Göktürk => ['gokturk'],
  'Green Eyes' => ['greeneyes'],
  Gunsmoke => ['gunnsmoke'],
  Hästpojkarna => ['hastpojkarna'],
  Hridhaan => ['hridhan', 'haridhaan', 'hrridhaan', 'hrridhaan',
    'hridaan'],
  'HZ Connection' => ['hzconnection'],
  Imanuel => ['imanual'],
  Imponderables => ['impoderables'],
  'India Blues' => ['indiablues'],
  'Jamm & Co' => ['jamm'],
  Jonathan => ['joanthan'],
  'Joy Division' => ['joydivision'],
  Juls => ['julst'],
  Kibe => ['kýbe'],
  Jupiter => ['jupitor'],
  'Last Arrival' => ['lastarrival'],
  'Late S.S. Jain' => ['lssjain'],
  'Le Romain boys' => ['leromain'],
  Lebensohl => ['lebenshol'],
  Leveni => ['levini'],
  'Loy Krathong' => ['longkatong'],
  Löparn => ['loparn'],
  Maharaja => ['maharaj', 'maharaaj'],
  'Meng Qing Xin' => ['mengqingxin'],
  Mismatch => ['missmatch'],
  Mjøskameratne => ['Mjöskameratene'],
  Måsen => ['Måsan'],
  Natalia => ['nataliya'],
  Naturalists => ['nature', 'naturalistene'],
  'Nav Chaitanya' => ['navchaitanya'],
  'Occupy Taksim' => ['occupytaksim'],
  Onyx => ['onix'],
  Opps => ['opsy'],
  Pagonia => ['pagonya'],
  'Paris Match' => ['parismatch', 'parimatch'],
  Paulistas => ['paulistanas'],
  'Pontiac 7' => ['pontiac7'],
  Prasetya => ['prasetia'],
  Preempters => ['preemptors'],
  "President's Team" => ['president', 'presidents'],
  Pretendents => ['pretendentas'],
  'Ram Charan' => ['ramcharan'],
  Quantum => ['qantum'],
  'River Friend' => ['riverfriend'],
  'Sarunta Toar' => ['sarunta'],
  Scientists => ['science'],
  'Sham Sharma' => ['shamsharma'],
  Shrikant => ['srikant'],
  Sigdonnemann => ['sigdonneman'],
  Skotii => ['skoti'],
  Soumitra => ['soumtra'],
  Spamirs => ['spamýrs'],
  Spartans => ['spartan'],
  Squeeze => ['squeze'],
  'Stall Dieden' => ['dieden'],
  Starmen => ['starman'],
  'Stone Cutters' => ['stonecutters'],
  Strategen => ['stratagen'],
  Syabas => ['syabhas', 'syahbas'],
  Syttisju => ['sytti7', 'sytti'],
  'Texan Aces' => ['texanaces', 'tnaces'],
  Titans => ['titan'],
  Valyo => ['valýo'],
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
