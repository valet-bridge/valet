#!perl

use strict;
use warnings;
use v5.10;

use File::Fetch;

# perl getfiles3.pl 592
# where 592 is a tournament number that we know about,
# on either Eurobridge or Worldbridge.
#
# Number 935 requires the ANCHORS entry for Lille.12 to end on
# Results and not on Asp.

# Set up the maps.
my $EUROCOMP = 'http://www.eurobridge.org/Repository/competitions/';
my $WORLDCOMP = 'http://www.worldbridge.org/Repository/tourn/';

my %ANCHORS;
$ANCHORS{'Estoril.05'}    = 'Estoril.05/Asp/';
$ANCHORS{'06Warsaw'}      = '06Warsaw/asp/';
$ANCHORS{'Shanghai.07'}   = 'Shanghai.07/Asp/';
$ANCHORS{'07Antalya'}     = '07Antalya/Asp/';
$ANCHORS{'08Pau'}         = '08Pau/Asp/';
$ANCHORS{'Beijing.08'}    = 'Beijing.08/Asp/';
$ANCHORS{'09Sanremo'}     = '09Sanremo/Asp/';
$ANCHORS{'SaoPaulo.09'}   = 'SaoPaulo.09/Asp/';
$ANCHORS{'10Ostend'}      = '10Ostend/Asp/';
$ANCHORS{'Veldhoven.11'}  = 'Veldhoven.11/Asp/';
$ANCHORS{'12Dublin'}      = '12Dublin/microSite/Asp/';
$ANCHORS{'Lille.12'}      = 'Lille.12/microSite/Asp/';
$ANCHORS{'13Oostende'}    = '13Oostende/microSite/Asp/';
$ANCHORS{'Bali.13'}       = 'Bali.13/Asp/';
$ANCHORS{'14Opatija'}     = '14Opatija/microSite/Asp/';
$ANCHORS{'15Tromso'}      = '15Tromso/microsite/Asp/';
$ANCHORS{'chennai.15'}    = 'chennai.15/Asp/';
$ANCHORS{'16Budapest'}    = '16Budapest/microSite/Asp/';
$ANCHORS{'wroclaw.16'}    = 'wroclaw.16/microSite/Asp/';
$ANCHORS{'17montecatini'} = '17montecatini/microsite/Asp/';
$ANCHORS{'lyon.17'}       = 'lyon.17/Asp/';
$ANCHORS{'18Ostend'}      = '18Ostend/microSite/Asp/';
$ANCHORS{'19Lisbon'}      = '19Lisbon/microSite/Asp/';
$ANCHORS{'19istanbul'}    = '19istanbul/microSite/Asp/';
$ANCHORS{'wuhan.19'}      = 'wuhan.19/Asp/';
$ANCHORS{'salsomaggiore.22'} = 'wuhan.19/Asp/';
$ANCHORS{'23tignes'}      = '23tignes/microSite/Asp/';

my @MAP;

my $t = 'Estoril.05';
@{$MAP[527]} = ( $WORLDCOMP, $t, '2005-World', 'Men', 1, 21, 0 );
@{$MAP[528]} = ( $WORLDCOMP, $t, '2005-World', 'Women', 1, 21, 0 );
@{$MAP[529]} = ( $WORLDCOMP, $t, '2005-World', 'Seniors', 1, 21, 0 );
@{$MAP[531]} = ( $WORLDCOMP, $t, '2005-WTNT', 'Open', 1, 15, 0 );

$t = '06Warsaw';
@{$MAP[552]} = ( $EUROCOMP, $t, '2006-Euro', 'Men', 1, 33, 0 );
@{$MAP[553]} = ( $EUROCOMP, $t, '2006-Euro', 'Women', 1, 21, 0 );
@{$MAP[554]} = ( $EUROCOMP, $t, '2006-Euro', 'Seniors', 1, 15, 0 );
@{$MAP[587]} = ( $EUROCOMP, $t, '2006-Euro', 'SeniorsFA', 1, 7, 0 );
@{$MAP[588]} = ( $EUROCOMP, $t, '2006-Euro', 'SeniorsFB', 1, 7, 0 );

