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
  'Aso Pika',
  'Atomic Bridge',
  'Avesta',
  'Awesome Avengers',
  'Aylan Kurdý',
  'Babes Amazones',
  'Bad Beat',
  'Bad Man',
  'Baltic Club',
  'Bara brudar',
  'Barny Army',
  'BBO Lovers',
  'Bea & Family',
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
  'Blue Chip Swedes',
  'Bo Gulasch',
  'Boas disipler',
  'Boogie Knights',
  'Boye B Fan Club',
  "Boys'n' Girls'",
  'Brian Is Beautiful',
  'British Lions',
  'Brødrene & co',
  'Brødrene Dal',
  'Ca. et halvt tonn',
  'Californian Aces',
  'Captain Blood',
  'Card Warriors',
  'Casino Floor',
  'Cat Daddy',
  "Chairman's Choice",
  'Circle the World',
  "Colonel's Team",
  'Cheap Tricks',
  'City Bridge',
  'Cold Light',
  'Contact 1',
  'Counter Strike',
  'Country Boys',
  'Croatian Pirates',
  'Curry Eaters',
  'D-MaTK',
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
  'Equator 1771',
  'Erdal Abi',
  'Erdal Tekin',
  'Esso-sveitin',
  'E.T & the Dummies',
  'Et par sama og 2 ens',
  'Etna Bridge',
  'EU oder so',
  'European Aces',
  'Eye of the Tiger',
  'f.d. Fröken Michiel',
  'Fairy Tale',
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
  'Freak City',
  'Friends of Lalit',
  'Fuglen har fløyet',
  'Full House',
  'Full Moon',
  'Full Spectrum',
  'Game Over',
  'Gang of Wyk',
  "Gary's Boys",
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
  "Hagen's Heroes",
  'Hands and Hearts',
  'Hannover Four',
  'Hansen Hurricanes',
  'Happy Bridge',
  'Happy Couples',
  'Hare Krishna',
  'Heldige Olav',
  "Hell's Angels",
  'Hillbilly Help Suit',
  'Hopp i sang',
  'Hurlumhei',
  'Hvalen og tjukkasene', 
  'Hvor er mine babes',
  'I Doctors',
  'Ikke akkurat kjedelig',
  'Il Fante di Fiori',
  'Ilhas & Aredores',
  'India Blues',
  'Indian Mavericks',
  'Inverted Minors',
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
  'Lady Da et ses Boys',
  'Langt mer enn ivrig',
  'Last Minute',
  'Lawrence Allstars',
  'Lawrence of Arabia',
  'La Vista',
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
  'Lovende ung',
  'Lucky 4',
  'Lucky Losers',
  'Lucky Seven',
  'Lucky Star',
  'Lucky 13',
  'Ma-Cartoon',
  'Magic Eyes',
  'Malatya Basket',
  'Man Harr det man har',
  'Manchester United',
  'Many Hands',
  'Master Minds',
  'Max 100',
  'Max-Nat',
  'Männer mit ELAN',
  'Meins bleibt meins',
  'Minas Trith',
  'Missão Impossivel',
  'Mo i Raneran',
  'Moo York Nix',
  'Mostly Harmless',
  'Ms. Guggenheim',
  'Murphys lag',
  'My Friends',
  'My Way',
  'Mystery Foursome',
  'Møllers Team',
  "Narcotic's What?",
  'Nice and Monsters',
  'Nilslands Crew',
  'Nilslands Slowfoxes',
  'Nilslands sväklinge',
  'No Fear',
  "No He Isn't",
  'No Limit',
  'No Problem',
  'Non Problem',
  'Norrlands guld',
  'North Pole',
  'North Star',
  'Not the Empire',
  'Novi Tim',
  'Næsten Junior',
  'Oceans4',
  'Oddskongen med rese',
  'Ohne Respekt Crew',
  'Ojasta Ahoon',
  'Olavs utvalgte',
  'Om het hoekie',
  'One Hundred Eighty',
  'One More!',
  'Opp og ned',
  'Orange Dynamite',
  'Ottos Lotto',
  'Over stokk og stein',
  'Ööklubi Strand',
  'Øst-Vest',
  'Papa & Rabbits',
  'Papa and Rabids',
  'Papas & Puppies',
  'Pearl of the Orient',
  'Piger og drenger',
  'Pink Panter',
  'Pinot Noir',
  'Plan B',
  'Pontiac 7',
  'Powerpuff Pinglorna',
  'Plejans Plöjare',
  "Pradeep's Four",
  'Precision Marathon',
  'Quatro Bruxas',
  'Queen and Knights',
  'Queen of Hearts',
  'Radio Communication',
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
  'Robin Hood',
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
  'Stabby with Youngsters',
  'Stis Multivariant',
  'Stone Cutters',
  'Storm Riders',
  'Strawberry Fields',
  'Super Pineapples',
  'Svag klöver',
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
  'The Groovia',
  'The Jets',
  'The Latin',
  'The Lions',
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
  'Tre hunkar en babe',
  'Tre rette og en vrang',
  'Tre sang',
  'Troll i eske',
  'Tupac Amaru',
  'Tut tut',
  'Ucurtma Avcisi',
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
  'Arnab' => ["arnab's"],
  'Babes Amazones' => ['babes-amazones'],
  'Best uten kort' => ['best uden kort'],
  'Beverly Hillbillies' => ['beverly hillbillie'],
  'Big Guns' => ['big gun'],
  'Big Makie' => ['big makie och co'],
  'Brian Is Beautiful' => ['brian is beatiful'],
  'Ca. et halvt tonn' => ['ca et halvt tonn'],
  'Californian Aces' => ['california aces'],
  "Chairman's Choice" => ["chairman's team"],
  'Croatian Pirates' => ['cro pirates'],
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
  'Fast and Furious' => ['fast & furious'],
  "Flint's Crew" => ["flint`s crew"],
  'Flora and Friends' => ['flora && friend'],
  'Fuglen har fløyet' => ['Foglen har fløyet'],
  'Freak City' => ['freak-city'],
  "Gary's Boys" => ['garys boys', 'gary´s boys'],
  'Good Men' => ['good man'],
  "Hagen's Heroes" => ["hagen`s heroes"],
  'Hands and Hearts' => ['hands & hearts'],
  'Heldige Olav' => ['heldige olav :)'],
  "Hell's Angels" => ['hells angels'],
  'Hopp i sang' => ['hoppa i sang'],
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
  'Lawrence of Arabia' => ['lawrence of arab'],
  'La Vista' => ['la vista team'],
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
  "Pradeep's Four" => ["pradeep's 4"],
  'Queen and Knights' => ["queen's & knight"],
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
   Aces Acolvik Adventure Aditya Aggressor Ahmetizm Ahornet 
   Akenobo Akinom Alfredo Alioth Allam Alliansen Allstars Alpha 
   Amrapali Amul Aurora Alternativlos Ambassador Andrzejki 
   Anglophones Appellkameratene Arangan Armani Arnab 
   Arno Aspe Asparagus Augerne Autostrada Avagard Avalanche Aytalus

   Balti Bananasplit Barracuda Bauhinia Beniaminek Bhinneka 
   Blondie Blueberry Bridgebutikken Bridgeministeriet Brudarna 
   Bubba Buddies
   Censored Challengers Cogito Crash
   Dallas Danger Dingyuan Dragon DSM Dyret
   Eagles Ekoap Enigma Epsilon Everest
   Farmers Fenghuang Filosofene Fisk Formidables Formosa 
   Francophones Freak
   GloryGlory Giants Goldcat Guests Gunsmoke
   Harlequins Hästpojkarna Holders Hollywood Honeymoon
   Imponderables Israbel Isrmany
   Journalists Jupiter
   Kings KMC Kuhmilch
   Lazy Lebron Lira
   Masters Moritz Movember
   Naturalists Neduk Nemesis Neverclaim Nightingale
   Octopussy Olrudbanden Olsenbanden Omega Outsiders Overivrig
   Pegasus Polirish Preempters
   Quasar
   Rampage Reklamtrion Robocop
   Saga Sakurai Saladmasters Sapphire Scientists Sigma Silverfox Sindbad 
   Skalman Skip Skitur Starmen Storeslemmen Strategen Studentene SweDanes
   Titans Torpedo Tsunami
   Úlfurinn Ulvene Underdogs Ungdomslaget
   Victory
   Winkiboy
   Zeerob Zugzwang
);

