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
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
   Aditya Ahmetizm Akinom Alex Alf Alfredo Ali Alizee Allam Amrapali 
   Amul Andrzejki Anna Anni Anol Anuj Apaçý Apek Arangan Arnab Arno 
   Arunas Auni Ayan

   Bauhinia Ben Beniaminek Berik Bilal Breno

   Carlitos Cathy Cem Chiranjeev Claudili Conie

   Dada Dadya Dahsyat Daniel Dauna Dawn Diana Didi Dido Diego Dieter 
   Dion Dora Dukens 

   Ece Edi Eliza Ellen Emre Eren Eric Erikas Erla Ewa

   Felix Fenia Fharon Fifi Frank Franz 

   Garry George Greta Gulce Guptas Gürsel

   Hanan Hande Harvin Havin Hayet Heino Heis Hel Hella Hilda Hridhaan 
   Hubsi Hunaja 

   Ida Ilya Imanuel Iris 

   Jagg Jaiganesh Janko Jans Jelena Jessi Jessica Jóannes Jonathan 
   Justyna Justynka 

   Kamlakars Karin Kasiyahan Keni Kenji Kinga Kitty Kris Kriston 
   Krisztina 

   Larry Lasse Lebron Leszek Leta Lili Loloc 

   Macak Mach Madhav Mads Magnus Maija Maj Mali Malinka Manashda Manena 
   Manno Mano Manu Manywar Margitta Marianne Mark Matilde Mats Mia 
   Michal Mihai Mikke Miguel Milo Miro Moritz Munawar Myoni 

   Nabil Natalia Nathans Nico Nik Nikita Nikitopoulos Niko Nikos Nina 
   Nis Noriko 

   Oguzhan Olena Onirepsou Oyku 

   Paco Pal Paoli Paulette Paulina Pero Peter Petra Pia Piter 

   Rafael Ramkumar Rene Rica Rob Rike Rima Robertinho Robi 

   Sabina Sara Sarp Selin Severin Sevil Shane Shankars Shavaz Shona 
   Shrikant Shuai Shushi Sid Siddheshwar Sigrid Simonetta Sindhu 
   Stefany Steliana Steve Sue Suz Svetla Swanand 

   Tadeu Tamae Tita Tofi Toma Tushar 

   Unlu 

   Valentino Vicky Victor Virginia Vivi 

   Wael Wafa Wala Waldi 

   Yelena Ylajai 

   Zara Zen Ziggy Zlatan 
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
