#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Captain;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Acacio Figueiredo',
  'Adam Edgtton',
  'Adolfo Steiger Garcao',
  'Ajay Bagaria',
  'Ajay Vaish',
  'Ajit Mahadar',
  'Akin Ucar',
  'Alain Lévy',
  'Alan Mould',
  'Aline Biondillo',
  'Alok Daga',
  'Alon Birman',
  'Alvares Ribeiro',
  'Amedian Bross',
  'Ami Zamir',
  'Amir Levin',
  'Amiya Ranjan Das',
  'Ana Tadeu',
  'Anders Hagen',
  'Anders Johansson',
  'Andrea Landry',
  'Andreas Rolf-Larsen',
  'Aniket Sanghvi',
  'Anita Sinclair',
  'Anoop Dhawan',
  'Antonio Falcao',
  'Antonio Frances',
  'Antonio Maria Campos',
  'Antonio Palma',
  'Anup Dhawan',
  'Aron N. Þorfinnsson',
  'Artur S. Silva',
  'Arun Bapat',
  'Arun Jain',
  'Arun Joshi',
  'Arun Kumar Sinha',
  'Arunas Jankauskas',
  'Asa Levinger',
  'Ashish Malhotra',
  'Ashwin Mehta',
  'A.K. Bose',
  'Ilan Bareket',
  'Baneet Malhotra',
  'Benedicte Cronier',
  'Bé. Oliveira',
  'Bharat Bhosale',
  'Bimal Sicka',
  'Birkir Jonsson',
  'Brian Senior',
  'Brigitta Fischer',
  'Buddy Shah',
  'Buus Thomsen',
  'Bøgh-Sørensen',
  'C.V. Rao',
  'Carlos Ferreira',
  'Carlos Galvão Lucas',
  'Carlos Gonçalves',
  'Carlos Luis',
  'Carlos Santos',
  'Carlos Teixeira',
  'Carole Puillet',
  'Chalermpol Wongwaiwit',
  'Charlie Lee',
  'Choo Wai Wong',
  'Christal Henner-Welland',
  'Christophe Grosset',
  'Corte-Real',
  'C.V. Rao',
  'D Banerjee',
  "D'Avossa",
  'Da Silva',
  'Dam Mortensen',
  'Daniel Gigello Gheorghe',
  'David Birman',
  'De Blasi',
  'de Botton',
  'de Bruyne',
  'de Falco',
  'de Knijff',
  'de Krull',
  'de la Barrera',
  'de Livera',
  'de Luca',
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
  'Diane Gordy',
  'Ding Yuan',
  'Djordje Dunjic',
  'Dmitri Marchessini',
  "D'Orsi",
  "D'Ovidio",
  'Dr. Anand',
  'Dr. Ashwani Mehta',
  'Duronto Rajshahi',
  'Ece Mizrahi',
  'Edmund Tse',
  'Eduardo Pinto',
  'Efrat Oren',
  'El Baz',
  'Ellena Moskovsky',
  'Emil Thomsen',
  'Enrique Pinto',
  'Erik Wied',
  'Erikas Vainikonis',
  'Eriko Matsuo',
  'Erla Sigurjónsdóttir',
  'Erlend Skjetne',
  'Espinosa Paz',
  'Evgueni Gladysh',
  'Ewa Lasting',
  'Fatih Yayla',
  'Fernando F. Santos',
  'Fernando Matos',
  'Filippo Palma',
  'Finn Kolesnik',
  'Flemming Dahl',
  'Francesca de Lucchi',
  'Francisco Costa-Cabral',
  'Frímann Stefánsson',
  'G. Limmen',
  'Gabriel Chagas',
  'Garcia da Rosa',
  'George Soo',
  'Gila Emody',
  'Ginossar',
  'Grzegorz Darkiewicz-Moniuszko',
  'Guang Zhong',
  'Guðmundur Ólafsson',
  'Gudmundur Snorrason',
  'Gudmundur S. Hermannsson',
  'Guðrún Óskarsdóttir',
  'Gunnar Birgisson',
  'Gunnar Björn Helgason',
  'Gunnar Sjökvist',
  'Gunnlaugur Sævarsson',
  'Gylfi Baldursson',
  'H. Narsimhan',
  'H.C. Nielsen',
  'Hana Shezifi',
  'Hans-Ove Sandin',
  'Haoran Hoyin',
  'Hecht Johansen',
  'Helge Hesselberg',
  'Hema Deora',
  'Hemant Jalan',
  'Hemant Lall',
  'Hemant Malse',
  'Henning Østergaard',
  'Henrik Lahrmann',
  'Hermann Friðriksson',
  'Hiroki Yokoi',
  'Hiroya Abe',
  'Hjalmar S Palsson',
  'Hjordis Eythorsdottir',
  'Hjordis Sigurjonsdottir',
  'Hong Hu',
  'Hong NIU',
  'Huijun Song',
  'Ilan Herbst',
  'Ingvar Erga',
  'Inocencio Almeida Araujo',
  'Inon Liran',
  'Ivan Abel',
  'J. Brigido',
  'J. Pereira de Sousa',
  'J. Pinheiro',
  'J. Tomljenovic',
  'J.C. Henriques',
  'J.E. Skjanni',
  'J.P. Goenka',
  'Jacob Cornell',
  'Jacky Ip',
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
  'Jin Zhuo',
  'João Fanha',
  'Joao Ferreira',
  'Joao Paes de Carvalho',
  'Joao Silva Neto',
  'John Holland',
  'John Møller Jepsen',
  'Jón Ásbjörnsson',
  'Jón Baldursson',
  'Jorge Alexandre',
  'Jorge Castanheira',
  'Jorge Cruzeiro',
  'Jorge Monteiro Dos Santos',
  'Jorge Petrucci',
  'Josef Blass',
  'José Dias',
  'José Moraes',
  'Jozef Pochron',
  'Jörg Fritsche',
  'Jörgen Lindqvist',
  'Juan Carlos Ventin',
  'Juan Valdez',
  'Julia Hoffman',
  'Juliano Barbosa',
  'Júlíus Sigurjónsson',
  'Kalpana Misra',
  'Kamal Kumar Nagori',
  'Kamlesh Gupta',
  'Kardelen Can',
  'Karl Christian Baumann',
  'Karl Sigurhjartarson',
  'Kasper Konow',
  'Ken Ford',
  'Kenten Hijau',
  'Knud Harries',
  'Koch-Palmund',
  'Kristian Tylvad',
  'Kristján Blöndal',
  'Kruse Petersen',
  'Krzysztof Strykier',
  'Kumar Vijay Anand',
  'Kurniadi Djauhari',
  'Kusuma Dilaga',
  'Kwok-Fai Mak',
  "L'Écuyer",
  'Lanpikul Thongchairit',
  'Lars Peter Damgaard',
  'Lauge Pedersen',
  'Lauren Travis',
  'Leif Thomsen',
  'Li Shu Yuan',
  'Li Xiao Lei',
  'Lin Rong Qiang',
  'Lone Bilde',
  'Lotan Fisher',
  'Lu Dong',
  'Luis Alvares Ribeiro',
  'Luis Brito',
  'Luis Oliveira',
  'Mads Eyde',
  'Majka Cilleborg Bilde',
  'Manoel Peirao',
  'Manoj Shah',
  'Manuel Capucho',
  'Manuel Neto',
  'Manuel Oliveira',
  'Manuela Mouttet',
  'Marc ter Laare',
  'Marc Kerlero de Rosbo',
  'Marcelo Branco',
  'Marele Urs',
  'Maria João Lara',
  'Mariana Leitão',
  'Mariana Nogueira',
  'Marianne Homme',
  'Marius Bartnes',
  'Mark Gordon',
  'Mark Micha',
  'Martine Rossard',
  'Mathias Bruun',
  'Maxim Henbest',
  'Maya Meera Sneha',
  'Mayda de Dios',
  'Miao Yang',
  'Michael Cornell',
  'Michael Lipkin',
  'Migry Zur-Campanile',
  'Miguel Lima',
  'Miguel A. Ribeiro',
  'Miguel S. Guedes',
  'Miguel Sarmento',
  'Miguel Silva',
  'Miguel Sousa Guedes',
  'Miguel Teixeira',
  'Mikud Mannid',
  'Modi Kenigsberg',
  'Mohamed Manaf Saleh',
  'Mohit Mehta',
  'Mohsen Kamel',
  'Moni Diba',
  'Monica Jajoo',
  'Morris Chang',
  'Morten Jepsen',
  'Morten Klug',
  'Morten Lund Madsen',
  'Morten Stege',
  'Murray Green',
  'Lars Møller Sørensen',
  'N. Chakraborty',
  'N.R.K. Moorthi',
  'Nabil Chaker',
  'Nabil Edgtton',
  'Nathan van Jole',
  'Navneet Swaika',
  'Nevena Senior',
  'Nils Mønsted',
  'Nuno Damaso',
  'Nuno Matos',
  'Nuno Paz',
  'Nuno Sousa',
  'Ofek Tal',
  'Ole Fugl',
  'Olivier Bessis',
  'Ómar Freyr',
  'Omar Sharif',
  'Ömer Abi',
  'P.C. Gupta',
  'Palma Carlos',
  'Pankaj Kapadia',
  'Pankaj Mehta',
  'Pascale Thuillez',
  'Patrick Choy',
  'Patrick Jourdain',
  'Paul Fireman',
  'Paul Hackett',
  'Paul Van Goor',
  'Paula Leslie',
  'Paula Lima',
  'Paulo Dias',
  'Paulo Goncalves Pereira',
  'Paulo Roberto Brum',
  'Paulo Rocha Pinto',
  'Pearl Mehta',
  'Pedro Durao',
  'Pedro Madeira',
  'Pedro Morbey',
  'Pedro Pratas',
  'Pedro Russo',
  'Pedro Salgueiro',
  'Pedro Sampaio Nunes',
  'Peter de Vries',
  'Peter Schaltz',
  'Peteris Bethers',
  'Petra Hamman',
  'Phailin Nimityongskul',
  'Phyllis Fireman',
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
  'Qiao Ge',
  'Qing Gong',
  'R.K. Sinha',
  'R.L. Kejriwal',
  'R.S. Mishra',
  'R Fernandes',
  'Radu Nistor',
  'Raghavendra Rajkumar',
  'Rahul Ravichandran',
  'Raja Brawijaya',
  'Ralitsa Mihaylova Mircheva',
  'Ratan Lal Sanghi',
  'Raul Guerreiro',
  'Razvan Andrei Gheorghe',
  'Reinaldo Timoteo',
  'Rita Choksi',
  'Rita Russo',
  'Robyn Brazier',
  'Rodrigo Suares',
  'Ronnie Benin-Barr',
  'Rui Pinto',
  'Rui Silva Santos',
  'Rúnar Einarsson',
  'Rusen Abi',
  'Sadek Radwan',
  'Sainte Marie',
  'Sally Brock',
  'Salvatore Luceno',
  'Sanat Roy',
  'Sandip Chatterji',
  'Sandra Batista',
  'Sanjay Bhattacharya',
  'Sara Silva',
  'Satish Diwanji',
  'Satish Modi',
  'Saumitra Basu',
  'Sejr Andreas Jensen',
  'Signe Buus Thomsen',
  'Shahar Zack',
  'Shashi Gupta',
  'Shekhar Banerjee',
  'Sheng He Wang',
  'Shih Yeh',
  'Shlomo Netzer',
  'Shree Priya',
  'Si Zheng',
  'Signe Thomsen',
  'Sigurdur Vilhjalmsson',
  'Simon Gillis',
  'Símon Símonarson',
  'Sinan Abi',
  'Sinan Göksu',
  'Sofia Costa Pessoa',
  'Song Hui',
  'Steen Schou',
  'Stefán Jóhannsson',
  'Stefan Vilhjalmsson',
  'Stig Farholt',
  'Sunil Machhar',
  'Susanne Bohnsack',
  'Sveinn Ericsson',
  'Sverrir Þórisson',
  'Sylvie Willard',
  'T. Debonnaire',
  'T.V. Joshi',
  'Teixeira-Reus',
  'Teresa Kay',
  'Thomas Vang Larsen',
  'Tiago Canelas',
  'Tomi Gotard',
  'Tone Torkelsen Svendsen',
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
  'Van Eijck',
  'Van Riel',
  'Van Zwol',
  'Varsha Jain',
  'Vesth-Hansen',
  'Vijay Anand Singh',
  'Vijay K Khan',
  'Villas Boas',
  'Vincent LI',
  'Visalakshi Narayanan Ramamoorthy',
  'W.W. Cho',
  'Waleed El Ahmady',
  'Wang Yuan Wei',
  'Ward Platt',
  'Wei Sender',
  'Weidong He',
  'Wing Hung Fok',
  'Wu Xiao Bing',
  'Wubbo de Boer',
  'Xavier Michaud Larivière',
  'Yaacov (Jacob) Mintz',
  'Yao Ke',
  'Ye Shi',
  'Yolluk Bostanci',
  'Yu Yi',
  'Yuval Levin',
  'Yuval Lubinski',
  'Zack Yaniv',
  'Zelal Su',
  'Zhang De Zhong',
  'Zhang Xiao Feng',
  'Zhong Jia',
  'Zia Mahmood',
  'ZHOU Tao'
);

