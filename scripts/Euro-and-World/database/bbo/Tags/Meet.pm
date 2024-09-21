#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Meet;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  # POLAND
  'Baltic Congress',
  'Beskids Slam',
  'Boleslawiec Festival',
  'Krakow Congress',
  'Luczniczka Meeting',
  'Polish Championships',
  'Poznan Congress',
  'Slawa Congress',
  'Warsaw Grand Prix',
  'Wroclaw Meeting',
  'Zulawski Congress',

 
  'Aegean Championships',
  'Azores Festival',
  'Amman Bridge Festival',
  'Australian National Championships',
  'Australian Summer Festival',
  'Australian Youth Triathlon',
  'Balkan Friendship Festival',
  'Bangkok Bridge Festival',
  'Banten Sports Week',
  'Bodrum Peninsula Festival',
  'Brasov Festival',
  'Brazilian Trials',
  'Cairo Bridge Festival',
  'Canadian Bridge Championships',
  'Cappadocia Fairy Chimneys Festival',
  'Copenhagen Invitational',
  'Crete Bridge Festival',
  'Danish Bridge Festival',
  'Estoril Bridge Festival',

  "European Champions' Cup",
  'European National Championships',
  'European Transnational Championships',
  'European Winter Games',
  'European Winter Transnational Championships',
  'European Youth Team Championships',
  'Generali European Championships',

  'Fes Festival',
  'Festival della Matematica',
  'Gold Coast Congress',
  'Greek Islands Festival',
  'Iceland Bridge Festival',
  'Indonesian National Championships',
  'Indonesian National Pre-Sports Week',
  'Indonesian National Sports Week',
  'International Bridge Festival',
  'Israel Grand Prix',
  'Israel International Festival',
  'Israel Teams Cup',
  'Italian Club Championship',
  'Italy Cup',
  'Jordan Bridge Festival',
  'Jyvaskala Easter Bridge Festival',
  'Lozenets Bridge Festival',
  'Maharaja Holkar National Championship',
  'Mar del Plata Festival',
  'Marmara Festival',
  'Mautern Bridge Festival',
  'Mersin Bridge Festival',
  'Monaco International Festival',
  'North American Bridge Championship',
  'Norwegian Championship',
  'Norwegian District Championship',
  'Pärnu Festival',
  'Plovdiv Bridge Festival',
  'Polish Grand Prix',
  'Polish Pairs Championship',
  'Polish Youth Olympiad',
  'Polish Schools Championship',
  'Pula Bridge Festival',
  'Red Sea International Festival',
  'Reykjavik Bridge Festival',
  'Samobor Bridge Meeting',
  'Serdika Bridge Festival',
  'Sivrioglu Festival',
  'Stara Zagora Bridge Festival',
  'Tallinn Bridge Festival',
  'Tolani Summer Nationals',
  'Thailand National Games',
  'Turkish Autumn Festival',
  'Turkish-Greek Friendship Festival',
  'The Hague Bridge Festival',
  'Umea Bridgefestival',
   'United States Bridge Championship',
  'Vanke Cup',
  'Varna Bridge Festival',
  'VVE Beheer Bridge Week',
  'Wachauer Bridge Festival',
  'West Java Regional',
  'Winter Bridge Festival',
  'Winter Championships',
  'Winter Nationals',
  'World Bridge Series',
  'World Mind Games',
  'World Team Championships',
   'World Team Olympiad',
);

