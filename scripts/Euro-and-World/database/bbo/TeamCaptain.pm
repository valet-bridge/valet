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
  'Ajay Vaish',
  'Alain Lévy',
  'Alvares Ribeiro',
  'Anders Johansson',
  'Anita Sinclair',
  'Antonio Maria Campos',
  'Artur S. Silva',
  'Arun Bapat',
  'Arun Jain',
  'A.K. Bose',
  'Bareket',
  'Benedicte Cronier',
  'C.V. Rao',
  'Carlo Bossi',
  'Carlos Gonçalves',
  'David Birman',
  'De Blasi',
  'de Botton',
  'de Bruyne',
  'de Knijff',
  'de Livera',
  'de Lombard',
  'de Monval',
  'De Muller',
  'der Kinderen',
  'Defranchi',
  'Della Monta',
  "Del'Monte",
  "D'Orsi",
  'El Baz',
  'Emil Thomsen',
  'Erla Sigurjónsdóttir',
  'Flemming Dahl',
  'Ginossar',
  'H.C. Nielsen',
  'Hecht Johansen',
  'Hemant Jalan',
  'J.C. Henriques',
  'J.E. Skjanni',
  'J.P. Goenka',
  'Jan Jansma',
  'Jay Ganesh',
  'Jeroo Mango',
  'Jessica Hayman',
  'João Fanha',
  'John Holland',
  'Jorge Cruzeiro',
  'Kasper Konow',
  'Krzysztof Strykier',
  "L'Écuyer",
  'Lauge Pedersen',
  'Lotan Fisher',
  'Marc ter Laare',
  'Manuel Oliveira',
  'Mark Gordon',
  'Maya Meera Sneha',
  'Maria João Lara',
  'Maxim Henbest',
  'Miguel Lima',
  'Miguel A. Ribeiro',
  'Miguel S. Guedes',
  'Miguel Silva',
  'Miguel Sousa Guedes',
  'Miguel Teixeira',
  'Mohit Mehta',
  'Morten Jepsen',
  'Møller Jepsen',
  'Nabil Chaker',
  'Nabil Edgtton',
  'Nuno Matos',
  'Nuno Sousa',
  'Palma Carlos',
  'Paul Hackett',
  'Paul Van Goor',
  'Paula Lima',
  'Paulo Rocha Pinto',
  'Peter de Vries',
  'Peter Schaltz',
  'Poul Clemmensen',
  'Qing Gong',
  'R.K. Sinha',
  'R.L. Kejriwal',
  'Rui Pinto',
  'Rui Santos',
  'Rúnar Einarsson',
  'Sally Brock',
  'Shashi Gupta',
  'Signe Thomsen',
  'Simon Gillis',
  'Sinan Abi',
  'Sinan Göksu',
  'Sunil Machhar',
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
  'Acacio Figueiredo' => ['acacio f.'],
  'Adam Edgtton' => ['a edgtton', 'a.edgtton'],
  'Alain Lévy' => ['alain levy'],
  'Alain Lévy' => ['levy', 'lévy'],
  'Alok Daga' => ["alok daga's iv"],
  'Alvensleben' => ['v.alvensleben', 'v. alvensleben'],
  'Antonio Maria Campos' => ['antonio m campos', 'antonio maria campo'],
  'Artur S. Silva' => ['artur s silva'],
  'Arun Jain' => ['arunjain'],
  'A.K. Bose' => ["a.k.bose's iv", "a.k.bose'iv", "a k bose's 4",
    "a k bose's IV"],
  'Bareket' => ['bareket ilan'],
  'Benedicte Cronier' => ['mme cronier'],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.'],
  'Carlos Gonçalves' => ['carlos goncalves'],
  'David Birman' => ['birman david', 'birman d'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Bruyne' => ['de Bruyune'],
  'de Knijff' => ['deknijff', 'di knijff'],
  "D'Orsi" => ['d orsi'],
  'El Baz' => ['baz'],
  'Erla Sigurjónsdóttir' => ['erla sigurjónsdótti'],
  'Flemming Dahl' => ['dahl'],
  'Ginossar' => ['eldad ginossar', 'ginossar eldad'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hecht Johansen' => ['hecht-johansen', 'hect johansen'],
  'J.C. Henriques' => ['j.c.henriques', 'j c henriques',
    'j. c. henriques', 'j. carlos henriques', 'jose c. henriques',
    'josé c. henriques', 'josé henriques'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni', 'je skjanni'],
  'J.P. Goenka' => ['j.p.goenka'],
  'João Fanha' => ['j.fanha', 'joao fanha'],
  'John Holland' => ['j holland'],
  'Krzysztof Strykier' => ['k.strykier'],
  "L'Écuyer" => ["l'ecuyer", 'lecuyer', 'l ecuyer'],
  'Lauge Pedersen' => ['lauge-pedersen'],
  'Lotan Fisher' => ['fisher lotan'],
  'Manuel Oliveira' => ['manuel oliveia', 'm.oliveira', 'm. oliveira',
    'm oliveira'],
  'Marc ter Laare' => ['ter laare'],
  'Maria João Lara' => ['maria joao lara', 'm joão lara',
    'm joao lara', 'm. j. lara', 'm.j.lara', 'mj.lara',
    'maria j.lara', 'm.joão lara', 'mª joão lara'],
  'Maxim Henbest' => ['m.henbest'],
  'Maya Meera Sneha' => ['maya meera'],
  'Miguel S. Guedes' => ['miguel s guedes'],
  'Miguel Teixeira' => ['miguel teixeira', 'm. teixeira'],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  'Patanè' => ["patane'"],
  'Paul Hackett' => ['p hackett'],
  'Paulo Rocha Pinto' => ['paulo pinto', 'rocha pinto'],
  'R.K. Sinha' => ["r k sinha'siv", "r k sinha's lv"],
  'R.L. Kejriwal' => ['r l kejriwal', 'r l kejriwaal', 'r.l.kejriwal mc'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Rúnar Einarsson' => ['einarsson'],
  'Sally Brock' => ['s brock'],
  'Shashi Gupta' => ["shashi gupta's 6"],
  'Sinan Göksu' => ['sinan goksu'],
  'Sunil Machhar' => ['sunil machar', 'sunil macchar',
    'sunal macchar', 'sunil maccher'],
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
  Aagaard Abecassis Adad Adams Adamsen Adde Agarwal Agostini 
  Aker Akhun Alami Alfonsin Allana Allegra Allfrey Allison Allix
  Almirall Alonso Altan Altay Alti Altinis Altshuler Alvensleben
  Amadori Ames Amoedo Amoils Amol Andersen Anderson Andersson 
  Andrasi Andrea Andreoli Andrew Angeleri Angelini Antmen Antoniou 
  Ao Apfel Appleton Apteker 
  Aranha Araszkiewicz Arle Armstrong Arun
  Ash Ashworth Ashton Ashwin Askgaard Asmeniadis Assael Assis
  Atalay Attaguile Auerbach Auken Austberg Avcioglu Avon

  Babacan Babsch Bagge Bailey Baker Bakhshi Baki Bakkeren Baldini 
  Baldursson Baleal Balkanski Ballebo Banerjee Bang
  Barat Barbosa Bareket Barel Bartnes Barton Basabe Baseggio Basile Bassini
  Bathurst Batov Bauch Bavaresco Bayes Baze
  Bäckström Beauchamp Beale Beatty Becker Bello Bellosta Belonogov
  Bennett Berdichevsky Berg Berger Bergheimer Berkowitz Berktas 
  Berlinski Berman Bernard 
  Bernasconi Bernstein Berrettini Bertens Bertheau Bertolucci Bessis 
  Bettini Beyer Bhalchandra Bhattacharya 
  Biagiotti Bilal Bilde Bilski Binderkrantz Bingol Biondillo 
  Biondo Bird Birin Bittner Bizer
  Bjarnarson Bjerkan Bjornlund Blackstock Blakeman Blakset Blanchard 
  Blanco Blandin Bley Bloom Blumental 
  Bo Boaz Bocchi Bock Bogach Bogacki Bohnhorst Bohnsack Bojoh 
  Boldt Bolling Bolognini
  Bombardieri Bomber Bompis Bongiovanni Bonori Booth Bordallo Bornova 
  Boro Boss Bossi Bostanci Bostosusz
  Boucher Boughey Bourke Bouscat 
  Bowdery Bowles Boylson Bozempergk Bozzo
  Brachman Brady Brake Braithwaite Bramley Branco Brantsma Braun Brenner
  Brightling Brink Brockwell Brod Brogeland Brown Brotteaux Brum Brunet
  Bruun Brunzell
  Buch Buchen Buchlev Buras Burgay Burke Buscaglia Buse 
  Busse Butland Butts Byrne

  Calandra Caldarelli Camacho Camberos Caplan Cappelli Cappeller 
  Caldwell Callaghan Caprera Cambiaghi Campos Caracci Carbonnier Carmichael 
  Cassini Carrasco Carruthers Carvalho Casabona Casadei Castelbranco 
  Castner Cattani Cayne Cengiz Cernat Cernato Cesati
  Chadwick Chagas Chai Chambers Chan Chang Charletoux Charlotte Charlsen 
  Chassagne Chatterji Chauvelot Chediak Cheek Chemla Chen Cheng Chizzoli 
  Chottin Chuang
  Cichocki Cilleborg Cimon Ciopettini Clair Clark Clement Clemmensen 
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
  Dobbels Dobes Doecke Dolla Donatella Dossena Doussot Doxiadis Drijver 
  Dubini Duguet Duman Dumbovich Dunitz Dunn 
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
  Fischer Fleisher Fleury Flierl Flock Flora 
  Ford Fordham Fornaciari Forrester Fortini Fout Fox
  Frances Franchi Fraser Frazer Frazzetto Frencken Fredin Freed 
  Fridriksson Friedland Friedlander Friis Fritsche 
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

  Hackett Hadjibalis Haffer Haidorfer Hallen Hamman Hampson Hampton 
  Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harding Harley Harper Harries Harris Harrison Harsanyi 
  Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Helgemo Helle Helmich Helms Heng Henneberg Henner 
  Herbst Herman Heskje Hillman Hinden Hirst Hliapas
  Hoffa Hoffman Hollands Hollman Honti Hopfenheit Hornibrook Horton Horwitz 
  Howard Howe Høyland
  Hu Huang Hughes Hugon Hugony Hult Hung Hupe

  Ichilcik Ingielewicz Iommi Iontzeff Irens Ivatury Iversen Ivrig Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jain Jalowka Jamieson
  Janicki Jankova Janiszewski Janowski 
  Jansma Janssen Jarlot Jarov Jassem Jawell Jayganesh 
  Jedrychowski Jeng Jensen Jepsen Jessheim Jian Jiang 
  Joel Johansen Johansson Johnson Jolly Jonsson Jokisch Jones Jourdain

  Kachchu Kahyaoglu Kaiser Kalita Kalish Kallsberg Kallunki Kalma Kalmin 
  Kamal Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kane Kanetkar 
  Kapadia Kapagiannidis Kaplan Kaptan
  Karadeniz Karamanlis Karavil Karl Kasday Kasle Kasler Kastel
  Katz Kay Kazik Kendrick Kenny Kent Keremida Kersey
  King Kiran Kirilenko Kirin Kizikli Klinger Klofa Klukowski Knap Knight
  Kocak Koch Koistinen Koivula Kokkes Kokten Kolankaya Kolata Kolesnik 
  Kondoch Kopecky Koppel
  Korbel Kordov Korkut Korth Kosti Kotányi Koumetz Kovacs Kovachev 
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
  Lubinski Ludewig Lund Luppi Lusk Lusky Lüßmann Lynch Lyngdal

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
  Meckstroth Medugno Medved Mehta Mejane Mello Mendez Mendoza 
  Meltzer Merah Merapi Merblum Mersin Mesbur Mestres 
  Metselaar Meyer Meyers Meyouhas
  Mickiewicz Miles Milgrim Mill Millar Miller Mills Milne Milner 
  Minahasa Miozzi Mira Miroglio Mitra Mittelman 
  Miura Mizrak Mohsen
  Mohtashami Molenaar Molenda Molina Monachan Moni Monsegur Montanari
  Mooney Moran Morath Morawski Morbey Morgan Moritsch Morot
  Morris Morrison Morse Moskovsky Mønsted
  Mortensen Moss Mossop Mott Mouiel
  Mucha Mueller Mullamphy Muller Multon Mundell Munksgaard 
  Munson Munteanu Muriel Murray Mus Mutiara

  Nab Nader Naels Nagy Nahmias Narasimhan Naqvi Nardullo Natale Navneet
  Neale Negrin Neill Nencini Netto Neuhauser Neulinger Neve 
  Newell Newman Nickell Nielsen Nieminen Nikolenkov Nilsland 
  Nilsson Ninos Nixon Noble Nowosadzki Nørgaard Nunes Nunn Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko Oikonomopoulus
  Oliveira Olsen Omran Oncu O'Rourke Ortega
  Onstott Osaulenko Osofsky Oursel Ozarar Ozbey Ozdil Ozenir
  Östberg Özbey

  Paganus Paiva Pajak Palma Palmeira Palmer Palmund Palau 
  Panagaki Papaxatzis Parker Parviainen Passaro Passell Pattinson Pattison
  Paulissen Pauncz Payen Pazur
  Peake Pedzinski Peirão Pekkinen Peksen Penfold Percario Pereira 
  Periasamy Pessoa Petculescu Petrucci Pettersson
  Phelan Piasecki Piedra Piekarek Pietraszek Piganeau Pilon Pinto Piper
  Pitt Platt Plaut Pollack Pollak Polowan Pont Popescu Popova Potier 
  Poulat Prescott Priano Proukakis Procter Pryor Puczynski

  Quail Quantin Quinn

  Rabinowitz Radcliffe Radisic Rankin Rao Raulund Ravenna Rayner
  Rehder Rekstad Renouard Revaz Reynolds
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
  Schoolmann Schou Schulz Schüller
  Scoltock Schreckenberger Scudder Schwartz Schwerdt
  Sealy Sebbane Seguineau Selberg Selcuk Seligman Serenella Serf 
  Serpoi Sesyilmaz Shadyro Sharif Shiels Shimizu Shirogane Short Shugart 
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
  Summers Sundelin Sundsten Suresh Suwik
  Syl Sylvan Szalay Szots

  Takayama Tamburrini Tan Tanaka Tarhan Tarsus Taylor 
  Tebha Teltscher Teodorescu Teramoto Terraneo Tesla Tez
  Thapa Thomsen Thompson Thomson Thoresen Thuillez Thurston 
  Ticha Tishler Tislevoll Todd Toffier Toivonen Tokay Tosi Townsend 
  Travis Troberg Tubiska Tucker Tudor Tulin Tuomi Turner Tuszynski 
  Tuwanakotta Tyradelli

  Ueland Uggeri Una Upmark Uskali Utter Uysal

  Vainikonis Valeanu Valio Valta
  Veloni Venkatesh Ventin Verbeek Verhees Versace Versluis
  Viana Videv Vigil Vihtilä Vinay Vinciguerra Virvidakis Vitas 
  Vogt Volcker Vorobei Vriend Vroustis

  Walsh Wang Wasik Waterlow Waters Watts Weingarten Weingold 
  Weinstein Weisinger Welland Werdelin Westerlund Westheimer Westra
  Westwood Whibley Wigoder Wijma Wikstrom Wildavsky Wilkinson 
  Willenken Williams Willis Wiltshire Witek Wittes
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Worm Wortel Wrang Wyer

  Xatzimpalis

  Yamada Yarington Yates Yezerski Yilankiran Yilmaz Yoleri Yule

  Zabunoglu Zagor Zagorin Zaleski Zanalda Zarkesch Zawada Zeeberg Zenari 
  Zhan Zhong Zimmermann Zollo Zorlu Zozis Zotos
);

my %SINGLE_TYPOS =
(
  Aagaard => ['aagard'],
  'Alain Lévy' => ['levy', 'lévy'],
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  'A.K. Bose' => ['a.k.bose'],
  Baleal => ['balelal'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bertheau => ['berthau'],
  Blumental => ['blummental'],
  Combescure => ['combescur'],
  Czímer => ['czimer'],
  'David Birman' => ['birman'],
  'de Livera' => ['delivera'],
  Debonnaire => ['debonaire'],
  "Del'Monte" => ['delmonte'],
  Demirbas => ['Demirbaþ'],
  Dumbovich => ['dumbovic'],
  Eisenberg => ['einsenberg'],
  Karadeniz => ['karadenýz'],
  'Lotan Fisher' => ['fisher'],
  Gartaganis => ['gartaginas'],
  Gladysh => ['gladysch'],
  Golebiowski => ['golembiowski'],
  'Carlos Gonçalves' => ['goncalves', 'gonsalves', 'gonçalv', 'gonçalve'],
  Greenwood => ['greenwod'],
  Gromöller => ['gromoeller', 'gromuller'],
  Giura => ['guira'],
  Günther => ['guenther'],
  Haughie => ['huaghie'],
  'Hecht Johansen' => ['hecht'],
  'J.E. Skjanni' => ['skjanni'],
  'J.P. Goenka' => ['goenka', 'jpgoenka'],
  Jedrychowski => ['jedrychowsky'],
  'Jeroo Mango' => ['mango'],
  Kaminski => ['kaminsky'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Kapagiannides' => ['kapagiannides'],
  'Kasper Konow' => ['konow'],
  Kazik => ['kazic'],
  Kotányi => ['kotanyi'],
  Lubinski => ['lubinsky'],
  'Maria João Lara' => ['lara'],
  Mahaffey => ['mahafey', 'mahaffee'],
  Manyawar => ['manyvar'],
  Markowicz => ['markovics', 'markowitz'],
  'Maxim Henbest' => ['henbest'],
  Mesbur => ['mesbor'],
  'Miguel Teixeira' => ['teixeira'],
  Milner => ['millner'],
  "O'Rourke" => ['o_rouke'],
  Oursel => ['ousel'],
  'Özbey' => ['ozbey'],
  'Patanè' => ['patane'],
  'Peirão' => ['peirao'],
  'Procter' => ['proctor'],
  'Sally Brock' => ['brock'],
  'Simon Gillis' => ['gillis'],
  Teltscher => ['teltsher'],
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