$t = 'Shanghai.07';
@{$MAP[607]} = ( $WORLDCOMP, $t, '2007-World', 'Men', 1, 21, 1 );
@{$MAP[608]} = ( $WORLDCOMP, $t, '2007-World', 'Women', 1, 21, 1 );
@{$MAP[609]} = ( $WORLDCOMP, $t, '2007-World', 'Seniors', 1, 21, 1 );
@{$MAP[610]} = ( $WORLDCOMP, $t, '2007-WTNT', 'Open', 1, 15, 1 );
@{$MAP[607]} = ( $WORLDCOMP, $t, '2007-World', 'Men', 1, 21, 1 );

$t = '07Antalya';
@{$MAP[627]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRA', 1, 5, 1 );
@{$MAP[628]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRB', 1, 5, 1 );
@{$MAP[629]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRC', 1, 5, 1 );
@{$MAP[630]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRD', 1, 5, 1 );
@{$MAP[631]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRE', 1, 5, 1 );
@{$MAP[632]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRF', 1, 5, 1 );
@{$MAP[633]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRG', 1, 5, 1 );
@{$MAP[634]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRH', 1, 5, 1 );
@{$MAP[635]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRI', 1, 5, 1 );
@{$MAP[636]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRJ', 1, 5, 1 );
@{$MAP[637]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRK', 1, 5, 1 );
@{$MAP[638]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedRRL', 1, 5, 1 );
@{$MAP[639]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedSwissA', 1, 5, 1 );
@{$MAP[640]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MixedSwissB', 1, 5, 1 );

@{$MAP[646]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRA', 1, 7, 1 );
@{$MAP[647]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRB', 1, 7, 1 );
@{$MAP[648]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRC', 1, 7, 1 );
@{$MAP[649]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRD', 1, 7, 1 );
@{$MAP[650]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRE', 1, 7, 1 );
@{$MAP[651]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRF', 1, 7, 1 );
@{$MAP[652]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRG', 1, 7, 1 );
@{$MAP[653]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRH', 1, 7, 1 );
@{$MAP[654]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRI', 1, 7, 1 );
@{$MAP[655]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRJ', 1, 7, 1 );
@{$MAP[656]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRK', 1, 7, 1 );
@{$MAP[657]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRL', 1, 7, 1 );
@{$MAP[658]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRM', 1, 7, 1 );
@{$MAP[659]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenRRN', 1, 7, 1 );
@{$MAP[660]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'WomenRRW', 1, 9, 1 );
@{$MAP[661]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'WomenRRX', 1, 9, 1 );
@{$MAP[662]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'SeniorsS', 1, 9, 1 );
@{$MAP[663]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'SeniorsT', 1, 9, 1 );

@{$MAP[664]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenSwissA', 1, 7, 1 );
@{$MAP[665]} = ( $EUROCOMP, $t, '2007-Open-Euro', 'MenSwissB', 1, 7, 1 );

$t = '08Pau';
@{$MAP[677]} = ( $EUROCOMP, $t, '2008-Euro', 'MenA', 1, 19, 1 );
@{$MAP[678]} = ( $EUROCOMP, $t, '2008-Euro', 'MenB', 1, 19, 1 );
@{$MAP[675]} = ( $EUROCOMP, $t, '2008-Euro', 'Women', 1, 25, 1 );
@{$MAP[676]} = ( $EUROCOMP, $t, '2008-Euro', 'Seniors', 1, 19, 1 );
@{$MAP[679]} = ( $EUROCOMP, $t, '2008-Euro', 'MenFinal', 1, 17, 1 );

$t = 'Beijing.08';
@{$MAP[694]} = ( $WORLDCOMP, $t, '2008-Mind', 'MenA', 1, 17, 1 );
@{$MAP[695]} = ( $WORLDCOMP, $t, '2008-Mind', 'MenB', 1, 17, 1 );
@{$MAP[696]} = ( $WORLDCOMP, $t, '2008-Mind', 'MenC', 1, 17, 1 );
@{$MAP[697]} = ( $WORLDCOMP, $t, '2008-Mind', 'MenD', 1, 17, 1 );
@{$MAP[698]} = ( $WORLDCOMP, $t, '2008-Mind', 'WomenA', 1, 17, 1 );
@{$MAP[699]} = ( $WORLDCOMP, $t, '2008-Mind', 'WomenB', 1, 17, 1 );
@{$MAP[700]} = ( $WORLDCOMP, $t, '2008-Mind', 'WomenC', 1, 17, 1 );
@{$MAP[701]} = ( $WORLDCOMP, $t, '2008-Mind', 'SeniorsA', 1, 15, 1 );
@{$MAP[702]} = ( $WORLDCOMP, $t, '2008-Mind', 'SeniorsB', 1, 15, 1 );
@{$MAP[688]} = ( $WORLDCOMP, $t, '2008-MTNT', 'Mixed', 1, 15, 1 );

$t = '09Sanremo';
@{$MAP[739]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRA', 1, 5, 1 );
@{$MAP[740]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRB', 1, 5, 1 );
@{$MAP[741]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRC', 1, 5, 1 );
@{$MAP[742]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRD', 1, 5, 1 );
@{$MAP[743]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRE', 1, 5, 1 );
@{$MAP[744]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRF', 1, 5, 1 );
@{$MAP[745]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRG', 1, 5, 1 );
@{$MAP[746]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRH', 1, 5, 1 );
@{$MAP[747]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRI', 1, 5, 1 );
@{$MAP[748]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRJ', 1, 5, 1 );
@{$MAP[749]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRK', 1, 5, 1 );
@{$MAP[750]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRL', 1, 5, 1 );
@{$MAP[751]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRM', 1, 5, 1 );
@{$MAP[752]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRN', 1, 5, 1 );
@{$MAP[753]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRO', 1, 5, 1 );
@{$MAP[754]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedRRP', 1, 5, 1 );
@{$MAP[755]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedSwissA', 1, 5, 1 );
@{$MAP[756]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'MixedSwissB', 1, 5, 1 );

@{$MAP[758]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRA', 1, 5, 1 );
@{$MAP[759]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRB', 1, 5, 1 );
@{$MAP[760]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRC', 1, 5, 1 );
@{$MAP[761]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRD', 1, 5, 1 );
@{$MAP[762]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRE', 1, 5, 1 );
@{$MAP[763]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRF', 1, 5, 1 );
@{$MAP[764]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRG', 1, 5, 1 );
@{$MAP[765]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRH', 1, 5, 1 );
@{$MAP[766]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRI', 1, 5, 1 );
@{$MAP[767]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRJ', 1, 5, 1 );
@{$MAP[768]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRK', 1, 5, 1 );
@{$MAP[769]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRL', 1, 5, 1 );
@{$MAP[770]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRM', 1, 5, 1 );
@{$MAP[771]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRN', 1, 5, 1 );
@{$MAP[772]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRO', 1, 5, 1 );
@{$MAP[773]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRP', 1, 5, 1 );
@{$MAP[774]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRQ', 1, 5, 1 );
@{$MAP[775]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRV', 1, 5, 1 );
@{$MAP[776]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRX', 1, 5, 1 );
@{$MAP[777]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRY', 1, 5, 1 );
@{$MAP[778]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenRRZ', 1, 5, 1 );
@{$MAP[794]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenSwissA', 1, 7, 1 );
@{$MAP[795]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'OpenSwissB', 1, 7, 1 );

@{$MAP[790]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'WomenRRU', 1, 11, 1 );
@{$MAP[791]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'WomenRRW', 1, 11, 1 );
@{$MAP[792]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'SeniorsRRS', 1, 13, 1 );
@{$MAP[793]} = ( $EUROCOMP, $t, '2009-Open-Euro', 'SeniorsRRT', 1, 13, 1 );

$t = 'SaoPaulo.09';
@{$MAP[782]} = ( $WORLDCOMP, $t, '2009-World', 'Men', 1, 21, 1 );
@{$MAP[783]} = ( $WORLDCOMP, $t, '2009-World', 'Women', 1, 21, 1 );
@{$MAP[784]} = ( $WORLDCOMP, $t, '2009-World', 'Seniors', 1, 21, 1);
@{$MAP[785]} = ( $WORLDCOMP, $t, '2009-WTNT', 'Open', 1, 15, 1 );

$t = '10Ostend';
@{$MAP[819]} = ( $EUROCOMP, $t, '2010-Euro', 'MenA', 1, 19, 1 );
@{$MAP[820]} = ( $EUROCOMP, $t, '2010-Euro', 'MenB', 1, 19, 1 );
@{$MAP[817]} = ( $EUROCOMP, $t, '2010-Euro', 'Women', 1, 27, 1 );
@{$MAP[818]} = ( $EUROCOMP, $t, '2010-Euro', 'Seniors', 1, 23, 1 );
@{$MAP[821]} = ( $EUROCOMP, $t, '2010-Euro', 'MenFinal', 20, 28, 1 );

$t = 'Veldhoven.11';
@{$MAP[881]} = ( $WORLDCOMP, $t, '2011-World', 'Men', 1, 21, 1 );
@{$MAP[882]} = ( $WORLDCOMP, $t, '2011-World', 'Women', 1, 21, 1 );
@{$MAP[883]} = ( $WORLDCOMP, $t, '2011-World', 'Seniors', 1, 21, 1);
@{$MAP[884]} = ( $WORLDCOMP, $t, '2011-WTNT', 'Open', 1, 15, 1 );

$t = '12Dublin',
@{$MAP[916]} = ( $EUROCOMP, $t, '2012-Euro', 'MenA', 1, 17, 1 );
@{$MAP[917]} = ( $EUROCOMP, $t, '2012-Euro', 'MenB', 1, 17, 1 );
@{$MAP[914]} = ( $EUROCOMP, $t, '2012-Euro', 'Women', 1, 19, 1 );
@{$MAP[915]} = ( $EUROCOMP, $t, '2012-Euro', 'Seniors', 1, 19, 1 );
@{$MAP[918]} = ( $EUROCOMP, $t, '2012-Euro', 'MenFinal', 18, 26, 1 );

$t = 'Lille.12';
@{$MAP[949]} = ( $WORLDCOMP, $t, '2012-Mind', 'MenA', 1, 15, 1 );
@{$MAP[950]} = ( $WORLDCOMP, $t, '2012-Mind', 'MenB', 1, 15, 1 );
@{$MAP[951]} = ( $WORLDCOMP, $t, '2012-Mind', 'MenC', 1, 15, 1 );
@{$MAP[952]} = ( $WORLDCOMP, $t, '2012-Mind', 'MenD', 1, 15, 1 );
@{$MAP[953]} = ( $WORLDCOMP, $t, '2012-Mind', 'WomenA', 1, 15, 1 );
@{$MAP[954]} = ( $WORLDCOMP, $t, '2012-Mind', 'WomenB', 1, 15, 1 );
@{$MAP[955]} = ( $WORLDCOMP, $t, '2012-Mind', 'WomenC', 1, 15, 1 );
@{$MAP[956]} = ( $WORLDCOMP, $t, '2012-Mind', 'SeniorsA', 1, 15, 1 );
@{$MAP[957]} = ( $WORLDCOMP, $t, '2012-Mind', 'SeniorsB', 1, 15, 1 );
@{$MAP[935]} = ( $WORLDCOMP, $t, '2012-MTNT', 'Mixed', 1, 15, 1 );

$t = '13Oostende';
@{$MAP[970]} = ( $EUROCOMP, $t, '2013-Open-Euro', 'Open', 1, 10, 1 );
@{$MAP[971]} = ( $EUROCOMP, $t, '2013-Open-Euro', 'Women', 1, 10, 1 );
@{$MAP[972]} = ( $EUROCOMP, $t, '2013-Open-Euro', 'Seniors', 1, 10, 1 );
@{$MAP[969]} = ( $EUROCOMP, $t, '2013-Open-Euro', 'Mixed', 1, 15, 1 );

$t = 'Bali.13';
@{$MAP[980]} = ( $WORLDCOMP, $t, '2013-World', 'Men', 1, 21, 1 );
@{$MAP[981]} = ( $WORLDCOMP, $t, '2013-World', 'Women', 1, 21, 1 );
@{$MAP[982]} = ( $WORLDCOMP, $t, '2013-World', 'Seniors', 1, 21, 1);
@{$MAP[983]} = ( $WORLDCOMP, $t, '2013-WTNT', 'Open', 1, 15, 1 );

$t = '14Opatija';
@{$MAP[1023]} = ( $EUROCOMP, $t, '2014-Euro', 'MenA', 1, 17, 1 );
@{$MAP[1024]} = ( $EUROCOMP, $t, '2014-Euro', 'MenB', 1, 17, 1 );
@{$MAP[1021]} = ( $EUROCOMP, $t, '2014-Euro', 'Women', 1, 23, 1 );
@{$MAP[1022]} = ( $EUROCOMP, $t, '2014-Euro', 'Seniors', 1, 12, 1 );
@{$MAP[1025]} = ( $EUROCOMP, $t, '2014-Euro', 'SeniorsFinalA', 1, 9, 1 );
@{$MAP[1026]} = ( $EUROCOMP, $t, '2014-Euro', 'SeniorsFinalB', 1, 8, 1 );
@{$MAP[1020]} = ( $EUROCOMP, $t, '2014-Euro', 'MenFinal', 18, 26, 1 );

$t = '15Tromso';
@{$MAP[1101]} = ( $EUROCOMP, $t, '2015-Open-Euro', 'Open', 1, 10, 1 );

$t = 'chennai.15';
@{$MAP[1130]} = ( $WORLDCOMP, $t, '2015-World', 'Men', 1, 21, 1 );
@{$MAP[1131]} = ( $WORLDCOMP, $t, '2015-World', 'Women', 1, 21, 1 );
@{$MAP[1132]} = ( $WORLDCOMP, $t, '2015-World', 'Seniors', 1, 21, 1);
@{$MAP[1133]} = ( $WORLDCOMP, $t, '2015-WTNT', 'Open', 1, 15, 1 );

$t = '16Budapest';
@{$MAP[1210]} = ( $EUROCOMP, $t, '2016-Euro', 'Men', 1, 37, 1 );
@{$MAP[1211]} = ( $EUROCOMP, $t, '2016-Euro', 'Women', 1, 23, 1 );
@{$MAP[1212]} = ( $EUROCOMP, $t, '2016-Euro', 'Seniors', 1, 23, 1 );

$t = 'wroclaw.16';
@{$MAP[1250]} = ( $WORLDCOMP, $t, '2016-Mind', 'MenA', 1, 17, 1 );
@{$MAP[1251]} = ( $WORLDCOMP, $t, '2016-Mind', 'MenB', 1, 17, 1 );
@{$MAP[1252]} = ( $WORLDCOMP, $t, '2016-Mind', 'MenC', 1, 17, 1 );
@{$MAP[1253]} = ( $WORLDCOMP, $t, '2016-Mind', 'WomenA', 1, 17, 1 );
@{$MAP[1254]} = ( $WORLDCOMP, $t, '2016-Mind', 'WomenB', 1, 17, 1 );
@{$MAP[1255]} = ( $WORLDCOMP, $t, '2016-Mind', 'Seniors', 1, 23, 1 );
@{$MAP[1256]} = ( $WORLDCOMP, $t, '2016-Mind', 'Mixed', 1, 23, 1 );

$t = '17montecatini';
@{$MAP[1400]} = ( $EUROCOMP, $t, '2017-Open-Euro', 'Open', 1, 10, 1 );

$t = 'lyon.17';
@{$MAP[1440]} = ( $WORLDCOMP, $t, '2017-World', 'Men', 1, 21, 1 );
@{$MAP[1441]} = ( $WORLDCOMP, $t, '2017-World', 'Women', 1, 21, 1 );
@{$MAP[1442]} = ( $WORLDCOMP, $t, '2017-World', 'Seniors', 1, 21, 1);
@{$MAP[1448]} = ( $WORLDCOMP, $t, '2017-WTNT', 'Open', 1, 15, 1 );

$t = '18Ostend';
@{$MAP[1500]} = ( $EUROCOMP, $t, '2018-Euro', 'Men', 1, 33, 1 );
@{$MAP[1501]} = ( $EUROCOMP, $t, '2018-Euro', 'Women', 1, 23, 1 );
@{$MAP[1502]} = ( $EUROCOMP, $t, '2018-Euro', 'Seniors', 1, 23, 1 );

$t = '19Lisbon';
@{$MAP[1593]} = ( $EUROCOMP, $t, '2019-Euro-Mixed', 'Mixed', 1, 29, 1 );

$t = '19istanbul';
@{$MAP[1600]} = ( $EUROCOMP, $t, '2019-Open-Euro', 'Open', 1, 10, 1 );

$t = 'wuhan.19';
@{$MAP[1640]} = ( $WORLDCOMP, $t, '2019-World', 'Men', 1, 23, 1 );
@{$MAP[1641]} = ( $WORLDCOMP, $t, '2019-World', 'Women', 1, 23, 1 );
@{$MAP[1642]} = ( $WORLDCOMP, $t, '2019-World', 'Seniors', 1, 23, 1);
@{$MAP[1648]} = ( $WORLDCOMP, $t, '2019-WTNT', 'Open', 1, 15, 1 );

$t = '20monaco';
@{$MAP[2000]} = ( $EUROCOMP, , '2020-Winter', 'Open', 1, 21, 1 );

$t = 'salsomaggiore.22';
@{$MAP[2200]} = ( $EUROCOMP, $t, '2022-World', 'Men', 1, 23, 1 );
@{$MAP[2201]} = ( $EUROCOMP, $t, '2022-World', 'Women', 1, 23, 1 );
@{$MAP[2202]} = ( $EUROCOMP, $t, '2022-World', 'Seniors', 1, 23, 1 );
@{$MAP[2203]} = ( $EUROCOMP, $t, '2022-World', 'Mixed', 1, 23, 1 );

$t = '22Madeira';
@{$MAP[2220]} = ( $EUROCOMP, $t, '2022-Euro', 'Men', 1, 39, 1 );
@{$MAP[2221]} = ( $EUROCOMP, $t, '2022-Euro', 'Women', 1, 19, 1 );
@{$MAP[2222]} = ( $EUROCOMP, $t, '2022-Euro', 'Seniors', 1, 19, 1 );

$t = '23tignes';
@{$MAP[2300]} = ( $EUROCOMP, $t, '2023-Winter', 'Open', 1, 12, 1 );


# Parse command line.
die "Need a tournament number" unless $#ARGV == 0;
my $tno = shift;

die "Not a known tournament number" unless defined $MAP[$tno];

my $site = $MAP[$tno][0];
my $tag = $MAP[$tno][1];
my $dir = $MAP[$tno][2];
my $group = $MAP[$tno][3];
my $round_first = $MAP[$tno][4];
my $round_last = $MAP[$tno][5];
my $spell_flag = $MAP[$tno][6];

my $tourney1 = $site  . $ANCHORS{$tag};
my $sprefix1 = "$tag/Rounds$group";
my $sprefix2 = "$tag/Matches$group";


# Open European
# -------------
# 
# my $rounds = 50;
# my $sprefix1 = '2018-Open/BAMFA1/Rounds';
# my $sprefix2 = '2018-Open/BAMFA1/Matches';
# my $tno = 1493;
# my $tourney1 = 'http://www.eurobridge.org/Repository/competitions/18Monaco/microSite/Asp/';


my $fetch1 = "$sprefix1/RoundTeams.asp";
my $boarddetails = ($spell_flag ? "BoardDetails.asp" : "Boarddetails.asp");
my $fetch2 = "$sprefix2/$boarddetails";
my $tourney2 = "RoundTeams.asp?qtournid=$tno&qroundno=";
my $prefix = "$tourney1$tourney2";

for my $r ($round_first .. $round_last)
{
  # First get the round overview.
  say "Round $r";

  my $name = $prefix . $r;
  say $name;

  my $res1 = $fetch1;
  $res1 =~ s/Teams/Teams$r/;

  my $ff = File::Fetch->new(uri => $name); 
  my $where = $ff->fetch(to => $sprefix1) or die $ff->error;
  say "fetch1 $fetch1 res1 $res1";
  rename $fetch1, $res1;

  # Then identify the URLs of match results.

  open my $fh, "<$res1" or die "Can't open $res1";
  my $line;
  my $table = 1;

  while ($line = <$fh>)
  {
    chomp $line;
    next if ($line !~ /$boarddetails/);
    next if ($line !~ /qmatchid=(\d+)/);

    my $name2 = $tourney1 . $boarddetails . "?qmatchid=$1";
    say $name2;

    # Then get each of the match files.

    my $res2 = $fetch2;
    $res2 =~ s/[dD]etails/Details-r$r-t$table/;
    $table++;

    $ff = File::Fetch->new(uri => $name2); 
    my $where = $ff->fetch(to => $sprefix2) or die $ff->error;
    say "fetch2 $fetch2 res2 $res2";
    rename $fetch2, $res2;

  }
  close $fh;

}

exit;

