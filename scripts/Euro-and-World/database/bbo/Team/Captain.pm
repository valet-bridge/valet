#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Captain;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_captain set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'Acacio Figueiredo',
  'Adam Edgtton',
  'Ajay Bagaria',
  'Ajay Vaish',
  'Ajit Mahadar',
  'Akin Ucar',
  'Alain Lévy',
  'Aline Biondillo',
  'Alok Daga',
  'Alvares Ribeiro',
  'Amedian Bross',
  'Amiya Ranjan Das',
  'Ana Tadeu',
  'Anders Johansson',
  'Andrea Landry',
  'Aniket Sanghvi',
  'Anita Sinclair',
  'Anoop Dhawan',
  'Antonio Falcao',
  'Antonio Frances',
  'Antonio Maria Campos',
  'Anup Dhawan',
  'Aron N. Þorfinnsson',
  'Artur S. Silva',
  'Arun Bapat',
  'Arun Jain',
  'Arunas Jankauskas',
  'Ashish Malhotra',
  'Ashwin Mehta',
  'A.K. Bose',
  'Ilan Bareket',
  'Baneet Malhotra',
  'Benedicte Cronier',
  'Bimal Sicka',
  'Birkir Jonsson',
  'Brigitta Fischer',
  'Buddy Shah',
  'C.V. Rao',
  'Carlos Ferreira',
  'Carlos Gonçalves',
  'Carlos Luis',
  'Carlos Santos',
  'Carlos Teixeira',
  'Chalermpol Wongwaiwit',
  'Choo Wai Wong',
  'Christal Henner-Welland',
  'Corte-Real',
  'C.V. Rao',
  'D Banerjee',
  "D'Avossa",
  'Da Silva',
  'David Birman',
  'De Blasi',
  'de Botton',
  'de Bruyne',
  'de Falco',
  'de Knijff',
  'de Krull',
  'de la Barrera',
  'de Livera',
  'de Lombard',
  'de Mendez',
  'de Michelis',
  'de Miguel',
  'de Monval',
  'De Muller',
  'de Tessieres',
  'Deepak Poddar',
  'Deniz Ruzgar Akyurek',
  'der Kinderen',
  'Derek Zen',
  'Defranchi',
  'Della Monta',
  "Del'Monte",
  'Dennis Bilde',
  'Dexter Morgan',
  'di Franco',
  'Diana Damyanova',
  'Ding Yuan',
  'Djordje Dunjic',
  'Dmitri Marchessini',
  "D'Orsi",
  "D'Ovidio",
  'Dr. Anand',
  'Dr. Ashwani Mehta',
  'Duronto Rajshahi',
  'Edmund Tse',
  'Efrat Oren',
  'Waleed El Ahmady',
  'El Baz',
  'Ellena Moskovsky',
  'Emil Thomsen',
  'Enrique Pinto',
  'Erikas Vainikonis',
  'Erla Sigurjónsdóttir',
  'Erlend Skjetne',
  'Espinosa Paz',
  'Fatih Yayla',
  'Fernando Matos',
  'Filippo Palma',
  'Flemming Dahl',
  'Francisco Costa-Cabral',
  'Frímann Stefánsson',
  'G. Limmen',
  'Gabriel Chagas',
  'Gila Emody',
  'Ginossar',
  'Grzegorz Darkiewicz-Moniuszko',
  'Guang Zhong',
  'Gudmundur S. Hermannsson',
  'Gunnar Björn Helgason',
  'Gunnlaugur Sævarsson',
  'Gunnar Sjökvist',
  'Gylfi Baldursson',
  'H.C. Nielsen',
  'Hana Shezifi',
  'Hans-Ove Sandin',
  'Hecht Johansen',
  'Hemant Jalan',
  'Hemant Malse',
  'Hermann Friðriksson',
  'Hiroki Yokoi',
  'Hong NIU',
  'Ilan Herbst',
  'Ingvar Erga',
  'Inocencio Almeida Araujo',
  'Inon Liran',
  'J. Brigido',
  'J. Pereira de Sousa',
  'J. Pinheiro',
  'J. Tomljenovic',
  'J.C. Henriques',
  'J.E. Skjanni',
  'J.P. Goenka',
  'Jaggy Shivdasani',
  'Jan Jansma',
  'Jan-Olov Andersson',
  'Janak Shah',
  'Javed Ahmed Miran',
  'Jay Ganesh',
  'Jean le Poder',
  'Jennifer de Winter',
  'Jeovani Salomao',
  'Jeroo Mango',
  'Jerzy Zaremba',
  'Jesper Buus Thomsen',
  'Jessica Hayman',
  'João Fanha',
  'Joao Paes de Carvalho',
  'Joao Silva Neto',
  'John Holland',
  'Jón Ásbjörnsson',
  'Jorge Alexandre',
  'Jorge Castanheira',
  'Jorge Cruzeiro',
  'Jorge Monteiro Dos Santos',
  'José Dias',
  'José Moraes',
  'Jozef Pochron',
  'Jörg Fritsche',
  'Jörgen Lindqvist',
  'Juan Valdez',
  'Juliano Barbosa',
  'Júlíus Sigurjónsson',
  'Kalpana Misra',
  'Kamal Kumar Nagori',
  'Kamlesh Gupta',
  'Karl Sigurhjartarson',
  'Kasper Konow',
  'Ken Ford',
  'Knud Harries',
  'Koch-Palmund',
  'Kristian Tylvad',
  'Krzysztof Strykier',
  'Kumar Vijay Anand',
  'Kurniadi Djauhari',
  'Kwok-Fai Mak',
  "L'Écuyer",
  'Lauge Pedersen',
  'Li Shu Yuan',
  'Li Xiao Lei',
  'Lin Rong Qiang',
  'Lotan Fisher',
  'Luis Brito',
  'Luis Oliveira',
  'Majka Cilleborg Bilde',
  'Marc ter Laare',
  'Marc Kerlero de Rosbo',
  'Manoel Peirao',
  'Manuel Capucho',
  'Manuel Neto',
  'Manuel Oliveira',
  'Manuela Mouttet',
  'Marius Bartnes',
  'Mark Gordon',
  'Maya Meera Sneha',
  'Mayda de Dios',
  'Maria João Lara',
  'Mariana Leitão',
  'Mariana Nogueira',
  'Mark Micha',
  'Maxim Henbest',
  'Migry Zur-Campanile',
  'Miguel Lima',
  'Miguel A. Ribeiro',
  'Miguel S. Guedes',
  'Miguel Silva',
  'Miguel Sousa Guedes',
  'Miguel Teixeira',
  'Mikud Mannid',
  'Modi Kenigsberg',
  'Mohamed Manaf Saleh',
  'Mohit Mehta',
  'Mohsen Kamel',
  'Moni Diba',
  'Morris Chang',
  'Morten Jepsen',
  'Møller Jepsen',
  'N. Chakraborty',
  'Nabil Chaker',
  'Nabil Edgtton',
  'Navneet Swaika',
  'Nuno Damaso',
  'Nuno Matos',
  'Nuno Paz',
  'Nuno Sousa',
  'Ofek Tal',
  'Olivier Bessis',
  'Ómar Freyr',
  'Omar Sharif',
  'Palma Carlos',
  'Pankaj Kapadia',
  'Pankaj Mehta',
  'Patrick Choy',
  'Patrick Jourdain',
  'Paul Hackett',
  'Paul Van Goor',
  'Paula Lima',
  'Paulo Dias',
  'Paulo Goncalves Pereira',
  'Paulo Roberto Brum',
  'Paulo Rocha Pinto',
  'Pearl Mehta',
  'Pedro Madeira',
  'Pedro Morbey',
  'Pedro Pratas',
  'Pedro Russo',
  'Peter de Vries',
  'Peter Schaltz',
  'Peteris Bethers',
  'Phailin Nimityongskul',
  'Piedade C. Real',
  'Pobsit Kamolvej',
  'Pony Nehmert',
  'Poul Clemmensen',
  'Prakash Bandhari',
  'Pramod Joshi',
  'Pramual Angkaew',
  'Prashant Desai',
  'Promila Saraf',
  'Quentin Robert',
  'Qing Gong',
  'R.K. Sinha',
  'R.L. Kejriwal',
  'R.S. Mishra',
  'Raghavendra Rajkumar',
  'Rahul Ravichandran',
  'Raja Brawijaya',
  'Ralitsa Mihaylova Mircheva',
  'Raul Guerreiro',
  'Reinaldo Timoteo',
  'Rita Choksi',
  'Rita Russo',
  'Rodrigo Suares',
  'Rui Pinto',
  'Rui Silva Santos',
  'Rúnar Einarsson',
  'Rusen Abi',
  'Sadek Radwan',
  'Sally Brock',
  'Salvatore Luceno',
  'Sanat Roy',
  'Sandip Chatterji',
  'Sandra Batista',
  'Sanjay Bhattacharya',
  'Satish Diwanji',
  'Satish Modi',
  'Saumitra Basu',
  'Shashi Gupta',
  'Shekhar Banerjee',
  'Shih Yeh',
  'Shlomo Netzer',
  'Shree Priya',
  'Signe Thomsen',
  'Sigurdur Vilhjalmsson',
  'Simon Gillis',
  'Símon Símonarson',
  'Sinan Abi',
  'Sinan Göksu',
  'Sofia Costa Pessoa',
  'Stefán Jóhannsson',
  'Sunil Machhar',
  'Susanne Bohnsack',
  'Sveinn Ericsson',
  'Sverrir Þórisson',
  'T. Debonnaire',
  'T.V. Joshi',
  'Teixeira-Reus',
  'Teresa Kay',
  'Tiago Canelas',
  'Tomi Gotard',
  'Tor Helness',
  'Toshiro Nose',
  'Udi Friedlander',
  'Uri Gilboa',
  'Urmil Agarwal',
  'van Prooijen',
  'Van Cleeff',
  'Van de Walle',
  'Van den Bos',
  'Van den Cleff',
  'Van der Vlugt',
  'Van Elsuwé',
  'Van Gestel',
  'Van Helsing',
  'Van Hoof',
  'Vang Larsen',
  'Van Riel',
  'Van Zwol',
  'Varsha Jain',
  'Vijay Anand Singh',
  'Villas Boas',
  'Vincent LI',
  'Visalakshi Narayanan Ramamoorthy',
  'Wang Yuan Wei',
  'Ward Platt',
  'Wei Sender',
  'Weidong He',
  'Wu Xiao Bing',
  'Wubbo de Boer',
  'Xavier Michaud Larivière',
  'Yaacov (Jacob) Mintz',
  'Yao Ke',
  'Yolluk Bostanci',
  'Yu Yi',
  'Yuval Lubinski',
  'Zack Yaniv',
  'Zelal Su',
  'Zhang De Zhong',
  'Zhang Xiao Feng',
  'Zia Mahmood',
  'ZHOU Tao'
);

