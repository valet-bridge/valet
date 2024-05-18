#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamCaptain;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_captain);

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
  'Alvares Ribeiro',
  'Amedian Bross',
  'Ana Tadeu',
  'Anders Johansson',
  'Aniket Sanghvi',
  'Anita Sinclair',
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
  'Carlo Bossi',
  'Carlos Ferreira',
  'Carlos Gonçalves',
  'Carlos Luiz',
  'Carlos Santos',
  'Carlos Teixeira',
  'Chalermpol Wongwaiwit',
  'Christal Henner-Welland',
  'D Banerjee',
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
  'der Kinderen',
  'Derek Zen',
  'Defranchi',
  'Della Monta',
  "Del'Monte",
  'Dennis Bilde',
  'di Franco',
  'Dian Wang',
  'Diana Damyanova',
  'Ding Yuan',
  'Djordje Dunjic',
  'Dmitri Marchessini',
  "D'Orsi",
  'Dr. Anand',
  'Dr. Ashwani Mehta',
  'Duronto Rajshahi',
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
  'Flemming Dahl',
  'Francisco Costa-Cabral',
  'Frímann Stefánsson',
  'Gabriel Chagas',
  'Gila Emody',
  'Ginossar',
  'Gudmundur S. Hermannsson',
  'Gunnlaugur Sævarsson',
  'Gunnar Sjökvist',
  'Gylfi Baldursson',
  'H.C. Nielsen',
  'Hana Shezifi',
  'Hecht Johansen',
  'Hemant Jalan',
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
  'J.C. Henriques',
  'J.E. Skjanni',
  'J.P. Goenka',
  'Jaggy Shivdasani',
  'Jan Jansma',
  'Jan-Olov Andersson',
  'Janak Shah',
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
  'Knud Harries',
  'Kristian Tylvad',
  'Krzysztof Strykier',
  'Kumar Vijay Anand',
  'Kurniadi Djauhari',
  "L'Écuyer",
  'Lauge Pedersen',
  'Li Shu Yuan',
  'Li Xiao Lei',
  'Lin Rong Qiang',
  'Lotan Fisher',
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
  'Modi Kenigsberg',
  'Mohit Mehta',
  'Mohsen Kamel',
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
  'Pedro Madeira',
  'Pedro Morbey',
  'Pedro Pratas',
  'Peter de Vries',
  'Peter Schaltz',
  'Poul Clemmensen',
  'Prakash Bandhari',
  'Pramual Angkaew',
  'Promila Saraf',
  'Qing Gong',
  'R.K. Sinha',
  'R.L. Kejriwal',
  'R.S. Mishra',
  'Raul Guerreiro',
  'Rita Choksi',
  'Rodrigo Suares',
  'Rui Pinto',
  'Rui Silva Santos',
  'Rúnar Einarsson',
  'Sadek Radwan',
  'Sally Brock',
  'Salvatore Luceno',
  'Sanjay Bhattacharya',
  'Satish Modi',
  'Saumitra Basu',
  'Shashi Gupta',
  'Shekhar Banerjee',
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
  'Sveinn Ericsson',
  'Sverrir Þórisson',
  'Tiago Canelas',
  'Tomi Gotard',
  'Tor Helness',
  'Toshiro Nose',
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
  'Vijay Anand Singh',
  'Villas Boas',
  'Vincent LI',
  'Wang Yuan Wei',
  'Ward Platt',
  'Wei Sender',
  'Weidong He',
  'Wu Xiao Bing',
  'Wubbo de Boer',
  'Xavier Michaud Larivière',
  'Yao Ke',
  'Ye Jun',
  'Yu Yi',
  'Yuval Lubinski',
  'Zack Yaniv',
  'Zhang De Zhong',
  'Zhang Xiao Feng',
  'Zia Mahmood',
  'ZHOU Tao'
);

