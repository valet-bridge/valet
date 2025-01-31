#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::First;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  'Ding-Yu'
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
   Aditya Ahmetizm Akinom Alex Alf Alfredo Alejandro Alexander Alfa
   Ali Alice Alizee Allam Amalia Amanda Amilcar Amrapali Amul Ana 
   Andrzejki Anna Anni Anol Anuj Apaçý Apek Arangan Aris Arnab Arno 
   Arunas Athena Auni Ayan

   Bachar Bas Bauhinia Ben Beniaminek Berik Berk Bilal Blanka Bob 
   Bodo Breno

   Carlitos Cathy Cem Charles Chiranjeev Claudili Cleo Conie

   Dada Dadya Dahsyat Daisy Daniel Dauna Dawn Daya Desi Diana Didi 
   Dido Diego Dieter Dion Disa Dora Dukens 

   Ece Edi Ekin Eliza Ellen Emre Emilio Eren Eric Erikas Erla 
   Ernis Esra Ewa

   Farida Felix Fenia Fharon Fifi Filippo Francesca Frank Franz 

   Garry Gene George Gerard Greta Gudrun Gulce Guptas Gürsel

   Hanan Hande Haoran Harvin Havin Hayet Heino Heis Hel Hella Henrique
   Hilda Hortensia Hridhaan Hubsi Hunaja 

   Ida Ilya Imanuel Iris 

   Jagg Jaiganesh Jake Janko Janne Jans Jelena Jenny Jerzy Jessi Jessica 
   Joanna Jóannes Joao Jonathan Joy Justyna Justynka 

   Kalin Kamlakars Karin Karl Kasiyahan Keni Kenji Kinga Kira Kitty 
   Kris Kriston Krisztina 

   Larry Lasse Laure Lea Lebron Leszek Leta Lili Lola Loloc Luc

   Macak Mach Madhav Mads Magnus Maija Maj Malaila Malene Mali Malin
   Malinka Malou Manashda Manena Manno Mano Manu Manywar Margitta 
   Marlene Marianne Mark Matilde Mats Mauricio Max Mia Michal Midori
   Mihaela Mihai Mikke Miguel Mila Milo Mira Miro Moritz Munawar Myoni 

   Nabil Natalia Nathans Nell Nevena Nico Nik Nikita Nikitopoulos Niko 
   Nikos Nina Nis Noriko 

   Oguzhan Ole Olena Onirepsou Oyku 

   Paco Pal Panjaroon Paoli Paulette Paulina Pero Peter Petra Pia 
   Pierre Piter Pradeep Pratap

   Qingjun

   Rado Rafael Ramkumar Rene Rica Rike Rima Rob Robertinho Robi Roger

   Sabina Sami Sandra Sara Sarp Selin Severin Sevil Shane Shankars 
   Shavaz Shona Shrikant Shuai Shushi Sid Siddheshwar Sigrid Silvana
   Simon Simonetta Sindhu Stefany Steliana Steve Sue Suz Svetla Swanand 

   Tadeu Tamae Tita Tofi Toma Tomas Tushar 

   Umut Unlu

   Valentino Vicky Victor Virginia Vivi 

   Wael Wafa Wala Waldi 

   Yael Yelena Ylajai Yves Yvonne

   Zara Zen Zeynep Ziggy Zip Zlatan 
);

my %SINGLE_TYPOS =
(
  Aditya => ['aaditya'],
  Alizee => ['alize'],

  Bilal => ['balil'],

  Erikas => ['ericas'],

  Hridhaan => ['hridhan', 'haridhaan', 'hrridhaan', 'hrridhaan', 'hridaan'],

  Imanuel => ['imanual'],

  Jonathan => ['joanthan'],

  Natalia => ['nataliya'],

  Shrikant => ['srikant']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