my %MULTI_TYPOS =
(
  'Acacio Figueiredo' => ['acacio f'],
  'Adam Edgtton' => ['a edgtton', 'a.edgtton'],
  'Adolfo Steiger Garcao' => ['adolfo steiger'],
  'Ajay Bagaria' => ['a.bagaria', "a. bagaira's iv"],
  'Alain Lévy' => ['alain levy'],
  'Alok Daga' => ["alok daga's iv"],
  'Alon Birman' => ['birman alon'],
  'Alvares Ribeiro' => ['luis a ribeiro', 'luis a. ribeiro', 
    'álvares ribeiro'],
  'Alvensleben' => ['v.alvensleben', 'v. alvensleben'],
  'Ami Zamir' => ['zamir ami'],
  'Amiya Ranjan Das' => ['a r dass'],
  'Andrea Landry'=> ['landry andrea'],
  Angelini => ['squadra angelýný', 'squadra angelini'],
  'Anoop Dhawan' => [
    'anoop dhaon', 
    'anoop dawan',
    'anoop dawand',
    'anoop dhavan'],
  'Antonio Falcao' => ['falcão'],
  'Antonio Maria Campos' => ['antonio m campos', 'antonio maria campo'],
  'Antonio Palma' => ['antónio palma'],
  'Artur S. Silva' => ['artur s silva'],
  'Arun Jain' => ['arunjain'],
  'Asa Levinger' => ['leviger asa'],
  'Ashwin Mehta' => ['dr.ashwin meheta'],
  'A.K. Bose' => ["a.k.bose's iv", "a.k.bose'iv", "a k bose's 4",
    "a k bose's IV", 'a.k.bose'],
  'Arun Kumar Sinha' => ['a k sinha', 'a.k.sinha'],
  'Ilan Bareket' => ['bareket ilan'],
  'Baneet Malhotra' => ['b malhotra'],
  'Benedicte Cronier' => ['mme cronier'],
  'Bé. Oliveira' => ['bé oliveira'],
  'Bimal Sicka' => ['bimal sikka'],
  'Birkir Jonsson' => ['birkir j jonsson', 'birkir jón jónsson'],
  Boaz => ['dr. boaz', "dr. boaz's"],
  Brogeland => ['brogeland fc'],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.', 'cv rao'],
  'Carlos Galvão Lucas' => ['carlos lucas'],
  'Carlos Gonçalves' => [
    'c goncalves',
    'c gonçalves', 
    'carlos gocalves', 
    'carlos goncalves', 
    'carlos gonçalve', 
    'carlos gonçalv'],
  'Choo Wai Wong' => ['int choowai'],
  'Christal Henner-Welland' => ['welland-h', 'henner-we',
    'henner-welland'],
  'Christophe Grosset' => ['grosset c'],
  Cladius => ['dr. cladius'],
  'David Birman' => ['birman david', 'birman d'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Bruyne' => ['de Bruyune'],
  'de Falco' => ['di falco'],
  'de Knijff' => ['deknijff', 'di knijff'],
  'Francesca de Lucchi' => ['de lucchi'],
  'de Tessieres' => ['de tessiere', 'de tessier', 'de tessie'],
  'D Banerjee' => ['prof d banerjee'],
  "D'Orsi" => ['d orsi', "d´orsi", "d`orsi", "d 'orsi"],
  'Daniel Gigello Gheorghe' => ['gheorghe d'],
  Desai => ['desai 5'],
  'Dr. Anand' => ["dr. anand's"],
  'Efrat Oren' => ['oren efrat'],
  'El Baz' => ['baz'],
  'Ellena Moskovsky' => ['e.moskovsky'],
  'Enrique Pinto' => ['e pinto'],
  'Erikas Vainikonis' => ['vainikonis e'],
  'Eriko Matsuo' => ['matsuo eriko'],
  'Erla Sigurjónsdóttir' => ['erla sigurjónsdótti'],
  'Espinosa Paz' => ['espinoza paz'],
  'Flemming Dahl' => ['dahl'],
  'Francisco Costa Cabral' => [
    'f. costa cabral', 
    'f. costa-cabral',
    'francisco c.cabral', 
    'francisco c. cabral', 
    'francisco costa cab'],
  'Frímann Stefánsson' => ['frímann stefansson'],
  'G. Limmen' => ['g.limmen'],
  'Gabriel Chagas' => ['chagas.g'],
  'Gila Emody' => ['emody gila'],
  'Ginossar' => ['eldad ginossar', 'ginossar eldad'],
  'Evgueni Gladysh' => ['e_gladysh', 'e_gladysh_', 'e_glaysh_'],
  'Finn Kolesnik' => ['f kolesnik'],
  'Guðmundur Ólafsson' => ['gudmundur olafsson'],
  'Guðrún Óskarsdóttir' => ['guðrún óskars'],
  'Gudmundur S. Hermannsson' => ['guðmundur sv. h'],
  'Gudmundur Snorrason' => ['gudmundur snorra'],
  'Gunnar Björn Helgason' => ['gunnar björn h', 'gunnar björn'],
  'Gunnlaugur Sævarsson' => ['gunnlaugur sævars', 'Gunnlaugur Sævarsso'],
  'H. Narsimhan' => ['h narsimhan'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hana Shezifi' => ['shezifi hana'],
  'Hans-Ove Sandin' => ['hans-ove', 'hans-ove crew'],
  'Hecht Johansen' => ['hecht-johansen', 'hect johansen'],
  Helekar => ['dr. helekar', 'dr.helekar'],
  'Hemant Jalan' => ['h.jalan', 'hemant  jalan'],
  'Hemant Lall' => ['hemant lal', 'henant lal', 'henant lall'],
  'Hemant Malse' => ['hemant- malse'],
  'Henrik Lahrmann' => ['daddy lahrmann'],
  'Hermann Friðriksson' => ['Hermann Fridriksson'],
  'Hiroki Yokoi' => ['yokoi hiroki'],
  'Hiroya Abe' => ['abe hiroya'],
  'Hjordis Eythorsdottir' => ['hjordis eythorsdott'],
  'Hjordis Sigurjonsdottir' => ['hjordis sigurjonsdo'],
  'Huijun Song' => ['hui song'],
  'Ilan Herbst' => ['herbst i', 'herbst ilan', 'herbsr ilan'],
  'Inocencio Almeida Araujo' => ['inocencio arauj', 'inocêncio araújo',
    'inocencio'],
  'Inon Liran' => ['liran inon'],
  'J. Tomljenovic' => ['jtomljenovic'],
  'J.C. Henriques' => [
    'jc henriques',
    'j c henriques',
    'j. c. henriques', 
    'j. carlos henriques', 
    'j.c.henriques', 
    'j.carlos henriques',
    'jose c. henriques',
    'jose c.henriques',
    'jose henriques',
    'josé c. henriques', 
    'josé carlos henriqu',
    'josé henriques', 
    'zc henriques',
    'ze carlos henriques',
    'zé carlos henriques', 
    'josé c henriques'],
  'J.E. Skjanni' => [
    'j. e. skjanni',
    'j e skjanni',
    'j.e skjanni',
    'j.e skjanni ehf',
    'j.e.skanni', 
    'j.e.skjanni', 
    'j.e. skanni',
    'j.e. skajnni ehf',
    'j.e. skjanni ehf',
    'je skjanni',
    'je skjanni ehf',
    'skjanni ehf'],
  'J.P. Goenka' => ['j.p.goenka'],
  'Jacob Cornell' => ['cornell jacob'],
  'Jean le Poder' => ['le poder'],
  'Jennifer de Winter' => ['jen de winther', 'jan de winter'],
  'Jesper Buus Thomsen' => ['jb thomsen', 'j. buus-thomsen'],
  'Jin Zhuo' => ['jin shuo'],
  'João Fanha' => ['j.fanha', 'joao fanha', 'j. fanha',
    'j fanha'],
  'Joao Silva Neto' => ['silva neto'],
  'Joao Paes de Carvalho' => [
    'j paes c',
    'j paes carvalho',
    'j paes de carvalho',
    'j.p.carvalho',
    'joao p. carvalho', 
    'joão p. carvalho', 
    'paes de carvalho'],
  'John Møller Jepsen' => ['møller jepsen',
    'john moeller jepsen'],
  'John Holland' => ['j holland'],
  'Jón Baldursson' => ['jon baldursson'],
  'Jorge Castanheira' => [
    'jorel8', 
    'castanheira',
    'j.castanheira'],
  'José Moraes' => ['josé morae', 'jose moraes'],
  'Joshi Sanghi' => ['dr.joshi', "dr.sanghi'siv",
    "dr. joshi's - sangl", "dr. sanghvi's  vi", 'dr. joshi sangli'],
  'Jozef Pochron' =>['j pochron'],
  'Jörgen Lindqvist' => ['jörgen lindqvist cr'],
  'Juan Carlos Ventin' => [
    'j.c.ventin',
    'juan carlos vent',
    'juan carlos venti',
    'juan carlos ventino',
    'juan vinton'],
  'Juan Valdez' => ['juan valdes'],
  'Julia Hoffman' => ['j hoffman'],
  'Jr. Yilankiran' => ['j.yilankiran', 'jr.yilankiran',
    'jr. yilankiran', 'jr.  yilankiran'],
  'Kalpana Misra' => ['kalpana mishra'],
  'Kamal Kumar Nagori' => ['kamal naguri', "kamal naguri's"],
  'Kamlesh Gupta' => ['kamalesh gupta', 'k gupta iv'],
  'Kardelen Can' => ['Can Kardelen'],
  'Karl Sigurhjartarson' => ['karl sigurhjartar', 'karl sigurhjartars',
    'karl sigurhjartarso', 'karl sigurhjartarss'],
  'Modi Kenigsberg' => ['kenigsberg modi'],
  Kishan => ["kishan's iv"],
  'Kristján Blöndal' => ['kristjan blondal'],
  'Krzysztof Strykier' => ['k.strykier'],
  'Kumar Vijay Anand' => ['kr. vijay anand', 'kr. vijayanand'],
  'Kurniadi Djauhari' => ['dee jee'],
  'Kwok-Fai Mak' => ['kf mak'],
  "L'Écuyer" => ["l'ecuyer", 'lecuyer', 'l ecuyer', 'l"ecuyer',
    "l'equyer"],
  'Lanpikul Thongchairit' => ['dr. thongchai'],
  'Lars Møller Sørensen' => ['Møller Sørensen',
    'lm sørensen'],
  'Lars Peter Damgaard' => ['l p damgaard'],
  'Lauge Pedersen' => ['lauge-pedersen'],
  'Lauren Travis' => ['l travis'],
  'Amir Levin' => ['levin amir', 'lavin amir'],
  Lhuissier => ["l'huissier"],
  'Lotan Fisher' => ['fisher lotan'],
  'Luis Alvares Ribeiro' => ['l.a. ribeiro'],
  'Luis Oliveira' => ['luís oliveira'],
  'Majka Cilleborg Bilde' => ['majka bilde'],
  'Manuel Capucho' => ['m capucho', 'manual capucho'],
  'Manuel Oliveira' => ['manuel oliveia', 'm.oliveira', 'm. oliveira',
    'm oliveira'],
  'Manuela Mouttet' => ['mme mouttet', 'mouttet'],
  'Marc ter Laare' => ['ter laare'],
  'Maria João Lara' => [
    'mª joão lara',
    'm joao lara', 
    'm joão lara',
    'm. j. lara', 
    'm.j.lara', 
    'm.j. lara',
    'mj.lara',
    'm. joão lara',
    'm.joao lara', 
    'm.joão lara', 
    'maria j.lara', 
    'maria joao lara'], 
  'Mariana Leitão' =>['mariana leitao'],
  'Marius Bartnes' => ['dr. bartnes'],
  'Martine Rossard' => ['mme rossard'],
  'Maxim Henbest' => ['m.henbest'],
  'Maya Meera Sneha' => [
    'maaya meera', 
    'maaya mira',
    'maya meera', 
    'maya mera sneha',
    'maya mira', 
    'maya mira sneha'],
  McLeish => ['mc. leish'],
  'Migry Zur-Campanile' => ['zur-campanile'],
  'Miguel Sousa Guedes' => ['miguel s guedes', 'm. sousa guedes',
    'sousa guedes'],
  'Miguel Teixeira' => ['miguel teixeira', 
    'm. teixeira', 'm.teixeira'],
  'Mikud Mannid' => ['mikud-mannid'],
  'Mohit Mehta' => ['mohit mehata', 'mohit meheta'],
  'Monica Jajoo' => ['monika jajoo', 'm.jajoo'],
  'N. Chakraborty' => ["n.c hakraborty's iv"],
  'N.R.K. Moorthi' => ['n r k moorthi'],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  'Nathan van Jole' => ['van jole'],
  'Nevena Senior' => ['n senior'],
  'Nuno Paz' => ['n paz'],
  "O'Rourke" => ['o rourke', 'o;rourke', "o'rouke"],
  'Ofek Tal' => ['ofel tal'],
  'Olivier Bessis' => ['bessis.o'],
  'Pascale Thuillez' => ['mme thuillez'],
  'Patanè' => ["patane'"],
  'Paul Hackett' => ['p hackett', 'pd hackett', 'hackett p'],
  'Paula Leslie' => ['p leslie'],
  'Paulo Goncalves Pereira' => [
    'p g pererira',
    'p g pereira', 
    'p gonçalves pereira',
    'p.g. pereira',
    'p.g.p.',
    'p.g.pereira', 
    'pg pereira',
    'p. g. pereira', 
    'paulo g pereira',
    'paulo g.pereira',
    'paulo gonçalves', 
    'paulo goncalves per',
    'paulo goncalves perreira', 
    'paulo gp', 
    'paulo g. pereira'],
  'Paulo Roberto Brum' => ['brum p', 'brum.p.', 'p brum'],
  'Paulo Rocha Pinto' => ['paulo pinto', 'rocha pinto',
    'j.p.rocha pinto'],
  'P.C. Gupta' => ['p c gupta'],
  'Pedro Madeira' => ['p. madeira', 'p madeira'],
  'Pedro Morbey' => ['p. morbey'],
  'Pedro Russo' => ['russo p'],
  'Petra Hamman' => ['p hamman'],
  'Phyllis Fireman' => ['ph fireman'],
  'Piedade C. Real' => ['piedade c.real'],
  'Prakash Bandhari' => ['prakash bhandari'],
  'Prashant Desai' => ["prashant desai's"],
  'Promila Saraf' => ['promila sorof', 'promils sarif',
    'promils saraf'],
  Prusa => ['prusa m'],
  'R.K. Sinha' => ["r k sinha'siv", "r k sinha's lv", 'r k sinha'],
  'R.L. Kejriwal' => [
    'r l kejriwaal', 
    'r l kejriwal', 
    'r l kejriwal m c', 
    'r.l.kejriwal mc', 
    'r.l.kejriwal', 
    'rl kejriwal mc',
    'r. l. kejriwal'],
  'Ratan Lal Sanghi' => [
    'dr sanghi', 
    'dr. sanghi', 
    'dr.sanghi',
    'dt sanghi', 
    'r l sanghi', 
    'r.l.sanghi',
    'dr rl sanghi', 
    'dr rl sanghvi'],
  'Raul Guerreiro' => ['r guerreiro'],
  'Razvan Andrei Gheorghe' => ['gheorghe r'],
  'Rita Choksi' => ['rita chokshi'],
  'Rodrigo Suares' => ['rodrigo soares'],
  'Ronnie Benin-Barr' => ['roni barr', 'barr-benin'],
  'R.S. Mishra' => ['r.s.mishra'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Rui Silva Santos' => ['rui santos', 'silva santos',
    'rui s. santos'],
  'Rúnar Einarsson' => ['runar einarsson'],
  'Salim Yilankiran' => ['yilankiran'],
  'Sally Brock' => ['s brock'],
  'Satish Diwanji' => ['col. diwanji'],
  'Shahar Zack' => ['zack shachar', 'zack s',
    'zavk shachar'],
  'Shih Yeh' => ['yeh shih'],
  'Shlomo Netzer' => ['netzer shlomo'],
  'Shree Priya' => ['sree priya'],
  'Signe Buus Thomsen' => ['s.buus-thomsen',
    's. buus-thomsen'],
  'Sigurdur Vilhjalmsson' => ['sigurður vilhjálmss'],
  'Sinan Göksu' => ['sinan goksu'],
  'Sofia Costa Pessoa' => ['s.pessoa', 'sofia pessoa'],
  'Sunil Machhar' => ['sunil machar', 'sunil macchar',
    'sunal macchar', 'sunil maccher', 'sunil.macchar', 's machhar'],
  'Sverrir Þórisson' => ['sverrir þ'],
  'T.V. Joshi' => ['t v joshi'],
  'Teixeira-Reus' => ['txecs-reus', 'txec-reus'],
  'Teresa Kay' => ['t.kay'],
  'Tone Torkelsen Svendsen' => ['t svendsen'],
  'Udi Friedlander' => ['friedlander udi'],
  'Uri Gilboa' => ['gilboa uri', 'gillboa uri'],
  Vahalia => ['dr.vahalia'],
  Vithaya => ['dr.vithaya'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vijay K Khan' => ['vijay k klan'],
  'Thomas Vang Larsen' => ['van larsen', 'vang larsen',
    'vang-larsen', 'vanglarsen'],
  'W.W. Cho' => ['WW Cho'],
  'Waleed El Ahmady' => ['el ahmady'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward-pratt'],
  'Wei Sender' => ['wei-sender'],
  'Weidong He' => ['he wei dong'],
  'Wing Hung Fok' => ['w h fok'],
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
  Avci Avcioglu Avon Awad Ayda 

  Babacan Babsch Baiche Baietto Bailey Bajraj Baker Bakhshi 
  Bakke Bakkeren Baldini Baldysz Ballebo Banikas Baran 
  Barbone Barbosa Barel Barion Baris Baron Bart Bartley
  Barton Basabe Baseggio Basile Bassini Bathurst Batov Bauch Bavaresco 
  Baybarut Bayes Baze Bäckström Beauchamp Beale Beatty Beaumier
  Beauvillain Becker Bell Bello Bellosta Belonogov Benassi Bennett 
  Berdichevsky Berg Berger Bergheimer Berkowitz Berktas Berlinski 
  Berman Bernard Bernasconi Bernstein Berrettini Bertens Bertheau 
  Bertolucci Besiris Bessis Bettini Beyer 
  Biagiotti Bilde Bilski Binderkrantz Bingol Biondillo Biondo 
  Bird Birin Birkelund Bittner Bitran Bizer Bjarnarson Bjerkan 
  Bjornlund Black Blackstock Blakeman Blakset Blanchard Blandin 
  Bley Bloom Blum Blumental Bo Boaz Bocchi Bock Bogach Bogacki 
  Bohnhorst Bohnsack Bokk Bojoh Boldt Bolling Bolognini Bombardieri 
  Bomber Bompis Bongiovanni Bonis Bonori Bontas Booth Bordallo Bos 
  Bose Bostosusz Botto Boucher Boughey Bourdin Bourke 
  Bowdery Bowles Boylson Bozempergk Bozzetto Bozzo
  Brachman Brady Brake Braithwaite Bramley Brantsma Branzoiu
  Braun Brede Brenner Bretagne Brifman Brightling Brink Brockwell 
  Brod Brogeland Brown Brunet Bruun Brunzell Bryant Buch Buchen 
  Buchlev Budkin Bunk Buras Burrows Burgay Burke Buscaglia Buse 
  Busse Butland Butts Byrne Bytskevich Börgesson

  Cabiati Caggese Calandra Caldarelli Caley Caldwell Callaghan Callander
  Camacho Camberos Cambiaghi Campos Capayianides Capitani Caplan 
  Caposiena Cappelli Cappeller Caprera Capriata Caracci Caramalli
  Cardine Carbonnier Carcy Carmichael Carrasco Carruthers Carvalho 
  Casabona Casadei Casen Cassini Castelblanco Castelli Castells 
  Castner Cattani Cavalieri Cayne Cengiz Cernat Cernato Cernatovo 
  Cerreto Cesati Chadwick Chai Chamberlain Chambers Chan Chang 
  Charletoux Charlotte Charlsen Chassagne Chauvelot Chediak Cheek 
  Chemla Cheng Chinchak Chizzoli Chopin Chottin Chrapot 
  Chubukov Ciccarelli Cichocki Ciechomski Cilleborg Cimon Cintra 
  Cionca Ciopettini Civale Cladius Clair Claret Clark Clarke Clausen 
  Clement Clemmensen Clemont Clerkin Close Coenraets Coglitore 
  Cohen Cohler Cohner Colarossi Coldea Cole Coletta Collett Collins 
  Combes 
  Combescure Compton Connie Conti Cook Cooke Cooper Cooreman 
  Cope Coren Coridakis Corlateanu Cormack Corssen Cossutta Counil 
  Courtney Coutts Coyne Creet Crestey Creuheras Crichton Crompton 
  Cronier Crouch Crzejdziak Cuevas Cullin Cummings Cuper Curo 
  Çýloðlu Czímer

  Dabrowka Dahlberg Dalecki Dalia Dalley Damiani Damkor Dancewicz 
  Danta Dantan Darak Daskalakis Daugava Dauvergne Davies 
  Dawson Debolina Debonnaire Debus Dechelette Dehaye Deik 
  Deleeuw Delestre Delfino Delfour Delibaltadakis Dellecavakis 
  Delimpaltadakis Delpiano DeMartino Demir Demirbas Demme Denning 
  Deniz Desai Deutsch Dexterzy Dialinas Dionysopoulos 
  Dhir Dhondy Dialynas Diamond Dilks Dinkin Dixon 
  Djurovic Dobbels Dobes Dobroiu Doecke Dolla Donatella 
  Donciu Donn Donzi Dossena Dovell Doub Doussot Doxiadis Drijver 
  Driver Dubini Duguet Duman Dumbovich Dumitrasciuc Dunitz Dunn 
  Duong Dupraz Dupuis Dupuy Durisotto Dutilloy Dworan Dyke

  Eaton Eber Ebery Economou Edgtton Efremov Efthimiou Eggeling 
  Eide Eidi Eidingsen Eisenberg Ekeblad Eksi Ekþi Elbaz Elias 
  Ellestad Ellia Engel Elinescu Enrique Ergil Erhart Erichsen 
  Eriksson Erk Erkel Erkin Espiasse Esterson Esteruelas Evans 
  Ewart Eykt

  Fabbri Fagerlund Faidas Faigenbaum Failla Faivre Falay Falciai Falk 
  Fallenius Fallon Fantonakis Fantoni Farholt Faria Farias Farstad
  Farwell Favard Federighi Fegarty Feiler Fent Ferenci Fergani 
  Ferramosca Ferrara Ferrari Fettes Fici Figlus Figueiredo 
  Filikci Filios Filip Finikiotis Finz Fioretti Fireman Firestone 
  Fleisher Fleury Flierl Flock Flora Fogaras Fonseca Fordham 
  Fornaciari Fornasari Forrester Fortini Fossi Foster Fournier Fout 
  Fox Franceschetti Franchi Fraser Frazer Frazzetto Frencken 
  Fredin Freed Frey Friedland Friedlander Friis Frosztega 
  Fruewirth Frukacz Frutos Fu Fucik Fuglestad Fuller Fung Furunes 
  Furuta Fyrun

  Gaede Gagliardi Gaglietto Gardiner Galinsky Gallus 
  Gana Gandoglia Ganzer Garateguy Garbosi Garg Garoufalis Garrido 
  Garrone Garvey Garner Gartaganis Gary Gaspar Gaviard Gawel Gawrys 
  Gelberg Geller Genc Generosi Gentili Georgescu Gerber Gerli 
  Gero Gerrard Geyer Gezer Ghionis Giangkos Giannessi Gidman 
  Gierulski Gigliotti Gilboa Gill Ginnan Ginossar Gioia Gitelman 
  Giura Gladiator Glanger Glasson Glopson Glyssner Gobbi Goded Gold 
  Goldberg Goldenfield Goldman Goldstein Golebiowski Gomerov Gomes 
  Goodman Goraco Gordon Goren Gosney Gotard Gottlieb Goyal Göthe 
  Grabel Grabowska Gradignan Gradovsky Grainger Gramberg Granda
  Greenberg Greenwood Grenside Grenthe Griffey Griffin Griffoni 
  Griffiths Grimeton Grigoriu Grimaldi Grisho Groenenboom Gromov Gromova 
  Gross Gromöller Gronaldo Grue Gruia Grunt Gruschow 
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
  Huang Huberschwiller Hughes Hugon Hugony Hult Hung Hupe Hurworth 
  Hyatt Høgis Høyland 

  Iacapraro Ichilcik Ilczuk Ilmez Ince Indemini Indzheva Ingielewicz 
  Iommi Iontzeff Irens Ishidaya Ivatury Iversen Ivrig Iyer Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jahnsen Jalowka Jamieson
  Janicki Janik Jankova Janiszewski Janowski Jansma Janssen Jarlot 
  Jassem Jawell Jayganesh Jedrychowski Jeng Jensen Jepsen 
  Jezioro Joel Johansson Johnson 
  Jolly Jokisch Jones Jotcham Junqueira Jussila Juutilainen

  Kabra Kachchu Kageling Kahyaoglu Kahn Kaiser Kalida Kalita Kalish 
  Kallifronas Kallsberg Kallunki Kalma Kalmin Kamat Kambancho 
  Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kane Kanetkar 
  Kang Kapagiannidis Kaplan Kaptan Karamanlis 
  Karavil Karayel Karlaftis Karpouzelis Kasapoglu Kasday Kasle 
  Kasler Kastel Kater Katsareli Katsutake Katz Kaushik Kay Kaya 
  Kaye Kazik Kazmierczak Keegan Kendrick Kenigsberg Kennedy Kenny 
  Kent Keremida Kersey Kesgin Khandelwal Khazanov Khyuppenen 
  Kilani Kilvington King Kiran Kiriakidoy Kirilenko Kishan 
  Kizikli Klapper Klimacki Klimentowska Klinger Klofa Klukowski 
  Knap Knight Kocak Koistinen Koivula Kokkes Koken Kokten 
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
  Leenhardt Legras Leiro Lena Lencastre Lengy Leptirici Lerner 
  Lesniewski Lesnik Lester Lev Levi Levinger Levin Levine Levoy 
  Levski Lewis Lhuissier Li Lian Libbrecht Libman Lie Lien 
  Liu Liggins Lilienstein Lillevik Lilley Limor Linczmayer Lindner 
  Lindstedt Llopart Locatelli Lockwood Longinotti 
  Lorentz Lorenzini Loreto Lormant Louchart Lovrecz Lowe Lubinski 
  Lucchesi Lucignano Ludewig Lund Luppi Lusk Lusky Lüßmann Lynch 
  Lyngen

  Maas MacDonald Macedo Machado Madsen Magee Maggio Maglietta 
  Mahaffey Maia Maiolani Malarme Maksymetz Malaczynski Malani 
  Malavasi Maluish Mamidaki Manara Mancuso Mandecka Mandelot Mane 
  Manfield Manganella Mangelrød Manglik Manni Mannix Mantica 
  Manyawar Maoilani Marani Marashev Marchioni Marek Margarida 
  Margiotta Mari Marill Marina Marincho Marinescu Marino Markey 
  Markowicz Marks Marmonti Marquardsen Marsonis Marston Marta 
  Martel Martellini Martens Martin Martini Martins Marupe Masana 
  Masini Mason Matei Matheson Matisons Matteucci Matushko 
  Mauberquez Mavridis Mayorga Mazurkiewicz Maybach Mäkikangas 
  Märsylä McAllister McCance McDonald McGann McGinley McGowan 
  McGrath McIntosh McKellar McLeish McLeod McKinnon McLeish 
  McManus McMahon McMullin McNamara Meckstroth Medik Medugno 
  Medved Mehech Mehrez Mejane Mello Mendoza Meltzer Merah 
  Merblum Mesbur Messika Mestres Metselaar Meyer Meyers 
  Meyouhas Mezei Michaud Michealakis Mickiewicz Miles Milgrim 
  Mill Millar Miller Milne Milner Mina Miner Minzli Miozzi 
  Miroglio Miszewska Mitra Mittelman Mirali Miura Mizel Mizrak 
  Mohota Mohtashami Molenaar Molenda Molina Molva Monachan 
  Moni Monsegur Montanari Mooney Moran Morath Morawski Moreira 
  Morelli Morgan Mori Moritsch Morris Morrison Morse Mortensen 
  Moses Moskovsky Mossop Mott Mouiel Mourgues Mpampou Mpanikas 
  Mpompolakis Mucha Mueller Mullamphy Muller Multon Mundell 
  Munksgaard Munson Munteanu Muntz Muriel Murray Mus Mutiara 
  Muzzio Mýzrak Mæsel Mønsted

  Nab Nadar Nader Naels Nagy Nahmias Naimuddin Naito Naniwada
  Narasimhan Naqvi Nardullo Natale Navneet Neale Negrin 
  Neill Nencini Netto Neuhauser Neulinger Neve Newell Newman 
  Ng Nickell Nieminen Nikolenkov Nikolov Nilsson 
  Nimhauser Ninos Nixon Nobel Noble Nordby Novoski Nowicki Nowosadzki 
  Nuñez Nørgaard Nunes Nunn Nussbaum Nyshchyi Nystrom
  
  O'Brien O'Gorman O'Shea Ohno Ohrysko Oikonomou Oikonomopoulos
  Olanski Olker Ollikkala Olofsson Olsen Omran Oncu O'Rourke Ortega
  Onstott Orhan O'Shea Osaulenko Osofsky Oteyza Otvosi Oursel 
  Outred Ozarar Ozbey Ozdil Ozenir Ozge Ozlen Ozsahin Ozturk Östberg 
  Özbey

  Pacareu Pacault Pacini Paganus Paiva Pajak Paladino Palatinus 
  Palau Palmeira Palmer Pals Panagaki Panto Panopoulos Papahatzis 
  Papakyriakopoulos Papaxatzis Parker Partearroyo Parviainen Pasquarè
  Passarinho Passaro Passell Pastore Pattinson Pattison Paulissen 
  Pauncz Pavlicek Payen Pazur Peake Pedzinski Peirão Pekkinen Peksen 
  Penfold Percario Pereira Peres Periasamy Perisic Persiani Petculescu 
  Petrescu Pettersson Phelan Piasecki Piedra Piekarek 
  Pietraszek Piganeau Pilon Pineles Pinguello Pinto Piper Pisak 
  Pisani Pitt Plaut Poizat Pollack Pollak Polledro Polowan 
  Pont Popescu Popova Potier Potts Poulat Pownall Pozzi Pradhan 
  Preddy Prescott Previde Priano Primavera Proukakis Procter 
  Prohorov Prusa Pryor Puczynski Pulkrab Purkarthofer Pszczola

  Quail Quantin Queran Quinn

  Rabinowitz Radcliffe Radikk Radin Radisic Rajagopal Ramamurthy 
  Ramchandran Ramondt Rankin Ranklin Ranson Rapp Rashti Rau Raulund 
  Ravenna Rayner Rebecchi Rees Reess Rehder Reid Reimer Reinholdt 
  Reiplinger Rekstad Renouard Reps Revaz Rew Reynolds Rheingold 
  Ribera Ribery Ricard Ricci Richardson Richman Ridgway Riedel Riehm 
  Rietvink Rieusset Rigal Rigaud Riisnæs Rimstedt Ringuet Riolo Rios 
  Ritmeijer Rivers Rizzo Robb Robertson Robinson Robles 
  Robson Rocafort Rocca Rodwell Rogoff Rohowsky Rolfmeyer Roll Rolland
  Romanin Romanski Rombaut Ronin Rosen Rosenberg Rosendorff Rosetta 
  Rosenkrantz Rosenthal Rossi Rosti Rothfield Rothstein 
  Roussoglou Roussos Rubiés Rubin Rubins Rubio Rueda Ruia Russo Ryman

  Sabbag Sabbatini Sadek Saelensminde Saesseli Sahin Saina Sairanen 
  Sakirler Sakr Salama Salisbury Salliere Salman Salvador Sancaktar
  Sandberg Sanden Sandqvist Sankichi Sansom Santos Saporta 
  Sapounakis Sargos Sarten Sarundajang Sauvage Savchenko Savelli 
  Savorani Savski Sawicki Sayaca Saydi Sayer Sayilkan Sayýlkan Sbarigia 
  Scanavino Scerri Schaltz Scherders Schermer Schlicker Schneider 
  Schnetzer Scholes Schonning Schoolmann Schuett Schulle 
  Schulz Schüller Schroeder Schreckenberger Scoltock Scudder 
  Scullin Schwartz Schwerdt Sealy Sebbane Seguineau Selberg Selcuk 
  Seligman Selway Semenov Semerci Sen Serenella Serf Serifoglu 
  Serpoi Sesyilmaz Setton Sezginsoy Shadyro Sharif Sharp Sher 
  Sherman Shezifi Shields Shiels Shimamura Shimizu Shirogane Short 
  Shudnev Shugart Shunta Silver Silverstein Silverstone Sime 
  Simonsen Simpson Simson Sinclair Sivrioglu Sjodal Sjöqvist 
  Skaanning Skelton Skjønnemann Skoglund Skorchev Skurec Skwark 
  Small Smart Smilgajs Smith Smirnov Smolanko Snashall Snellers 
  Snow Socha Sohlin Soldati Solheim Solimando Solodar Sonsini 
  Soriano Sorkin Sosler Soukup Soulet Sowter Sörvoll Spangenberg 
  Spector Spelmans Spiridonescu Spitalnick Spooner Sprung Squires 
  Stabell Stamatov Stankovic Stansby Stark Stavrinos Steel 
  Stegaroiu Steiner Stensson Stephenson Stern Steinberg Sternberg 
  Stevens Stewart Stienen Stilling Stoichkov Stokka Stoltz Stoppa 
  Street Stretz Strul Strøm Stuart Sulgrove Sveindal Sveinsson 
  Svendsen Suarez Sugino Summers Sundelin Sundsten Sung Suñol 
  Suresh Sutherlin Suwik Sütmen Svindahl Swarup Sweidan Sykioti 
  Sylvan Symons Syversen Szalay Szenberg Szigethy Szots 
  Szymanowski Sørensen

  Tachev Tajima Talpur Tamburi Tamburrini Tan Tanaka Taner 
  Tardy Tarhan Tarkunde Tarnovski Tasman Taylor Tebha Tedd 
  Teltscher Tembouret Tencer Teodorescu Teramoto Terraneo Tesla Tez 
  Thapa Thomsen Thompson Thomson Thoresen Thuillez Thurston Ticha 
  Tishler Tislevoll Todd Toffier Toivonen Tokay Torielli Toro
  Tosi Townsend Trabucchi Travis Triana Tritt Troberg Tsang Tsilis 
  Tubiska Tucker Tudor Tulin Tully Tuomi Turner Tuszynski Tuwanakotta 
  Türkoðlu Tyradelli Tøndel

  Ucar Ueland Uggeri Ultav Una Upmark Uskali Uskela Usluduran Utter 
  Uysal

  Vahaboglu Vahalia Vainikonis Valeanu Valio Valta Vanchev Varadi 
  Varenne Vasarhelyi Veloni Venetina Venkatesh Verbeek Verhees 
  Vernay Versace Versluis Viale Viana Vidigal Viennois Vidalat
  Videv Vigil Vihtilä Vilella Villegas Vinay Vincent Vinciguerra 
  Virvidakis Vitas Vithaya Vogt Voinescu Volcker Vorobei Vriend 
  Vroustis Vucic

  Wademark Waledzik Walker Walsh Wang Ware Warne Wasik Watawe 
  Waterlow Waters Watkins Watts Watve Weber Weed Weiler Weingarten 
  Weingold Weinhold Weinstein Weisinger Welland Weltzer Werdelin 
  Wesolowska Westerlund Westheimer Westra Westwood Whibley Whiting
  Wiankowski Wigoder Wijma Wikstrom Wildavsky Willcox Wilkinson 
  Willenken Williams Willis Wilson Wiltshire Winciorek Winkler
  Wit Witek Wittes Wold Wolfarth Wolff Wolfson Wolpert Woodruff 
  Woolsey Worm Wortel Wrang Wu Wyer

  Xatzimpalis

  Yadlin Yalman Yamada Yang Yarington Yates Yergýn
  Yezerski Yildiz Yilmaz Ying Yokoi Yoleri Yuen Yule

  Zabunoglu Zago Zagor Zagorin Zajac Zakarian Zaleski Zanalda 
  Zambonini Zaninotti Zarkesch Zatorski Zawada Zawislak Zeeberg 
  Zenari Zhan Zhao Zhaoheng Zhong Zhukov Zielinski Zimmermann 
  Zipovski Zobu Zochowska Zollo Zolotov Zorlu Zotti Zozis Zotos 
  Zwart

  Övelius Özþahin
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
  'Alan Mould' => ['mould'],
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  'Alvares Ribeiro' => ['luisaribeiro'],
  'Amiya Ranjan Das' => ['das'],
  'Aniket Sanghvi' => ['aniket'],
  'Antonio Frances' => ['frances', 'francés'],
  Arcieri => ['arceri'],
  'Arunas Jankauskas' => ['arünas'],
  Avcioglu => ['avcýoðlu', 'avcioðlu'],
  Bartley => ['bartly'],
  Beale => ['beatle'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bertheau => ['berthau'],
  Blumental => ['blummental'],
  Bocchi => ['norby'],
  Bojoh => ['bujoh'],
  'Brigitta Fischer' => ['fischer'],
  Brogeland => ['broge'],
  'Buddy Shah' => ['buddy'],
  Bytskevich => ['bytskevitch'],
  'Carlos Ferreira' => ['ferreira'],
  'Carole Puillet' => ['puillet'],
  'Chalermpol Wongwaiwit' => ['chalermpol'],
  'Christal Henner-Welland' => ['henner'],
  'Christophe Grosset' => ['grosset'],
  Ciechomski => ['ciechomek'],
  Combescure => ['combescur'],
  Cooreman => ['cooremans'],
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
  'Doxiadis' => ['doksiadis'],
  "D'Orsi" => ['dorsi'],
  Dumbovich => ['dumbovic'],
  Eisenberg => ['einsenberg'],
  Eksi => ['ekþý'],
  'Edmund Tse' => ['tse'],
  'Erlend Skjetne' => ['erlendskjetne'],
  'Waleed El Ahmady' => ['elahmady', 'elhamady'],
  Failla => ['faill'],
  'Francisco Costa-Cabral' => ['cabral'],
  Franceschetti => ['franceschett'],
  'G. Limmen' => ['limmen'],
  'Gabriel Chagas' => ['chagas'],
  Gartaganis => ['gartaginas'],
  Garoufalis => ['garoufallis'],
  'Evgueni Gladysh' => ['gladysch', 'gladysh'],
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
  Huberschwiller => ['huberschwi'],
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
  'Jorge Petrucci' => ['petrucci'],
  'Josef Blass' => ['blass'],
  'José Moraes' => ['moraes'],
  'Jörg Fritsche' => ['fritsche', 'joefri'],
  'Juan Carlos Ventin' => ['ventin'],
  Kaminski => ['kaminsky'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Kapagiannides' => ['kapagiannides'],
  Karamanlis => ['karamanli'],
  Karlaftis => ['karlaytis'],
  'Kasper Konow' => ['konow'],
  Kazik => ['kazic'],
  'Ken Ford' => ['ford'],
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
  'Lotan Fisher' => ['fisher'],
  'Luis Oliveira' => ['oliveira'],
  Lyngen => ['lyn'],
  Maas => ['mass'],
  'Maria João Lara' => ['lara'],
  Mahaffey => ['mahafey', 'mahaffee'],
  Mane => ['mané'],
  'Manoel Peirao' => ['manoel'],
  'Manuel Capucho' => ['capucho'],
  Manyawar => ['manyvar', 'manyavar'],
  'Marc Kerlero de Rosbo' => ['kerlero'],
  'Marcelo Branco' => ['branco'],
  Markowicz => ['markovics', 'markowitz'],
  'Martine Rossard' => ['rossard'],
  'Maxim Henbest' => ['henbest'],
  'Maya Meera Sneha' => ['mayameerasneha'],
  Meltzer => ['metzler'],
  Mesbur => ['mesbor'],
  Meyers => ['myers'],
  'Miguel Teixeira' => ['teixeira'],
  Milne => ['mlne'],
  Milner => ['millner'],
  'Mohamed Manaf Saleh' => ['manaf'],
  Mohota => ['mohata'],
  'Mohsen Kamel' => ['mohsenkamel'],
  'Moni Diba' => ['monidiba'],
  'John Møller Jepsen' => ['møllerjepsen'],
  Narasimhan => ['narasinham'],
  Nowosadzki => ['nowosad'],
  'Nuno Damaso' => ['damaso'],
  Nystrom => ['nyström'],
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
  'Paul Fireman' => ['fireman'],
  'Paulo Goncalves Pereira' => ['pgp'],
  'Paulo Roberto Brum' => ['brum'],
  'Pedro Madeira' => ['pmadeira'],
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
  'Radu Nistor' => ['nistor'],
  'Raghavendra Rajkumar' => ['raghvendra'],
  'Rahul Ravichandran' => ['ravichandran'],
  'Ralitsa Mihaylova Mircheva' => ['ralitsa'],
  Ramamurthy => ['ramamurthi'],
  'Reinaldo Timoteo' => ['timoteo'],
  Richardson => ['rchardson'],
  Rietvink => ['reitvink'],
  Riisnæs => ['riisnes', 'riisnaes'],
  Rizzo => ['rizzp'],
  'Robyn Brazier' => ['brazier'],
  Rosenkrantz => ['rosenkranz'],
  Rosenthal => ['rosentahl'],
  Roussos => ['rousos'],
  Rubiés => ['rubies', 'rubie'],
  Rubin => ['rugin'],
  'Rui Silva Santos' => ['rss'],
  Ruia => ['ruya'],
  'Sainte Marie' => ['stemarie'],
  'Sally Brock' => ['brock'],
  'Salvatore Luceno' => ['lucenò'],
  Sapounakis => ['sapounaki'],
  Schaltz => ['schalz', 'shaltz'],
  Schneider => ['scheinder'],
  'Steen Schou' => ['schou', 'shhou'],
  Schüller => ['schueller'],
  Schwartz => ['schwarz'],
  Selcuk => ['Selçuk'],
  'Brian Senior' => ['serior'],
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
  'Sylvie Willard' => ['willard'],
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


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
