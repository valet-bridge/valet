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
  'David Birman',
  'Della Monta',
  'Ginossar',
  'Jan Jansma',
  'Jorge Cruzeiro',
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
  'Yao Ke'
);

my %MULTI_TYPOS =
(
  'Bareket' => ['bareket ilan'],
  'David Birman' => ['birman david', 'birman d.'],
  'Edgtton' => ['a edgtton', 'a.edgtton'],
  'Ginossar' => ['eldad ginossar'],
  'Pontiac 7' => ['pontiac7'],
  'Sinan Göksu' => ['sinan goksu'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen', 'vanglarsen']
);

my @SINGLE_WORDS = qw(
  Aagaard Abecassis Adams Adamsen Agarwal Agostini 
  Aker Allegra Allfrey Allison Altay Altshuler
  Ames Amoils Anderson Andreoli Angelini Appleton Apteker 
  Aranha Armstrong Arun
  Ashton Ashwin Askgaard Assael Auken Austberg
  Babsch Baker Bakhshi Baki Bakkeren Banerjee Barton Bathurst Baze
  Becker Beauchamp Bello Bellosta Berkowitz Bernstein 
  Bertens Bertheau Bessis 
  Bilde Binderkrantz Bird Blakset Blanchard Bloom Blumental 
  Bo Bocchi Bohnhorst Bohnsack Boldt Bompis Bourke Bowles
  Brachman Brady Braithwaite Bramley Branco Braun
  Brightling Brink Brock Brockwell Brogeland Brown Brum Bruun
  Buchen Buras Burgay Burke Byrne
  Cappeller Caldwell Callaghan Caprera Campos Carmichael Carruthers 
  Carvalho Castelbranco Castner Cayne
  Chagas Chang Charlotte Charlsen Chatterji Chemla Cheng Chuang
  Cilleborg Clemmensen Cohen Cohler Cole Collins
  Compton Cook Cooper Cope Coren Courtney Coutts
  Cronier Crouch Cuevas
  Dahl Dahlberg Damiani Davies Dehaye Delfour Deva 
  Drijver Dumbovich Dunitz Dunn Dyke
  Eden Edgtton Eggeling Eidi Eisenberg Ekeblad Elinescu Erichsen Ewart
  Fagerlund Faigenbaum Fantoni Ferrara Fireman Fischer 
  Fleisher Ford Fordham Forrester Frances Franchi Fraser
  Fredin Freed Friedland Fritsche Fu Fucik
  Gabrial Gardiner Garvey Gartaganis Gary Gaviard Gawrys
  Gillis Ginossar Gitelman Gladysh Glasson
  Goldberg Goldman Goldstein Gordon Gosney Gotard
  Greenberg Gromov Gromova Grue
  Gumby Gupta
  Hauge Hackett Hamman Hampson Hampton Hans Hansen Hanlon
  Harding Harley Harper Harris Harrison Harsanyi Haughie
  Helgemo Helms Helness Hemant Henner Herbst
  Hillman Hinden Hirst
  Hopfenheit Hoffman Horwitz Howard Howe
  Hughes Hugony Hung
  Irens Iversen
  Jacobs Jagniewski Jain Jansma Janssen Jassem
  Jepsen Jian Jiang  Johansen Johnson Jokisch Jones Jourdain
  Kalita Kamil Kamras Kaplan Kasle Katz Kay
  Kent Kirilenko Klinger Koistinen Kolata Kolesnik Konow Korbel Kosti
  Kranyak Kriegel Kriftner Kristensen Kwiecien
  Lall Lambardi Larsen Lauria
  Lee Levi Levin Levine Levy Lewis Lhuissier
  Liggins Lilley Lindqvist Lombard Lorentz Lorenzini
  Lund Lusky Lynch
  Madsen Mahaffey Maksymetz Mancuso Mari Markey Markowicz Marston
  Martens Martin Marquardsen Matheson Mavridis Maybach
  McAllister McGann McIntosh McKellar McKinnon McManus
  Meckstroth Mello Mendoza Mesbur Meltzer
  Michaud Milgrim Mills Milne Milner Mittelman Miura
  Mooney Moran Morath Morbey Morgan Morris Morrison Morse 
  Mortensen Moss Mossop Mott Mouiel
  Multon Munksgaard Munson Murray 
  Nader Nagy
  Neill Newell Nickell Nielsen Nilsland Nilsson
  Nowosadzki
  Nunes Nunn Nystrom
  Oliveira
  O'Rourke
  Onstein Onstott
  Palmer Passell Pattinson Paulissen
  Penfold Pereira
  Piedra Piekarek Piganeau Pilon
  Platt
  Pollack Polowan
  Quantin
  Rao Raulund Ravenna Reynolds
  Richardson Rigal Rimstedt
  Robertson Robinson Robles Rogoff Rohowsky Rombaut Rosen Rosetta 
  Rosenkrantz Rosenthal Rothfield Rourke
  Rubin Rubio
  Sadek Saelensminde Sandqvist Santos
  Schaltz Schermer Schlicker Schneider Schoolmann Schou 
  Schreckenberger Schwartz Schwerdt
  Shugart Silverstone Sime Simonsen Simpson Simson Sinclair 
  Skorchev Smith Sorkin Soulet
  Spangenberg Spector Sprung
  Stamatov Stansby Steiner Stephenson Stern Sternberg Stevens Stewart
  Stoichkov Street Stretz Strul Svendsen Sundelin
  Sylvan
  Tamburrini Tarsus Taylor Teixeira Teltscher
  Thomsen Thompson Thomson Thoresen Thurston Townsend Turner
  Una Upmark
  Venkatesh Ventin Verhees Versace
  Viana Vinciguerra Vitas Volcker Vriend
  Weingold Weinstein
  Welland Werdelin Westheimer Westra
  Whibley
  Wigoder Wildavsky Wilkinson Willenken Williams Witte
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Wrang
  Zagorin Zaleski Zhong Zia Zimmermann
);

my %SINGLE_TYPOS =
(
  Allfrey => ['alfrey'],
  Altshuler => ['altschuler', 'altshuller'],
  Beauchamp => ['bauchamp', 'beachamp'],
  Gartaganis => ['gartaginas'],
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
