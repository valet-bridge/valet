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
  'Ginossar' => ['eldad ginossar'],
  'Pontiac 7' => ['pontiac7'],
  'Sinan Göksu' => ['sinan goksu'],
  'van Prooijen'=> ['van proojen'],
  'Van den Bos' => ['van des bos'],
  'Vang Larsen' => ['van larsen', 'vang-larsen']
);

my @SINGLE_WORDS = qw(
  Altay Ames Anderson Appleton
  Baki Bello Bellosta Bertens Bessis Bo
  Carmichael Campos Charlotte Cole Compton Cope Courtney
  Deva Drijver Dyke
  Eggeling Elinescu
  Fantoni Ferrara Fleisher Fredin Freed
  Garvey Gartaganis Gary Gaviard Gawrys
  Gillis Ginossar Gitelman
  Goldberg Goldman Goldstein Gordon Gosney Gotard
  Greenberg Gromov Gromova Grue
  Gumby Gupta
  Hauge
  Hackett Hamman Hampson Hampton Hans Hansen Harper Harris Harrison
  Helness
  Hillman Hinden Hirst
  Hoffman Horwitz
  Hughes Hung
  Irens Iversen
  Jacobs Jagniewski Jain Jansma Janssen Jassem
  Kamil Kamras Kaplan Kasle Katz
  Kent Klinger Koistinen Kosti
  Kranyak Kriegel
  Lall Lambardi Larsen
  Lee Levi Levin Levine Levy Lewis Lhuissier
  Liggins Lilley
  Lund Lynch
  Mahaffey Markey Markowicz Martin Marquardsen
  McIntoch McKellar McManus
  Meckstroth Mendoza Mesbur Meltzer
  Mills Milne Milner Mittelman Miura
  Mooney Moran Morath
  Morbey Morgan Morris Morrison Morse Moss Mossop Mott Mouiel
  Nader Nagy
  Neill Newell Nickell Nielsen Nilsland Nilsson
  Nunes Nunn Nystrom
  Oliveira
  O'Rourke
  Onstein Onstott
  Palmer Passell
  Penfold Pereira
  Piekarek
  Platt
  Pollack
  Quantin
  Rao Ravenna
  Richardson Rigal Rimstedt
  Robinson Robles Rogoff Rombaut Rosen Rosetta Rosenthal Rubin Rubio
  Sadek Saelensminde Sandqvist Santos
  Schaltz Schermer Schneider Schwartz
  Shugart Sime Simson Sinclair Smith Sorkin Soulet
  Spangenberg Spector
  Stamatov Stansby Stephenson Stern Sternberg Stevens
  Stoichkov Street Strul Sundelin
  Sylvan
  Tamburrini Tarsus Taylor Teixeira Teltscher
  Thomsen Thomson
  Una Upmark
  Venkatesh Ventin
  Viana Vinciguerra Vitas Volcker
  Weingold Weinstein
  Welland Werdelin Westheimer Westra
  Whibley
  Wigoder Wildavsky Wilkinson Willenken Williams Witte
  Wold Wolfarth Wolff Wolfson Wolpert Woodruff Woolsey
  Wrang
  Zagorin Zaleski Zia Zimmermann
);

my %SINGLE_TYPOS =
(
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