my %MULTI_TYPOS =
(
  'All China Games' => ['all-china games'],
  'Australian Summer Festival' => ['summer bridge festival'],
  'Azores Festival' => ['azores festival bridge', 'azores bridge open',
    'azores bridge teams', 'azores team', 'azores teams',
    'azores team festval', 'festival azores bridge', 'azores festiva', 
    'festival azores'],
  'Balkan Friendship Festival' => ['balkan bridge festival',
    'balkan festival', 'balcan friendship festival',
    'balcan frienship festival', 'balkan frienship festival',
    'balkan friendsphip festival'],
  'Baltic Congress' => ['baltic bridge congress',
    'international baltic congress'],
  'Bodrum Peninsula Festival' => ['bodrum yarýmada bric festivali'],
  'Brasov Festival' => ['festival brasov', 'festival bridge brasov',
    'international bridge festival brasov',
    'festivalul international de bridge brasov'],
  'Brazilian Trials' => [
    'brazilian team trials',
    'brazilian teams trials'],
  'Copenhagen Invitational' => ['copenhagen bridge invitational'],
  'Crete Bridge Festival' => ['crete b_ festival'],
  'Estoril Bridge Festival' => ['estoril festival'],
  'European National Championships' => [
    'champ eur pau',
    'e_b_l_ team championships',
    'e_b_l_ teams championship',
    'e_b_l_ team champioships',
    'ebl team champs',
    'ebl team championships',
    'ebl teams championship',
    'ebl teams championships',
    'eur cha pau',
    'eur cham pau',
    'eur champ eur',
    'eur champ pau',
    'eur champ puau',
    'euro team championships',
    'european b.t.ch.',
    'european b_t_ch_',
    'european bridge team championships',
    'european bridge team champ',
    'europeqn teqm championships',
    'european team championship',
    'european team championships',
    'european teams championship',
    'european teams championships'],
  'European Transnational Championships' => [
    'euro open championships', 
    'euro open teams',
    'euroepan open champ', 
    'european open champ', 
    'europe open champ'],

  'European Youth Team Championships' => [
    'european youth bridge championship',
    'european youth championships',
    'european youth championship'],

  'Fes Festival' => ['fes bridge international festival',
    'festival fes', 'festival de fes', 'festival international de fès',
    'festival de fez'],
  'Gold Coast Congress' => ['gold coast'],
  'Greek Islands Festival' => ['greek bridge festival',
    'greek island festival', 'athens bridge festival', 
    'greek islands festivals', 'greek festival islands', 'greek islands'],
  'Iceland Bridge Festival' => ['iceland bridgefestival',
    'iceland express bridge festival',
    'icelandic express bridge festival'],
  'Indonesian National Pre-Sports Week' => ['pra pon'],
  'Indonesian National Sports Week' => ['indonesia week',
    'indonesian national sports weeks'],
  'International Bridge Festival' => ['int_ bridge festival'],
  'Israel Grand Prix' => ['israeli grand prix',
    'israeli grand prize'],
  'Israel International Festival' => ['israel int_ festival',
    'int_ israel festival', 'israel festival', 'israel fest_'],
  'Israel Teams Cup' => [
    'israel national team cup',
    'israel team cup', 
    'israeli team cup', 
    'israel teams cup', 
    'israel team of four cup'],
  'Italian Club Championship' => [
    'camp.societ sportive',
    'campionato italiano di societa',
    'campionato italiano di società',
    'campionato italiano intersocietario',
    'campionato di società',
    'campionati soc',
    'interclub italy',
    'italian club champ_',
    'italian clubs champ_',
    'italian club team',
    'italian club team cham',
    'italian club team champ',
    'italian club team championship',
    'italian club team championships',
    'italian club teams',
    'italian clubs teams championships',
    'italian teams clubs championships',
    'italian interclub',
    'interclub italian'],
  'Italy Cup' => ['coppa italia'],

  'Jordan Bridge Festival' => ['jordab festival', 'jordan b_ festival',
    'jordan bridge f estival', 'jordan bridge tournament spring festival',
    'jordan bridge tournament ( spring festival)',
    'jordan bridge tournament (spring festival)'],
  'Jyvaskala Easter Bridge Festival' => ['easter bridge trophy'],

  'Krakow Congress' => ['krakow meeting'],
  'Lozenets Bridge Festival' => ['bridge festival lozenets'],

  'Luczniczka Meeting' => ['meeting luczniczka'],
  'Maharaja Holkar National Championship' => [
    'maharaja holakar championship',
    'maharaja holar national open',
    'maharaja holkar bridge championship',
    'maharaja holkar championship',
    'maharaja holkar national open championship',
    'maharaja holkar national tournament',
    'M Yeshwantrao Holkar National Bridge Championship'],
  'Mar del Plata Festival' => [ 'mar del plata international festival',
    'mar del plata international bridge festival'],
  'Marmara Festival' => ['festival marmara'],
  'Mautern Bridge Festival' => ['mautern bridgefestival'],
  'Monaco International Festival' => ['festival international de monaco'],
  'Norwegian District Championship' => ['norwegian district',
     'norw district', 'norwegian regional chship',
     'norway regional champship'],
  'Plovdiv Bridge Festival' => ['international festival - plovdiv',
    'international festival plovdiv'],
  'Polish Pairs Championship' => [
    'pairs championship od poland',
    'pairs championship of poland'],
  'Polish Schools Championship' => [
    'polish schools champ',
    'polish schools champs'],
  'Polish Youth Olympiad' => ['oom'],
  'Poznan Congress' => [
    'bridge meeting poznan',
    'kongres poznanski', 
    'poznanski kongres brydzowy'],
  'Pula Bridge Festival' => ['international festival pula',
    'pula bridge festiwal'],
  'Red Sea International Festival' => ['red see international festival',
    'read beach festival', 'red beach festival', 'red sea festival',
    'red sea bridge festival', 'red see int_ bridge festival',
    'red sea int_ festival'],
  'Reykjavik Bridge Festival' => ['reykjavikbridgefestival'],
  'Samobor Bridge Meeting' => ['bridge meeting samobor'],
  'Serdika Bridge Festival' => ['bridge festival - serdika',
    'bridge festival serdika'],
  'Slava Congress' => ['s³awa turniej kongresowy'],
  'Stara Zagora Bridge Festival' => ['bridge festival - stara zagora',
    'bridge festival stara zagora', 
    'bridge festival-bulgaria-stara zagora'],
  'Tallinn Bridge Festival' => ['talinn festival', 'tallin festival',
    'tallinns festival'],
  'Tolani Summer Nationals' => ['tolani open', 'dr_tolani summer nationals',
    'tolani open summer nationals', 'dr tolani summer nationals',
    'dr_ tolani summer nationals',
    'dr_ tolani open summer nations', 'dr_ tolani summar nationals',
    'dr_tolani open summer natinal', 'dr_tolani open summer national', 
    'dr_tolani open summer nationals', 'dr_ tolani open summer nationals',
    'dr_tolani open summer nationaals', 'dr tolani open summer nationals'],
  'Turkish Autumn Festival' => ['sonbahar bridge festival'],
  'Turkish-Greek Friendship Festival' => [
    'greek-turkish friendship festival'],
  'United States Bridge Championship' => ['us bridge championship',
    'u_s_b_c', 'united states bridge championships'],
  'Varna Bridge Festival' => ['international bridge festival varna'],
  'VVE Beheer Bridge Week' => ['vve-beheer bridgeweek',
    'vve-beheer bridge week'],
  'Wachauer Bridge Festival' => ['wachauer bridgefestival'],
  'West Java Regional' => ['west java regional sport games',
    'west java regional games', 'west java regional spots event',
    'regional west java'],
  'Winter Championships' => ['winter championship',
    'winter championsship'],
  'Winter Nationals' => ['winter national', 'wintter nationals',
    'wintrer national'],
  'World Mind Games' => ['world mind game', 'word mind games', 'wmsg',
    'mind sports games', 'sawmg', 'wmg', 'wnsg', 'world ming games'],
  'World Team Olympiad' => ['world bridge team olympiad',
    'world bridge olympiad', 'bridge olympiad'],
  'Zulawski Congress' => [
    'mityng zulawski', 
    "kongres \"zulawski\"",
    'kongres zulawski', 
    "mityng \"zulawski\""]
);

my @SINGLE_WORDS = qw(
  Congress
  Festival
);

my %SINGLE_TYPOS =
(
  'Australian National Championships' => ['anc'],
  'Australian Summer Festival' => ['sfb', 'sfob'],
  'Bangkok Bridge Festival' => ['bbf', 'bff'],
  'Canadian Bridge Championships' => ['cbc'],
  Congress => ['kongres', 'kongresowy'],
  'European National Championships' => ['ec'],
  'European Transnational Championships' => ['eobc', 'eoc'],
  'European Winter Games' => ['ewg'],
  Festival => ['fest', 'festivan', 'festývalý', 'festivalul', 'festiwal'],
  'Gold Coast Congress' => ['gc', 'gcc'],
  'Indonesian National Pre-Sports Week' => ['prapon'],
  'Indonesian National Sports Week' => ['indonesia week', 'pon'],
  'North American Bridge Championship' => ['nabc'],
  'Norwegian Championship' => ['nm'],
  'United States Bridge Championship' => ['usbc'],
  'Winter Nationals' => ['winternationals'],
  'World Bridge Series' => ['wbs'],
  'World Team Championships' => ['wbtc'],
  'World Team Olympiad' => ['olympiad', 'olympiads', 'wbo']
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