my %MULTI_TYPOS =
(
  'Acacio Figueiredo' => ['acacio f'],
  'Adam Edgtton' => ['a edgtton', 'a.edgtton'],
  'Ajay Bagaria' => ['a.bagaria'],
  'Alain Lévy' => ['alain levy'],
  'Alok Daga' => ["alok daga's iv"],
  'Alvares Ribeiro' => ['luis alvares ribeiro', 'luis a ribeiro',
    'luis a. ribeiro', 'álvares ribeiro'],
  'Alvensleben' => ['v.alvensleben', 'v. alvensleben'],
  'Antonio Falcao' => ['falcão'],
  'Antonio Maria Campos' => ['antonio m campos', 'antonio maria campo'],
  'Artur S. Silva' => ['artur s silva'],
  'Arun Jain' => ['arunjain'],
  'Arunas Jankauskas' => ['arünas jankauskas'],
  'Ashwin Mehta' => ['dr.ashwin meheta'],
  'A.K. Bose' => ["a.k.bose's iv", "a.k.bose'iv", "a k bose's 4",
    "a k bose's IV"],
  'Ilan Bareket' => ['bareket ilan'],
  'Benedicte Cronier' => ['mme cronier'],
  'Bimal Sicka' => ['bimal sikka'],
  'Birkir Jonsson' => ['birkir j jonsson'],
  Boaz => ['dr. boaz', "dr. boaz's"],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.', 'cv rao'],
  'Carlos Gonçalves' => ['carlos goncalves', 'c goncalves',
    'carlos gonçalve', 'carlos gonçalv'],
  'Christal Henner-Welland' => ['welland-h', 'henner-we'],
  Cladius => ['dr. cladius'],
  'David Birman' => ['birman david', 'birman d'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Bruyne' => ['de Bruyune'],
  'de Knijff' => ['deknijff', 'di knijff'],
  'de Tessieres' => ['de tessiere', 'de tessier', 'de tessie'],
  'D Banerjee' => ['prof d banerjee'],
  "D'Orsi" => ['d orsi'],
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
  'Gabriel Chagas' => ['chagas.g'],
  'Gila Emody' => ['emody gila'],
  'Ginossar' => ['eldad ginossar', 'ginossar eldad'],
  'Gudmundur S. Hermannsson' => ['guðmundur sv. h'],
  'Gunnlaugur Sævarsson' => ['gunnlaugur sævars', 'Gunnlaugur Sævarsso'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hana Shezifi' => ['shezifi hana'],
  'Hecht Johansen' => ['hecht-johansen', 'hect johansen'],
  Helekar => ['dr. helekar', 'dr.helekar'],
  'Hemant Jalan' => ['k. jalan', 'h.jalan', 'hemant  jalan'],
  'Hermann Friðriksson' => ['Hermann Fridriksson'],
  'Hiroki Yokoi' => ['yokoi hiroki'],
  'Ilan Herbst' => ['herbst i', 'herbst ilan'],
  'Inocencio Almeida Araujo' => ['inocencio arauj', 'inocêncio araújo'],
  'Inon Liran' => ['liran inon'],
  'J.C. Henriques' => ['j.c.henriques', 'j c henriques',
    'j. c. henriques', 'j. carlos henriques', 'jose c. henriques',
    'josé c. henriques', 'josé henriques', 'ze carlos henriques',
    'zé carlos henriques', 'jc henriques', 'josé c henriques'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni', 'je skjanni',
    'je skjanni ehf'],
  'J.P. Goenka' => ['j.p.goenka'],
  'Joao Paes de Carvalho' => ['j paes c'],
  'Jean le Poder' => ['le poder'],
  'Jennifer de Winter' => ['jen de winther', 'jen de winter',
    'jan de winter'],
  'Jesper Buus Thomsen' => ['jb thomsen'],
  'João Fanha' => ['j.fanha', 'joao fanha', 'j. fanha'],
  'Joao Silva Neto' => ['silva neto'],
  'John Holland' => ['j holland'],
  'Jón Ásbjörnsson' => ['ásbjörnsson'],
  'Jorge Castanheira' => ['jorel8'],
  'Joshi Sanghi' => ['dr.joshi', "dr.sanghi'siv", 'dr. joshi sanghi',
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
  "L'Écuyer" => ["l'ecuyer", 'lecuyer', 'l ecuyer', 'l"ecuyer'],
  'Lauge Pedersen' => ['lauge-pedersen'],
  'Lotan Fisher' => ['fisher lotan'],
  'Majka Cilleborg Bilde' => ['majka bilde'],
  'Manuel Capucho' => ['m capucho', 'manual capucho'],
  'Manuel Oliveira' => ['manuel oliveia', 'm.oliveira', 'm. oliveira',
    'm oliveira'],
  'Manuela Mouttet' => ['mme mouttet'],
  'Marc ter Laare' => ['ter laare'],
  'Maria João Lara' => ['maria joao lara', 'm joão lara',
    'm joao lara', 'm. j. lara', 'm.j.lara', 'mj.lara',
    'maria j.lara', 'm.joão lara', 'mª joão lara', 'm. joão lara'],
  'Mariana Leitão' =>['mariana leitao'],
  'Marius Bartnes' => ['dr. bartnes'],
  'Maxim Henbest' => ['m.henbest'],
  'Maya Meera Sneha' => ['maya meera', 'maya mira', 'maya mira sneha'],
  McLeish => ['mc. leish'],
  'Migry Zur-Campanile' => ['zur-campanile'],
  'Miguel S. Guedes' => ['miguel s guedes'],
  'Miguel Teixeira' => ['miguel teixeira', 'm. teixeira'],
  'Mohit Mehta' => ['mohit mehata'],
  'N. Chakraborty' => ["n.c hakraborty's iv"],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  "O'Rourke" => ['o rourke', 'o;rourke', "o'rouke"],
  'Ofek Tal' => ['ofel tal'],
  'Olivier Bessis' => ['bessis.o.', 'bessis.o'],
  'Patanè' => ["patane'"],
  'Paul Hackett' => ['p hackett', 'pd hackett', 'hackett p'],
  'Paulo Goncalves Pereira' => ['paulo g pereira', 'paulo goncalves per',
    'paulo gonçalves', 'p g pereira', 'p. g. pereira', 'pg pereira',
      'p.g.pereira'],
  'Paulo Roberto Brum' => ['brum p', 'brum.p.', 'paulo brum', 'p brum'],
  'Paulo Rocha Pinto' => ['paulo pinto', 'rocha pinto'],
  'Pedro Madeira' => ['p. madeira', 'p madeira'],
  'Pedro Morbey' => ['p. morbey'],
  'Promila Saraf' => ['promila soraf'],
  'R.K. Sinha' => ["r k sinha'siv", "r k sinha's lv", 'r k sinha'],
  'R.L. Kejriwal' => ['r l kejriwal', 'r l kejriwaal', 
    'r.l.kejriwal mc', 'r. l. kejriwal', 'rl kejriwal'],
  'Raul Guerreiro' => ['r guerreiro'],
  'Rita Choksi' => ['rita chokshi'],
  'Rodrigo Suares' => ['rodrigo soares'],
  'R.S. Mishra' => ['r. s. mishra', 'r.s.mishra'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Rui Silva Santos' => ['rui santos', 'silva santos',
    'rui s. santos'],
  'Rúnar Einarsson' => ['einarsson'],
  'Salim Yilankiran' => ['yilankiran'],
  'Sally Brock' => ['s brock'],
  'Shashi Gupta' => ["shashi gupta's 6"],
  'Shlomo Netzer' => ['netzer shlomo'],
  'Sigurdur Vilhjalmsson' => ['sigurður vilhjálmss'],
  'Sinan Göksu' => ['sinan goksu'],
  'Sofia Costa Pessoa' => ['s.pessoa'],
  'Sunil Machhar' => ['sunil machar', 'sunil macchar', 's macchar',
    'sunal macchar', 'sunil maccher', 'sunil.macchar'],
  'Sverrir Þórisson' => ['sverrir þ'],
  Vahalia => ['dr.vahalia'],
  Vithaya => ['dr.vithaya'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen'],
  'Waleed El Ahmady' => ['el ahmady'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward pratt',
    'ward-pratt'],
  'Wei Sender' => ['wei-sender'],
  'Weidong He' => ['he wei dong'],
  'Xavier Michaud Larivière' => ['michaud- lariviere',
    'michaud-lariviere', 'michaud lari'],
  'Yuval Lubinski' => ['lubinsky yuval']
);

my @SINGLE_WORDS = qw(
  Aagaard Abecassis Adad Adams Adamsen Adde Adem Adrei Adriano Adrilla
  Agarwal Agica Agnihotri Agostini Akama Akem Aker Akgul Akgun Akhun 
  Akkab Akkoyunlu Akuzum Alami Alela Alfonsin Alineo Allana Allegaert 
  Allegra Allfrey Allison Allix Alloul Almirall Alocchi Aloi Alonso 
  Altan Altay Alti Altinis Altshuler Alujas Alvensleben Amadori 
  Amaral Ames Amoedo Amoils Amol Andersen Anderson Andersson 
  Andrasi Andrea Andreoli Andrew Angeleri Angelini Antas Antmen Antoniou 
  Ao Apfel Appleton Apteker Aranha Araszkiewicz Araujo Arcieri Arle 
  Aroix Armstrong Arun Asakoshi Ash Ashworth Ashton Ashwin Askgaard 
  Asmeniadis Assael Assemi Assis Atalay Atabey Atay Attaguile 
  Auerbach Auken Aust Austberg Avci Avcioglu Avon Awad Ayda Aydin

  Babacan Babsch Bagge Baiche Bailey Baker Bakhshi Baki Bakkeren Baldini 
  Baldysz Baleal Balkanski Ballebo Bang Banikas Baran Barat Barbone 
  Barel Barion Bart Barton Basabe Baseggio Basile Bassini Bathurst 
  Batov Bauch Bavaresco Bayes Baze Bäckström Beauchamp Beale Beatty 
  Becker Bello Bellosta Belonogov Benassi Bennett Berdichevsky Berg 
  Berger Bergheimer Berkowitz Berktas Berlinski Berman Bernard 
  Bernasconi Bernstein Berrettini Bertens Bertheau Bertolucci Bessis 
  Bettini Beyer Bhalchandra Bhattacharya Biagiotti Bilal Bilde Bilski 
  Binderkrantz Bingol Biondillo Biondo Bird Birin Bittner Bitran Bizer
  Bjarnarson Bjerkan Bjornlund Blackstock Blakeman Blakset Blanchard 
  Blanco Blandin Bley Bloom Blum Blumental Bo Boaz Bocchi Bock 
  Bogach Bogacki Bohnhorst Bohnsack Bokk Bojoh Boldt Bolling Bolognini
  Bombardieri Bomber Bompis Bongiovanni Bonis Bonori Booth Bordallo 
  Bornova Boro Bos Boss Bossi Bostanci Bostosusz Boucher Boughey 
  Bourke Bouscat Bowdery Bowles Boylson Bozempergk Bozzo
  Brachman Brady Brake Braithwaite Bramley Branco Brantsma Branzoiu
  Braun Brede Brenner Bretagne Brifman Brightling Brink Brockwell 
  Brod Brogeland Brown Brotteaux Brunet Bruun Brunzell Buch Buchen 
  Buchlev Budkin Buras Burrows Burgay Burke Buscaglia Buse Busse Butland 
  Butts Byrne Bytskevich Börgesson

  Cabiati Caggese Calandra Caldarelli Caley Caldwell Callaghan 
  Camacho Camberos Cambiaghi Campos Capayianides Capitani Caplan 
  Cappelli Cappeller Caprera Caracci Cardine Carbonnier Carcy Carmichael 
  Carrasco Carruthers Carvalho Casabona Casadei Casen Cassini 
  Castelbranco Castelli Castner Cattani Cayne Cengiz Cernat Cernato 
  Cernatovo Cerreto Cesati Chadwick Chai Chambers Chan Chang 
  Charletoux Charlotte Charlsen Chassagne Chatterji Chauvelot 
  Chediak Cheek Chemla Chen Cheng Chinchak Chizzoli Chopin Chottin 
  Chuang Chubukov Ciccarelli Cichocki Ciechomski Cilleborg Cimon Cintra 
  Ciopettini Cladius Clair Claret Clark Clarke Clausen Clement 
  Clemmensen Close Coenraets Coglitore Cohen Cohler Cohner Colarossi 
  Coldea Cole Collett Collins Combes Combescure Compton Connie 
  Conti Cook Cooke Cooper Cope Coren Coridakis Corlateanu Cormack 
  Corssen Cotton Courtney Coutts Coyne Creet Crestey Creuheras 
  Crichton Crompton Cronier Crouch Crzejdziak Cuevas Cullin Cummings 
  Cuper Curo Çýloðlu Czímer

  Dabrowka Dahlberg Dalecki Dalia Dalley Damiani Dancewicz Danta Dantan 
  Dao Darak Das Daskalakis Daugava Dauvergne Davies Dawson Debolina 
  Debonnaire Debus Dechelette Degla Dehaye Deik Deleeuw Delfino 
  Delfour Delibaltadakis Dellecavakis Delimpaltadakis Delpiano DeMartino 
  Demirbas Demme Denning Deniz Desai Deutsch Deva Dexter Dexterzy
  Dialinas Dionysopoulos Dhir Dhondy Dialynas Diamond Dionosypoulus 
  Dinkin Dixon Djurovic Dobbels Dobes Dobroiu Doecke Doksiadis 
  Dolla Donatella Donciu Donn Donzi Dossena Dovell Doub Doussot 
  Doxiadis Drijver Dubini Duguet Duman Dumbovich Dunitz Dunn 
  Duong Dupraz Dupuis Dupuy Durisotto Dutilloy Dworan Dyke

  Eaton Eber Ebery Economou Eden Edgtton Efremov Efthimiou Eggeling 
  Eide Eidi Eidingsen Eisenberg Ekeblad Eksi Elbas Ellestad Ellia 
  Engel Elinescu Enrique Ergil Erichsen Eriksson Erk Erkel Ekþi
  Esterson Esteruelas Evans Ewart Eykt

  Fabbri Fagerlund Faidas Faigenbaum Failla Falciai Falk Fallenius Fallon 
  Fang Fantonakis Fantoni Farholt Faria Farias Farwell Favard
  Federighi Fegarty Feiler Feng Fent Fergani Fernando Ferramosca Ferrara 
  Ferrari Fettes Fici Figlus Figueiredo Filikci Filios Filip 
  Finikiotis Fioretti Fireman Firestone Fleisher Fleury Flierl Flock 
  Flora Fonseca Ford Fordham Fornaciari Fornasari Forrester Fortini 
  Foster Fournier Fout Fox Franchi Fraser Frazer Frazzetto Frencken 
  Fredin Freed Frey Fridriksson Friedland Friedlander Friis
  Frosztega Fruewirth Frukacz Frutos Fu Fucik Fuglestad Fuller Fung
  Furunes Furuta Fyrun

  Gabrial Gaede Garliardi Gagliardi Gaglietto Gardiner Galinsky Gallus 
  Gandoglia Ganzer Garateguy Garbosi Garvey Garner Gartaganis 
  Gary Gaspar Gaviard Gawel Gawrys Gelberg Geller Genc Generosi 
  Georgescu Gerber Gerli Gero Gerrard Geyer Gezer Giangkos 
  Giannessi Gidman Gierulski Gigliotti Gill Ginnan Ginossar 
  Gioia Gitelman Giura Gladiator Gladysh Glanger Glasson Glopson
  Goded Gold Goldberg Goldenfield Goldman Goldstein Golebiowski 
  Gomerov Gomes Goodman Gordon Goren Gosney Gotard Gottlieb Goyal Göthe
  Grabel Grabowska Gradignan Gradovsky Grainger Gramberg Green 
  Greenberg Greenwood Grenside Grenthe Griffey Griffin Griffoni Griffiths 
  Grimeton Grigoriu Grimaldi Grisho Groemenboom Gromov Gromova 
  Gross Grosset Gromöller Gronaldo Grue Gruia Grunt Gruschow Grzelak
  Gu Guariglia Gudkov Gue Gueglio Guerreiro Guglietto Guillaumin 
  Gula Guldberg Gumby Guo Gupta Gurley Gursel Gustawsson Gutmark 
  Guy Günther

  Hackett Hadjibalis Haffer Hagenberg Haidorfer Hallen Hamman 
  Hampson Hampton Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harari Harasimowicz Harding Harley Harper Harries Harris 
  Harrison Harsanyi 
  Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Hegedus Helekar Helgemo Helle Helmich Helms Heng Henneberg 
  Herman Heskje Hillman Hinden Hinge Hiraki Hirchwald Hirst Hliapas
  Hobeika Hoff Hoffa Hoffman Hollands Hollman Honti Hopfenheit 
  Hornibrook Horowitz Horton Horwitz 
  Howard Howe Høyland
  Hu Huang Hughes Hugon Hugony Hult Hung Hupe

  Ichilcik Ingielewicz Iommi Iontzeff Irens Ivatury Iversen Ivrig Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jain Jalowka Jamieson
  Janicki Janik Jankova Janiszewski Janowski 
  Jansma Janssen Jarlot Jarov Jassem Jawell Jayganesh 
  Jedrychowski Jeng Jensen Jepsen Jessheim Jian Jiang 
  Joel Johansen Johansson Johnson Jolly Jonsson Jokisch Jones Jotcham

  Kabra Kachchu Kahyaoglu Kaiser Kalita Kalish Kallsberg Kallunki 
  Kalma Kalmin Kamal Kambancho Kamil Kaminaris Kaminski Kamras Kannavos 
  Kandemir Kane Kanetkar Kapadia Kapagiannidis Kaplan Kaptan 
  Karadeniz Karamanlis Karavil Karayel Karl Karlaftis Karpouzelis 
  Kasday Kasle Kasler Kastel Kater Katz Kaushik Kay Kaya Kaye 
  Kazik Kazmierczak Kendrick Kennedy Kenny Kent Keremida Kersey 
  Khandelwal Khazanov Kilvington King Kiran Kirilenko 
  Kirin Kishan Kizikli Klapper Klimacki Klinger Klofa Klukowski 
  Knap Knight Kocak Koch Koistinen Koivula Kokkes Kokten Kolankaya 
  Kolata Kolesnik Kollnes Kolonkaya Kondoch Koneru Kopecky Koppel
  Korbel Kordov Korkut Korth Kosaka Kosti Kotányi Koumetz Kovacs Kovachev 
  Kovacich Kowalski Kozikowski
  Kranyak Krajewski Krausova Krawczyk Krekorian Kriegel Kriftner 
  Kristensen Kroch Krochmalik
  Kuang Kubac Kujawa Kuokkanen Kurbalija Kvangraven 
  Kwiatkowski Kwiecien Kyriakidou Kyrilenko

  Laan Labaere Lachowicz Laffineur Lagrange Lagree Lall Lambardi Lanciano 
  Landry Lantaron Lanzarotti Larsen Larssen Lasserre Latteria Lauria 
  Lavín Lavings Law Lawy Lazer Lazkar Lebatteux Lebel Lebowitz 
  Leca Lechtman Lehtinen Lee Leenhardt Legras Leiro Lena 
  Lennart Leptirici Lerner Lesniewski Lester 
  Lev Levi Levinger Levin Levine Levoy Levski Lew Lewis Lhuissier
  Li Libman Lie Lien Liu Liggins Lilienstein Lillevik Lilley Limmen 
  Linczmayer Lindner Lindstedt Lindqvist Llopart
  Locatelli Lockwood Lombard Longinotti Lorentz Lorenzini Loreto 
  Lormant Louchart Lowe Lubinski Ludewig Lund Luppi Lusk Lusky 
  Lüßmann Lynch Lyngdal Lyngen

  Maas MacDonald Macedo Machado Madsen Magee Maggio Maglietta Mahaffey 
  Maia Maiolani Malarme Maksymetz 
  Malaczynski Malavasi Maluish Manara Mancuso Mandecka Mandelot Mane 
  Manfield Manganella Manglik Manni Mannix Manyawar
  Marashev Marchioni Marek Margarida Margiotta Mari Marill Marina 
  Marincho Marinescu Marino
  Markey Markowicz Marks Marmonti Marquardsen Marsonis Marston
  Marta Martel Martens Masini Mason Martin
  Matheson Matteucci Matushko Marupe Matunga
  Mauberquez Mavridis Mazurkiewicz Maybach Mäkikangas Märsylä
  McAllister McCance McDonald McGann McGinley McGowan McGrath
  McIntosh McKellar McLeish McLeod McKinnon McLeish
  McManus McMahon McMullin McNamara
  Meckstroth Medugno Medved Mejane Mello Mendez Mendoza 
  Meltzer Merah Merapi Merblum Mersin Mesbur Messika Mestres 
  Metselaar Meyer Meyers Meyouhas Mezei Michaud
  Mickiewicz Miles Milgrim Mill Millar Miller Mills Milne Milner 
  Mina Minahasa Miner Miozzi Mira Miroglio Miszewska Mitra Mittelman 
  Mirali Miura Mizel Mizrak 
  Mohtashami Molenaar Molenda Molina Monachan Moni Monsegur Montanari
  Mooney Moran Morath Morawski Moreira Morgan Moritsch Morot
  Morris Morrison Morse Moskovsky Mønsted
  Mortensen Moses Moss Mossop Mott Mouiel
  Mucha Mueller Mullamphy Muller Multon Mundell Munksgaard 
  Munson Munteanu Muriel Murray Mus Mutiara Muzzio Mæsel

  Nab Nadar Nader Naels Nagy Nahmias Naito Narasimhan Naqvi 
  Narasinham Nardullo 
  Natale Navneet
  Neale Negrin Neill Nencini Netto Neuhauser Neulinger Neve 
  Newell Newman Nickell Nielsen Nieminen Nikolenkov Nilsland 
  Nilsson Nimhauser Ninos Nixon Noble Nowosadzki Nørgaard 
  Nunes Nunn Nussbaum Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko Oikonomopoulos
  Olanski Ollikkala Olsen Omran Oncu O'Rourke Ortega
  Onstott Osaulenko Osofsky Otvosi Oursel Outred 
  Ozarar Ozbey Ozdil Ozenir Ozlen Östberg Özbey

  Pacault Paganus Paiva Pajak Paladino Palma Palmeira Palmer 
  Palmund Palau Panagaki Panto Panopoulos Papakyriakopoulos 
  Papaxatzis Parker Parviainen Passarinho Passaro Passell 
  Pattinson Pattison Paulissen Pauncz Pavlicek Payen Pazur
  Peake Pedzinski Peirão Pekkinen Peksen Penfold Percario Peres
  Periasamy Persiani Petculescu Petrucci Pettersson
  Phelan Piasecki Piedra Piekarek Pietraszek Piganeau Pilon Piper
  Pitt Platt Plaut Poizat Pollack Pollak Polowan Pont Popescu 
  Popova Potier Potts Poulat Pownall Prescott Priano Proukakis 
  Procter Prohorov Prusa Pryor Puczynski Pulkrab Purkarthofer Pszczola

  Quail Quantin Queran Quinn

  Rabinowitz Radcliffe Radin Radisic Ramondt Rankin Ranson Rao Rapp 
  Rau Raulund Ravenna Rayner Rees Reess Rehder Reid Rekstad 
  Renouard Reps Revaz Rew Reynolds Rhodes Ribera Ricard Ricci 
  Richardson Richman Riedel Riehm Rigal Rigaud Riisnæs Rimstedt Riolo Rios 
  Rivers Rizzo Robert Robertson Robinson Robles Robson Rocafort 
  Rocca Rodwell Rogoff Rohowsky Roll Romanin Rombaut Rosen 
  Rosenberg Rosendorff Rosetta Rosenkrantz Rosenthal Rossard 
  Rossi Rothfield Roussoglou Roussos Rubin Rubio Rueda Russo Ryman

  Sabbag Sabbatini Sadek Saelensminde Saesseli Sahin Saina Sairanen 
  Sakirler Sakr Salama Salisbury Salliere Salman Salvador Sancaktar
  Sandberg Sandqvist Sansom Saporta Sapounakis Sarten Sarundajang
  Savelli Savorani Savski Sawicki Sayaca Saydi Sayer Sayilkan Sbarigia
  Scanavino Scerri Schaltz Schermer Schlicker Schneider Schnetzer 
  Schonning Schoolmann Schou Schuett Schulle Schulz Schüller Schroeder 
  Scoltock Schreckenberger Scudder Scullin Schwartz Schwerdt
  Sealy Sebbane Seguineau Selberg Selcuk Seligman Semerci Sen Serenella 
  Serf Serifoglu Serpoi Sesyilmaz Sezginsoy Shadyro Sharif Sharp 
  Sher Sherman Shields Shiels Shimamura Shimizu Shirogane Short 
  Shudney Shugart Shunta Silver Silverstein Silverstone Sime 
  Simonsen Simpson Simson Sinclair Sivrioglu Sjodal Skaanning Skelton 
  Skjønnemann Skoglund Skorchev Skwark Small Smart Smilgajs 
  Smith Smirnov Smolanko Snashall Snellers Snow
  Socha Sohlin Soldati Solodar Sonsini Soriano Sorkin Sosler Soukup 
  Soulet Soumitra Sowter Sörvoll Spangenberg Spector Spelmans 
  Spitalnick Spooner Sprung Squires Stabell Stamatov Stankovic 
  Stansby Stark Stavrinos Steel Stegaroiu Steiner Stensson Stephenson 
  Stern Steinberg Sternberg Stevens Stewart Stienen Stilling
  Stoichkov Stoltz Stoppa Street Stretz Strul Strøm Stuart
  Sulgrove Sveindal Sveinsson Svendsen Sugino Summers Sundelin 
  Sundsten Suñol Suresh Sutherlin Suwik Sütmen Svindahl Sykioti Syl 
  Sylvan Symons Szalay Szenberg Szigethy Szots Szymanowski Sørensen

  Tachev Tajima Takayama Talpur Tamburi Tamburrini Tan Tanaka Taner 
  Tarhan Tarkunde Tarnovski Tarsus Taylor Tebha Tedd Teltscher 
  Tembouret Teodorescu Teramoto Terraneo Tesla Tez Thapa Thomsen 
  Thompson Thomson Thoresen Thuillez Thurston Ticha Timoteo Tishler 
  Tislevoll Todd Toffier Toivonen Tokay Tosi Townsend Trabucchi 
  Travis Tritt Troberg Tubiska Tucker Tudor Tulin Tully Tuomi 
  Turner Tuszynski Tuwanakotta Tyradelli Tøndel

  Ueland Uggeri Ultav Una Upmark Uskali Uskela Usluduran Utter Uysal

  Vahaboglu Vahalia Vainikonis Valeanu Valio Valta Varadi Varenne 
  Vasarhelyi Veloni Venetina Venkatesh Ventin Verbeek Verhees 
  Vernay Versace Versluis Viale Viana Vidigal Viennois Videv Vigil 
  Vihtilä Vilella Villegas Vinay Vincent Vinciguerra Virvidakis 
  Vitas Vithaya Vogt Volcker Vorobei Vriend Vroustis Vucic

  Wademark Waledzik Walker Walsh Wang Ware Warne Wasik Watawe 
  Waterlow Waters Watkins Watts Watve Weber Weed Weiler Weingarten 
  Weingold Weinhold Weinstein Weisinger Welland Weltzer Werdelin 
  Wesolowska Westerlund Westheimer Westra Westwood Whibley Wiankowski
  Wigoder Wijma Wikstrom Wildavsky Willcox Wilkinson Willenken 
  Williams Willis Wilson Wiltshire Winciorek Wit Witek Wittes
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey Worm Wortel 
  Wrang Wu Wyer

  Xatzimpalis

  Yadlin Yamada Yang Yarington Yates Yezerski Yilmaz Ying Yoleri Yuen Yule

  Zabunoglu Zago Zagor Zagorin Zajac Zaleski Zanalda Zambonini Zaninotti
  Zaremba Zarkesch Zatorski Zawada Zawislak Zeeberg Zenari Zhan Zhao 
  Zhong Zhukov Zimmermann Zipovski Zobu Zollo Zolotov Zorlu Zotti
  Zozis Zotos
);

my %SINGLE_TYPOS =
(
  Aagaard => ['aagard'],
  Agarwal => ['agarwals'],
  Akgul => ['akgül'],
  'Alain Lévy' => ['levy', 'lévy'],
  'Aline Biondillo' => ['aline'],
  'Ajay Bagaria' => ['bagaria'],
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  'Antonio Frances' => ['frances', 'francés'],
  Araujo => ['araújo'],
  Arcieri => ['arceri'],
  'Aron N. Þorfinnsson' => ['þorfinnsson'],
  'Arunas Jankauskas' => ['arünas'],
  Avcioglu => ['avcýoðlu', 'avcioðlu'],
  'A.K. Bose' => ['a.k.bose'],
  Baleal => ['balelal'],
  Beale => ['beatle'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bertheau => ['berthau'],
  Blumental => ['blummental'],
  'Brigitta Fischer' => ['fischer'],
  Brogeland => ['broge'],
  Bytskevich => ['bytskevitch'],
  'Carlos Ferreira' => ['ferreira'],
  'Chalermpol Wongwaiwit' => ['chalermpol'],
  'Christal Henner-Welland' => ['henner'],
  Ciechomski => ['ciechomek'],
  Combescure => ['combescur'],
  Curo => ['curò'],
  Czímer => ['czimer'],
  Dabrowka => ['d¹brówka'],
  'David Birman' => ['birman'],
  'de Livera' => ['delivera'],
  'de Tessieres' => ['tessieres'],
  Debonnaire => ['debonaire'],
  "Del'Monte" => ['delmonte'],
  Demirbas => ['Demirbaþ'],
  'Diana Damyanova' => ['dianadamyanova'],
  'Dmitri Marchessini' => ['dmitri'],
  'Dr. Ashwani Mehta' => ['ashwani'],
  Dumbovich => ['dumbovic'],
  Eisenberg => ['einsenberg'],
  'Erlend Skjetne' => ['erlendskjetne'],
  'Waleed El Ahmady' => ['elahmady', 'elhamady'],
  Failla => ['faill'],
  'Francisco Costa-Cabral' => ['cabral'],
  'Gabriel Chagas' => ['chagas'],
  Gartaganis => ['gartaginas'],
  Gladysh => ['gladysch'],
  Golebiowski => ['golembiowski'],
  'Carlos Gonçalves' => ['goncalves', 'gonsalves', 'gonçalv', 'gonçalve',
    'gonçalves'],
  Greenwood => ['greenwod'],
  Gromöller => ['gromoeller', 'gromuller'],
  Giura => ['guira'],
  Günther => ['guenther'],
  'Gylfi Baldursson' => ['baldursson'],
  Hackett => ['hakett'],
  Haughie => ['huaghie'],
  'Hecht Johansen' => ['hecht'],
  'Hong NIU' => ['hongniu'],
  'Ilan Bareket' => ['bareket'],
  'Ilan Herbst' => ['herbst'],
  'J.E. Skjanni' => ['skjanni'],
  'J.P. Goenka' => ['goenka', 'jpgoenka'],
  'Jaggy Shivdasani' => ['jaggy'],
  'Jan-Olov Andersson' => ['joa'],
  Jedrychowski => ['jedrychowsky'],
  'Jeovani Salomao' => ['jeovani'],
  'Jeroo Mango' => ['mango'],
  'John Holland' => ['j holland'],
  'José Moraes' => ['moraes'],
  'Jörg Fritsche' => ['fritsche', 'joefri'],
  Kaminski => ['kaminsky'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Kapagiannides' => ['kapagiannides'],
  Karadeniz => ['karadenýz'],
  Karamanlis => ['karamanli'],
  'Kasper Konow' => ['konow'],
  Kazik => ['kazic'],
  Khandelwal => ['khandelwals'],
  Kilvington => ['kilvigton'],
  Koivula => ['koivulat'],
  Kotányi => ['kotanyi'],
  Krochmalik => ['krockmalik'],
  Kurbalija => ['kuribalija'],
  'Lotan Fisher' => ['fisher'],
  'Luis Oliveira' => ['oliveira'],
  Lyngen => ['lyn'],
  Maas => ['mass'],
  'Maria João Lara' => ['lara'],
  Mahaffey => ['mahafey', 'mahaffee'],
  'Majka Cilleborg Bilde' => ['majka'],
  'Manoel Peirao' => ['manoel'],
  'Manuel Capucho' => ['capucho'],
  Manyawar => ['manyvar'],
  'Marius Bartnes' => ['bartnes'],
  'Marc Kerlero de Rosbo' => ['kerlero'],
  Markowicz => ['markovics', 'markowitz'],
  'Maxim Henbest' => ['henbest'],
  Mesbur => ['mesbor'],
  Meltzer => ['metzler'],
  'Miguel Teixeira' => ['teixeira'],
  Milner => ['millner'],
  'Mohsen Kamel' => ['mohsenkamel'],
  Novosadzki => ['novosad'],
  'Nuno Damaso' => ['damaso'],
  "O'Rourke" => ['o_rouke'],
  Olanski => ['olansk'],
  Oursel => ['ousel'],
  Özbey => ['ozbey'],
  'Palma Carlos' => ['pcarlos'],
  Panopoulos => ['panopulos'],
  Patanè => ['patane'],
  'Patrick Jourdain' => ['jourdain'],
  'Paulo Goncalves Pereira' => ['pgp'],
  'Paulo Roberto Brum' => ['brum'],
  'Pedro Madeira' => ['pmadeira'],
  'Pedro Morbey' => ['morbey'],
  'Pedro Pratas' => ['pratas'],
  Peirão => ['peirao'],
  Procter => ['proctor'],
  Prusa => ['prusa m'],
  Pszczola => ['pepsi'],
  Quantin => ['quentin'],
  Riisnæs => ['riisnes'],
  Rosenkrantz => ['rosenkranz'],
  Rosenthal => ['rosentahl'],
  Rubin => ['rugin'],
  'Sally Brock' => ['brock'],
  'Salvatore Luceno' => ['lucenò'],
  'Sanjay Bhattacharya' => ['bhattacharya'],
  Schneider => ['scheinder'],
  Schüller => ['schueller'],
  Selcuk => ['Selçuk'],
  'Simon Gillis' => ['gillis'],
  'Sofia Costa Pessoa' => ['pessoa'],
  Sörvoll => ['sorvoll'],
  Stephenson => ['stephenso'],
  'Saumitra Basu' => ['saumitra'],
  Svendsen => ['svends'],
  Svindahl => ['svindhal'],
  Szenberg => ['szpenberg'],
  Tarnovski => ['tranovski'],
  Teltscher => ['teltsher'],
  Teodorescu => ['teodeorescu'],
  Thuillez => ['tuillez'],
  'Tomi Gotard' => ['tomi'],
  'Tor Helness' => ['helness'],
  'Toshiro Nose' => ['nose'],
  Townsend => ['towsend'],
  Vasarhelyi => ['vasarhely'],
  Venkatesh => ['venky'],
  'Villas Boas' => ['villasboas'],
  Vinciguerra => ['vinci'],
  'Wang Yuan Wei' => ['wangyuanwei'],
  Wigoder => ['wigodor'],
  Wolfson => ['wolson'],
  'Xavier Michaud Larivière' => ['lariviere'],
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

1;
