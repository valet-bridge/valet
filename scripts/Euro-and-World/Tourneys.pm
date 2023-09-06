#!perl

package Tourneys;

use strict;
use warnings;
use Exporter;
use v5.10;

our @ISA = qw(Exporter);
our @EXPORT = qw(@MAP %ANCHORS init_tourneys make_dir_list);

# Set up the maps.
my $EUROCOMP = 'http://www.eurobridge.org/Repository/competitions/';
my $WORLDCOMP = 'http://www.worldbridge.org/Repository/tourn/';

our @MAP;
our %ANCHORS;

sub init_tourneys
{
  $ANCHORS{'Estoril.05'}    = 'Estoril.05/Asp/';
  $ANCHORS{'06Warsaw'}      = '06Warsaw/asp/';
  $ANCHORS{'Shanghai.07'}   = 'Shanghai.07/Asp/';
  $ANCHORS{'07Antalya'}     = '07Antalya/Asp/';
  $ANCHORS{'08Pau'}         = '08Pau/Asp/';
  $ANCHORS{'Beijing.08'}    = 'Beijing.08/Asp/';
  $ANCHORS{'09Sanremo'}     = '09Sanremo/Asp/';
  $ANCHORS{'SaoPaulo.09'}   = 'SaoPaulo.09/Asp/';
  $ANCHORS{'10Ostend'}      = '10Ostend/Asp/';
  $ANCHORS{'Veldhoven.11'}  = 'Veldhoven.11/Microsite/Results/';
  $ANCHORS{'12Dublin'}      = '12Dublin/microSite/Asp/';
  $ANCHORS{'Lille.12'}      = 'Lille.12/microSite/Results/';
  $ANCHORS{'13Oostende'}    = '13Oostende/microSite/Asp/';
  $ANCHORS{'Bali.13'}       = 'Bali.13/microSite/Asp/';
  $ANCHORS{'14Opatija'}     = '14Opatija/microSite/Asp/';
  $ANCHORS{'15Tromso'}      = '15Tromso/microsite/Asp/';
  $ANCHORS{'chennai.15'}    = 'chennai.15/microSite/Asp/';
  $ANCHORS{'16Budapest'}    = '16Budapest/microSite/Asp/';
  $ANCHORS{'wroclaw.16'}    = 'wroclaw.16/microSite/Asp/';
  $ANCHORS{'17montecatini'} = '17montecatini/microsite/Asp/';
  $ANCHORS{'lyon.17'}       = 'lyon.17/microsite/Asp/';
  $ANCHORS{'18Ostend'}      = '18Ostend/microSite/Asp/';
  $ANCHORS{'19Lisbon'}      = '19Lisbon/microSite/Asp/';
  $ANCHORS{'19istanbul'}    = '19istanbul/microSite/Asp/';
  $ANCHORS{'wuhan.19'}      = 'wuhan.19/microSite/Asp/';
  $ANCHORS{'20monaco'}      = '20monaco/microSite/Asp/';
  $ANCHORS{'salsomaggiore.22'} = 'salsomaggiore.22/microSite/Asp/';
  $ANCHORS{'22Madeira'}     = '22Madeira/microSite/Asp/';
  $ANCHORS{'23tignes'}      = '23tignes/microSite/Asp/';
  $ANCHORS{'marrakech.23'}  = 'marrakech.23/microSite/Asp/';


  my $t = 'Estoril.05';
  my $d = '2005-World';
  @{$MAP[527]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 0 );
  @{$MAP[528]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 0 );
  @{$MAP[529]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 0 );

  # Still Estoril.
  $d = '2005-WTNT';
  @{$MAP[531]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 15, 0 );

  $t = '06Warsaw';
  $d = '2006-Euro';
  @{$MAP[552]} = ( $EUROCOMP, $t, $d, 'Open'           , 1, 33, 0 );
  @{$MAP[553]} = ( $EUROCOMP, $t, $d, 'Women'          , 1, 21, 0 );
  @{$MAP[554]} = ( $EUROCOMP, $t, $d, 'Seniors/RR'     , 1, 15, 0 );
  @{$MAP[587]} = ( $EUROCOMP, $t, $d, 'Seniors/Final/A', 1, 7, 0 );
  @{$MAP[588]} = ( $EUROCOMP, $t, $d, 'Seniors/Final/B', 1, 7, 0 );

  $t = 'Shanghai.07';
  $d = '2007-World';
  @{$MAP[607]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 1 );
  @{$MAP[608]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 1 );
  @{$MAP[609]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 1 );

  $d = '2007-WTNT';
  @{$MAP[610]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '07Antalya';
  $d = '2007-Open-Euro';
  @{$MAP[627]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/A'   , 1, 5, 0 );
  @{$MAP[628]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/B'   , 1, 5, 0 );
  @{$MAP[629]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/C'   , 1, 5, 0 );
  @{$MAP[630]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/D'   , 1, 5, 0 );
  @{$MAP[631]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/E'   , 1, 5, 0 );
  @{$MAP[632]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/F'   , 1, 5, 0 );
  @{$MAP[633]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/G'   , 1, 5, 0 );
  @{$MAP[634]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/H'   , 1, 5, 0 );
  @{$MAP[635]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/I'   , 1, 5, 0 );
  @{$MAP[636]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/J'   , 1, 5, 0 );
  @{$MAP[637]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/K'   , 1, 5, 0 );
  @{$MAP[638]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/L'   , 1, 5, 0 );
  @{$MAP[639]} = ( $EUROCOMP, $t, $d, 'Mixed/Swiss/A', 1, 5, 0 );
  @{$MAP[640]} = ( $EUROCOMP, $t, $d, 'Mixed/Swiss/B', 1, 5, 0 );

  @{$MAP[646]} = ( $EUROCOMP, $t, $d, 'Open/RR/A'    , 1, 7, 0 );
  @{$MAP[647]} = ( $EUROCOMP, $t, $d, 'Open/RR/B'    , 1, 7, 0 );
  @{$MAP[648]} = ( $EUROCOMP, $t, $d, 'Open/RR/C'    , 1, 7, 0 );
  @{$MAP[649]} = ( $EUROCOMP, $t, $d, 'Open/RR/D'    , 1, 7, 0 );
  @{$MAP[650]} = ( $EUROCOMP, $t, $d, 'Open/RR/E'    , 1, 7, 0 );
  @{$MAP[651]} = ( $EUROCOMP, $t, $d, 'Open/RR/F'    , 1, 7, 0 );
  @{$MAP[652]} = ( $EUROCOMP, $t, $d, 'Open/RR/G'    , 1, 7, 0 );
  @{$MAP[653]} = ( $EUROCOMP, $t, $d, 'Open/RR/H'    , 1, 7, 0 );
  @{$MAP[654]} = ( $EUROCOMP, $t, $d, 'Open/RR/I'    , 1, 7, 0 );
  @{$MAP[655]} = ( $EUROCOMP, $t, $d, 'Open/RR/J'    , 1, 7, 0 );
  @{$MAP[656]} = ( $EUROCOMP, $t, $d, 'Open/RR/K'    , 1, 7, 0 );
  @{$MAP[657]} = ( $EUROCOMP, $t, $d, 'Open/RR/L'    , 1, 7, 0 );
  @{$MAP[658]} = ( $EUROCOMP, $t, $d, 'Open/RR/M'    , 1, 7, 0 );
  @{$MAP[659]} = ( $EUROCOMP, $t, $d, 'Open/RR/N'    , 1, 7, 0 );
  @{$MAP[660]} = ( $EUROCOMP, $t, $d, 'Women/RR/W'   , 1, 9, 0 );
  @{$MAP[661]} = ( $EUROCOMP, $t, $d, 'Women/RR/X'   , 1, 9, 0 );
  @{$MAP[662]} = ( $EUROCOMP, $t, $d, 'Seniors/RR/S' , 1, 9, 0 );
  @{$MAP[663]} = ( $EUROCOMP, $t, $d, 'Seniors/RR/T' , 1, 9, 0 );
  
  @{$MAP[664]} = ( $EUROCOMP, $t, $d, 'Open/Swiss/A' , 1, 7, 0 );
  @{$MAP[665]} = ( $EUROCOMP, $t, $d, 'Open/Swiss/B' , 1, 7, 0 );

  $t = '08Pau';
  $d = '2008-Euro';
  @{$MAP[677]} = ( $EUROCOMP, $t, $d, 'Open/RR/A' , 1, 19, 1 );
  @{$MAP[678]} = ( $EUROCOMP, $t, $d, 'Open/RR/B' , 1, 19, 1 );
  @{$MAP[675]} = ( $EUROCOMP, $t, $d, 'Women'     , 1, 25, 1 );
  @{$MAP[676]} = ( $EUROCOMP, $t, $d, 'Seniors'   , 1, 19, 1 );
  @{$MAP[679]} = ( $EUROCOMP, $t, $d, 'Open/Final', 1, 17, 1 );

  $t = 'Beijing.08';
  $d = '2008-Mind';
  @{$MAP[694]} = ( $WORLDCOMP, $t, $d, 'Open/A'   , 1, 17, 1 );
  @{$MAP[695]} = ( $WORLDCOMP, $t, $d, 'Open/B'   , 1, 17, 1 );
  @{$MAP[696]} = ( $WORLDCOMP, $t, $d, 'Open/C'   , 1, 17, 1 );
  @{$MAP[697]} = ( $WORLDCOMP, $t, $d, 'Open/D'   , 1, 17, 1 );
  @{$MAP[698]} = ( $WORLDCOMP, $t, $d, 'Women/E'  , 1, 17, 1 );
  @{$MAP[699]} = ( $WORLDCOMP, $t, $d, 'Women/F'  , 1, 17, 1 );
  @{$MAP[700]} = ( $WORLDCOMP, $t, $d, 'Women/G'  , 1, 17, 1 );
  @{$MAP[701]} = ( $WORLDCOMP, $t, $d, 'Seniors/K', 1, 15, 1 );
  @{$MAP[702]} = ( $WORLDCOMP, $t, $d, 'Seniors/L', 1, 15, 1 );

  # Still Beijing.
  $d = '2008-MTNT';
  @{$MAP[688]} = ( $WORLDCOMP, $t, $d, 'Mixed', 1, 15, 1 );

  $t = '09Sanremo';
  $d = '2009-Open-Euro';
  @{$MAP[739]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/A'   , 1, 5, 1 );
  @{$MAP[740]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/B'   , 1, 5, 1 );
  @{$MAP[741]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/C'   , 1, 5, 1 );
  @{$MAP[742]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/D'   , 1, 5, 1 );
  @{$MAP[743]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/E'   , 1, 5, 1 );
  @{$MAP[744]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/F'   , 1, 5, 1 );
  @{$MAP[745]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/G'   , 1, 5, 1 );
  @{$MAP[746]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/H'   , 1, 5, 1 );
  @{$MAP[747]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/I'   , 1, 5, 1 );
  @{$MAP[748]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/J'   , 1, 5, 1 );
  @{$MAP[749]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/K'   , 1, 5, 1 );
  @{$MAP[750]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/L'   , 1, 5, 1 );
  @{$MAP[751]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/M'   , 1, 5, 1 );
  @{$MAP[752]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/N'   , 1, 5, 1 );
  @{$MAP[753]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/O'   , 1, 5, 1 );
  @{$MAP[754]} = ( $EUROCOMP, $t, $d, 'Mixed/RR/P'   , 1, 5, 1 );
  @{$MAP[755]} = ( $EUROCOMP, $t, $d, 'Mixed/Swiss/A', 1, 5, 1 );
  @{$MAP[756]} = ( $EUROCOMP, $t, $d, 'Mixed/Swiss/B', 1, 5, 1 );

  @{$MAP[758]} = ( $EUROCOMP, $t, $d, 'Open/RR/A'    , 1, 5, 1 );
  @{$MAP[759]} = ( $EUROCOMP, $t, $d, 'Open/RR/B'    , 1, 5, 1 );
  @{$MAP[760]} = ( $EUROCOMP, $t, $d, 'Open/RR/C'    , 1, 5, 1 );
  @{$MAP[761]} = ( $EUROCOMP, $t, $d, 'Open/RR/D'    , 1, 5, 1 );
  @{$MAP[762]} = ( $EUROCOMP, $t, $d, 'Open/RR/E'    , 1, 5, 1 );
  @{$MAP[763]} = ( $EUROCOMP, $t, $d, 'Open/RR/F'    , 1, 5, 1 );
  @{$MAP[764]} = ( $EUROCOMP, $t, $d, 'Open/RR/G'    , 1, 5, 1 );
  @{$MAP[765]} = ( $EUROCOMP, $t, $d, 'Open/RR/H'    , 1, 5, 1 );
  @{$MAP[766]} = ( $EUROCOMP, $t, $d, 'Open/RR/I'    , 1, 5, 1 );
  @{$MAP[767]} = ( $EUROCOMP, $t, $d, 'Open/RR/J'    , 1, 5, 1 );
  @{$MAP[768]} = ( $EUROCOMP, $t, $d, 'Open/RR/K'    , 1, 5, 1 );
  @{$MAP[769]} = ( $EUROCOMP, $t, $d, 'Open/RR/L'    , 1, 5, 1 );
  @{$MAP[770]} = ( $EUROCOMP, $t, $d, 'Open/RR/M'    , 1, 5, 1 );
  @{$MAP[771]} = ( $EUROCOMP, $t, $d, 'Open/RR/N'    , 1, 5, 1 );
  @{$MAP[772]} = ( $EUROCOMP, $t, $d, 'Open/RR/O'    , 1, 5, 1 );
  @{$MAP[773]} = ( $EUROCOMP, $t, $d, 'Open/RR/P'    , 1, 5, 1 );
  @{$MAP[774]} = ( $EUROCOMP, $t, $d, 'Open/RR/Q'    , 1, 5, 1 );
  @{$MAP[775]} = ( $EUROCOMP, $t, $d, 'Open/RR/V'    , 1, 5, 1 );
  @{$MAP[776]} = ( $EUROCOMP, $t, $d, 'Open/RR/X'    , 1, 5, 1 );
  @{$MAP[777]} = ( $EUROCOMP, $t, $d, 'Open/RR/Y'    , 1, 5, 1 );
  @{$MAP[778]} = ( $EUROCOMP, $t, $d, 'Open/RR/Z'    , 1, 5, 1 );
  @{$MAP[794]} = ( $EUROCOMP, $t, $d, 'Open/Swiss/A' , 1, 7, 1 );
  @{$MAP[795]} = ( $EUROCOMP, $t, $d, 'Open/Swiss/B' , 1, 7, 1 );

  @{$MAP[790]} = ( $EUROCOMP, $t, $d, 'Women/U'      , 1, 11, 1 );
  @{$MAP[791]} = ( $EUROCOMP, $t, $d, 'Women/W'      , 1, 11, 1 );
  @{$MAP[792]} = ( $EUROCOMP, $t, $d, 'Seniors/S'    , 1, 13, 1 );
  @{$MAP[793]} = ( $EUROCOMP, $t, $d, 'Seniors/T'    , 1, 13, 1 );

  $t = 'SaoPaulo.09';
  $d = '2009-World';
  @{$MAP[782]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 1 );
  @{$MAP[783]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 1 );
  @{$MAP[784]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 1);

  # Still Sao Paulo.
  $d = '2009-WTNT';
  @{$MAP[785]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '10Ostend';
  $d = '2010-Euro';
  @{$MAP[819]} = ( $EUROCOMP, $t, $d, 'Open/RR/A', 1, 19, 1 );
  @{$MAP[820]} = ( $EUROCOMP, $t, $d, 'Open/RR/B', 1, 19, 1 );
  @{$MAP[817]} = ( $EUROCOMP, $t, $d, 'Women'    , 1, 27, 1 );
  @{$MAP[818]} = ( $EUROCOMP, $t, $d, 'Seniors'  , 1, 23, 1 );
  @{$MAP[821]} = ( $EUROCOMP, $t, $d, 'Open/Final', 20, 28, 1 );

  $t = 'Veldhoven.11';
  $d = '2011-World';
  @{$MAP[881]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 1 );
  @{$MAP[882]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 1 );
  @{$MAP[883]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 1);

  # Still Veldhoven.
  $d = '2011-WTNT';
  @{$MAP[884]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '12Dublin',
  $d = '2012-Euro';
  @{$MAP[916]} = ( $EUROCOMP, $t, $d, 'Open/RR/A', 1, 17, 1 );
  @{$MAP[917]} = ( $EUROCOMP, $t, $d, 'Open/RR/B', 1, 17, 1 );
  @{$MAP[914]} = ( $EUROCOMP, $t, $d, 'Women'    , 1, 19, 1 );
  @{$MAP[915]} = ( $EUROCOMP, $t, $d, 'Seniors'  , 1, 19, 1 );
  @{$MAP[918]} = ( $EUROCOMP, $t, $d, 'Open/Final', 18, 26, 1 );

  $t = 'Lille.12';
  $d = '2012-Mind';
  @{$MAP[949]} = ( $WORLDCOMP, $t, $d, 'Open/A'   , 1, 15, 1 );
  @{$MAP[950]} = ( $WORLDCOMP, $t, $d, 'Open/B'   , 1, 15, 1 );
  @{$MAP[951]} = ( $WORLDCOMP, $t, $d, 'Open/C'   , 1, 15, 1 );
  @{$MAP[952]} = ( $WORLDCOMP, $t, $d, 'Open/D'   , 1, 15, 1 );
  @{$MAP[953]} = ( $WORLDCOMP, $t, $d, 'Women/A'  , 1, 15, 1 );
  @{$MAP[954]} = ( $WORLDCOMP, $t, $d, 'Women/B'  , 1, 15, 1 );
  @{$MAP[955]} = ( $WORLDCOMP, $t, $d, 'Women/C'  , 1, 15, 1 );
  @{$MAP[956]} = ( $WORLDCOMP, $t, $d, 'Seniors/A', 1, 15, 1 );
  @{$MAP[957]} = ( $WORLDCOMP, $t, $d, 'Seniors/B', 1, 15, 1 );

  # Still Lille.
  $d = '2012-MTNT';
  @{$MAP[935]} = ( $WORLDCOMP, $t, $d, 'Mixed', 1, 15, 1 );

  $t = '13Oostende';
  $d = '2013-Open-Euro';
  @{$MAP[970]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 10, 1 );
  @{$MAP[971]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 10, 1 );
  @{$MAP[972]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 10, 1 );
  @{$MAP[969]} = ( $EUROCOMP, $t, $d, 'Mixed'  , 1, 15, 1 );

  $t = 'Bali.13';
  $d = '2013-World';
  @{$MAP[980]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 1 );
  @{$MAP[981]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 1 );
  @{$MAP[982]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 1);

  # Still Bali.
  $d = '2013-WTNT';
  @{$MAP[983]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '14Opatija';
  $d = '2014-Euro';
  @{$MAP[1023]} = ( $EUROCOMP, $t, $d, 'Open/RR/A'      , 1, 17, 1 );
  @{$MAP[1024]} = ( $EUROCOMP, $t, $d, 'Open/RR/B'      , 1, 17, 1 );
  @{$MAP[1021]} = ( $EUROCOMP, $t, $d, 'Women'          , 1, 23, 1 );
  @{$MAP[1022]} = ( $EUROCOMP, $t, $d, 'Seniors/RR'     , 1, 12, 1 );
  @{$MAP[1025]} = ( $EUROCOMP, $t, $d, 'Seniors/Final/A', 1, 9, 1 );
  @{$MAP[1026]} = ( $EUROCOMP, $t, $d, 'Seniors/Final/B', 1, 8, 1 );
  @{$MAP[1020]} = ( $EUROCOMP, $t, $d, 'Open/Final'     , 18, 26, 1 );

  $t = '15Tromso';
  $d = '2015-Open-Euro';
  @{$MAP[1101]} = ( $EUROCOMP, $t, $d, 'Mixed'  , 1, 10, 1 );
  @{$MAP[1102]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 10, 1 );
  @{$MAP[1103]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 10, 1 );
  @{$MAP[1104]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 13, 1 );

  $t = 'chennai.15';
  $d = '2015-World';
  @{$MAP[1130]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 1 );
  @{$MAP[1131]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 1 );
  @{$MAP[1132]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 1);

  # Still Chennai.
  $d = '2015-WTNT';
  @{$MAP[1133]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '16Budapest';
  $d = '2016-Euro';
  @{$MAP[1210]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 37, 1 );
  @{$MAP[1211]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 23, 1 );
  @{$MAP[1212]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 23, 1 );

  $t = 'wroclaw.16';
  $d = '2016-Mind';
  @{$MAP[1250]} = ( $WORLDCOMP, $t, $d, 'Open/A'  , 1, 17, 1 );
  @{$MAP[1251]} = ( $WORLDCOMP, $t, $d, 'Open/B'  , 1, 17, 1 );
  @{$MAP[1252]} = ( $WORLDCOMP, $t, $d, 'Open/C'  , 1, 17, 1 );
  @{$MAP[1253]} = ( $WORLDCOMP, $t, $d, 'Women/A' , 1, 17, 1 );
  @{$MAP[1254]} = ( $WORLDCOMP, $t, $d, 'Women/B' , 1, 17, 1 );
  @{$MAP[1255]} = ( $WORLDCOMP, $t, $d, 'Seniors' , 1, 23, 1 );
  @{$MAP[1256]} = ( $WORLDCOMP, $t, $d, 'Mixed'   , 1, 23, 1 );

  $t = '17montecatini';
  $d = '2017-Open-Euro';
  @{$MAP[1400]} = ( $EUROCOMP, $t, $d, 'Mixed'  , 1, 10, 1 );
  @{$MAP[1401]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 10, 1 );
  @{$MAP[1402]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 10, 1 );
  @{$MAP[1403]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 10, 1 );

  $t = 'lyon.17';
  $d = '2017-World';
  @{$MAP[1440]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 21, 1 );
  @{$MAP[1441]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 21, 1 );
  @{$MAP[1442]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 21, 1);

  # Still Lyon.
  $d = '2017-WTNT';
  @{$MAP[1448]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '18Ostend';
  $d = '2018-Euro';
  @{$MAP[1500]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 33, 1 );
  @{$MAP[1501]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 23, 1 );
  @{$MAP[1502]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 21, 1 );

  $t = '19Lisbon';
  $d = '2019-Euro-Mixed';
  @{$MAP[1593]} = ( $EUROCOMP, $t, $d, 'Mixed', 1, 29, 1 );

  $t = '19istanbul';
  $d = '2019-Open-Euro';
  @{$MAP[1600]} = ( $EUROCOMP, $t, $d, 'Mixed'  , 1, 10, 1 );
  @{$MAP[1601]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 10, 1 );
  @{$MAP[1602]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 10, 1 );
  @{$MAP[1603]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 10, 1 );

  $t = 'wuhan.19';
  $d = '2019-World';
  @{$MAP[1640]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 23, 1 );
  @{$MAP[1641]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 23, 1 );
  @{$MAP[1642]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 23, 1);
  @{$MAP[1643]} = ( $WORLDCOMP, $t, $d, 'Mixed'  , 1, 23, 1);

  # Still Wuhan.
  $d = '2019-WTNT';
  @{$MAP[1648]} = ( $WORLDCOMP, $t, $d, 'Open', 1, 15, 1 );

  $t = '20monaco';
  $d = '2020-Winter';
  @{$MAP[2000]} = ( $EUROCOMP, $t, $d, 'Open', 1, 21, 1 );

  $t = 'salsomaggiore.22';
  $d = '2022-World';
  @{$MAP[2200]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 23, 1 );
  @{$MAP[2201]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 23, 1 );
  @{$MAP[2202]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 23, 1 );
  @{$MAP[2203]} = ( $WORLDCOMP, $t, $d, 'Mixed'  , 1, 23, 1 );

  $t = '22Madeira';
  $d = '2022-Euro';
  @{$MAP[2220]} = ( $EUROCOMP, $t, $d, 'Open'   , 1, 29, 1 );
  @{$MAP[2221]} = ( $EUROCOMP, $t, $d, 'Women'  , 1, 19, 1 );
  @{$MAP[2222]} = ( $EUROCOMP, $t, $d, 'Seniors', 1, 19, 1 );
  @{$MAP[2223]} = ( $EUROCOMP, $t, $d, 'Mixed'  , 1, 21, 1 );

  $t = '23tignes';
  $d = '2023-Winter';
  @{$MAP[2300]} = ( $EUROCOMP, $t, $d, 'Open', 1, 12, 1 );

  $t = 'marrakech.23';
  $d = '2023-World';
  @{$MAP[2350]} = ( $WORLDCOMP, $t, $d, 'Open'   , 1, 23, 1 );
  @{$MAP[2351]} = ( $WORLDCOMP, $t, $d, 'Women'  , 1, 23, 1 );
  @{$MAP[2352]} = ( $WORLDCOMP, $t, $d, 'Seniors', 1, 23, 1 );
  @{$MAP[2353]} = ( $WORLDCOMP, $t, $d, 'Mixed'  , 1, 23, 1 );

}


sub make_dir_list
{
  my ($param, $dir_list_ref) = @_;

  if ($param eq 'all')
  {
    for my $i (0 .. $#MAP)
    {
      push @$dir_list_ref, 
        { name => $MAP[$i][2] . "/" . $MAP[$i][3], number => $i }
        if defined $MAP[$i];
    }
  }
  elsif (defined $MAP[$param])
  {
    push @$dir_list_ref, 
      { name => $MAP[$param][2] . "/" . $MAP[$param][3], 
        number => $param };
  }
  else
  {
    die "No such tournament number: $param";
  }
}


1;