my %SINGLE_TYPOS =
(
  Acolvik => ['acolvick'],
  'Adams Family' => ['adamsfamily'],
  Aditya => ['aaditya'],
  Alizee => ['alize'],
  'Alunand Plus' => ['alunand'],
  Ambassador => ['ambassadors', 'ambassdor'],
  'Apollo Soyuz' => ['apollosoyuz', 'apollosoyouz'],
  Appellkameratene => ['apellkameratene'],
  'Atomic Bridge' => ['atomic'],
  Barracuda => ['barakuda', 'baracuda'],
  Bhinneka => ['bhineka', 'bhinneke'],
  Dingyuan => ['dinyuan'],
  Formidables => ['formidable', 'formidabble', 'formidabels',
    'formiddable', 'formiddables', 'formadibles', 'formadeble',
    'formadables', 'fromidables'],
  'Green Eyes' => ['greeneyes'],
  Gunsmoke => ['gunnsmoke'],
  Hästpojkarna => ['hastpojkarna'],
  'India Blues' => ['indiablues'],
  'Jamm & Co' => ['jamm'],
  'Joy Division' => ['joydivision'],
  'Naturalists' => ['nature'],
  'Pontiac 7' => ['pontiac7'],
  Preempters => ['preemptors'],
  Scientists => ['science'],
  Starmen => ['starman'],
  Strategen => ['stratagen'],
  'Texan Aces' => ['texanaces'],
  Titans => ['titan'],
  'Vegetable Hotpot' => ['vegetable'],
  'Wei De' => ['weide'],
  'Wild Griffins' => ['wildgriffin', 'wildgriffins'],
  'YOI Returns' => ['yoi']

);


sub set_hashes_team_fun
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