my %MULTI_TYPOS =
(
  'Acacio Figueiredo' => ['acacio f'],
  'Adam Edgtton' => ['a edgtton', 'a.edgtton'],
  'Ajay Bagaria' => ['a.bagaria', "a. bagaira's iv"],
  'Alain Lévy' => ['alain levy'],
  'Alok Daga' => ["alok daga's iv"],
  'Alvares Ribeiro' => ['luis a ribeiro', 'luis a. ribeiro', 
    'álvares ribeiro'],
  'Alvensleben' => ['v.alvensleben', 'v. alvensleben'],
  'Amiya Ranjan Das' => ['a r dass'],
  'Andrea Landry'=> ['landry andrea'],
  'Antonio Falcao' => ['falcão'],
  'Antonio Maria Campos' => ['antonio m campos', 'antonio maria campo'],
  'Artur S. Silva' => ['artur s silva'],
  'Arun Jain' => ['arunjain'],
  'Ashwin Mehta' => ['dr.ashwin meheta'],
  'A.K. Bose' => ["a.k.bose's iv", "a.k.bose'iv", "a k bose's 4",
    "a k bose's IV", 'a.k.bose'],
  'Ilan Bareket' => ['bareket ilan'],
  'Baneet Malhotra' => ['b malhotra'],
  'Benedicte Cronier' => ['mme cronier'],
  'Bimal Sicka' => ['bimal sikka'],
  'Birkir Jonsson' => ['birkir j jonsson'],
  Boaz => ['dr. boaz', "dr. boaz's"],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.', 'cv rao'],
  'Carlos Gonçalves' => ['carlos goncalves', 'c goncalves',
    'carlos gonçalve', 'carlos gonçalv'],
  'Choo Wai Wong' => ['int choowai'],
  'Christal Henner-Welland' => ['welland-h', 'henner-we',
    'henner-welland'],
  Cladius => ['dr. cladius'],
  'David Birman' => ['birman david', 'birman d'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Bruyne' => ['de Bruyune'],
  'de Knijff' => ['deknijff', 'di knijff'],
  'de Tessieres' => ['de tessiere', 'de tessier', 'de tessie'],
  'D Banerjee' => ['prof d banerjee'],
  "D'Orsi" => ['d orsi', "d´orsi", "d`orsi", "d 'orsi"],
  Desai => ['desai 5'],
  'Dr. Anand' => ["dr. anand's"],
  'Efrat Oren' => ['oren efrat'],
  'El Baz' => ['baz'],
  'Ellena Moskovsky' => ['e.moskovsky'],
  'Enrique Pinto' => ['e pinto'],
  'Erikas Vainikonis' => ['vainikonis e'],
  'Erla Sigurjónsdóttir' => ['erla sigurjónsdótti'],
  'Espinosa Paz' => ['espinoza paz'],
  'Flemming Dahl' => ['dahl'],
  'Francisco Costa Cabral' => ['f. costa cabral', 'f. costa-cabral',
    'francisco c. cabral', 'francisco costa cab'],
  'G. Limmen' => ['g.limmen'],
  'Gabriel Chagas' => ['chagas.g'],
  'Gila Emody' => ['emody gila'],
  'Ginossar' => ['eldad ginossar', 'ginossar eldad'],
  'Gudmundur S. Hermannsson' => ['guðmundur sv. h'],
  'Gunnar Björn Helgason' => ['gunnar björn h', 'gunnar björn'],
  'Gunnlaugur Sævarsson' => ['gunnlaugur sævars', 'Gunnlaugur Sævarsso'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hana Shezifi' => ['shezifi hana'],
  'Hans-Ove Sandin' => ['hans-ove', 'hans-ove crew'],
  'Hecht Johansen' => ['hecht-johansen', 'hect johansen'],
  Helekar => ['dr. helekar', 'dr.helekar'],
  'Hemant Jalan' => ['h.jalan', 'hemant  jalan'],
  'Hemant Malse' => ['hemant- malse'],
  'Hermann Friðriksson' => ['Hermann Fridriksson'],
  'Hiroki Yokoi' => ['yokoi hiroki'],
  'Ilan Herbst' => ['herbst i', 'herbst ilan'],
  'Inocencio Almeida Araujo' => ['inocencio arauj', 'inocêncio araújo',
    'inocencio'],
  'Inon Liran' => ['liran inon'],
  'J. Tomljenovic' => ['jtomljenovic'],
  'J.C. Henriques' => ['j.c.henriques', 'j c henriques',
    'j. c. henriques', 'j. carlos henriques', 'jose c. henriques',
    'josé c. henriques', 'josé henriques', 'ze carlos henriques',
    'zé carlos henriques', 'jc henriques', 'josé c henriques'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni', 'je skjanni',
    'je skjanni ehf'],
  'J.P. Goenka' => ['j.p.goenka'],
  'Joao Paes de Carvalho' => ['j paes c'],
  'Jean le Poder' => ['le poder'],
  'Jennifer de Winter' => ['jen de winther', 'jan de winter'],
  'Jesper Buus Thomsen' => ['jb thomsen'],
  'João Fanha' => ['j.fanha', 'joao fanha', 'j. fanha'],
  'Joao Silva Neto' => ['silva neto'],
  'John Holland' => ['j holland'],
  'Jorge Castanheira' => ['jorel8', 'castanheira'],
  'José Moraes' => ['josé morae'],
  'Joshi Sanghi' => ['dr.joshi', "dr.sanghi'siv",
    "dr. joshi's - sangl", "dr. sanghvi's  vi", 'dr. joshi sangli'],
  'Jozef Pochron' =>['j pochron'],
  'Jörgen Lindqvist' => ['jörgen lindqvist cr'],
  'Juan Valdez' => ['juan valdes'],
  'Jr. Yilankiran' => ['j.yilankiran', 'jr.yilankiran',
    'jr. yilankiran', 'jr.  yilankiran'],
  'Kalpana Misra' => ['kalpana mishra'],
  'Kamal Kumar Nagori' => ['kamal naguri', "kamal naguri's"],
  'Kamlesh Gupta' => ['kamalesh gupta', 'k gupta iv'],
  'Karl Sigurhjartarson' => ['karl sigurhjartar', 'karl sigurhjartars',
    'karl sigurhjartarso', 'karl sigurhjartarss'],
  'Modi Kenigsberg' => ['kenigsberg modi'],
  Kishan => ["kishan's iv"],
  'Krzysztof Strykier' => ['k.strykier'],
  'Kumar Vijay Anand' => ['kr. vijay anand', 'kr. vijayanand'],
  'Kurniadi Djauhari' => ['dee jee'],
  'Kwok-Fai Mak' => ['kf mak'],
  "L'Écuyer" => ["l'ecuyer", 'lecuyer', 'l ecuyer', 'l"ecuyer',
    "l'equyer"],
  'Lauge Pedersen' => ['lauge-pedersen'],
  Lhuissier => ["l'huissier"],
  'Lotan Fisher' => ['fisher lotan'],
  'Luis Oliveira' => ['luís oliveira'],
  'Majka Cilleborg Bilde' => ['majka bilde'],
  'Manuel Capucho' => ['m capucho', 'manual capucho'],
  'Manuel Oliveira' => ['manuel oliveia', 'm.oliveira', 'm. oliveira',
    'm oliveira'],
  'Manuela Mouttet' => ['mme mouttet', 'mouttet'],
  'Marc ter Laare' => ['ter laare'],
  'Maria João Lara' => ['maria joao lara', 'm joão lara',
    'm joao lara', 'm. j. lara', 'm.j.lara', 'mj.lara',
    'maria j.lara', 'm.joão lara', 'mª joão lara', 'm. joão lara',
    'm.j. lara'],
  'Mariana Leitão' =>['mariana leitao'],
  'Marius Bartnes' => ['dr. bartnes'],
  'Maxim Henbest' => ['m.henbest'],
  'Maya Meera Sneha' => ['maya meera', 'maya mira', 'maya mira sneha'],
  McLeish => ['mc. leish'],
  'Migry Zur-Campanile' => ['zur-campanile'],
  'Miguel Sousa Guedes' => ['miguel s guedes', 'm. sousa guedes',
    'sousa guedes'],
  'Miguel Teixeira' => ['miguel teixeira', 'm. teixeira'],
  'Mikud Mannid' => ['mikud-mannid'],
  'Mohit Mehta' => ['mohit mehata', 'mohit meheta'],
  'N. Chakraborty' => ["n.c hakraborty's iv"],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  'Nuno Paz' => ['n paz'],
  "O'Rourke" => ['o rourke', 'o;rourke', "o'rouke"],
  'Ofek Tal' => ['ofel tal'],
  'Olivier Bessis' => ['bessis.o'],
  'Patanè' => ["patane'"],
  'Paul Hackett' => ['p hackett', 'pd hackett', 'hackett p'],
  'Paulo Goncalves Pereira' => ['paulo goncalves per',
    'paulo gonçalves', 'p g pereira', 'p. g. pereira', 'pg pereira',
      'p.g.pereira', 'paulo gp', 'paulo g. pereira', 'p.g.p.',
      'paulo goncalves perreira'],
  'Paulo Roberto Brum' => ['brum p', 'brum.p.', 'p brum'],
  'Paulo Rocha Pinto' => ['paulo pinto', 'rocha pinto'],
  'Pedro Madeira' => ['p. madeira', 'p madeira'],
  'Pedro Morbey' => ['p. morbey'],
  'Pedro Russo' => ['russo p'],
  'Piedade C. Real' => ['piedade c.real'],
  'Prakash Bandhari' => ['prakash bhandari'],
  'Prashant Desai' => ["prashant desai's"],
  'Promila Saraf' => ['promila sorof'],
  Prusa => ['prusa m'],
  'R.K. Sinha' => ["r k sinha'siv", "r k sinha's lv", 'r k sinha'],
  'R.L. Kejriwal' => ['r l kejriwal', 'r l kejriwaal', 'rl kejriwal mc',
    'r l kejriwal m c', 'r.l.kejriwal mc', 'r.l.kejriwal', 
    'r. l. kejriwal'],
  'Raul Guerreiro' => ['r guerreiro'],
  'Rita Choksi' => ['rita chokshi'],
  'Rodrigo Suares' => ['rodrigo soares'],
  'R.S. Mishra' => ['r.s.mishra'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Rui Silva Santos' => ['rui santos', 'silva santos',
    'rui s. santos'],
  'Salim Yilankiran' => ['yilankiran'],
  'Sally Brock' => ['s brock'],
  'Satish Diwanji' => ['col. diwanji'],
  'Shih Yeh' => ['yeh shih'],
  'Shlomo Netzer' => ['netzer shlomo'],
  'Shree Priya' => ['sree priya'],
  'Sigurdur Vilhjalmsson' => ['sigurður vilhjálmss'],
  'Sinan Göksu' => ['sinan goksu'],
  'Sofia Costa Pessoa' => ['s.pessoa'],
  'Sunil Machhar' => ['sunil machar', 'sunil macchar',
    'sunal macchar', 'sunil maccher', 'sunil.macchar', 's machhar'],
  'Sverrir Þórisson' => ['sverrir þ'],
  'T.V. Joshi' => ['t v joshi'],
  'Teixeira-Reus' => ['txecs-reus', 'txec-reus'],
  'Teresa Kay' => ['t.kay'],
  'Udi Friedlander' => ['friedlander udi'],
  'Uri Gilboa' => ['gilboa uri', 'gillboa uri'],
  Vahalia => ['dr.vahalia'],
  Vithaya => ['dr.vithaya'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen'],
  'Waleed El Ahmady' => ['el ahmady'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward-pratt'],
  'Wei Sender' => ['wei-sender'],
  'Weidong He' => ['he wei dong'],
  'Xavier Michaud Larivière' => ['michaud- lariviere',
    'michaud-lariviere', 'michaud lari'],
  'Yuval Lubinski' => ['lubinsky yuval']
);

my @SINGLE_WORDS = qw(
  Aagaard Abecassis Adad Adams Adamsen Adde Adem Adrei Adriano Adrilla
  Agarwal Agica Agnihotri Agostini Akama Akem Aker Akgul Akgun Akhun 
  Akkab Akkoyunlu Akuzum Alami Alegre Alegrio Alela Alfonsin Alineo 
  Allana Allegaert Allegra Allfrey Allison Allix Alloul Almirall 
  Alocchi Aloi Alonso Altan Alti Altinis Altshuler Alujas 
  Alvensleben Amadori Amaral Ames Amoedo Amoils Amol 
  Anderson Andersson Andrasi Andrea Andreoli Andrew Angeleri 
  Angelini Antas Antmen Antoniou Ao Apfel Appleton Apteker Aranha 
  Araszkiewicz Araujo Arcieri Arle Aroix Armstrong Arun Asakoshi 
  Ash Ashworth Ashton Askgaard Asmeniadis Assael Assemi 
  Atalay Atabey Atay Attaguile Auerbach Auken Aust Austberg 
  Avci Avcioglu Avon Awad Ayda Aydin

  Babacan Babsch Baiche Baietto Bailey Bajraj Baker Bakhshi 
  Bakkeren Baldini Baldysz Baleal Ballebo 
  Banikas Baran Barbone Barbosa Barel Barion Baris Baron Bart 
  Barton Basabe Baseggio Basile Bassini Bathurst Batov Bauch Bavaresco 
  Baybarut Bayes Baze Bäckström Beauchamp Beale Beatty Beaumier
  Beauvillain Becker Bell Bello Bellosta Belonogov Benassi Bennett 
  Berdichevsky Berg Berger Bergheimer Berkowitz Berktas Berlinski 
  Berman Bernard Bernasconi Bernstein Berrettini Bertens Bertheau 
  Bertolucci Besiris Bessis Bettini Beyer 
  Biagiotti Bilde Bilski Binderkrantz Bingol Biondillo Biondo 
  Bird Birin Bittner Bitran Bizer Bjarnarson Bjerkan Bjornlund Black
  Blackstock Blakeman Blakset Blanchard Blandin Bley Bloom Blum 
  Blumental Bo Boaz Bocchi Bock Bogach Bogacki Bohnhorst Bohnsack 
  Bokk Bojoh Boldt Bolling Bolognini Bombardieri Bomber Bompis 
  Bongiovanni Bonis Bonori Bontas Booth Bordallo Boro Bos 
  Bose Boss Bostosusz Botto Boucher Boughey Bourke 
  Bowdery Bowles Boylson Bozempergk Bozzetto Bozzo
  Brachman Brady Brake Braithwaite Bramley Branco Brantsma Branzoiu
  Braun Brede Brenner Bretagne Brifman Brightling Brink Brockwell 
  Brod Brogeland Brown Brunet Bruun Brunzell Buch Buchen 
  Buchlev Budkin Bujoh Buras Burrows Burgay Burke Buscaglia Buse 
  Busse Butland Butts Byrne Bytskevich Börgesson

  Cabiati Caggese Calandra Caldarelli Caley Caldwell Callaghan Callander
  Camacho Camberos Cambiaghi Campos Capayianides Capitani Caplan 
  Caposiena Cappelli Cappeller Caprera Capriata Caracci Caramalli
  Cardine Carbonnier Carcy Carmichael Carrasco Carruthers Carvalho 
  Casabona Casadei Casen Cassini Castelblanco Castelli Castells 
  Castner Cattani Cavalieri Cayne Cengiz Cernat Cernato Cernatovo 
  Cerreto Cesati Chadwick Chai Chambers Chan Chang Charletoux 
  Charlotte Charlsen Chassagne Chauvelot Chediak Cheek 
  Chemla Cheng Chinchak Chizzoli Chopin Chottin Chrapot 
  Chubukov Ciccarelli Cichocki Ciechomski Cilleborg Cimon Cintra 
  Cionca Ciopettini Civale Cladius Clair Claret Clark Clarke Clausen 
  Clement Clemmensen Close Coenraets Coglitore Cohen Cohler Cohner 
  Colarossi Coldea Cole Coletta Collett Collins Combes Combescure 
  Compton Connie Conti Cook Cooke Cooper Cooreman Cope Coren 
  Coridakis Corlateanu Cormack Corssen Cossutta Counil Courtney 
  Coutts Coyne Creet Crestey Creuheras Crichton Crompton Cronier 
  Crouch Crzejdziak Cuevas Cullin Cummings Cuper Curo Çýloðlu Czímer

  Dabrowka Dahlberg Dalecki Dalia Dalley Damiani Damkor Dancewicz 
  Danta Dantan Darak Daskalakis Daugava Dauvergne Davies 
  Dawson Debolina Debonnaire Debus Dechelette Degla Dehaye Deik 
  Deleeuw Delfino Delfour Delibaltadakis Dellecavakis 
  Delimpaltadakis Delpiano DeMartino Demir Demirbas Demme Denning 
  Deniz Desai Deutsch Deva Dexterzy Dialinas Dionysopoulos 
  Dhir Dhondy Dialynas Diamond Dilks Dinkin Dixon 
  Djurovic Dobbels Dobes Dobroiu Doecke Doksiadis Dolla Donatella 
  Donciu Donn Donzi Dossena Dovell Doub Doussot Doxiadis Drijver 
  Driver Dubini Duguet Duman Dumbovich Dumitrasciuc Dunitz Dunn 
  Duong Dupraz Dupuis Dupuy Durisotto Dutilloy Dworan Dyke

  Eaton Eber Ebery Economou Edgtton Efremov Efthimiou Eggeling 
  Eide Eidi Eidingsen Eisenberg Ekeblad Eksi Elbaz Elias Ellestad 
  Ellia Engel Elinescu Enrique Ergil Erhart Erichsen Eriksson Erk 
  Erkel Ekþi Espiasse Esterson Esteruelas Evans Ewart Eykt

  Fabbri Fagerlund Faidas Faigenbaum Failla Falay Falciai Falk 
  Fallenius Fallon Fantonakis Fantoni Farholt Faria Farias 
  Farwell Favard Federighi Fegarty Feiler Fent Fergani 
  Ferramosca Ferrara Ferrari Fettes Fici Figlus Figueiredo 
  Filikci Filios Filip Finikiotis Finz Fioretti Fireman Firestone 
  Fleisher Fleury Flierl Flock Flora Fonseca Ford Fordham 
  Fornaciari Fornasari Forrester Fortini Fossi Foster Fournier Fout 
  Fox Franchi Fraser Frazer Frazzetto Frencken Fredin Freed 
  Frey Friedland Friedlander Friis Frosztega 
  Fruewirth Frukacz Frutos Fu Fucik Fuglestad Fuller Fung Furunes 
  Furuta Fyrun

  Gaede Gagliardi Gaglietto Gardiner Galinsky Gallus 
  Gana Gandoglia Ganzer Garateguy Garbosi Garg Garoufalis Garrido 
  Garrone Garvey Garner Gartaganis Gary Gaspar Gaviard Gawel Gawrys 
  Gelberg Geller Genc Generosi Gentili Georgescu Gerber Gerli 
  Gero Gerrard Geyer Gezer Ghionis Giangkos Giannessi Gidman 
  Gierulski Gigliotti Gilboa Gill Ginnan Ginossar Gioia Gitelman 
  Giura Gladiator Gladysh Glanger Glasson Glopson Gobbi Goded Gold 
  Goldberg Goldenfield Goldman Goldstein Golebiowski Gomerov Gomes 
  Goodman Goraco Gordon Goren Gosney Gotard Gottlieb Goyal Göthe 
  Grabel Grabowska Gradignan Gradovsky Grainger Gramberg Granda
  Green Greenberg Greenwood Grenside Grenthe Griffey Griffin Griffoni 
  Griffiths Grimeton Grigoriu Grimaldi Grisho Groenenboom Gromov Gromova 
  Gross Grosset Gromöller Gronaldo Grue Gruia Grunt Gruschow 
  Gruszczynski Grzelak Gu Guariglia Gudkov Gue Gueglio Guermani 
  Guglietto Guillaumin Gula Guldberg Guler Gumby 
  Gupta Gurley Gursel Gustawsson Gutmark Guy Günther Gyimesi

  Hackett Hadjibalis Haffer Hagenberg Haidorfer Hallen Hallongren
  Hamman Hampson Hampton Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harari Harasimowicz Harding Harley Harper Harries Harris 
  Harrison Harsanyi Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Hegedus Heifer Helekar Helgemo Helle Helman Helmer Helmich Helms Henault
  Henclik Henneberg Henriques Herman Herrera Herscap
  Heskje Hill Hillman Hinden Hindon Hinge Hiraki Hirchwald Hirst Hitti 
  Hliapas Hobeika Hoff Hoffa Hoffman Hollands Hollman Honti Hooda 
  Hopfenheit Hornibrook Horowitz Horton Horwitz Howard Howe Hu 
  Huang Hughes Hugon Hugony Hult Hung Hupe Hurworth Høgis Høyland 

  Iacapraro Ichilcik Ilczuk Ilmez Ince Indemini Ingielewicz Iommi 
  Iontzeff Irens Ishidaya Ivatury Iversen Ivrig Iyer Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jalowka Jamieson
  Janicki Janik Jankova Janiszewski Janowski Jansma Janssen Jarlot 
  Jassem Jawell Jayganesh Jedrychowski Jeng Jensen Jepsen 
  Jezioro Joel Johansson Johnson 
  Jolly Jokisch Jones Jotcham Junqueira Jussila Juutilainen

  Kabra Kachchu Kageling Kahyaoglu Kahn Kaiser Kalida Kalita Kalish 
  Kallifronas Kallsberg Kallunki Kalma Kalmin Kamat Kambancho 
  Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kane Kanetkar 
  Kang Kapagiannidis Kaplan Kaptan Karadeniz Karamanlis 
  Karavil Karayel Karlaftis Karpouzelis Kasapoglu Kasday Kasle 
  Kasler Kastel Kater Katsareli Katsutake Katz Kaushik Kay Kaya 
  Kaye Kazik Kazmierczak Keegan Kendrick Kenigsberg Kennedy Kenny 
  Kent Keremida Kersey Kesgin Khandelwal Khazanov Khyuppenen 
  Kilani Kilvington King Kiran Kiriakidoy Kirilenko Kishan 
  Kizikli Klapper Klimacki Klimentowska Klinger Klofa Klukowski 
  Knap Knight Kocak Koch Koistinen Koivula Kokkes Koken Kokten 
  Kolankaya Kolata Kolesnik Kollnes Kolonkaya Konckier Kondoch 
  Konefal Koneru Kopecky Koppel Korbel Kordov Korkmaz Korkut Korth 
  Kosaka Kosti Kotányi Kotinas Kotronarou Koumetz Kovacs Kovachev 
  Kovacich Kowalski Kozikowski Kökten Kranyak Krajewski Krausova 
  Krawczyk Krekorian Kriegel Kriftner Kristensen Kroch Krochmalik 
  Krolikowski Kubac Kujawa Kuokkanen Kurbalija Kutenik
  Kutner Kvangraven Kwiatkowski Kwiecien Kwok Kyriakidou Kyrilenko

  Laan Labaere Lachowicz Laffineur Lagrange Lagree Lalanne Lall 
  Lambardi Lanciano Lane Langer Lantaron Lanzarotti Larsen 
  Larssen Lasserre Lauria Lavín Lavings Law Lawy Lay Lazer Lazkar 
  Leao Lebatteux Lebel Lebi Lebowitz Leca Lechtman Lehtinen Lee 
  Leenhardt Legras Leiro Lena Lengy Leptirici Lerner 
  Lesniewski Lesnik Lester Lev Levi Levinger Levin Levine Levoy 
  Levski Lewis Lhuissier Li Lian Libbrecht Libman Lie Lien 
  Liu Liggins Lilienstein Lillevik Lilley Limor Linczmayer Lindner 
  Lindstedt Llopart Locatelli Lockwood Lombard Longinotti 
  Lorentz Lorenzini Loreto Lormant Louchart Lovrecz Lowe Lubinski 
  Lucchesi Lucignano Ludewig Lund Luppi Lusk Lusky Lüßmann Lynch 
  Lyngdal Lyngen

  Maas MacDonald Macedo Machado Madsen Magee Maggio Maglietta 
  Mahaffey Maia Maiolani Malarme Maksymetz Malaczynski Malani 
  Malavasi Maluish Mamidaki Manara Mancuso Mandecka Mandelot Mane 
  Manfield Manganella Manglik Manni Mannix Mantica Manyawar Maoilani
  Marani Marashev Marchioni Marek Margarida Margiotta Mari Marill 
  Marina Marincho Marinescu Marino Markey Markowicz Marks Marmonti 
  Marquardsen Marsonis Marston Marta Martel Martellini Martens Martin 
  Martini Martins Marupe Masana Masini Mason Matei Matheson 
  Matisons Matteucci Matushko Mauberquez Mavridis Mayorga 
  Mazurkiewicz Maybach Mäkikangas Märsylä McAllister McCance 
  McDonald McGann McGinley McGowan McGrath McIntosh McKellar 
  McLeish McLeod McKinnon McLeish McManus McMahon McMullin 
  McNamara Meckstroth Medik Medugno Medved Mehech Mejane Mello 
  Mendoza Meltzer Merah Merblum Mesbur Messika 
  Mestres Metselaar Meyer Meyers Meyouhas Mezei Michaud Michealakis 
  Mickiewicz Miles Milgrim Mill Millar Miller Milne 
  Milner Mina Miner Minzli Miozzi Miroglio 
  Miszewska Mitra Mittelman Mirali Miura Mizel Mizrak Mohota 
  Mohtashami Molenaar Molenda Molina Molva Monachan Moni Monsegur 
  Montanari Mooney Moran Morath Morawski Moreira Morelli Morgan 
  Mori Moritsch Morot Morris Morrison Morse Mortensen 
  Moses Moskovsky Moss Mossop Mott Mouiel Mpampou Mpanikas 
  Mpompolakis Mucha Mueller Mullamphy Muller Multon Mundell 
  Munksgaard Munson Munteanu Muntz Muriel Murray Mus Mutiara 
  Muzzio Mýzrak Mæsel Mønsted

  Nab Nadar Nader Naels Nagy Nahmias Naimuddin Naito Naniwada
  Narasimhan Naqvi Narasinham Nardullo Natale Navneet Neale Negrin 
  Neill Nencini Netto Neuhauser Neulinger Neve Newell Newman 
  Ng Nickell Nieminen Nikolenkov Nikolov Nilsson 
  Nimhauser Ninos Nixon Nobel Noble Nordby Novoski Nowicki Nowosadzki 
  Nuñez Nørgaard Nunes Nunn Nussbaum Nyshchyi Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko Oikonomou Oikonomopoulos
  Olanski Olker Ollikkala Olofsson Olsen Omran Oncu O'Rourke Ortega
  Onstott Orhan Osaulenko Osofsky Oteyza Otvosi Oursel Outred 
  Ozarar Ozbey Ozdil Ozenir Ozge Ozlen Ozsahin Ozturk Östberg Özbey

  Pacareu Pacault Pacini Paganus Paiva Pajak Paladino Palau 
  Palmeira Palmer Pals Panagaki Panto Panopoulos Papahatzis 
  Papakyriakopoulos Papaxatzis Parker Partearroyo Parviainen Pasquarè
  Passarinho Passaro Passell Pastore Pattinson Pattison Paulissen 
  Pauncz Pavlicek Payen Pazur Peake Pedzinski Peirão Pekkinen Peksen 
  Penfold Percario Pereira Peres Periasamy Perisic Persiani Petculescu 
  Petrescu Petrucci Pettersson Phelan Piasecki Piedra Piekarek 
  Pietraszek Piganeau Pilon Pineles Pinguello Pinto Piper Pisak 
  Pisani Pitt Plaut Poizat Pollack Pollak Polledro Polowan 
  Pont Popescu Popova Potier Potts Poulat Pownall Pozzi Pradhan 
  Prescott Previde Priano Primavera Proukakis Procter Prohorov 
  Prusa Pryor Puczynski Pulkrab Purkarthofer Pszczola

  Quail Quantin Queran Quinn

  Rabinowitz Radcliffe Radikk Radin Radisic Rajagopal Ramamurthy 
  Ramchandran Ramondt Rankin Ranklin Ranson Rapp Rashti Rau Raulund 
  Ravenna Rayner Rebecchi Rees Reess Rehder Reid Reimer Reinholdt 
  Reiplinger Rekstad Renouard Reps Revaz Rew Reynolds Rheingold Rhodes 
  Ribera Ribery Ricard Ricci Richardson Richman Ridgway Riedel Riehm 
  Rietvink Rieusset Rigal Rigaud Riisnæs Rimstedt Ringuet Riolo Rios 
  Ritmeijer Rivers Rizzo Robb Robertson Robinson Robles 
  Robson Rocafort Rocca Rodwell Rogoff Rohowsky Roll Romanin 
  Romanski Rombaut Ronin Rosen Rosenberg Rosendorff Rosetta 
  Rosenkrantz Rosenthal Rossard Rossi Rosti Rothfield Rothstein 
  Roussoglou Roussos Rubiés Rubin Rubins Rubio Rueda Ruia Russo Ryman

  Sabbag Sabbatini Sadek Saelensminde Saesseli Sahin Saina Sairanen 
  Sakirler Sakr Salama Salisbury Salliere Salman Salvador Sancaktar
  Sandberg Sanden Sandqvist Sankichi Sansom Santos Saporta 
  Sapounakis Sargos Sarten Sarundajang Savchenko Savelli Savorani 
  Savski Sawicki Sayaca Saydi Sayer Sayilkan Sayýlkan Sbarigia 
  Scanavino Scerri Schaltz Scherders Schermer Schlicker Schneider 
  Schnetzer Scholes Schonning Schoolmann Schou Schuett Schulle 
  Schulz Schüller Schroeder Schreckenberger Scoltock Scudder 
  Scullin Schwartz Schwerdt Sealy Sebbane Seguineau Selberg Selcuk 
  Seligman Semenov Semerci Sen Serenella Serf Serifoglu Serpoi 
  Sesyilmaz Sezginsoy Shadyro Sharif Sharp Sher Sherman Shezifi 
  Shields Shiels Shimamura Shimizu Shirogane Short Shudnev Shugart 
  Shunta Silver Silverstein Silverstone Sime Simonsen Simpson Simson 
  Sinclair Sivrioglu Sjodal Skaanning Skelton Skjønnemann Skoglund 
  Skorchev Skurec Skwark Small Smart Smilgajs Smith Smirnov Smolanko 
  Snashall Snellers Snow Socha Sohlin Soldati Solheim Solimando Solodar 
  Sonsini Soriano Sorkin Sosler Soukup Soulet Sowter 
  Sörvoll Spangenberg Spector Spelmans Spiridonescu Spitalnick 
  Spooner Sprung Squires Stabell Stamatov Stankovic Stansby Stark 
  Stavrinos Steel Stegaroiu Steiner Stensson Stephenson Stern 
  Steinberg Sternberg Stevens Stewart Stienen Stilling Stoichkov 
  Stoltz Stoppa Street Stretz Strul Strøm Stuart Sulgrove Sveindal 
  Sveinsson Svendsen Suarez Sugino Summers Sundelin Sundsten Sung 
  Suñol Suresh Sutherlin Suwik Sütmen Svindahl Swarup Sweidan 
  Sykioti Sylvan Symons Szalay Szenberg Szigethy Szots 
  Szymanowski Sørensen

  Tachev Tajima Talpur Tamburi Tamburrini Tan Tanaka Taner 
  Tardy Tarhan Tarkunde Tarnovski Tasman Taylor Tebha Tedd 
  Teltscher Tembouret Tencer Teodorescu Teramoto Terraneo Tesla Tez 
  Thapa Thomsen Thompson Thomson Thoresen Thuillez Thurston Ticha 
  Tishler Tislevoll Todd Toffier Toivonen Tokay Torielli Toro
  Tosi Townsend Trabucchi Travis Tritt Troberg Tsang Tsilis Tubiska 
  Tucker Tudor Tulin Tully Tuomi Turner Tuszynski Tuwanakotta 
  Türkoðlu Tyradelli Tøndel

  Ucar Ueland Uggeri Ultav Una Upmark Uskali Uskela Usluduran Utter 
  Uysal

  Vahaboglu Vahalia Vainikonis Valeanu Valio Valta Vanchev Varadi 
  Varenne Vasarhelyi Veloni Venetina Venkatesh Ventin Verbeek Verhees 
  Vernay Versace Versluis Viale Viana Vidigal Viennois Vidalat
  Videv Vigil Vihtilä Vilella Villegas Vinay Vincent Vinciguerra 
  Virvidakis Vitas Vithaya Vogt Voinescu Volcker Vorobei Vriend 
  Vroustis Vucic

  Wademark Waledzik Walker Walsh Wang Ware Warne Wasik Watawe 
  Waterlow Waters Watkins Watts Watve Weber Weed Weiler Weingarten 
  Weingold Weinhold Weinstein Weisinger Welland Weltzer Werdelin 
  Wesolowska Westerlund Westheimer Westra Westwood Whibley Whiting
  Wiankowski Wigoder Wijma Wikstrom Wildavsky Willcox Wilkinson 
  Willenken Williams Willis Wilson Wiltshire Winciorek Wit Witek 
  Wittes Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey Worm 
  Wortel Wrang Wu Wyer

  Xatzimpalis

  Yadlin Yalman Yamada Yang Yarington Yates Yergýn
  Yezerski Yildiz Yilmaz Ying Yokoi Yoleri Yuen Yule

  Zabunoglu Zago Zagor Zagorin Zajac Zaleski Zanalda Zambonini 
  Zaninotti Zarkesch Zatorski Zawada Zawislak Zeeberg Zenari 
  Zhan Zhao Zhaoheng Zhong Zhukov Zielinski Zimmermann Zipovski 
  Zobu Zollo Zolotov Zorlu Zotti Zozis Zotos Zwart

  Özþahin
);

my %SINGLE_TYPOS =
(
  Aagaard => ['aagard'],
  Agarwal => ['agarwals'],
  Akgul => ['akgül'],
  'Akin Ucar' => ['akin'],
  'Alain Lévy' => ['levy', 'lévy'],
  'Aline Biondillo' => ['aline'],
  'Ajay Bagaria' => ['bagaria'],
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  'Alvares Ribeiro' => ['luisaribeiro'],
  'Amiya Ranjan Das' => ['das'],
  Angelini => ['angelýný'],
  'Aniket Sanghvi' => ['aniket'],
  'Antonio Frances' => ['frances', 'francés'],
  Arcieri => ['arceri'],
  'Arunas Jankauskas' => ['arünas'],
  Avcioglu => ['avcýoðlu', 'avcioðlu'],
  Baleal => ['balelal'],
  Beale => ['beatle'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bertheau => ['berthau'],
  Bessis => ['bes'],
  Blumental => ['blummental'],
  Bocchi => ['norby'],
  'Brigitta Fischer' => ['fischer'],
  Brogeland => ['broge'],
  'Buddy Shah' => ['buddy'],
  Bytskevich => ['bytskevitch'],
  'Carlos Ferreira' => ['ferreira'],
  'Chalermpol Wongwaiwit' => ['chalermpol'],
  'Christal Henner-Welland' => ['henner'],
  Ciechomski => ['ciechomek'],
  Combescure => ['combescur'],
  Curo => ['curò'],
  'C.V. Rao' => ['cvrao'],
  Dabrowka => ['d¹brówka'],
  'David Birman' => ['birman'],
  'de Falco' => ['defalco'],
  'de Livera' => ['delivera'],
  'de Tessieres' => ['tessieres', 'tessiere'],
  Debonnaire => ['debonaire'],
  "Del'Monte" => ['delmonte', 'ish'],
  Delimpaltadakis => ['delim'],
  Demirbas => ['Demirbaþ'],
  'Deniz Ruzgar Akyurek' => ['ruzgar'],
  'Diana Damyanova' => ['dianadamyanova'],
  'Dmitri Marchessini' => ['dmitri'],
  "D'Orsi" => ['dorsi'],
  Dumbovich => ['dumbovic'],
  Eisenberg => ['einsenberg'],
  Eksi => ['ekþý'],
  'Edmund Tse' => ['tse'],
  'Erlend Skjetne' => ['erlendskjetne'],
  'Waleed El Ahmady' => ['elahmady', 'elhamady'],
  Failla => ['faill'],
  'Francisco Costa-Cabral' => ['cabral'],
  'G. Limmen' => ['limmen'],
  'Gabriel Chagas' => ['chagas'],
  Gartaganis => ['gartaginas'],
  Garoufalis => ['garoufallis'],
  Gladysh => ['gladysch'],
  Golebiowski => ['golembiowski'],
  'Carlos Gonçalves' => ['gonsalves', 'gonçalves'],
  Greenwood => ['greenwod'],
  'Grzegorz Darkiewicz-Moniuszko' => ['moniuszko'],
  Grenthe => ['grent', 'grenth'],
  Gromöller => ['gromoeller', 'gromuller', 'gro'],
  Giura => ['guira'],
  Günther => ['guenther'],
  Hackett => ['hakett'],
  Harangozo => ['harangozó'],
  Hassett => ['hasett'],
  Haughie => ['huaghie'],
  'Hecht Johansen' => ['hecht'],
  Hoffman => ['hofman'],
  'Hong NIU' => ['hongniu'],
  'Ilan Bareket' => ['bareket'],
  'Ilan Herbst' => ['herbst'],
  Ilmez => ['Ýlmez'],
  'J.E. Skjanni' => ['skjanni'],
  'J.P. Goenka' => ['goenka', 'jpgoenka'],
  'Jaggy Shivdasani' => ['jaggy'],
  'Jan-Olov Andersson' => ['joa'],
  Jansma => ['jansa'],
  'Javed Ahmed Miran' => ['miran'],
  Jedrychowski => ['jedrychowsky'],
  'Jeovani Salomao' => ['jeovani'],
  'Jeroo Mango' => ['mango'],
  'Jerzy Zaremba' => ['zaremba'],
  'Joao Silva Neto' => ['silvaneto'],
  'John Holland' => ['j holland'],
  'José Moraes' => ['moraes'],
  'Jörg Fritsche' => ['fritsche', 'joefri'],
  Kaminski => ['kaminsky'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Kapagiannides' => ['kapagiannides'],
  Karadeniz => ['karadenýz'],
  Karamanlis => ['karamanli'],
  Karlaftis => ['karlaytis'],
  'Kasper Konow' => ['konow'],
  Kazik => ['kazic'],
  Khandelwal => ['khandelwals', 'khandewal'],
  Kilvington => ['kilvigton'],
  Koivula => ['koivulat'],
  Kordov => ['kordöv'],
  Kotányi => ['kotanyi'],
  Kökten => ['kokten'],
  Krochmalik => ['krockmalik'],
  Kurbalija => ['kuribalija'],
  Lantaron => ['lantarón'],
  Lauria => ['laurýa'],
  Llopart =>['lllopar', 'llopar'],
  Lombard => ['lomard'],
  'Lotan Fisher' => ['fisher'],
  'Luis Oliveira' => ['oliveira'],
  Lyngen => ['lyn'],
  Maas => ['mass'],
  'Maria João Lara' => ['lara'],
  Mahaffey => ['mahafey', 'mahaffee'],
  Mane => ['mané'],
  'Manoel Peirao' => ['manoel'],
  'Manuel Capucho' => ['capucho'],
  Manyawar => ['manyvar'],
  'Marc Kerlero de Rosbo' => ['kerlero'],
  Markowicz => ['markovics', 'markowitz'],
  'Maxim Henbest' => ['henbest'],
  'Maya Meera Sneha' => ['mayameerasneha'],
  Mesbur => ['mesbor'],
  Meltzer => ['metzler'],
  'Miguel Teixeira' => ['teixeira'],
  Milne => ['mlne'],
  Milner => ['millner'],
  'Mohamed Manaf Saleh' => ['manaf'],
  Mohota => ['mohata'],
  'Mohsen Kamel' => ['mohsenkamel'],
  'Moni Diba' => ['monidiba'],
  'Møller Jepsen' => ['møllerjepsen'],
  Nowosadzki => ['nowosad'],
  'Nuno Damaso' => ['damaso'],
  Olanski => ['olansk'],
  Oursel => ['ousel'],
  Ozdil => ['odzil'],
  Ozturk => ['öztürk'],
  Özbey => ['ozbey'],
  Pacareu => ['pacareau'],
  'Palma Carlos' => ['pcarlos'],
  Panopoulos => ['panopulos'],
  Patanè => ['patane'],
  'Patrick Jourdain' => ['jourdain'],
  'Paulo Goncalves Pereira' => ['pgp'],
  'Paulo Roberto Brum' => ['brum'],
  'Pedro Madeira' => ['pmadeira', 'madeira'],
  'Pedro Morbey' => ['morbey'],
  'Pedro Pratas' => ['pratas'],
  Peirão => ['peirao'],
  Peksen => ['pekþen'],
  'Peteris Bethers' => ['peteris'],
  'Phailin Nimityongskul' => ['phailin'],
  'Pobsit Kamolvej' => ['pobsit'],
  'Pony Nehmert' => ['pony'],
  'Pramual Angkaew' => ['pramual'],
  Prescott => ['prescot'],
  Procter => ['proctor'],
  Pszczola => ['pepsi'],
  'Quentin Robert' => ['robert'],
  Radikk => ['radekk', 'radik'],
  'Raghavendra Rajkumar' => ['raghvendra'],
  'Rahul Ravichandran' => ['ravichandran'],
  'Ralitsa Mihaylova Mircheva' => ['ralitsa'],
  Ramamurthy => ['ramamurthi'],
  'Reinaldo Timoteo' => ['timoteo'],
  Richardson => ['rchardson'],
  Rietvink => ['reitvink'],
  Riisnæs => ['riisnes'],
  Rizzo => ['rizzp'],
  Rosenkrantz => ['rosenkranz'],
  Rosenthal => ['rosentahl'],
  Roussos => ['rousos'],
  Rubiés => ['rubies', 'rubie'],
  Rubin => ['rugin'],
  'Rui Silva Santos' => ['rss'],
  Ruia => ['ruya'],
  'Sally Brock' => ['brock'],
  'Salvatore Luceno' => ['lucenò'],
  Sapounakis => ['sapounaki'],
  Schaltz => ['schalz', 'shaltz'],
  Schneider => ['scheinder'],
  Schou => ['shhou'],
  Schüller => ['schueller'],
  Schwartz => ['schwarz'],
  Selcuk => ['Selçuk'],
  Senior => ['serior'],
  'Simon Gillis' => ['gillis'],
  Simson => ['simso'],
  Sinclair => ['sýnclaýr'],
  Smilgajs => ['smilgais'],
  'Sofia Costa Pessoa' => ['pessoa'],
  Stephenson => ['stephenso'],
  'Saumitra Basu' => ['saumitra'],
  'Sunil Machhar' => ['macchar', 'sinilmachar'],
  Svendsen => ['svends'],
  Svindahl => ['svindhal'],
  Szenberg => ['szpenberg'],
  Tarnovski => ['tranovski'],
  Teltscher => ['teltsher'],
  Teodorescu => ['teodeorescu'],
  Thuillez => ['tuillez', 'thuilliez'],
  'Tomi Gotard' => ['tomi'],
  'Tor Helness' => ['helness'],
  'Toshiro Nose' => ['nose'],
  Townsend => ['towsend'],
  'Teixeira-Reus' => ['txecreus'],
  Ucar => ['uçar'],
  Vasarhelyi => ['vasarhely', 'vasrahely'],
  Venkatesh => ['venky'],
  'Villas Boas' => ['villasboas'],
  Vinciguerra => ['vinci'],
  'Visalakshi Narayanan Ramamoorthy' => ["vnr's"],
  'Wang Yuan Wei' => ['wangyuanwei'],
  Watawe => ['watave'],
  Wigoder => ['wigodor'],
  Wolfson => ['wolson'],
  'Yaacov (Jacob) Mintz' => ['minz'],
  Yilankiran => ['yilankirn', 'yýlankýran'],
  'Yuval Lubinski' => ['lubinsky'],
  Zabonoglu => ['zabunoðlu'],
  Zaleski => ['zalesky', 'zalenski'],
  Zimmermann => ['zimmmermann', 'zimmerman', 'zimermann',
    'zimerman', 'zmmermann'],
  Zolotov => ['zolotoy'],
  Zozis => ['zosis'],
  'Zia Mahmood' => ['mahmood', 'mamhood', 'zia']
);


sub set_hashes_team_captain
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
