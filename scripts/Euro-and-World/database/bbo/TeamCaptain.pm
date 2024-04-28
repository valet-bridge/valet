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
  'Alvares Ribeiro',
  'Anita Sinclair',
  'Antonio Maria Campos',
  'Arun Bapat',
  'Arun Jain',
  'A.K. Bose',
  'Bareket',
  'Benedicte Cronier',
  'C.V. Rao',
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
  'Krzysztof Strykier',
  "L'Écuyer",
  'Lotan Fisher',
  'Marc ter Laare',
  'Manuel Oliveira',
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
  'Rui Pinto',
  'Rui Santos',
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
  'Yao Ke',
  'Zack Yaniv',
  'Zia Mahmood',
  'ZHOU Tao'
);

my %MULTI_TYPOS =
(
  'Acacio Figueiredo' => ['acacio f.'],
  'Adam Edgtton' => ['a edgtton', 'a.edgtton'],
  'Alvensleben' => ['v.alvensleben', 'v. alvensleben'],
  'Antonio Maria Campos' => ['antonio m campos', 'antonio maria campo'],
  'Arun Jain' => ['arunjain'],
  'A.K. Bose' => ["a.k.bose's iv", "a.k.bose'iv", "a k bose's 4"],
  'Bareket' => ['bareket ilan'],
  'Benedicte Cronier' => ['mme cronier'],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.'],
  'David Birman' => ['birman david', 'birman d.'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Bruyne' => ['de Bruyune'],
  'de Knijff' => ['deknijff', 'di knijff'],
  "D'Orsi" => ['d orsi'],
  'El Baz' => ['baz'],
  'Flemming Dahl' => ['dahl'],
  'Ginossar' => ['eldad ginossar'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hecht Johansen' => ['hecht-johansen'],
  'J.C. Henriques' => ['j.c.henriques', 'j c henriques',
    'j. c. henriques', 'j. carlos henriques', 'jose c. henriques',
    'josé c. henriques', 'josé henriques'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni', 'je skjanni'],
  'J.P. Goenka' => ['j.p.goenka'],
  'João Fanha' => ['j.fanha', 'joao fanha'],
  'John Holland' => ['j holland'],
  'Krzysztof Strykier' => ['k.strykier'],
  "L'Écuyer" => ["l'ecuyer", 'lecuyer', 'l ecuyer'],
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
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Sally Brock' => ['s brock'],
  'Shashi Gupta' => ["shashi gupta's 6"],
  'Sinan Göksu' => ['sinan goksu'],
  'Sunil Machhar' => ['sunil machar'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward pratt'],
  'Wei Sender' => ['wei-sender']
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
  Bettini Beyer
  Bhalchandra Bhattacharya 
  Biagiotti Bilal Bilde Binderkrantz Bingol Biondillo Biondo Bird Birin 
  Bittner Bizer
  Bjarnarson Bjerkan Bjornlund Blackstock Blakeman Blakset Blanchard 
  Blanco Blandin Bley Bloom Blumental 
  Bo Boaz Bocchi Bock Bogach Bogacki Bohnhorst Bohnsack Bojoh 
  Boldt Bolognini
  Bombardieri Bomber Bompis Bongiovanni Bonori Bordallo Bornova 
  Bossi Bostanci Bostosusz
  Boucher Boughey Bourke Bouscat 
  Bowdery Bowles Boylson Bozempergk Bozzo
  Brachman Brady Braithwaite Bramley Branco Brantsma Braun Brenner
  Brightling Brink Brockwell Brod Brogeland Brown Brotteaux Brum Brunet
  Bruun Brunzell
  Buchen Buchlev Buras Burgay Burke Buscaglia Buse Busse Butland Butts
  Byrne

  Calandra Caldarelli Camacho Camberos Caplan Cappelli Cappeller 
  Caldwell Callaghan Caprera Cambiaghi Campos Caracci Carbonnier Carmichael 
  Cassini Carrasco Carruthers Carvalho Casabona Casadei Castelbranco 
  Castner Cattani Cayne Cengiz Cernat Cernato Cesati
  Chadwick Chagas Chai Chambers Chan Chang Charletoux Charlotte Charlsen 
  Chassagne Chatterji Chauvelot Chediak Chemla Chen Cheng Chizzoli Chuang
  Cichocki Cilleborg Cimon Ciopettini Clair Clark Clement Clemmensen 
  Coenraets Coglitore Cohen Cohler Coldea Cole Collett Collins Combes 
  Combescure Compton Connie Conti Cook Cooke Cooper Cope 
  Coren Coridakis Corlateanu Cormack Corssen Cotton
  Courtney Coutts Coyne
  Creet Crestey Chrichton Crompton Cronier Crouch 
  Cuevas Cullin Cummings Cuper Çýloðlu

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
  Efremov Efthimiou Eggeling Eidi Einarsson Eisenberg 
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
  Gioia Gitelman Giura Gladiator Gladysh Glasson Glopson
  Goded Goldberg Goldenfield Goldman Goldstein Golebiowski 
  Gomerov Gomes Gonçalves Goodman
  Gordon Goren Gosney Gotard Gottlieb Goyal Göthe
  Grabel Grabowska Gradignan Gradovsky Grainger Gramberg Green 
  Greenberg Greenwood Grenside Grenthe Griffey Griffin Griffoni Griffiths 
  Grimeton Grigoriu Grimaldi Grisho Groemenboom
  Gromov Gromova Gross Grosset Gromöller 
  Gronaldo Grue Gruia Grunt Gruschow Grzelak
  Guariglia Gudkov Gue Gueglio Guerreiro Guglietto Guillaumin 
  Gula Gumby Guo Gupta Gurley Gursel Gustawsson Gutmark Günther

  Hackett Hadjibalis Haffer Haidorfer Hallen Hamman Hampson Hampton 
  Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harding Harley Harper Harries Harris Harrison Harsanyi 
  Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Helgemo Helle Helmich Helms Hemant Heng Henneberg Henner 
  Herbst Herman Heskje Hillman Hinden Hirst Hliapas
  Hoffa Hoffman Hollands Hollman Honti Hopfenheit Hornibrook Horton Horwitz 
  Howard Howe Høyland
  Hu Huang Hughes Hugon Hugony Hult Hung Hupe

  Ingielewicz Iommi Iontzeff Irens Ivatury Iversen Ivrig Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jain Jalowka Jamieson
  Janicki Jankova Janiszewski Janowski 
  Jansma Janssen Jarlot Jarov Jassem Jawell Jayganesh 
  Jedrychowski Jensen Jepsen Jessheim Jian Jiang 
  Joel Johansen Johansson Johnson Jonsson Jokisch Jones Jourdain

  Kachchu Kahyaoglu Kaiser Kalita Kalish Kallsberg Kallunki Kalma Kalmin 
  Kamal Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kane Kanetkar 
  Kapadia Kapagiannidis Kaplan Kaptan
  Karadeniz Karamanlis Karavil Karl Kasday Kasle Kasler Kastel
  Katz Kay Kazik Kendrick Kenny Kent Keremida Kersey
  King Kiran Kirilenko Kirin Kizikli Klinger Klofa Klukowski Knap Knight
  Kocak Koistinen Koivula Kokkes Kokten Kolankaya Kolata Kolesnik 
  Kondoch Konow Kopecky Koppel
  Korbel Kordov Korkut Korth Kosti Koumetz Kovacs Kovachev 
  Kovacich Kowalski Kozikowski
  Kranyak Krausova Krawczyk Krekorian Kriegel Kriftner Kristensen Krochmalik
  Kuang Kubac Kuokkanen Kvangraven Kwiatkowski Kwiecien Kyriakidou

  Laan Lachowicz Laffineur Lagrange Lall Lambardi Lanciano 
  Landry Lantaron Lanzarotti 
  Larsen Larssen Lasserre Latteria Lauria Lavín Lavings Law Lawy Lazer
  Lebatteux Lebel Lebowitz Lechtman Lehtinen Lee Leenhardt Legras Lena 
  Lennart Leptirici Lerner Lesniewski Lester 
  Levi Levinger Lévy Levin Levine Levski Levy Lew Lewis Lhuissier
  Lie Liggins Lilienstein Lillevik Lilley Limmen Lindner Lindstedt
  Lindqvist Llopart
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
  Michaud Mickiewicz Miles Milgrim Mill Miller Mills Milne Milner 
  Minahasa Miozzi Mira Miroglio Mitra Mittelman 
  Miura Mizrak Mohsen
  Mohtashami Molenaar Molenda Molina Monachan Moni Monsegur Montanari
  Mooney Moran Morath Morawski Morbey Morgan Moritsch Morot
  Morris Morrison Morse Moskovsky Mønsted
  Mortensen Moss Mossop Mott Mouiel
  Mucha Mueller Mullamphy Muller Multon Mundell Munksgaard 
  Munson Munteanu Muriel Murray Mus Mutiara

  Nab Nader Naels Nagy Nahmias Narasimhan Naqvi Nardullo Natale Navneet
  Neale Negrin Neill Nencini Netto Neuhauser Neve Newell Newman 
  Nickell Nielsen Nieminen Nikolenkov Nilsland Nilsson Ninos Nixon
  Noble Nowosadzki Nørgaard
  Nunes Nunn Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko Oikonomopoulus
  Oliveira Olsen Omran Oncu O'Rourke Ortega
  Onstott Osaulenko Osofsky Oursel Ozarar Ozbey Ozdil Ozenir
  Östberg Özbey

  Paganus Paiva Pajak Palma Palmeira Palmer Palau Panagaki Papaxatzis
  Parker Parviainen Passaro Passell Pattinson Pattison
  Paulissen Pauncz Payen Pazur
  Pedzinski Peirão Pekkinen Peksen Penfold Percario Pereira Periasamy 
  Pessoa Petculescu Petrucci Pettersson
  Phelan Piasecki Piedra Piekarek Pietraszek Piganeau Pilon Pinto Pitt
  Platt Plaut Pollack Pollak Polowan Pont Popescu Popova Potier Poulat
  Prescott Priano Proukakis Procter Pryor Puczynski

  Quail Quantin Quinn

  Rabinowitz Radisic Rankin Rao Raulund Ravenna Rayner
  Rehder Rekstad Renouard Reynolds
  Ricard Ricci Richardson Richman Riedel Riehm Rigal Rigaud 
  Rimstedt Rios Rivers Rizzo
  Robert Robertson Robinson Robles Robson Rocafort Rocca Rodwell
  Rogoff Rohowsky Roll Rombaut Rosen Rosendorff Rosetta 
  Rosenkrantz Rosenthal Rossard Rossi Rothfield Rourke Roussoglou Roussos
  Rubin Rubio Rueda Ryman

  Sabbatini Sadek Saelensminde Saesseli Saina Sairanen Sakr Salliere
  Salman Sandqvist Santos Sansom Sapounakis Savelli Savorani 
  Sawicki Saydi Sayer Sayilkan
  Scerri Schaltz Schermer Schlicker Schneider Schnetzer Schonning
  Schoolmann Schou Schüller
  Scoltock Schreckenberger Scudder Schwartz Schwerdt
  Sealy Sebbane Seguineau Selcuk Seligman Serenella Serf Serpoi Sesyilmaz
  Shadyro Sharif Shimizu Shirogane Short Shugart 
  Silver Silverstein Silverstone Sime Simonsen Simpson Simson Sinclair 
  Skaanning Skelton Skorchev Small Smart Smilgajs Smith Smirnov Smolanko 
  Snashall Snellers 
  Sohlin Soldati Solodar Sonsini Sorkin Soukup Soulet Soumitra Sowter
  Spangenberg Spector Sprung Squires
  Stabell Stamatov Stankovic Stansby Stark Stavrinos
  Steel Steiner Stephenson Stern 
  Sternberg Stevens Stewart Stienen
  Stoichkov Street Stretz Strul Strøm Stuart
  Sveindal Sveinsson Svendsen 
  Summers Sundelin Sundsten Suresh Suwik
  Sylvan Szalay Szots

  Takayama Tamburrini Tan Tanaka Tarhan Tarsus Taylor 
  Tebha Teltscher Teodorescu Teramoto Terraneo Tesla Tez
  Thapa Thomsen Thompson Thomson Thoresen Thurston 
  Ticha Tishler Tislevoll Todd Toffier Toivonen Tokay Tosi Townsend 
  Travis Troberg Tubiska Tudor Tulin Tuomi Turner Tuszynski 
  Tuwanakotta Tyradelli

  Ueland Uggeri Una Upmark Uskali Utter Uysal

  Vainikonis Valeanu Valio Valta
  Veloni Venkatesh Ventin Verbeek Verhees Versace Versluis
  Viana Videv Vigil Vihtilä Vinay Vinciguerra Virvidakis Vitas 
  Vogt Volcker Vorobei Vriend Vroustis

  Wang Wasik Waterlow Waters Watts Weingarten Weingold 
  Weinstein Weisinger Welland Werdelin Westerlund Westheimer Westra
  Whibley Wigoder Wijma Wikstrom Wildavsky Wilkinson 
  Willenken Williams Willis Wiltshire Witek Wittes
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Worm Wortel Wrang Wyer

  Xatzimpalis

  Yamada Yates Yezerski Yilankiran Yilmaz Yoleri Yule

  Zabunoglu Zagor Zagorin Zaleski Zanalda Zarkesch Zawada Zeeberg Zenari 
  Zhan Zhong Zimmermann Zollo Zorlu Zozis Zotos
);

my %SINGLE_TYPOS =
(
  Aagaard => ['aagard'],
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  'A.K. Bose' => ['a.k.bose'],
  Baleal => ['balelal'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Bertheau => ['berthau'],
  Blumental => ['blummental'],
  Combescure => ['combescur'],
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
  Gonçalves => ['goncalves', 'gonsalves', 'gonçalv', 'gonçalve'],
  Greenwood => ['greenwod'],
  Gromöller => ['gromoeller', 'gromuller'],
  Günther => ['guenther'],
  'Hecht Johansen' => ['hecht'],
  'J.E. Skjanni' => ['skjanni'],
  'J.P. Goenka' => ['goenka', 'jpgoenka'],
  Jedrychowski => ['jedrychowsky'],
  'Jeroo Mango' => ['mango'],
  Kaminski => ['kaminsky'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Kapagiannides' => ['kapagiannides'],
  Kazik => ['kazic'],
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
