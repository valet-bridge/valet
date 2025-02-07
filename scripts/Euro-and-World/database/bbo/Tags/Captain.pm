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
  'A. Anderson',
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
  'Ana Brito',
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
  'Ariz Anklesaria',
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
  'Björk Jonsdottir',
  'Bora Unver',
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
  'Carolina Pimenta',
  'Chalermpol Wongwaiwit',
  'Charlie Lee',
  'Chen Yeh',
  'Choo Wai Wong',
  'Christal Henner-Welland',
  'Christophe Grosset',
  'Corte-Real',
  'C.V. Rao',
  'D Banerjee',
  "D'Avossa",
  'Da Rosa',
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
  'de Leo',
  'de Livera',
  'de Luca',
  'de Mendez',
  'de Michelis',
  'de Miguel',
  'de Monval',
  'De Muller',
  'de Tessieres',
  'Deepa Dhar',
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
  'Dinis Sottomayor',
  'Djordje Dunjic',
  'Dmitri Marchessini',
  "D'Orsi",
  "D'Ovidio",
  'Dr. Anand',
  'Dr. Ashwani Mehta',
  'Dr. Behre',
  'Duronto Rajshahi',
  'Ece Mizrahi',
  'Edmund Tse',
  'Eduardo Pinto',
  'Efrat Oren',
  'El Baz',
  'Ellena Moskovsky',
  'Emil Thomsen',
  'Enrique Pinto',
  'Erdal Tekin',
  'Erik Wied',
  'Erikas Vainikonis',
  'Eriko Matsuo',
  'Erla Sigurjónsdóttir',
  'Erlend Skjetne',
  'Espinosa Paz',
  'Evgueni Gladysh',
  'Ewa Lasting',
  'F.P. Goncalves',
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
  'Hon Hu',
  'Hong Ju',
  'Hong Hu',
  'Hong Niu',
  'Hong Ru',
  'Huijun Song',
  'Ilan Herbst',
  'Ilko Popov',
  'Ingvar Erga',
  'Inocencio Almeida Araujo',
  'Inon Liran',
  'Ivan Abel',
  'J. Brigido',
  'J. Pereira de Sousa',
  'J. Pinheiro',
  'J. Thompson',
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
  'Jimmie Feidie Eman',
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
  'Jose Carlos Sousa Santos',
  'José Dias',
  'José Moraes',
  'José Pastor',
  'Jozef Pochron',
  'Jörg Fritsche',
  'Jörgen Lindqvist',
  'Juan Carlos Ventin',
  'Juan Huertas',
  'Juan Valdez',
  'Juei-Yu Shih',
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
  'Kirubakara Moorthy',
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
  'La Chapelle',
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
  'M. Triana',
  'Mads Eyde',
  'Magnus Moren',
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
  'Miguel Sarmento',
  'Miguel Silva',
  'Miguel Sousa Guedes',
  'Miguel Teixeira',
  'Mikael Arnberg',
  'Mikud Mannid',
  'Mila Senior',
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
  'N. Gupta',
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
  'Qi Quan',
  'Qiao Ge',
  'Qiao Meng',
  'Qiao Xie',
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
  'Roberto Barbosa',
  'Robyn Brazier',
  'Rodrigo Suares',
  'Ronnie Benin-Barr',
  'Rouanet Labbe',
  'Rui Pinto',
  'Rui Silva Santos',
  'Rúnar Einarsson',
  'Rusen Abi',
  'Ruyi Qiu',
  'Sadek Radwan',
  'Sainte Marie',
  'Sally Brock',
  'Salvatore Luceno',
  'Sanat Roy',
  'Sandip Chatterji',
  'Sandra Batista',
  'Sanjay Bhattacharya',
  'Sara Silva',
  'Sarah Combescure',
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
  'Sveit Snorra Karlsonar',
  'Sylvie Willard',
  'T. Debonnaire',
  'T.V. Joshi',
  'Teixeira-Reus',
  'Teresa Kay',
  'Thomas Vang Larsen',
  'Tiago Canelas',
  'Tomas Ruth',
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
  'Van Eijck',
  'Van Elsuwé',
  'Van Gestel',
  'Van Helsing',
  'Van Hoof',
  'Van Lankveld',
  'Van Riel',
  'Van Zwol',
  'Varsha Jain',
  'Véronique Bessis',
  'Vesth-Hansen',
  'Vijay Anand Singh',
  'Vijay K Khan',
  'Villas Boas',
  'Vinay Mohan Lal',
  'Vincent Li',
  'Visalakshi Narayanan Ramamoorthy',
  'Viviane Gonçalves Pereira',
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
  'Ana Brito' => ['a brito'],
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
  'Ariz Anklesaria' => ['ariz ankesaria'],
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
  'Deepak Poddar' => ['dippak poddar'],
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
  'F.P. Goncalves' => ['f.p.goncalves'],
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
  Hill => ["hill's"],
  'Hiroki Yokoi' => ['yokoi hiroki'],
  'Hiroya Abe' => ['abe hiroya'],
  'Hjordis Eythorsdottir' => ['hjordis eythorsdott'],
  'Hjordis Sigurjonsdottir' => ['hjordis sigurjonsdo'],
  'Huijun Song' => ['hui song'],
  'Hong Ju' => ['hung ju'],
  'Hong Ru' => ['hung-ru', 'hong-ru'],
  'Ilan Herbst' => ['herbst i', 'herbst ilan', 'herbsr ilan'],
  'Inocencio Almeida Araujo' => ['inocencio arauj', 'inocêncio araújo',
    'inocencio'],
  'Inon Liran' => ['liran inon'],
  'J. Thompson' => ['j thompson'],
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
    'j castanheira',
    'j.castanheira'],
  'Jorge Cruzeiro' => ['j cruzeiro'],
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
  'Luis Alvares Ribeiro' => ['l.a. ribeiro', 'l a ribeiro'],
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
  'Miguel A. Ribeiro' => ['miguel ar'],
  'Miguel Sousa Guedes' => [
    'm. sousa guedes',
    'miguel s guedes', 
    'miguel s. guedes',
    'miguel s g',
    'miguel sg',
    'sousa guedes'], 
  'Miguel Teixeira' => ['m. teixeira', 'm.teixeira', 
    'm teixeira'],
  'Mikael Arnberg' => ['Arnbergs team'],
  'Mikud Mannid' => ['mikud-mannid'],
  'Mila Senior' => ['mila senyor'],
  'Mohit Mehta' => ['mohit mehata', 'mohit meheta'],
  'Monica Jajoo' => ['monika jajoo', 'm.jajoo'],
  'N. Chakraborty' => ["n.c hakraborty's iv"],
  'N.R.K. Moorthi' => ['n r k moorthi'],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  'Nathan van Jole' => ['van jole'],
  'Nevena Senior' => ['n senior'],
  'Nuno Paz' => ['n paz'],
  'Nuno Sousa' => ['n sousa'],
  "O'Rourke" => ['o rourke', 'o;rourke', "o'rouke"],
  'Ofek Tal' => ['ofel tal'],
  'Olivier Bessis' => ['bessis.o'],
  'Ömer Abi' => ['omer abi'],
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
  'Roberto Barbosa' => ['beto barbosa'],
  'Rodrigo Suares' => ['rodrigo soares'],
  'Ronnie Benin-Barr' => ['roni barr', 'barr-benin'],
  'R.S. Mishra' => ['r.s.mishra'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Rui Silva Santos' => ['rui santos', 'silva santos',
    'rui s. santos'],
  'Rúnar Einarsson' => ['runar einarsson'],
  'Ruyi Qiu' => ['qiu ruyi'],
  'Sainte Marie' => ['ste mar'],
  'Salim Yilankiran' => ['yilankiran'],
  'Sally Brock' => ['s brock'],
  'Sarah Combescure' => ['me combescure'],
  'Satish Diwanji' => ['col. diwanji'],
  'Shahar Zack' => ['zack shachar', 'zack s',
    'zavk shachar'],
  'Shih Yeh' => ['yeh shih'],
  'Shlomo Netzer' => ['netzer shlomo'],
  'Shree Priya' => ['sree priya'],
  'Signe Buus Thomsen' => ['s.buus-thomsen',
    's. buus-thomsen'],
  'Sigurdur Vilhjalmsson' => ['sigurður vilhjálmss'],
  'Sinan Abi' => ['ahi sinan fagsk'],
  'Sinan Göksu' => ['sinan goksu'],
  'Sofia Costa Pessoa' => ['s.pessoa', 'sofia pessoa'],
  'Sunil Machhar' => ['sunil machar', 'sunil macchar',
    'sunal macchar', 'sunil maccher', 'sunil.macchar', 's machhar'],
  'Sveit Snorra Karlsonar' => ['sveit snorra karls'],
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
  'Véronique Bessis' => ['mme bessis'],
  'Vijay K Khan' => ['vijay k klan'],
  'Vinay Mohan Lal' => ['v m lal'],
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
  Aagaard Aarmot Aatorp Abbani Abe Abdimanoglu Abecassis Abel 
  Abouchanab Adad Adams Adamsen Adde Adem Adrei Adriano Adrilla 
  Agarwal Agenes Aggelopoulos Agica Agnihotri Agostini Akama Akem 
  Aker Akgul Akgun Akhun Akkab Akkoyunlu Akl Aksuyek Akuzum Alami 
  Alboga Alegre Alegrio Alela Alfonsin Alineo Allana Allavena 
  Allegaert Allegra Allfrey Alliot Allison Allix Alloul Almirall 
  Alocchi Aloi Alonso Alp Alpert Altan Alti Altinis Altshuler Alujas 
  Alvensleben Amadori Amaral Ames Amoedo Amoils Amol Anderson 
  Andersson Andrasi Andrea Andrei Andreoli Andresen Andrew Andrews 
  Angeleri Angelini Angelopoulos Anoyrkatis Antas Antmen Antoniou 
  Ao Aoye Apfel Appleton Apteker Aranha Araszkiewicz Araujo Arcieri 
  Arf Argelazi Arle Arnone Aroix Armstrong Arslan Artuffo Arun 
  Arutiunianc Asakoshi Ash Ashberg Ashe Ashworth Ashton Askgaard 
  Asmeniadis Assael Assemi Atalay Atabey Atay Athanasiadis Attaguile 
  Aubonnet Auerbach Auken Aust Austberg Avci Avcioglu Avon Awad 
  Aybar Ayda Azzahra Azzolini

  Baba Babacan Babsch Bach Bahbout Baiche Baietto Bailey Bajraj Baker 
  Bakhshi Bakke Bakkeren Baldi Baldini Baldursson Baldysz Balian 
  Ballebo Bamehrez Banach Bangur Banikas Baniri Baran Barantiev Barban 
  Barbone Barbosa Barda Bardin Barel Barion Baris Baron Baroni Barr 
  Bart Bartley Barton Basabe Basaran Bascunan Baseggio Baskan Basile 
  Bassini Bates Bathurst Batov Battaglia Bauch Baumier Bausback 
  Bavaresco Baybarut Bayes Baze Bäckström Beach Beauchamp Beale 
  Beatty Beaumier Beauvillain Becker Beckman Bedi Bedouet Bell 
  Belladonna Belli Bellicaud Bello Bellosta Belonogov Benassi Bende
  Bennett Berdichevsky Berg Berger Bergheimer Berkowitz Berktas 
  Berrington Berlinski Berman Bernabei Bernard Bernal Bernasconi 
  Bernstein Berrettini Bertens Bertheau Bertolucci Besiris Besnault 
  Bessis Bettini Bettiol Beyer Biagiotti Bianchedi Bianchi Bieder 
  Bijker Bilde Bilgin Bilici Bilski Binderkrantz Bing Bingol 
  Biondillo Biondo Bird Birin Birkelund Bitetti Bittner Bitran Bizer 
  Bizon Bjaring Bjarnarson Bjerkan Bjertnes Bjornlund Black 
  Blackstock Blakeman Blakset Blanchard Blandin Bley Bloch 
  Bloggs Bloom Blum Blumental Bo Boaz Bocchi Bock Boesgaard Bogach 
  Bogacki Bogucki Bohach Bohnhorst Bohnsack Bokk Bojoh Boldt Bolling 
  Bolognini Bombardieri Bomber Bompis Bonardo Bones Bongiovanni 
  Bonin Bonis Bonori Bontas Bookallil Booth Bora Bordallo Borker 
  Bortoletti Bos Boscardin Bose Bostosusz Botto Boucher Boughey 
  Bourdeau Bourdin Bourke Bouton Bowdery Bowles Boylson Bozempergk 
  Bozzetto Bozzo Brachman Brady Brake Braithwaite Brambilla Bramley 
  Brantsma Branzoiu Bratli Braun Brede Bremark Brenner Bretagne 
  Bretz Briciu Brifman Brightling Brink Brockwell Brod Brody 
  Brogeland Brogi Brown Brugnano Brunet Bruno Bruun Brunzell Bryant 
  Buch Buchen Buchlev Budkin Bunk Buras Buratti Burger Burgess 
  Burrows Burgay Burke Buscaglia Buse Busse Bussenot Butland Butts 
  Byrne Byrnes Bytskevich Börgesson Bållå

  Cabanes Cabiati Cafranga Caggese Cailliau Calandra Caldarelli Caley 
  Caldwell Callaghan Callander Camacho Camberos Cambiaghi Camerini 
  Cammarata Campagnano Campos Cannavale Capal Capayianides Capitani 
  Caplan Caposiena Cappelli Cappeller Caprera Capriata Caracci Caralp 
  Caramalli Cardine Carbonnier Carcy Carleton Carmichael Carnicelli 
  Carrasco Carruthers Carter Carvalho Casabona Casadei Casen Cassar 
  Cassini Castelblanco Castelli Castells Castner Cattani Cavalieri 
  Cayne Cazabon Cedrone Celli Cengiz Cernat Cernato Cernatovo Cerreto 
  Cerocchi Cesati Chadwick Chai Chalikon Chalupniczak Chamberlain 
  Chambers Chan Chang Charletoux Charlotte Charlsen Chassagne Chauvelot 
  Chediak Cheek Chemla Chen Cheng Chevalier Chinchak Chitlangia 
  Chizzoli Chmurski Chodacki Chopin Chottin Chow Chrapot Chubarova 
  Chubukov Chumakov Ciccarelli Cicek Cichocki Cichy Ciechomski 
  Cilleborg Cimon Cinar Cintra Cionca Ciopettini Ciszak Civale 
  Cividin Cladius Clair Claret Clark Clarke Clausen Clayton Clement 
  Clemmensen Clemont Clerkin Cliffe Clifford Close Coenraets Coglitore 
  Cohen Cohler Cohner Colak Colarossi Coldea Cole Coles Coletta 
  Collett Collins Colombo Colonna Colotto Combes Combescure Comella 
  Compton Connie Conti Cook Cooke Cooper Cooreman Cope Corallo Coren 
  Coridakis Corlateanu Cormack Cornell Corssen Cossutta Costa Counil 
  Courtney Coutts Covarrubias Coyne Creet Crestey Cruise Creuheras 
  Crichton Crompton Cronier Crouch Crzejdziak Cuevas Cullen Cullin 
  Cummings Cuper Curo Curtis Cury Çýloðlu Czajka Czímer

  Dabrowka Dabrowski Dagistanli Dahlberg Dai Dalecki Dalia Dalley 
  Damgaard Damiani Damkor Dancewicz Danielsen Danta Dantan Darak 
  Daraktchiev Darling Daskalakis Daugava Dauvergne Davies Dawson 
  Debolina Debonnaire Debus Dechelette Dedehayir Dehaye Deheeger Deik 
  Delaney Deleeuw Delestre Delfino Delfour Delibaltadakis Dellecavakis 
  Delimpaltadakis Delmas Delpiano Demarco DeMartino Demir Demirbas 
  Demirev Demme Denning Deniz Denizci Deprati Desai Dessy Deutsch 
  Dexterzy Dialinas Dionysopoulos Dhir Dhondy Dialynas Diamond Dilks 
  Dima Dinkin Dixon Dizdar Djurovic Dobbels Dobes Dobrescu Dobroiu 
  Doecke Dogan Dolla Don Donatella Donati Donde Donciu Donn Donner 
  Donzi Doria Dossena Douglas Dovell Doub Doussot Doxiadis Doyle 
  Drijver Driver Dubini Duckworth Dufau Duguet Duman Dumbovich 
  Dumitrasciuc Dunitz Dunn Dunne Duong Dupraz Dupuis Dupuy Durisotto 
  Dutilloy Dworan Dwyer Dyankov Dybicz Dyke Dyson Dziuba

  Eaton Ebenius Eber Ebery Economou Edberg Edgtton Edmonds Efremov 
  Efthimiou Eggeling Eide Eidi Eidingsen Eiriksson Eisenberg Ekeblad 
  Ekenberg Ekrens Eksi Ekþi Elbaz Elbeyati Elbro Elias Ellestad Ellia 
  Elliott Engel Elinescu Enrique Ergil Erhart Erichsen Eriksen Eriksson 
  Erk Erkel Erkin Erkovan Espiasse Esterson Esteruelas Evans Ewart Eyde 
  Eyjapeyjar Eykt

  Fabbri Fagerlund Faidas Faigenbaum Failla Faivre Falay Falciai Falk 
  Fallenius Fallon Fan Fanos Fantonakis Fantoni Farholt Faria Farias 
  Farstad Farwell Fashingbauer Favard Federighi Fegarty Feiler Feldman
  Fellus Fendrick Fent Ferenci Fergani Ferlazzo Ferm Ferramosca 
  Ferrara Ferrari Fettes Fici Fidan Figlus Figueiredo Filikci Filios 
  Filip Filipowicz Finikiotis Finz Fioretti Fireman Firestone Fleischer 
  Fleischman Fleischmann Fleisher Fleury Flierl Flinken Flint Flock 
  Flora Fogaras Fonseca Fordham Fornaciari Fornasari Forrester Fortini 
  Fossi Foster Fourcaudot Fournier Fout Fox Fragola Franceschetti 
  Franchi Fraser Frazer Frazzetto Free Freeman Frencken Frenna Fredin 
  Freed Frey Friedland Friedlander Friis Frosztega Fruewirth Frukacz 
  Frutos Fu Fucik Fuglestad Fuller Fung Furunes Furuta Fyrun

  Gadioli Gaede Gagliardi Gaglietto Gardiner Galaktionova Galek 
  Galinsky Gallais Gallus Gana Gandhi Gandoglia Ganzer Garateguy Garbosi 
  Garcia Gardener Garfield Garg Garoufalis Garrido Garrone Garvey Garner 
  Gartaganis Gary Gaspar Gates Gautret Gaviard Gawel Gawrys Ge Gelberg 
  Geller Genc Generosi Gentili Georgescu Gerber Gerli Gero Geromboux 
  Gerrard Gerstmann Geyer Gezer Ghionis Giangkos Giannessi Giard 
  Gibbons Gibson Gidman Gierulski Gigliotti Gilboa Gill Gilliland 
  Gills
  Ginnan Ginossar Gioia Giove Gipson Gitelman Giubilo Giura Gladiator 
  Glanger Glasson Glopson Glyssner Gobbi Goded Gold Goldberg 
  Goldenfield Goldman Goldstein Golebiowski Golin Gombert Gomerov 
  Gomes Goodman Goraco Gordon Goren Gosney Gotard Gottlieb Gower Goyal 
  Göthe Grabel Grabowska Gradignan Gradinariu Gradovsky Grainger 
  Gramberg Granda Granville Grant Greenberg Greenwood Grenside 
  Grenthe Griffey Griffin Griffoni Griffiths Grillo Grime Grimeton 
  Grigoriu Grimaldi Grisho Groenenboom Gromov Gromova Gromöller 
  Gronaldo Gross Grossack Grosvenor Grude Grue Gruia Grunt Gruschow 
  Gruszczynski Grzelak Grøtheim Gu Guariglia Guclu Gudkov Gue 
  Gueglio Guermani 
  Guglietto Guichet Guillaumin Guja Gula Guldberg Guler Gulyas 
  Gumby Guner Gunes Gungor Gupta Gurkan Gurler Gurley Gursel Gustawsson 
  Gutmark Guy Günther Gwozdzinsky Gyimesi

  Hackett Hadjibalis Haffer Hagenberg Haidorfer Halezer Hallen Hallerman
  Hallongren Hamman Hampson Hampton Han Hanna Hans Hansen Hanlon 
  Hantveit Harangozo Harari Harasimowicz Harding Harley Harms Harper 
  Harries Harris Harrison Harsanyi Hasenson Hassett Hauge Haugen Haughie 
  Häusler Havas Hayman Hegedus Heibø Heidelbaden Heifer Helekar Helgemo 
  Helle Helman Helmer Helmich Helms Hemberg Hemery Henault Henclik 
  Henneberg Henriksen Henriques Herden Herman Hernandez Herrera Herscap 
  Herz Heskje Hessel
  Hetz Hill Hillman Hinden Hindon Hinge Hiraki Hirata Hirchwald Hirst 
  Hitti Hliapas Hobeika Hoff Hoffa Hoffman Hoffner Hogg Hogstad 
  Hollands Hollman Holm Honti Hooda Hoogervorst Hope Hopfenheit Hornibrook 
  Horowitz Horton Horwitz Hove Howard Howe Hristov Hsieh Hu Huang 
  Huberschwiller Hughes Hugon Hugony Hult Humphries Hung Hupe Hurd
  Hurworth Husted Hutton Hyatt Høgis Høyland 

  Iacapraro Iancu Ichilcik Ilczuk Ilmez Ince Indemini Indzheva 
  Ingielewicz Ino Iommi Iontzeff Irens Ishidaya Iskin Ismir Ivanchev
  Ivatury Iversen Ivrig Iwona Iyer Izisel

  Jacini Jacob Jacobs Jaggar Jagger Jagniewski Jagroop Jahnsen 
  Jalowka Jamieson
  Janicki Janik Jankova Janisz Janiszewski Janowski Jansson Jansma 
  Janssen Jardon Jarlot Jasinski Jassem Jawell Jayganesh Jeanneteau 
  Jedrychowski Jeng Jenkins Jenner Jensen Jepsen Jezioro Joel 
  Johannsson Johansson Johansen Johnson Jolly Jokisch Jones Jotcham 
  Juanca Juhl Jungdal Junqueira Jussila Juster Juutilainen

  Kabra Kachchu Kageling Kahyaoglu Kahn Kahraman Kaiser Kalida Kalita 
  Kalish Kallifronas Kallsberg Kallunki Kalma Kalmin Kamat Kambancho 
  Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kane Kanetkar 
  Kang Kapagiannidis Kapitanski Kaplan Kaptan Kara Karamanlis Karavil 
  Karayel Karika Karlaftis Karpouzelis Kasapoglu Kasday Kasimir Kasle 
  Kasler Kastel Kater Katsareli Katsutake Katz Kaushik Kay Kaya 
  Kaye Kazik Kazmierczak Kazmucha Keaveney Keegan Kelso Kemeny 
  Kendrick Kenigsberg Kennedy Kenny Kent Keremida Kersey Kesgin 
  Ketenci Khandelwal Khazanov Khyuppenen Kielbasa Kilani Kilvington 
  Kim Kindsbekken King Kippe Kiran Kiriakidoy Kirilenko Kishan 
  Kizikli Klapper Klesser Klimacki Klimentowska Klinger Klofa 
  Klukowski Knap Knight Knottenbelt Kocak Koeppel Koistinen Koivu
  Koivula Kokali Kokish Kokkes Koken Koksoy Kokten Kolankaya Kolata 
  Kolesnik Kollnes Kolonkaya Kompa Konckier Kondoch Konefal Koneru 
  Kopecky Koppel Korbel Kordov Korenhof Korkmaz Korkut Korth Kosaka Koster
  Kosti Kot Kotányi Kotarak Kotinas Kotronarou Koumetz Kovacs Kovachev 
  Kovacich Kowalski Kozakos Kozik Kozikowski Kökten Kraichev Krajewski 
  Kranyak Krausova Krawczyk Krekorian Kriegel Kriftner Krishan Kristensen 
  Kritsalis Kroch Krochmalik Krolikowski Krupowicz Kruse Krøjgaard 
  Ku Kuba 
  Kubac Kujawa Kuokkanen Kurbalija Kurek Kutenik Kutner Kuzey Kvangraven 
  Kvaran Kwiatkowski Kwiecien Kwok Kychanov Kyriakidou Kyrilenko

  Laan Labaere Lachowicz Laffineur Lagrange Lagree Lalanne Lall 
  Lambardi Lanciano Lane Langer Langlet Lantaron Lanzarotti Larisa 
  Larrain Larsen Larssen Lasserre Lauria Lavín Lavings Law Lawy Lay 
  Lazer Lazkar Leao Lebatteux Lebel Lebi Lebowitz Leca Lechtman Lee
  Leenhardt Legras Lehtinen Leibowitz Leiro Lelez Lena Lencastre Lengy 
  Lennon Lensmann Leon Leonardon Leong Leptirici Lerner Leslie 
  Lesniewski Lesnik Lester Lev Levi Levinger Levin Levine Levinson 
  Levoni Levoy Levski Levy Lewis Lhuissier Li Lian Libbrecht Libman 
  Licursi Lie Lien Liu Liggins Lilienstein Lillevik Lilley Limor Lin 
  Linczmayer Lindner Lindsay Lindstedt Lipkin Lishkov Lisik Lisle 
  Livgård Llopart Locatelli Lockwood Longinotti Lopez Lorentz Lorenzini 
  Loreto Lormant Louchart Lovrecz Lowe Lowry Lu Luba Lubinski Lucena 
  Lucchesi Lucignano Luczeczko Ludewig Lui Lund Lundberg Luppi Lupsan 
  Lusk Lusky Lüßmann Lynch Lyngen

  Maas MacCormac MacDonald Mackenzie Mace Macedo Machado Madala 
  Madsen Maduzia Magee Magis Maggio Maglietta Magnuson Magnusson
  Magyari Mahaffey Maia Mainoldi Maiolani Maison Majcher Malarme 
  Malinowski Makarewicz Maksymetz Malaczynski Malani Malavasi 
  Maluish Malysh Mamidaki Manalang Manara Mancuso Mandecka Mandelot Mane 
  Manfield Manganella Mangelrød Manglik Manni Mannix Mantica Manyawar 
  Maoilani Marani Marashev Marchioni Marcinowski Marcora Marek Margarida 
  Margiotta Mari Mariani Marioni Marill Marina Marincho Marinescu 
  Marino Markey Markowicz Marks Marmonti Marquardsen Marshall Marsonis 
  Marston Marta Martel Martellini Martens Martin Martini Martins 
  Marupe Marx Masana Masini Mason Masselli Maszenda Matei Matheson 
  Matisons Matkowski Matos Matteucci Matushko Mauberquez Mavridis Maya
  Mayorga Maze Mazurkiewicz Maybach Mäkikangas Märsylä McAllister 
  McCallum McCance McDevitt McDonald McGann McGinley McGowan McGrath 
  McIntosh McKellar McLeish McLeod McKinnon McLeish McManus 
  McMahon McMullin McNamara McRobert Meckstroth Medik Medugno Medved 
  Mehech 
  Mehrez Mejane Mello Meltzer Mendick Menezes Mendoza Merah Merblum Mercan 
  Mesbur Messika Mestres Metselaar Meyer Meyers Meyouhas Mezei 
  Michaud Michealakis Michielsen Mickiewicz Mikyska Miles Milgrim 
  Mill Millar Millens Miller Milne Milner Mina Miner Miniter 
  Minwalla Minzli Miozzi Mirkovic Miroglio Mirolli Miszewska Mitra 
  Mittelman Mirali Miura Mizel Mizrak Mohandes Mohota Mohtashami 
  Molenaar Molenda Molina Molle Molson Molva Monachan Moni Monsegur 
  Montanari Montes Monvernay Mooney Moran Morath Morawski Moreau 
  Moreira Morelli Morgan Morgantini Mori Morimura Moritsch Morri 
  Morris Morrison Morse Mortarotti Mortensen Moses Moskovsky Mossop 
  Mott Mouiel Mourgues Mpampou Mpanikas Mpompolakis Mucha Mueller 
  Mullamphy Muller Multon Mundell Munksgaard Munson Munteanu Muntz 
  Muriel Murray Mus Musso Mutiara Muzzio Mýzrak Mæsel Mønsted

  Nab Nadar Nader Naels Naess Nagy Nahmias Nakanekar Nakanishi 
  Naimuddin Naito Naniwada Narasimhan Naqvi Nardullo Nataf Natale 
  Natt Navneet Nawrocki
  Neale Negrin Neill Nencini Nettleton Netto Neuhauser Neulinger 
  Neumann Neve Newell Newman Ng Nickell Nicoletti Niekawa Nieminen 
  Nikolenkov Nikolov Nilsland Nilsson Nimhauser Ninos Nisbet Nixon 
  Nobel Noble Nordby Noland Norris Norton Novo Novoski Nowak Nowicki 
  Nowosadzki Ntalas Nuñez Nørgaard Nuhoglu Nunes Nunn Nussbaum 
  Nygren Nyshchyi Nystrom
  
  O'Briain O'Brien O'Gorman O'Rourke O'Shea Occelli Ohno Ohrysko 
  Oikonomou Oikonomopoulos Olanski Olczyk Oldfield Olker Ollikkala 
  Olofsson Olsen Omran Oncu Onishuk Ortega Onstott Oppezzi Orhan 
  Osaulenko Osie Osofsky Oteyza Otvosi Oursel Outred Ozarar Ozaydin 
  Ozbay Ozcan Ozdil Ozenir Ozge Ozlen Ozsahin Ozturk Östberg Özbey

  Pacareu Pacault Pace Pacini Pagano Paganus Paiva Pajak Paladino 
  Palatinus Palau Palazzo Palmeira Palmer Pals Pampanini Panagaki 
  Panto Panopoulos Pantusa Papahatzis papakostas Papakyriakopoulos 
  Papaxatzis Papp Parekh Parker Parl Parrish Partearroyo Parviainen 
  Paske Pasquarè Passarinho Passaro Passell Pastore Paton Patterson
  Pattinson Pattison Paulissen Pauncz Pavlicek Pawlak Payen Paz 
  Pazur Peake Pedzinski Peirão Pekkinen Peksen Pelka Penfold 
  Pepper Percario Percy Pereira Perekatova Peres Periasamy Perisic 
  Perlmutter Persiani Petculescu Petrakiev Petrini Petrescu 
  Pettersson Phelan Piasecki 
  Piazza Piccioni Piedra Piekarek Pietraszek Piganeau Pignanelli
  Pigulski Pilon Pineles Pinguello Pinto Piper Pisak Pisani Pitt 
  Piva Plaut Plackett Platnick Poizat Polat Poleschi Pollack Pollak 
  Pollastrini Polledro Polowan 
  Pomilio Ponomareva Pons Pont Popescu Popova Portal Porteous Potier 
  Potts Poulat Pownall Pozzi Pradhan Preddy Prescott Previde Priano 
  Primavera Proukakis Procter Prohorov Prusa Pryce
  Pryor Puczynski Pugliese 
  Pulkrab Punch Purkarthofer Pszczola

  Quail Quantin Queran Quinn Quinton Qvistsson

  Rabie Rabinowitz Radcliffe Radikk Radin Radisic Rajagopal Ramamurthy 
  Ramchandran Ramirez Ramondt Rana Rankin Ranklin Ranson Rapp Rashti 
  Rathi Rau Raulund Ravenna Rayner Reardon Rebecchi Recalcati Reddan 
  Rees Reess Rehder Reid Reimer Reinholdt Reiplinger Rekstad Renouard 
  Repka Reps Revaz Reviglio Rew Reynolds Rheingold Ribera Ribery Ricard 
  Ricci Richardson Richman Ridgway Riedel Riehm Rietvink Rieusset 
  Rigal Rigaud Rigney Riisnæs Rimstedt Ringuet Riolo Rios Rippey
  Ritmeijer Rivara Rivers Rizzo Robb Robbins Robertson Robinson 
  Robles Robson Rocafort Rocca Roche Rockoff Rodwell Rogoff 
  Rohowsky Rolfmeyer Roll Rolland Roman Romanin Romanski Rombaut Rondon
  Ronin Root Rosen Rosenberg Rosendorff Rosetta Rosenkrantz Rosenthal 
  Rossi Rosti Roth Rothfield Rothstein Roussoglou Roussos Rubenstein
  Rubiés Rubin Rubins Rubio Ruchka Rueda Ruia Russo Ryman

  Sabbag Sabbatini Sadek Saelensminde Saesseli Sagiv Sagra Sahin Saina 
  Sairanen Sakirler Sakr Salama Salinas Salisbury Salliere Salman 
  Salonen Saltoglu Salvador Salvadori Sampaio Sancaktar Sandberg 
  Sanden Sanders Sandford Sandqvist Sangiorgio Sankichi Sansom 
  Santolini Santos Saoud Saporta Sapounakis Sargos Sarten Sarundajang 
  Sauvage Savchenko Savelli Savin Savorani Savski Sawicki Saxena 
  Sayaca Saydi Sayer Sayilkan Sayýlkan Säflund Sbarigia Scanavino Scerri 
  Schaltz Scherders Schermer Schireson Schlicker Schmidt Schneider 
  Schnetzer Schoellkopf Schoenwald Scholes Schonning Schoolmann 
  Schreiber Schuett Schulle Schulz Schüller Schroeder Schreckenberger 
  Scoltock Scriattoli Scudder Scullin Schwartz Schwerdt Seale Sealy 
  Sebbane Seguineau Selberg Selcuk Seligman Selway Semenov Semerci 
  Sen Sencer Sengoku Senguler Serek Serenella Serf Serifoglu Serpoi 
  Sesyilmaz Setton Sezginsoy Shadyro Shah Shaoxing Sharif Sharp Shashou
  Shelley Shen Sher Sherman Shezifi Shields Shiels Shimamura Shimizu 
  Shirogane Shore Short Shourie Shudnev Shugart Shunta Sieg Silvasanu
  Silver Silverman Silverstein Silverstone Sime Simonsen Simpson Simson 
  Sinclair Sinègre Sirola Sivrioglu Sjodal Sjöberg Sjöqvist Skaanning 
  Skelton Skimmeland Skjaeran Skjønnemann Skoglund Skop Skora Skorchev 
  Skurec Skwark Sliva Small Smart Smederevac Smilgajs Smit Smith 
  Smirnov Smyth Smolanko Snashall Snellers Snow Socha Soerensen 
  Sohlin Solari Soldati Solheim Solimando Solmi Solodar Sonsini 
  Soresini Soriano Sorkin Sorvoll Sosler Soukup Soulet Sowter 
  Soylu Sörvoll Spangenberg Spears Spector Spelmans Spinkhuizen 
  Spiridonescu Spitalnick Spooner Springer Sprung Squires Stabell 
  Stamatov Stankovic Stanley Stansby Stark Starkowski Stavrinos 
  Steel Stefanov Stefanovich Stegaroiu Stege Steiner Steinhardt 
  Stensson Stephani Stephenson Stepinski Stern Steinberg Sternberg 
  Stevens Stewart Stiefel Stienen Stilling Stoichkov Stokka Stoltz 
  Stoppa Stout Stoyanov Street Stretz Strul Strøm Stuart Strzemecki 
  Stynes Sulgrove Sveindal Sveinsson Svendsen Suarez Sugino Summers 
  Sundelin Sunderasan Sundsten Sung Suñol Suresh Sutherlin Sutmen 
  Suwik Sütmen Svindahl Swarup Sweidan Sykioti Sylvan Sylvester 
  Symons Syversen Szalay Szalka Szczepanski Szenberg Szigethy Szots 
  Szpilka Sztyrak Szymaszczyk Szymanowski Sørensen

  Tachev Tajima Talluri Talpur Tamburi Tamburrini Tan Tanaka Taner 
  Tardy Tarhan Tarkunde Tarnopol Tarnovski Tartarin Tasman Taylor 
  Tebha Tedd Teisen Teltscher Tembouret Tencer Teodorescu Teramoto 
  Terenzi Terraneo Tesla Tessitore Tez Thapa Thomsen Thompson 
  Thomson Thor Thoresen Thorpe Thuillez Thurston Tian Ticha Tígulsjöan
  Tihane Tijssen Tilly Tishler Tislevoll Tobin Todd Toffier Toledano 
  Toivonen Tokay Tolle Tomlin Tommasini Tonti Torielli Toro Tosi 
  Townsend Trabucchi Travis Triana Tripathi Tritt Troberg Tsang Tsilis 
  Tu Tubiska Tucker Tudor Tulin Tully Tuomi Turner Tuszynski Tutty 
  Tuwanakotta Türkoðlu Tyradelli Tyson Tøndel

  Ucar Ueland Uggeri Ultav Una Upmark Uran Uskali Uskela Usluduran 
  Utter Uysal Uzunhasan

  Vahaboglu Vahalia Vailati Vainikonis Valeanu Valio Valta Vanchev Varadi 
  Varenne Vargas Vasarhelyi Vecchi Veloni Venetina Venkatesh Verbeek 
  Verhaegen Verhees Vernay Versace Versluis Viale Viana Vicuna 
  Vidigal Viennois Vidal Vidalat Videv Vigil Vignaga Vihtilä Vilanou 
  Vilella Villegas Vinay Vincent Vinciguerra Virvidakis Vis Vitas 
  Vithaya Vogt Vohra Voinescu Volcker Vorobei Vorobeychikova Vriend 
  Vroustis Vucic

  Wademark Waledzik Walker Walsh Wan Wang Ward Ware Warne Warner 
  Wasik Watawe Waterlow Waters Watkins Watts Watve Weber Weed Wei
  Weibel Weiler 
  Weingarten Weingold Weinhold Weinstein Weisinger Welland Weltzer 
  Werdelin Wesolowska Westerlund Westheimer Westman Weston Westra 
  Westwood Whibley Whiting Wiankowski Wigoder Wijma Wikstrom 
  Wildavsky Willcox Wille Wilkinson Willenken Williams Willis Wilson 
  Wiltshire Winciorek Winestock Winkler Wit Witek Winter Wittes Wnuk 
  Wohlmuth Wojcieszek Wolanski Wold Wolfarth Wolff Wolfson Wolpert Wood 
  Woodruff Woolsey Worm Wortel Wrang Wrobel Wu Wurth Wyer

  Xatzimpalis Xerri Xiao Xie Xu

  Yadlin Yagmur Yalman Yamada Yang Yanko Yaras Yarington Yates Yergýn
  Yezerski Yildiz Yilmaz Ying Yokoi Yoleri Youngs Yücekök Yuen Yule

  Zabunoglu Zack Zago Zagor Zagorin Zahr Zajac Zakarian Zaleski Zalewski
  Zamir Zampini Zanalda Zambonini Zaninotti Zarkesch Zatorski Zawada 
  Zawislak Zeeberg Zenari Zhan Zhang Zhao Zhaoheng Zhong Zhukov 
  Zielinski Zimmermann Zines Zipovski Zobu Zochowska Zollo Zolotov Zonca
  Zorlu Zotti Zozis Zotos Zwart

  Øberg Østergaard Övelius Özþahin
);

