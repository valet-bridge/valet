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
  'Arun Bapat',
  'Arun Jain',
  'Bareket',
  'C.V. Rao',
  'David Birman',
  'De Blasi',
  'de Botton',
  'de Knijff',
  'de Livera',
  'de Monval',
  'De Muller',
  'Defranchi',
  'Della Monta',
  "Del'Monte",
  "D'Orsi",
  'El Baz',
  'Ginossar',
  'H.C. Nielsen',
  'Hecht-Johansen',
  'J.E. Skjanni',
  'Jan Jansma',
  'Jeroo Mango',
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
  'Miguel Teixeira',
  'Nabil Chaker',
  'Nabil Edgtton',
  'Nuno Matos',
  'Nuno Sousa',
  'Palma Carlos',
  'Paul Hackett',
  'Paul Van Goor',
  'Paula Lima',
  'Paulo Rocha Pinto',
  'Pontiac 7',
  'Rui Pinto',
  'Rui Santos',
  'Sally Brock',
  'Shashi Gupta',
  'Sinan Abi',
  'Sinan Göksu',
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
  'Yao Ke',
  'Zia Mahmood',
  'ZHOU Tao'
);

my %MULTI_TYPOS =
(
  'Acacio Figueiredo' => ['acacio f.'],
  'Adam Edgtton' => ['a edgtton', 'a.edgtton'],
  'Bareket' => ['bareket ilan'],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.'],
  'David Birman' => ['birman david', 'birman d.'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'de Knijff' => ['deknijff', 'di knijff'],
  "D'Orsi" => ['d orsi'],
  'El Baz' => ['baz'],
  'Ginossar' => ['eldad ginossar'],
  'H.C. Nielsen' => ['hc nielsen'],
  'Hecht-Johansen' => ['hecht'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni'],
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
  'Miguel Teixeira' => ['miguel teixeira', 'm. teixeira'],
  'Nabil Chaker' => ['chaker'],
  'Nabil Edgtton' => ['n edgtton', 'n.edgtton'],
  'Patanè' => ["patane'"],
  'Paul Hackett' => ['p hackett'],
  'Paulo Rocha Pinto' => ['paulo pinto', 'rocha pinto'],
  'Pontiac 7' => ['pontiac7'],
  'Rui Pinto' => ['ruin pinto', 'r.pinto'],
  'Sally Brock' => ['s brock'],
  'Sinan Göksu' => ['sinan goksu'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward pratt'],
  'Wei Sender' => ['wei-sender']
);

my @SINGLE_WORDS = qw(
  Aagaard Abecassis Adad Adams Adamsen Adde Agarwal Agostini 
  Aker Akhun Alami Alfonsin Allana Allegra Allfrey Allison Allix
  Almirall Alonso Altan Altay Alti Altinis Altshuler
  Amadori Ames Amoedo Amoils Amol Anderson Andersson Andrasi Andrea 
  Andreoli Andrew Angeleri Angelini Antmen Antoniou Ao Appleton Apteker 
  Aranha Arle Armstrong Arun
  Ash Ashworth Ashton Ashwin Askgaard Asmeniadis Assael Assis
  Atalay Attaguile Auken Austberg Avcioglu Avon

  Babacan Babsch Bailey Baker Bakhshi Baki Bakkeren Baldini Banerjee 
  Barbosa Bareket Barton Basabe Basile Bathurst Bauch Bavaresco Baze
  Bäckström Beauchamp Beatty Becker Bello Bellosta Belonogov
  Berg Berger Bergheimer Berkowitz Berktas Berlinski Bernard Bernstein 
  Berrettini Bertens Bertheau Bessis Beyer
  Biagiotti Bilal Bilde Binderkrantz Bingol Biondillo Bird Birin Bizer
  Bjarnarson Bjerkan Bjornlund Blackstock Blakset Blanchard Blandin 
  Bley Bloom Blumental 
  Bo Bocchi Bock Bogach Bohnhorst Bohnsack Boldt Bolognini
  Bomber Bompis Bonori Bordallo Boucher Boughey Bourke 
  Bowdery Bowles Boylson Bozempergk Bozzo
  Brachman Brady Braithwaite Bramley Branco Brantsma Braun Brenner
  Brightling Brink Brockwell Brod Brogeland Brown Brum Bruun Brunzell
  Buchen Buchlev Buras Burgay Burke Buscaglia Buse Busse Butland Butts
  Byrne

  Calandra Caldarelli Camacho Camberos Caplan Cappelli Cappeller 
  Caldwell Callaghan Caprera Cambiaghi Campos Caracci Carmichael 
  Carrasco Carruthers Carvalho Casabona Casadei Castelbranco 
  Castner Cattani Cayne Cengiz Cernat Cernato Cesati
  Chadwick Chagas Chai Chan Chang Charletoux Charlotte Charlsen 
  Chassagne Chatterji Chauvelot Chediak Chemla Cheng Chizzoli Chuang
  Cichocki Cilleborg Cimon Ciopettini Clair Clark Clement Clemmensen 
  Coglitore Cohen Cohler Coldea Cole Collett Collins Combes 
  Compton Connie Conti Cook Cooke Cooper Cope Coren Corssen 
  Courtney Coutts Coyne
  Creet Crestey Crompton Cronier Crouch Cuevas Cuper Çýloðlu

  Dahl Dahlberg Dalley Damiani Dancewicz Dantan Das Daskalakis 
  Dauvergne Davies Dawson
  Debonnaire Dechelette Dehaye Deik Delfour DeMartino Demirbas Denning 
  Deutsch Deva Dhir Dhondy Diamond Dinkin Dixon Djurovic
  Dobbels Dobes Doecke Dolla Dossena Doussot Doxiadis Drijver 
  Dubini Duguet Duman Dumbovich Dunitz Dunn 
  Duong Dupraz Dupuis Durisotto Dutilloy Dyke

  Eaton Eber Ebery Economou Eden Edgtton Efthimiou Eggeling Eidi Eisenberg 
  Ekeblad Eksi Engel Elinescu Enrique 
  Ergil Erichsen Eriksson Erk Esterson Esteruelas Evans Ewart

  Fabbri Fagerlund Faidas Faigenbaum Failla Falk Fallenius Fallon 
  Fantoni Farholt Faria Favard
  Federighi Fegarty Feiler Ferramosca Ferrara Ferrari Ferreira
  Fici Filios Filip Finikiotis Fioretti Fireman Fischer 
  Fleisher Fleury Flierl Flock Flora 
  Ford Fordham Fornaciari Forrester Fortini Fout
  Frances Franchi Fraser Frencken Fredin Freed 
  Friedland Friis Fritsche Frosztega Fruewirth Frukacz Frutos
  Fu Fucik Fuglestad Fuller Furuta Fyrun

  Gabrial Gaede Gardiner Galinsky Gallus Gandoglia Ganzer Garbosi 
  Garvey Gaspar Gartaganis Gary Gaviard Gawel Gawrys
  Genc Generosi Georgescu Gerli Gero Geyer Gezer
  Giangkos Giannessi Gidman Gill Gillis Ginnan Ginossar 
  Gioia Gitelman Giura Gladiator Gladysh Glasson
  Goded Goenka Goldberg Goldman Goldstein Gomerov Gomes Goodman
  Gordon Goren Gosney Gotard Gottlieb Goyal Göthe
  Grabel Grainger Green Greenberg Grenthe 
  Griffey Griffoni Griffiths Grigoriu Grimaldi
  Gromov Gromova Gross Grosset Gromöller 
  Grue Gruia Grunt Gruschow Grzelak
  Guariglia Gudkov Gue Gueglio Gula Gumby Gupta Gursel 
  Gustawsson Gutmark Günther

  Hackett Hadjibalis Haffer Haidorfer Hallen Hamman Hampson Hampton 
  Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harding Harley Harper Harries Harris Harrison Harsanyi 
  Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Helgemo Helle Helms Helness Hemant Henner Herbst Herman Heskje
  Hillman Hinden Hirst Hliapas
  Hoffman Hollands Hollman Honti Hopfenheit Hornibrook Horton Horwitz 
  Howard Howe Høyland
  Hu Hughes Hugon Hugony Hult Hung

  Iommi Irens Ivatury Iversen Ivrig Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jain Jankova Janowski 
  Jansma Janssen Jarlot Jassem Jepsen Jian Jiang 
  Joel Johansen Johnson Jokisch Jones Jourdain

  Kachchu Kahyaoglu Kalita Kalish Kallsberg Kallunki Kalma Kalmin 
  Kamil Kaminaris Kaminski Kamras Kannavos Kandemir Kanetkar Kaplan Kaptan
  Karadeniz Karamanlis Karavil Kasle Kasler 
  Katz Kay Kendrick Kenny Kent Keremida
  King Kiran Kirilenko Kirin Kizikli Klinger Klofa Klukowski Knap Knight
  Kocak Koistinen Koivula Kokkes Kokten Kolankaya Kolata Kolesnik 
  Kondoch Konow Kopecky Koppel
  Korbel Kordov Korkut Korth Kosti Kovachev Kovacich Kowalski Kozikowski
  Kranyak Krausova Krawczyk Kriegel Kriftner Kristensen Krochmalik
  Kubac Kuokkanen Kvangraven Kwiecien Kyriakidou

  Laan Lachowicz Laffineur Lall Lambardi Lanciano Lantaron Lanzarotti 
  Larsen Lasserre Lauria Lavín Lavings Law Lawy Lazer
  Lehtinen Lee Lesniewski Lester Levi Levinger Lévy Levin Levine Levy 
  Lewis Lhuissier
  Lie Liggins Lillevik Lilley Limmen Lindner Lindqvist Llopart
  Locatelli Lombard Lorentz Lorenzini Loreto Lowe
  Lubinski Ludewig Lund Luppi Lusk Lusky Lüßmann Lynch

  Maas Machado Madsen Maggio Mahaffey Maiolani Malarme Maksymetz 
  Malavasi Maluish Mancuso Mane Manfield Manglik Manni
  Marashev Margarida Margiotta Mari Marill Marino
  Markey Markowicz Marmonti Marsonis Marston
  Marta Martens Martin Marquardsen Masini Mason Matheson Matteucci Matushko
  Mauberquez Mavridis Maybach Mäkikangas
  McAllister McGann McGowan McIntosh McKellar McKinnon 
  McManus McMahon McMullin McNamara
  Meckstroth Medugno Mejane Mello Mendoza Mesbur Meltzer Mestres 
  Metselaar Meyer Meyers Meyouhas
  Michaud Miles Milgrim Mill Mills Milne Milner Miozzi Mittelman Miura
  Mohtashami Molenaar Molenda Molina Monachan Moni Monsegur Montanari
  Mooney Moran Morath Morbey Morgan Morris Morrison Morse Mønsted
  Mortensen Moss Mossop Mott Mouiel
  Mucha Mueller Mullamphy Muller Multon Munksgaard Munson Munteanu 
  Murray Mus

  Nab Nader Naels Nagy Nahmias Narasimhan Naqvi Nardullo Natale Navneet
  Neale Negrin Neill Nencini Netto Neuhauser Neve Newell Newman 
  Nickell Nielsen Nieminen Nikolenkov Nilsland Nilsson Ninos Nixon
  Noble Nowosadzki Nørgaard
  Nunes Nunn Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko Oikonomopoulus
  Oliveira Olsen Omran Oncu O'Rourke Ortega
  Onstein Onstott Osaulenko Osofsky Oursel Ozarar Ozbey Ozdil Ozenir
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

  Rabinowitz Radisic Radkov Rankin Rao Raulund Ravenna Rayner
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
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  Beauchamp => ['bauchamp', 'beachamp'],
  'David Birman' => ['birman'],
  'de Livera' => ['delivera'],
  Debonnaire => ['debonaire'],
  "Del'Monte" => ['delmonte'],
  Demirbas => ['Demirbaþ'],
  Karadeniz => ['karadenýz'],
  'Lotan Fisher' => ['fisher'],
  Gartaganis => ['gartaginas'],
  Gromöller => ['gromoeller', 'gromuller'],
  'J.E. Skjanni' => ['skjanni'],
  'Jeroo Mango' => ['mango'],
  Kandemir => ['kandemýr', 'kandermir'],
  Kannavos => ['kanavos'],
  'Maria João Lara' => ['lara'],
  Markowicz => ['markovics', 'markowitz'],
  'Maxim Henbest' => ['henbest'],
  'Miguel Teixeira' => ['teixeira'],
  Milner => ['millner'],
  "O'Rourke" => ['o_rouke'],
  'Özbey' => ['ozbey'],
  'Patanè' => ['patane'],
  'Peirão' => ['peirao'],
  'Procter' => ['proctor'],
  'Sally Brock' => ['brock'],
  Teltscher => ['teltsher'],
  Venkatesh => ['venky'],
  Vinciguerra => ['vinci'],
  Wigoder => ['wigodor'],
  Zabonoglu => ['zabunoðlu'],
  Zaleski => ['zalesky'],
  Zimmermann => ['zimmmermann', 'zimmerman', 'zimermann',
    'zimerman', 'zmmermann'],
  Zozis => ['zosis'],
  'Zia Mahmood' => ['mahmood', 'zia']
);


sub set_hashes_team_captain
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
