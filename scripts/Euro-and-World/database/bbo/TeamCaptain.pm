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
  'Alvares Ribeiro',
  'Amedian Bross',
  'Ana Tadeu',
  'Anders Johansson',
  'Aniket Sanghvi',
  'Anita Sinclair',
  'Antonio Maria Campos',
  'Aron N. Þorfinnsson',
  'Artur S. Silva',
  'Arun Bapat',
  'Arun Jain',
  'Arunas Jankauskas',
  'Ashish Malhotra',
  'A.K. Bose',
  'Ilan Bareket',
  'Benedicte Cronier',
  'Bimal Sicka',
  'Birkir Jonsson',
  'Brigitta Fischer',
  'C.V. Rao',
  'Carlo Bossi',
  'Carlos Gonçalves',
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
  'der Kinderen',
  'Defranchi',
  'Della Monta',
  "Del'Monte",
  'Dennis Bilde',
  'di Franco',
  "D'Orsi",
  'Dr. Ashwani Mehta',
  'Efrat Oren',
  'El Ahmady',
  'El Baz',
  'Emil Thomsen',
  'Erikas Vainikonis',
  'Erla Sigurjónsdóttir',
  'Espinosa Paz',
  'Flemming Dahl',
  'Gabriel Chagas',
  'Ginossar',
  'Gunnlaugur Sævarsson',
  'Gunnar Sjökvist',
  'Gylfi Baldursson',
  'H.C. Nielsen',
  'Hecht Johansen',
  'Hemant Jalan',
  'Hermann Friðriksson',
  'Hong NIU',
  'Ilan Herbst',
  'Inocencio Almeida Araujo',
  'J.C. Henriques',
  'J.E. Skjanni',
  'J.P. Goenka',
  'Jan Jansma',
  'Jay Ganesh',
  'Jean le Poder',
  'Jeroo Mango',
  'Jessica Hayman',
  'João Fanha',
  'John Holland',
  'Jón Ásbjörnsson',
  'Jorge Alexandre',
  'Jorge Cruzeiro',
  'José Moraes',
  'Jozef Pochron',
  'Jörg Fritsche',
  'Júlíus Sigurjónsson',
  'Karl Sigurhjartarson',
  'Kasper Konow',
  'Knud Harries',
  'Kristian Tylvad',
  'Krzysztof Strykier',
  'Kumar Vijay Anand',
  "L'Écuyer",
  'Lauge Pedersen',
  'Lotan Fisher',
  'Majka Cilleborg Bilde',
  'Marc ter Laare',
  'Manuel Oliveira',
  'Manuela Mouttet',
  'Mark Gordon',
  'Maya Meera',
  'Maria João Lara',
  'Mariana Leitão',
  'Mariana Nogueira',
  'Mark Micha',
  'Maxim Henbest',
  'Miguel Lima',
  'Miguel A. Ribeiro',
  'Miguel S. Guedes',
  'Miguel Silva',
  'Miguel Sousa Guedes',
  'Miguel Teixeira',
  'Mohit Mehta',
  'Mohsen Kamel',
  'Morten Jepsen',
  'Møller Jepsen',
  'Nabil Chaker',
  'Nabil Edgtton',
  'Nuno Matos',
  'Nuno Sousa',
  'Omar Sharif',
  'Palma Carlos',
  'Pankaj Mehta',
  'Patrick Choy',
  'Patrick Jourdain',
  'Paul Hackett',
  'Paul Van Goor',
  'Paula Lima',
  'Paulo Dias',
  'Paulo Roberto Brum',
  'Paulo Rocha Pinto',
  'Pedro Madeira',
  'Pedro Morbey',
  'Peter de Vries',
  'Peter Schaltz',
  'Poul Clemmensen',
  'Prakash Bandhari',
  'Promila Saraf',
  'Qing Gong',
  'R.K. Sinha',
  'R.L. Kejriwal',
  'R.S. Mishra',
  'Raul Guerreiro',
  'Rodrigo Suares',
  'Rui Pinto',
  'Rui Santos',
  'Rúnar Einarsson',
  'Sally Brock',
  'Sanjay Bhattacharya',
  'Shashi Gupta',
  'Shekhar Banerjee',
  'Signe Thomsen',
  'Simon Gillis',
  'Símon Símonarson',
  'Sinan Abi',
  'Sinan Göksu',
  'Stefán Jóhannsson',
  'Sunil Machhar',
  'Sveinn Ericsson',
  'Sverrir Þórisson',
  'Tor Helness',
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
  'Vincent LI',
  'Ward Platt',
  'Wei Sender',
  'Wubbo de Boer',
  'Xavier Michaud Larivière',
  'Yao Ke',
  'Zack Yaniv',
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
  'Alvensleben' => ['v.alvensleben', 'v. alvensleben'],
  'Antonio Maria Campos' => ['antonio m campos', 'antonio maria campo'],
  'Artur S. Silva' => ['artur s silva'],
  'Arun Jain' => ['arunjain'],
  'Arunas Jankauskas' => ['arünas jankauskas'],
  'A.K. Bose' => ["a.k.bose's iv", "a.k.bose'iv", "a k bose's 4",
    "a k bose's IV"],
  'Ilan Bareket' => ['bareket ilan'],
  'Benedicte Cronier' => ['mme cronier'],
  'Bimal Sicka' => ['bimal sikka'],
  'Birkir Jonsson' => ['birkir j jonsson'],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.', 'cv rao'],
  'Carlos Gonçalves' => ['carlos goncalves'],
  'David Birman' => ['birman david', 'birman d'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Bruyne' => ['de Bruyune'],
  'de Knijff' => ['deknijff', 'di knijff'],
  'de Tessieres' => ['de tessiere', 'de tessier', 'de tessie'],
  "D'Orsi" => ['d orsi'],
  'Efrat Oren' => ['oren efrat'],
  'El Baz' => ['baz'],
  'Erikas Vainikonis' => ['vainikonis e'],
  'Erla Sigurjónsdóttir' => ['erla sigurjónsdótti'],
  'Espinosa Paz' => ['espinoza paz'],
  'Flemming Dahl' => ['dahl'],
  'Francisco Costa Cabral' => ['f. costa cabral', 'f. costa-cabral',
    'francisco c. cabral', 'francisco costa cab'],
  'Ginossar' => ['eldad ginossar', 'ginossar eldad'],
  'Gunnlaugur Sævarsson' => ['gunnlaugur sævars'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hecht Johansen' => ['hecht-johansen', 'hect johansen'],
  'Hermann Friðriksson' => ['Hermann Fridriksson'],
  'Ilan Herbst' => ['herbst i', 'herbst ilan'],
  'Inocencio Almeida Araujo' => ['inocencio arauj'],
  'J.C. Henriques' => ['j.c.henriques', 'j c henriques',
    'j. c. henriques', 'j. carlos henriques', 'jose c. henriques',
    'josé c. henriques', 'josé henriques', 'ze carlos henriques',
    'zé carlos henriques'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni', 'je skjanni'],
  'J.P. Goenka' => ['j.p.goenka'],
  'Jean le Poder' => ['le poder'],
  'João Fanha' => ['j.fanha', 'joao fanha'],
  'John Holland' => ['j holland'],
  'Jón Ásbjörnsson' => ['ásbjörnsson'],
  'Jozef Pochron' =>['j pochron'],
  'Karl Sigurhjartarson' => ['karl sigurhjartar', 'karl sigurhjartars',
    'karl sigurhjartarso', 'karl sigurhjartarss'],
  'Krzysztof Strykier' => ['k.strykier'],
  'Kumar Vijay Anand' => ['kr. vijay anand', 'kr. vijayanand'],
  "L'Écuyer" => ["l'ecuyer", 'lecuyer', 'l ecuyer', 'l"ecuyer'],
  'Lauge Pedersen' => ['lauge-pedersen'],
  'Lotan Fisher' => ['fisher lotan'],
  'Alvares Ribeiro' => ['luis alvares ribeiro', 'luis a ribeiro',
    'luis a. ribeiro'],
  'Manuel Oliveira' => ['manuel oliveia', 'm.oliveira', 'm. oliveira',
    'm oliveira'],
  'Manuela Mouttet' => ['mme mouttet'],
  'Marc ter Laare' => ['ter laare'],
  'Maria João Lara' => ['maria joao lara', 'm joão lara',
    'm joao lara', 'm. j. lara', 'm.j.lara', 'mj.lara',
    'maria j.lara', 'm.joão lara', 'mª joão lara'],
  'Mariana Leitão' =>['mariana leitao'],
  'Maxim Henbest' => ['m.henbest'],
  'Maya Meera' => ['maya meera sneha', 'maya mira'],
  'Miguel S. Guedes' => ['miguel s guedes'],
  'Miguel Teixeira' => ['miguel teixeira', 'm. teixeira'],
  'Mohit Mehta' => ['mohit mehata'],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  'Patanè' => ["patane'"],
  'Paul Hackett' => ['p hackett', 'pd hackett'],
  'Paulo Roberto Brum' => ['brum p'],
  'Paulo Rocha Pinto' => ['paulo pinto', 'rocha pinto'],
  'Pedro Madeira' => ['p. madeira'],
  'Pedro Morbey' => ['p. morbey'],
  'Promila Saraf' => ['promila soraf'],
  'R.K. Sinha' => ["r k sinha'siv", "r k sinha's lv"],
  'R.L. Kejriwal' => ['r l kejriwal', 'r l kejriwaal', 
    'r.l.kejriwal mc', 'r. l. kejriwal', 'rl kejriwal'],
  'Raul Guerreiro' => ['r guerreiro'],
  'R.S. Mishra' => ['r. s. mishra'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Rúnar Einarsson' => ['einarsson'],
  'Sally Brock' => ['s brock'],
  'Shashi Gupta' => ["shashi gupta's 6"],
  'Sinan Göksu' => ['sinan goksu'],
  'Sunil Machhar' => ['sunil machar', 'sunil macchar',
    'sunal macchar', 'sunil maccher'],
  'Sverrir Þórisson' => ['sverrir þ'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward pratt',
    'ward-pratt'],
  'Wei Sender' => ['wei-sender'],
  'Xavier Michaud Larivière' => ['michaud- lariviere',
    'michaud-lariviere', 'michaud lari']
);

my @SINGLE_WORDS = qw(
  Aagaard Abecassis Adad Adams Adamsen Adde Adem Adrei Adriano Adrilla
  Agarwal Agica Agnihotri Agostini Akama Akem Aker Akgul Akgun Akhun 
  Akkab Akkoyunlu Akuzum Alami Alela Alfonsin Alineo Allana Allegaert 
  Allegra Allfrey Allison Allix Alloul Almirall Alocchi Aloi Alonso 
  Altan Altay Alti Altinis Altshuler Alujas Alvensleben
  Amadori Amaral Ames Amoedo Amoils Amol Andersen Anderson Andersson 
  Andrasi Andrea Andreoli Andrew Angeleri Angelini Antmen Antoniou 
  Ao Apfel Appleton Apteker 
  Aranha Araszkiewicz Araujo Arcieri Arle Aroix Armstrong Arun
  Asakoshi Ash Ashworth Ashton Ashwin Askgaard 
  Asmeniadis Assael Assemi Assis
  Atalay Atabey Atay Attaguile Auerbach Auken Aust Austberg 
  Avci Avcioglu Avon Awad Ayda Aydin

  Babacan Babsch Bagge Bailey Baker Bakhshi Baki Bakkeren Baldini 
  Baleal Balkanski Ballebo Bang
  Barat Barbosa Barel Bartnes Barton Basabe Baseggio Basile Bassini
  Bathurst Batov Bauch Bavaresco Bayes Baze
  Bäckström Beauchamp Beale Beatty Becker Bello Bellosta Belonogov
  Bennett Berdichevsky Berg Berger Bergheimer Berkowitz Berktas 
  Berlinski Berman Bernard 
  Bernasconi Bernstein Berrettini Bertens Bertheau Bertolucci Bessis 
  Bettini Beyer Bhalchandra Bhattacharya 
  Biagiotti Bilal Bilski Binderkrantz Bingol Biondillo 
  Biondo Bird Birin Bittner Bitran Bizer
  Bjarnarson Bjerkan Bjornlund Blackstock Blakeman Blakset Blanchard 
  Blanco Blandin Bley Bloom Blumental 
  Bo Boaz Bocchi Bock Bogach Bogacki Bohnhorst Bohnsack Bojoh 
  Boldt Bolling Bolognini
  Bombardieri Bomber Bompis Bongiovanni Bonori Booth Bordallo Bornova 
  Boro Boss Bossi Bostanci Bostosusz
  Boucher Boughey Bourke Bouscat 
  Bowdery Bowles Boylson Bozempergk Bozzo
  Brachman Brady Brake Braithwaite Bramley Branco Brantsma Braun Brenner
  Brightling Brink Brockwell Brod Brogeland Brown Brotteaux Brunet
  Bruun Brunzell
  Buch Buchen Buchlev Buras Burgay Burke Buscaglia Buse 
  Busse Butland Butts Byrne

  Calandra Caldarelli Camacho Camberos Caplan Cappelli Cappeller 
  Caldwell Callaghan Caprera Cambiaghi Campos Caracci Carbonnier Carmichael 
  Casen Cassini Carrasco Carruthers Carvalho Casabona Casadei 
  Castelbranco Castner Cattani Cayne Cengiz Cernat Cernato Cesati
  Chadwick Chai Chambers Chan Chang Charletoux Charlotte Charlsen 
  Chassagne Chatterji Chauvelot Chediak Cheek Chemla Chen Cheng Chizzoli 
  Chottin Chuang
  Cichocki Cilleborg Cimon Ciopettini Clair Clark Clement Clemmensen 
  Close
  Coenraets Coglitore Cohen Cohler Colarossi Coldea Cole Collett 
  Collins Combes Combescure Compton Connie Conti Cook Cooke Cooper Cope 
  Coren Coridakis Corlateanu Cormack Corssen Cotton
  Courtney Coutts Coyne
  Creet Crestey Chrichton Crompton Cronier Crouch 
  Cuevas Cullin Cummings Cuper Çýloðlu Czímer

  Dabrowka Dahlberg Dalecki Dalia Dalley Damaso Damiani 
  Dancewicz Dantan Dao Darak Das Daskalakis 
  Daugava Dauvergne Davies Dawson
  Debolina Debonnaire Debus Dechelette Degla Dehaye Deik Delfour 
  Dellecavakis Delimpaltadakis DeMartino Demirbas Denning Deniz
  Deutsch Deva Dexter Dhir Dhondy Diamond Dinkin Dixon Djurovic
  Dobbels Dobes Dobroiu Doecke Dolla Donatella Donciu Dossena 
  Doub Doussot Doxiadis 
  Drijver Dubini Duguet Duman Dumbovich Dunitz Dunn 
  Duong Dupraz Dupuis Durisotto Dutilloy Dyke

  Eaton Eber Ebery Economou Eden Edgtton 
  Efremov Efthimiou Eggeling Eidi Eisenberg 
  Ekeblad Eksi Ellestad Engel Elinescu Enrique 
  Ergil Erichsen Eriksson Erk Esterson Esteruelas Evans Ewart Eykt

  Fabbri Fagerlund Faidas Faigenbaum Failla Falk Fallenius Fallon 
  Fang Fantonakis Fantoni Farholt Faria Farwell Favard
  Federighi Fegarty Feiler Feng Fernando Ferramosca Ferrara 
  Ferrari Ferreira Fettes
  Fici Figueiredo Filios Filip Finikiotis Fioretti Fireman Firestone 
  Fleisher Fleury Flierl Flock Flora 
  Ford Fordham Fornaciari Forrester Fortini Fout Fox
  Frances Franchi Fraser Frazer Frazzetto Frencken Fredin Freed 
  Fridriksson Friedland Friedlander Friis
  Frosztega Fruewirth Frukacz Frutos
  Fu Fucik Fuglestad Fuller Furunes Furuta Fyrun

  Gabrial Gaede Gaglietto Gardiner Galinsky Gallus Gandoglia Ganzer Garbosi 
  Garvey Garner Gartaganis Gary Gaspar Gaviard Gawel Gawrys
  Genc Generosi Georgescu Gerli Gero Geyer Gezer
  Giangkos Giannessi Gidman Gierulski Gigliotti Gill Ginnan Ginossar 
  Gioia Gitelman Giura Gladiator Gladysh Glanger Glasson Glopson
  Goded Goldberg Goldenfield Goldman Goldstein Golebiowski 
  Gomerov Gomes Goodman
  Goren Gosney Gotard Gottlieb Goyal Göthe
  Grabel Grabowska Gradignan Gradovsky Grainger Gramberg Green 
  Greenberg Greenwood Grenside Grenthe Griffey Griffin Griffoni Griffiths 
  Grimeton Grigoriu Grimaldi Grisho Groemenboom
  Gromov Gromova Gross Grosset Gromöller 
  Gronaldo Grue Gruia Grunt Gruschow Grzelak
  Guariglia Gudkov Gue Gueglio Guerreiro Guglietto Guillaumin 
  Gula Gumby Guo Gupta Gurley Gursel Gustawsson Gutmark Guy Günther

  Hackett Hadjibalis Haffer Hagenberg Haidorfer Hallen Hamman 
  Hampson Hampton Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harding Harley Harper Harries Harris Harrison Harsanyi 
  Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Helgemo Helle Helmich Helms Heng Henneberg Henner 
  Herman Heskje Hillman Hinden Hirst Hliapas
  Hoffa Hoffman Hollands Hollman Honti Hopfenheit Hornibrook Horton Horwitz 
  Howard Howe Høyland
  Hu Huang Hughes Hugon Hugony Hult Hung Hupe

  Ichilcik Ingielewicz Iommi Iontzeff Irens Ivatury Iversen Ivrig Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jain Jalowka Jamieson
  Janicki Jankova Janiszewski Janowski 
  Jansma Janssen Jarlot Jarov Jassem Jawell Jayganesh 
  Jedrychowski Jeng Jensen Jepsen Jessheim Jian Jiang 
  Joel Johansen Johansson Johnson Jolly Jonsson Jokisch Jones 

  Kachchu Kahyaoglu Kaiser Kalita Kalish Kallsberg Kallunki Kalma Kalmin 
  Kamal Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kane Kanetkar 
  Kapadia Kapagiannidis Kaplan Kaptan
  Karadeniz Karamanlis Karavil Karl Karpouzelis Kasday Kasle Kasler Kastel
  Katz Kaushik Kay Kazik Kendrick Kenny Kent Keremida Kersey
  King Kiran Kirilenko Kirin Kizikli Klinger Klofa Klukowski Knap Knight
  Kocak Koch Koistinen Koivula Kokkes Kokten Kolankaya Kolata Kolesnik 
  Kondoch Kopecky Koppel
  Korbel Kordov Korkut Korth Kosaka Kosti Kotányi Koumetz Kovacs Kovachev 
  Kovacich Kowalski Kozikowski
  Kranyak Krausova Krawczyk Krekorian Kriegel Kriftner Kristensen Krochmalik
  Kuang Kubac Kuokkanen Kvangraven Kwiatkowski Kwiecien Kyriakidou

  Laan Lachowicz Laffineur Lagrange Lall Lambardi Lanciano 
  Landry Lantaron Lanzarotti 
  Larsen Larssen Lasserre Latteria Lauria Lavín Lavings Law Lawy Lazer
  Lebatteux Lebel Lebowitz Lechtman Lehtinen Lee Leenhardt Legras Lena 
  Lennart Leptirici Lerner Lesniewski Lester 
  Lev Levi Levinger Levin Levine Levski Lew Lewis Lhuissier
  Li Libman Lie Liggins Lilienstein Lillevik Lilley Limmen Lindner 
  Lindstedt Lindqvist Llopart
  Locatelli Lockwood Lombard Longinotti Lorentz Lorenzini Loreto Lowe
  Lubinski Ludewig Lund Luppi Lusk Lusky Lüßmann Lynch Lyngdal Lyngen

  Maas MacDonald Machado Madsen Magee Maggio Maglietta Mahaffey 
  Maiolani Malarme Maksymetz 
  Malaczynski Malavasi Maluish Mancuso Mane Manfield Manglik Manni Mannix
  Manyawar
  Marashev Marchioni Marek Margarida Margiotta Mari Marill Marina 
  Marincho Marinescu Marino
  Markey Markowicz Marks Marmonti Marquardsen Marsonis Marston
  Marta Martel Martens Masini Mason Martin
  Matheson Matteucci Matushko Marupe Matunga
  Mauberquez Mavridis Mazurkiewicz Maybach Mäkikangas
  McAllister McCance McDonald McGann McGinley McGowan McGrath
  McIntosh McKellar McLeish McLeod McKinnon McLeish
  McManus McMahon McMullin McNamara
  Meckstroth Medugno Medved Mejane Mello Mendez Mendoza 
  Meltzer Merah Merapi Merblum Mersin Mesbur Mestres 
  Metselaar Meyer Meyers Meyouhas
  Mickiewicz Miles Milgrim Mill Millar Miller Mills Milne Milner 
  Minahasa Miozzi Mira Miroglio Mitra Mittelman 
  Mirali Miura Mizrak 
  Mohtashami Molenaar Molenda Molina Monachan Moni Monsegur Montanari
  Mooney Moran Morath Morawski Morgan Moritsch Morot
  Morris Morrison Morse Moskovsky Mønsted
  Mortensen Moss Mossop Mott Mouiel
  Mucha Mueller Mullamphy Muller Multon Mundell Munksgaard 
  Munson Munteanu Muriel Murray Mus Mutiara Mæsel

  Nab Nader Naels Nagy Nahmias Naito Narasimhan Naqvi Nardullo 
  Natale Navneet
  Neale Negrin Neill Nencini Netto Neuhauser Neulinger Neve 
  Newell Newman Nickell Nielsen Nieminen Nikolenkov Nilsland 
  Nilsson Ninos Nixon Noble Nowosadzki Nørgaard Nunes Nunn Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko Oikonomopoulos
  Olanski Oliveira Olsen Omran Oncu O'Rourke Ortega
  Onstott Osaulenko Osofsky Oursel Ozarar Ozbey Ozdil Ozenir
  Östberg Özbey

  Pacault Paganus Paiva Pajak Palma Palmeira Palmer Palmund Palau 
  Panagaki Papaxatzis Parker Parviainen Passaro Passell Pattinson Pattison
  Paulissen Pauncz Payen Pazur
  Peake Pedzinski Peirão Pekkinen Peksen Penfold Percario Pereira 
  Periasamy Pessoa Petculescu Petrucci Pettersson
  Phelan Piasecki Piedra Piekarek Pietraszek Piganeau Pilon Pinto Piper
  Pitt Platt Plaut Pollack Pollak Polowan Pont Popescu Popova Potier 
  Poulat Pownall Prescott Priano Proukakis Procter Pryor Puczynski

  Quail Quantin Quinn

  Rabinowitz Radcliffe Radisic Rankin Rao Raulund Ravenna Rayner
  Rees Rehder Reid Rekstad Renouard Revaz Reynolds
  Ribera Ricard Ricci Richardson Richman Riedel Riehm Rigal Rigaud 
  Rimstedt Rios Rivers Rizzo
  Robert Robertson Robinson Robles Robson Rocafort Rocca Rodwell
  Rogoff Rohowsky Roll Rombaut Rosen Rosendorff Rosetta 
  Rosenkrantz Rosenthal Rossard Rossi Rothfield Rourke Roussoglou Roussos
  Rubin Rubio Rueda Ryman

  Sabbatini Sadek Saelensminde Saesseli Saina Sairanen Sakr Salliere
  Salman Sandqvist Santos Sansom Sapounakis Savelli Savorani 
  Sawicki Saydi Sayer Sayilkan Sbarigia
  Scerri Schaltz Schermer Schlicker Schneider Schnetzer Schonning
  Schoolmann Schou Schulz Schüller Schroeder Scoltock Schreckenberger 
  Scudder Schwartz Schwerdt
  Sealy Sebbane Seguineau Selberg Selcuk Seligman Serenella Serf 
  Serpoi Sesyilmaz 
  Shadyro Sharif Shiels Shimamura Shimizu Shirogane Short Shugart 
  Silver Silverstein Silverstone Sime Simonsen Simpson Simson Sinclair 
  Skaanning Skelton Skorchev Small Smart Smilgajs Smith Smirnov Smolanko 
  Snashall Snellers 
  Sohlin Soldati Solodar Sonsini Sorkin Soukup Soulet Soumitra Sowter
  Spangenberg Spector Spooner Sprung Squires
  Stabell Stamatov Stankovic Stansby Stark Stavrinos
  Steel Steiner Stephenson Stern 
  Sternberg Stevens Stewart Stienen
  Stoichkov Street Stretz Strul Strøm Stuart
  Sveindal Sveinsson Svendsen 
  Sugino Summers Sundelin Sundsten Suresh Suwik
  Syl Sylvan Szalay Szots

  Tajima Takayama Tamburrini Tan Tanaka Tarhan Tarsus Taylor 
  Tebha Teltscher Teodorescu Teramoto Terraneo Tesla Tez
  Thapa Thomsen Thompson Thomson Thoresen Thuillez Thurston 
  Ticha Tishler Tislevoll Todd Toffier Toivonen Tokay Tosi Townsend 
  Travis Troberg Tubiska Tucker Tudor Tulin Tully Tuomi Turner Tuszynski 
  Tuwanakotta Tyradelli

  Ueland Uggeri Una Upmark Uskali Utter Uysal

  Vainikonis Valeanu Valio Valta
  Veloni Venkatesh Ventin Verbeek Verhees Versace Versluis
  Viana Videv Vigil Vihtilä Vinay Vinciguerra Virvidakis Vitas 
  Vogt Volcker Vorobei Vriend Vroustis

  Wademark Walsh Wang Ware Warne Wasik Waterlow Waters Watts 
  Weed Weingarten Weingold Weinstein Weisinger Welland Werdelin 
  Westerlund Westheimer Westra Westwood Whibley Wigoder Wijma 
  Wikstrom Wildavsky Wilkinson 
  Willenken Williams Willis Wiltshire Witek Wittes
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Worm Wortel Wrang Wu Wyer

  Xatzimpalis

  Yamada Yarington Yates Yezerski Yilankiran Yilmaz Yoleri Yuen Yule

  Zabunoglu Zagor Zagorin Zaleski Zanalda Zarkesch Zawada Zeeberg Zenari 
  Zhan Zhong Zimmermann Zollo Zorlu Zozis Zotos
);

my %SINGLE_TYPOS =
(
  Aagaard => ['aagard'],
  Agarwal => ['agarwals'],
  Akgul => ['akgül'],
  'Alain Lévy' => ['levy', 'lévy'],
  'Ajay Bagaria' => ['bagaria'],
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  Araujo => ['araújo'],
  Arcieri => ['arceri'],
  'Aron N. Þorfinnsson' => ['þorfinnsson'],
  'Arunas Jankauskas' => ['arünas'],
  Avcioglu => ['avcýoðlu', 'avcioðlu'],
  'A.K. Bose' => ['a.k.bose'],
  Baleal => ['balelal'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bertheau => ['berthau'],
  Blumental => ['blummental'],
  'Brigitta Fischer' => ['fischer'],
  Combescure => ['combescur'],
  Czímer => ['czimer'],
  'David Birman' => ['birman'],
  'de Livera' => ['delivera'],
  'de Tessieres' => ['tessieres'],
  Debonnaire => ['debonaire'],
  "Del'Monte" => ['delmonte'],
  Demirbas => ['Demirbaþ'],
  'Dr. Ashwani Mehta' => ['ashwani'],
  Dumbovich => ['dumbovic'],
  Eisenberg => ['einsenberg'],
  'El Ahmady' => ['elahmady'],
  Karadeniz => ['karadenýz'],
  'Lotan Fisher' => ['fisher'],
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
  Haughie => ['huaghie'],
  'Hecht Johansen' => ['hecht'],
  'Hong NIU' => ['hongniu'],
  'Ilan Bareket' => ['bareket'],
  'Ilan Herbst' => ['herbst'],
  'J.E. Skjanni' => ['skjanni'],
  'J.P. Goenka' => ['goenka', 'jpgoenka'],
  Jedrychowski => ['jedrychowsky'],
  'Jeroo Mango' => ['mango'],
  'José Moraes' => ['moraes'],
  'Jörg Fritsche' => ['fritsche', 'joefri'],
  Kaminski => ['kaminsky'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Kapagiannides' => ['kapagiannides'],
  'Kasper Konow' => ['konow'],
  Kazik => ['kazic'],
  Kotányi => ['kotanyi'],
  Lubinski => ['lubinsky'],
  Lyngen => ['lyn'],
  'Maria João Lara' => ['lara'],
  Mahaffey => ['mahafey', 'mahaffee'],
  'Majka Cilleborg Bilde' => ['majka'],
  Manyawar => ['manyvar'],
  Markowicz => ['markovics', 'markowitz'],
  McLeish => ['mc. leish'],
  'Maxim Henbest' => ['henbest'],
  Mesbur => ['mesbor'],
  'Miguel Teixeira' => ['teixeira'],
  Milner => ['millner'],
  "O'Rourke" => ['o_rouke'],
  Olanski => ['olansk'],
  Oursel => ['ousel'],
  'Özbey' => ['ozbey'],
  'Patanè' => ['patane'],
  'Patrick Jourdain' => ['jourdain'],
  'Pedro Morbey' => ['morbey'],
  'Peirão' => ['peirao'],
  'Procter' => ['proctor'],
  Quantin => ['quentin'],
  'Sally Brock' => ['brock'],
  'Sanjay Bhattacharya' => ['bhattacharya'],
  'Simon Gillis' => ['gillis'],
  Stephenson => ['stephenso'],
  Svendsen => ['svends'],
  Teltscher => ['teltsher'],
  Thuillez => ['tuillez'],
  'Tor Helness' => ['helness'],
  Venkatesh => ['venky'],
  Vinciguerra => ['vinci'],
  Wigoder => ['wigodor'],
  'Xavier Michaud Larivière' => ['lariviere'],
  Zabonoglu => ['zabunoðlu'],
  Zaleski => ['zalesky'],
  Zimmermann => ['zimmmermann', 'zimmerman', 'zimermann',
    'zimerman', 'zmmermann'],
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