my %SINGLE_TYPOS =
(
  'A. Anderson' => ['aanderson'],
  Aagaard => ['aagard'],
  Agarwal => ['agarwals'],
  Akgul => ['akgül'],
  'Akin Ucar' => ['akin'],
  'Alain Lévy' => ['levy', 'lévy'],
  'Aline Biondillo' => ['aline'],
  'Ajay Bagaria' => ['bagaria'],
  'Alan Mould' => ['mould'],
  Allfrey => ['alfrey', 'alffrey'],
  Altshuler => ['altschuler', 'altshuller'],
  'Alvares Ribeiro' => ['luisaribeiro'],
  'Amiya Ranjan Das' => ['das'],
  'Anders Hagen' => ['hagen'],
  Andresen => ['andressen', 'andrresen'],
  Angelopoulos => ['angelopulos'],
  'Aniket Sanghvi' => ['aniket'],
  'Antonio Frances' => ['frances', 'francés'],
  Arcieri => ['arceri'],
  Argelazi => ['algelazi'],
  'Arunas Jankauskas' => ['arünas'],
  Avcioglu => ['avcýoðlu', 'avcioðlu'],
  Bartley => ['bartly'],
  Beale => ['beatle'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bedi => ['bedis', "bedi's"],
  Bertheau => ['berthau'],
  Blumental => ['blummental'],
  Bocchi => ['norby'],
  Bojoh => ['bujoh'],
  Bramley => ['brameley'],
  'Brigitta Fischer' => ['fischer'],
  Brogeland => ['broge'],
  'Buddy Shah' => ['buddy'],
  Burgess => ['burguess'],
  Bytskevich => ['bytskevitch'],
  Caldarelli => ['cladarelli'],
  'Carlos Ferreira' => ['ferreira'],
  'Carole Puillet' => ['puillet'],
  Castelblanco => ['castellblanco'],
  Castner => ['kastner'],
  Cernato => ['chernato'],
  'Chalermpol Wongwaiwit' => ['chalermpol'],
  'Christal Henner-Welland' => ['henner'],
  'Christophe Grosset' => ['grosset'],
  Chitlangia => ['chitalangia'],
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
  Dechelette => ['dechellette'],
  'Deepa Dhar' => ['deepadhar'],
  "Del'Monte" => ['delmonte', 'ish'],
  Delimpaltadakis => ['delim'],
  Demirbas => ['Demirbaþ'],
  'Deniz Ruzgar Akyurek' => ['ruzgar'],
  Diamond => ['dimaond'],
  'Diana Damyanova' => ['dianadamyanova'],
  'Dmitri Marchessini' => ['dmitri'],
  'Doxiadis' => ['doksiadis'],
  "D'Orsi" => ['dorsi'],
  Dumbovich => ['dumbovic'],
  Eisenberg => ['einsenberg'],
  Eksi => ['ekþý'],
  'Edmund Tse' => ['tse'],
  Elbeyati => ['elbeyatý'],
  'Erdal Tekin' => ['erdaltekin'],
  'Erik Wied' => ['ried'],
  'Erlend Skjetne' => ['erlendskjetne'],
  'Waleed El Ahmady' => ['elahmady', 'elhamady'],
  Faigenbaum => ['faiguenbaum'],
  Failla => ['faill'],
  Fleisher => ['fliesher'],
  'Francisco Costa-Cabral' => ['cabral'],
  Franceschetti => ['franceschett'],
  'G. Limmen' => ['limmen'],
  'Gabriel Chagas' => ['chagas'],
  Gartaganis => ['gartaginas', 'gartagnis'],
  Garoufalis => ['garoufallis'],
  'Evgueni Gladysh' => ['gladysch', 'gladysh'],
  Golebiowski => ['golembiowski', 'go£êbiowski'],
  'Carlos Gonçalves' => ['gonsalves', 'gonçalves'],
  Greenwood => ['greenwod'],
  'Grzegorz Darkiewicz-Moniuszko' => ['moniuszko'],
  Grenthe => ['grent', 'grenth'],
  Gromöller => ['gromoeller', 'gromuller', 'gro'],
  Grossack => ['grossac', 'grossak'],
  Giura => ['guira'],
  Günther => ['guenther'],
  Hackett => ['hakett', 'hacket'],
  Harangozo => ['harangozó'],
  Hassett => ['hasett'],
  Haughie => ['huaghie'],
  'Hecht Johansen' => ['hecht'],
  Hoffman => ['hofman'],
  'Hong NIU' => ['hongniu'],
  Hoogervorst => ['hoogercorst'],
  Huberschwiller => ['huberschwi'],
  'Ilan Bareket' => ['bareket'],
  'Ilan Herbst' => ['herbst'],
  Ilmez => ['Ýlmez'],
  Ince => ['ýnce'],
  'J.E. Skjanni' => ['skjanni'],
  'J.C. Henriques' => ['jchenriques'],
  'J.P. Goenka' => ['goenka', 'jpgoenka'],
  'Jaggy Shivdasani' => ['jaggy'],
  'Jan-Olov Andersson' => ['joa'],
  Jansma => ['jansa'],
  'Javed Ahmed Miran' => ['miran'],
  Jedrychowski => ['jedrychowsky'],
  'Jeovani Salomao' => ['jeovani'],
  'Jeroo Mango' => ['mango'],
  'Jerzy Zaremba' => ['zaremba'],
  'Jimmie Feidie Eman' => ['jfe'],
  'Joao Silva Neto' => ['silvaneto'],
  'John Holland' => ['j holland'],
  'Jorge Petrucci' => ['petrucci'],
  'Josef Blass' => ['blass'],
  'Jose Carlos Sousa Santos' => ['jcss'],
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
  Khyuppenen => ['khiuppenen', 'kyuppenen'],
  Kilvington => ['kilvigton'],
  Kindsbekken => ['kindsebekken'],
  Koivula => ['koivulat'],
  Koksoy => ['köksoy'],
  Kolesnik => ['kolesnick', 'kollesnik'],
  Kordov => ['kordöv'],
  Kotányi => ['kotanyi'],
  Kökten => ['kokten'],
  Kraichev => ['kraychev'],
  Krochmalik => ['krockmalik'],
  Kurbalija => ['kuribalija'],
  Kvangraven => ['knangraven'],
  Lantaron => ['lantarón'],
  Larrain => ['larraín'],
  Lauria => ['laurýa'],
  Leao => ['leão'],
  Lhuissier => ['lhuisser'],
  Llopart =>['lllopar', 'llopar'],
  'Lotan Fisher' => ['fisher'],
  'Luis Oliveira' => ['oliveira'],
  Lyngen => ['lyn'],
  Maas => ['mass'],
  'Maria João Lara' => ['lara', 'mjlara'],
  Mahaffey => ['mahafey', 'mahaffee'],
  Mane => ['mané'],
  'Manoel Peirao' => ['manoel'],
  'Manuel Capucho' => ['capucho'],
  Manyawar => ['manyvar', 'manyavar'],
  'Marc Kerlero de Rosbo' => ['kerlero'],
  'Marcelo Branco' => ['branco'],
  Marcinowski =>['marchinowski', 'marcinowsci'],
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
  Mittelman => ['mittleman'],
  'Mohamed Manaf Saleh' => ['manaf'],
  Mohota => ['mohata'],
  'Mohsen Kamel' => ['mohsenkamel'],
  'Moni Diba' => ['monidiba'],
  'John Møller Jepsen' => ['møllerjepsen'],
  Narasimhan => ['narasinham'],
  Nowosadzki => ['nowosad'],
  'Nuno Damaso' => ['damaso'],
  Nystrom => ['nyström'],
  "O'Rourke" => ['orourke'],
  Olanski => ['olansk'],
  Oursel => ['ousel'],
  Ozbay => ['ozbey'],
  Ozdil => ['odzil'],
  Ozturk => ['öztürk'],
  Özbey => ['ozbey'],
  Pacareu => ['pacareau'],
  'Palma Carlos' => ['pcarlos'],
  Panopoulos => ['panopulos'],
  Papahatzis => ['papachatzis'],
  Patanè => ['patane'],
  'Patrick Jourdain' => ['jourdain'],
  'Paul Fireman' => ['fireman'],
  'Paulo Goncalves Pereira' => ['pgp', 'pgpereira'],
  'Paulo Roberto Brum' => ['brum'],
  Pavlicek => ['pavlichek'],
  'Pedro Madeira' => ['pmadeira'],
  'Pedro Morbey' => ['morbey'],
  'Pedro Pratas' => ['pratas'],
  Peirão => ['peirao'],
  Peksen => ['pekþen'],
  'Peteris Bethers' => ['peteris'],
  'Phailin Nimityongskul' => ['phailin'],
  Platnick => ['platncik'],
  'Pobsit Kamolvej' => ['pobsit'],
  'Pony Nehmert' => ['pony'],
  'Pramual Angkaew' => ['pramual'],
  Prescott => ['prescot'],
  Procter => ['proctor'],
  Pszczola => ['pepsi'],
  'Qiao Meng' => ['qiaomeng'],
  'Quentin Robert' => ['robert'],
  Qvistsson => ['qvistssons'],
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
  Rosenthal => ['rosentahl', 'rosenthall'],
  Roussos => ['rousos'],
  Rubiés => ['rubies', 'rubie'],
  Rubin => ['rugin'],
  'Rui Silva Santos' => ['rss'],
  Ruia => ['ruya'],
  'Sainte Marie' => ['stemarie'],
  'Sally Brock' => ['brock'],
  'Salvatore Luceno' => ['lucenò'],
  Sapounakis => ['sapounaki'],
  'Saumitra Basu' => ['saumitra'],
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
  Sivrioglu => ['sývrýoðlu'],
  Skjaeran => ['Skjæran'],
  Smederevac => ['smeredevac'],
  Smilgajs => ['smilgais'],
  'Sofia Costa Pessoa' => ['pessoa'],
  Stephenson => ['stephenso'],
  Stepinski => ['stêpiñski'],
  Stoyanov => ['stojanov'],
  'Sunil Machhar' => ['macchar', 'machhar', 'sinilmachar'],
  Svendsen => ['svends'],
  Svindahl => ['svindhal'],
  'Sylvie Willard' => ['willard'],
  Szenberg => ['szpenberg'],
  Szczepanski => ['sczcepanski'],
  Tarnovski => ['tranovski'],
  Teltscher => ['teltsher'],
  Teodorescu => ['teodeorescu'],
  Thuillez => ['tuillez', 'thuilliez'],
  Tislevoll => ['tislovoll'],
  'Tomi Gotard' => ['tomi'],
  'Tor Helness' => ['helness'],
  'Toshiro Nose' => ['nose'],
  Townsend => ['towsend'],
  'Teixeira-Reus' => ['txecreus'],
  Ucar => ['uçar'],
  Vainikonis => ['vainkonis'],
  'Van Lankveld' => ['lankveld'],
  Vasarhelyi => ['vasarhely', 'vasrahely'],
  Venkatesh => ['venky'],
  'Villas Boas' => ['villasboas'],
  Vilella => ['vilela'],
  Vinciguerra => ['vinci', 'vinceguerra', 'vinciguera'],
  'Visalakshi Narayanan Ramamoorthy' => ["vnr's"],
  'Wang Yuan Wei' => ['wangyuanwei'],
  Watawe => ['watave'],
  Weinstein => ['weinsten'],
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
