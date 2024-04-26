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
  'Bareket',
  'C.V. Rao',
  'David Birman',
  'de Botton',
  'Della Monta',
  'Ginossar',
  'J.E. Skjanni',
  'Jan Jansma',
  'Jorge Cruzeiro',
  'Manuel Oliveira',
  'Palma Carlos',
  'Paul Van Goor',
  'Pontiac 7',
  'Rui Santos',
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
  'Ward Platt',
  'Yao Ke'
);

my %MULTI_TYPOS =
(
  'Bareket' => ['bareket ilan'],
  'C.V. Rao' => ['c v rao', 'c. v. rao', 'c.v.rao', 'c.v.rao.'],
  'David Birman' => ['birman david', 'birman d.'],
  'de Botton' => ['janet de botton', 'j de botton',
    'de botten', 'de bottom', 'debotton'],
  'Ginossar' => ['eldad ginossar'],
  'J.E. Skjanni' => ['j.e.skanni', 'j.e.skjanni'],
  'Manuel Oliveira' => ['manuel oliveia', 'm.oliveira', 'm. oliveira',
    'm oliveira'],
  'Pontiac 7' => ['pontiac7'],
  'Sinan Göksu' => ['sinan goksu'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen'],
  'Ward Platt' => ['ward-platt', 'world platt', 'ward pratt']
);

my @SINGLE_WORDS = qw(
  Aagaard Abecassis Adad Adams Adamsen Adde Agarwal Agostini 
  Aker Akhun Alami Alfonsin Allana Allegra Allfrey Allison Allix
  Almirall Alonso Altan Altay Alti Altinis Altshuler
  Amadori Ames Amoedo Amoils Amol Anderson Andrasi Andrea Andreoli Andrew
  Angelini Antmen Antoniou Ao Appleton Apteker 
  Aranha Arle Armstrong Arun
  Ash Ashworth Ashton Ashwin Askgaard Asmeniadis Assael Assis
  Atalay Attaguile Auken Austberg Avcioglu Avon

  Babsch Bailey Baker Bakhshi Baki Bakkeren Baldini Banerjee 
  Barbosa Bareket Barton Basabe Basile Bathurst Bauch Bavaresco Baze
  Bäckström Beauchamp Beatty Becker Bello Bellosta Berger Bergheimer 
  Berkowitz Berktas Berlinski Bernard Bernstein 
  Bertens Bertheau Bessis Beyer
  Bilal Bilde Binderkrantz Bingol Biondillo Bird Birin Bizer
  Bjerkan Blackstock Blakset Blanchard Blandin Bley Bloom Blumental 
  Bo Bocchi Bock Bogach Bohnhorst Bohnsack Boldt Bolognini
  Bompis Bonori Bordallo Boucher Boughey Bourke 
  Bowdery Bowles Boylson Bozzo
  Brachman Brady Braithwaite Bramley Branco Brantsma Braun Brenner
  Brightling Brink Brock Brockwell Brod Brogeland Brown Brum Bruun Brunzell
  Buchen Buchlev Buras Burgay Burke Buscaglia Byrne

  Calandra Caldarelli Camacho Camberos Cappelli Cappeller 
  Caldwell Callaghan Caprera Campos Caracci Carmichael 
  Carrasco Carruthers Carvalho Casabona Castelbranco Castner Cayne
  Cengiz Cesati
  Chadwick Chagas Chai Chan Chang Charletoux Charlotte Charlsen 
  Chassagne Chatterji Chauvelot Chediak Chemla Cheng Chizzoli Chuang
  Cilleborg Cimon Clair Clark Clement Clemmensen Coglitore Cohen Cohler 
  Coldea Cole Collett Collins Combes Compton Connie Conti 
  Cook Cooke Cooper Cope Coren Corssen Courtney Coutts 
  Creet Crestey Cronier Crouch Cuevas Cuper

  Dahl Dahlberg Dalley Damiani Dancewicz Dantan Das Daskalakis Davies Dawson
  Dechelette Dehaye Delfour Denning Deva 
  Dhir Dhondy Dinkin Dixon Djurovic
  Dobbels Dobes Dolla Dossena Doussot Doxiades Drijver 
  Dubini Duguet Duman Dumbovich Dunitz Dunn 
  Duong Dupraz Dupuis Durisotto Dutilloy Dyke

  Eaton Eber Ebery Economou Eden Efthimiou Eggeling Eidi Eisenberg 
  Ekeblad Eksi Engel Elinescu Enrique 
  Ergil Erichsen Eriksson Erk Esterson Esteruelas Evans Ewart

  Fagerlund Faidas Faigenbaum Failla Falk Fallenius Fallon 
  Fantoni Farholt Faria Favard
  Federighi Fegarty Feiler Ferramosca Ferrara Ferreira
  Fici Filios Filip Finikiotis Fioretti Fireman Fischer 
  Fleisher Fleury Flierl Flock Flora 
  Ford Fordham Fornaciari Forrester Fortini Fout
  Frances Franchi Fraser Frencken Fredin Freed 
  Friedland Friis Fritsche Frosztega Fruewirth Frukacz Frutos
  Fu Fucik Fuglestad Fuller Furuta Fyrun

  Gabrial Gaede Gardiner Galinsky Gallus Gandoglia Ganzer Garbosi 
  Garvey Gaspar Gartaganis Gary Gaviard Gawel Gawrys
  Genc Georgescu Gero
  Giannessi Gidman Gill Gillis Ginnan Ginossar Gitelman Giura
  Gladiator Gladysh Glasson
  Goded Goenka Goldberg Goldman Goldstein Gomerov Gomes Goodman
  Gordon Goren Gosney Gotard Gottlieb Goyal
  Grabel Grainger Green Greenberg Grenthe 
  Griffey Griffoni Griffiths Grigoriu Grimaldi
  Gromov Gromova Gross Grosset Gromöller 
  Grue Gruia Grunt Gruschow Grzelak
  Gudkov Gueglio Gula Gumby Gupta Gursel

  Hackett Hadjibalis Haffer Haidorfer Hallen Hamman Hampson Hampton 
  Hanna Hans Hansen Hanlon Hantveit
  Harangozo Harding Harley Harper Harries Harris Harrison Harsanyi 
  Hasenson Hassett Hauge Haughie Häusler Havas Hayman
  Helgemo Helle Helms Helness Hemant Henbest Henner Herbst Herman Heskje
  Hillman Hinden Hirst
  Hollman Honti Hopfenheit Hoffman Horton Horwitz Howard Howe Høyland
  Hu Hughes Hugon Hugony Hult Hung

  Iommi Irens Ivaturi Iversen Ivrig Izisel

  Jacob Jacobs Jagger Jagniewski Jagroop Jain Jankova Janowski 
  Jansma Janssen Jarlot Jassem Jepsen Jian Jiang 
  Joel Johansen Johnson Jokisch Jones Jourdain

  Kachchu Kahyaoglu Kalita Kalish Kallsberg Kallunki Kalma Kalmin 
  Kamil Kaminaris Kaminski Kamras Kanavos Kandemir Kaplan 
  Karamanlis Karavil Kasle Katz Kay Kendrick Kenny Kent Keremida
  Kirilenko Kirin Kizikli Klinger Klofa Klukowski Knap Knight
  Kocak Koistinen Koivula Kokkes Kokten Kolankaya Kolata Kolesnik 
  Kondoch Konow Kopecky Koppel
  Korbel Kordov Korkut Korth Kosti Kovachev Kovacich Kowalski Kozikowski
  Kranyak Krausova Krawczyk Kriegel Kriftner Kristensen Krochmalik
  Kubac Kuokkanen Kwiecien Kyriakidou

  Lall Lambardi Lanciano Lantaron Lara Larsen Lauria Lavings Law Lawy
  Lehtinen Lee Lester Levi Lévy Levin Levine Levy Lewis Lhuissier
  Lie Liggins Lillevik Lilley Limmen Lindner Lindqvist Llopart
  Lombard Lorentz Lorenzini Lowe
  Lubinski Ludewig Lund Lusk Lusky Lüßmann Lynch

  Maas Machado Madsen Mahaffey Malarme Maksymetz Mancuso Mane Manfield
  Manglik Manni
  Marashev Margarida Mari Markey Markowicz Marsonis Marston
  Marta Martens Martin Marquardsen Mason Matheson Matushko
  Mavridis Maybach
  McAllister McGann McGowan McIntosh McKellar McKinnon 
  McManus McMahon McMullin McNamara
  Meckstroth Medugno Mejane Mello Mendoza Mesbur Meltzer Mestres 
  Metselaar Meyer Meyers Meyouhas
  Michaud Miles Milgrim Mill Mills Milne Milner Mittelman Miura
  Mohtashami Molenaar Molenda Molina Monachan Moni Monsegur Montanari
  Mooney Moran Morath Morbey Morgan Morris Morrison Morse Mønsted
  Mortensen Moss Mossop Mott Mouiel
  Mucha Mullamphy Multon Munksgaard Munson Munteanu Murray Mus

  Nab Nader Naels Nagy Nahmias Narasimhan Naqvi Nardullo Natale Navneet
  Neale Negrin Neill Nencini Neuhauser Neve Newell Newman 
  Nickell Nielsen Nieminen Nikolenkov Nilsland Nilsson Ninos Nixon
  Noble Nowosadzki Nørgaard
  Nunes Nunn Nystrom
  
  O'Brien O'Gorman Ohno Ohrysko 
  Oliveira Olsen Omran Oncu O'Rourke Ortega
  Onstein Onstott Osaulenko Osofsky Oursel Ozarar Ozbey Ozdil Ozenir

  Paganus Paiva Pajak Palmeira Palmer Palau Panagaki Papaxatzis
  Parker Parviainen Passaro Passell Pattinson Paulissen Pauncz Payen Pazur
  Pedzinski Pekkinen Peksen Penfold Percario Pereira Periasamy 
  Pessoa Petculescu Petrucci Petterson
  Phelan Piasecki Piedra Piekarek Pietraszek Piganeau Pilon Pinto Pitt
  Platt Plaut Pollack Polowan Pont Popescu Popova Potier Poulat
  Prescott Priano Priokakis Procter Pryor

  Quail Quantin Quinn
  Radkov Rankin Rao Raulund Ravenna Rehder Rekstad Reynolds
  Ricard Ricci Richardson Richman Riehm Rigal Rigaud Rimstedt Rivers Rizzo
  Robert Robertson Robinson Robles Robson Rocafort Rocca Rodwell
  Rogoff Rohowsky Roll Rombaut Rosen Rosetta 
  Rosenkrantz Rosenthal Rossard Rossi Rothfield Rourke
  Rubin Rubio Ryman
  Sabbatini Sadek Saelensminde Saesseli Saina Sairanen Sakr Salliere
  Salman Sandqvist Santos Sansom Sapounakis Savelli Savorani 
  Sawicki Saydi Sayer Sayilkan
  Scerri Schaltz Schermer Schlicker Schneider Schnetzer 
  Schoolmann Schou Schüller
  Scoltock Schreckenberger Scudder Schwartz Schwerdt
  Sealy Sebbane Seguineau Selcuk Seligman Serenella Serf Serpoi
  Shadyro Sharif Shimizu Shirogane Short Shugart 
  Silverstone Sime Simonsen Simpson Simson Sinclair 
  Skelton Skorchev Small Smart Smilgajs Smith Smirnov Smolanko 
  Snashall Snellers 
  Sohlin Soldati Solodar Sorkin Soulet Soumitra Sowter
  Spangenberg Spector Sprung Squires
  Stabell Stamatov Stankovic Stansby Stark Steel Steiner Stephenson Stern 
  Sternberg Stevens Stewart
  Stoichkov Street Stretz Strul Strøm Stuart
  Sveindal Sveinsson Svendsen 
  Summers Sundelin Sundsten Suresh Suwik
  Sylvan Szalay Szots
  Takayama Tamburrini Tanaka Tarsus Taylor 
  Tebha Teixeira Teltscher Teodorescu Teramoto Terraneo Tesla Tez
  Thapa Thomsen Thompson Thomson Thoresen Thurston 
  Ticha Tishler Tislevoll Todd Toffier Toivonen Tokay Tosi Townsend 
  Travis Troberg Tubiska Tudor Tulin Turner Tuszynski Tuwanakotta Tyradelli
  Ueland Uggeri Una Upmark Uskali Utter Uysal
  Vainikonis Valeanu Valio Valta
  Veloni Venkatesh Ventin Verbeek Verhees Versace Versluis
  Viana Videv Vigil Vihtilä Vinay Vinciguerra Virvikadis Vitas 
  Vogt Volcker Vorobei Vriend Vroustis
  Wang Wasik Waterlow Waters Watts Weingarten Weingold 
  Weinstein Weisinger Welland Werdelin Westerlund Westheimer Westra
  Whibley Wigoder Wijma Wikstrom Wildavsky Wilkinson 
  Willenken Williams Willis Wiltshire Witek Wittes
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Worm Wortel Wrang
  Yamada Yates Yezerski Yilankiran Yilmaz Yoleri Yule
  Zagorin Zaleski Zanalda Zarkesch Zawada Zeeberg Zenari Zhan Zhong 
  Zia Zimmermann
  Zollu Zorlu Zosis Zotos
);

my %SINGLE_TYPOS =
(
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  Beauchamp => ['bauchamp', 'beachamp'],
  'David Birman' => ['birman'],
  Gartaganis => ['gartaginas'],
  'J.E. Skjanni' => ['skjanni'],
  Markowicz => ['markovics', 'markowitz'],
  Milner => ['millner'],
  "O'Rourke" => ['o_rouke'],
  Teltscher => ['teltsher'],
  Wigoder => ['wigodor'],
  Zaleski => ['zalesky'],
  Zimmermann => ['zimmmermann', 'zimmerman', 'zimermann',
    'zimerman', 'zmmermann']
);


sub set_hashes_team_captain
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
