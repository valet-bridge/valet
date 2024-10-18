#!perl

package EntryT;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Time::Piece;

use lib '.';

my @HEADER_FIELDS = qw(
  TOURNAMENT_NAME
  TOURNAMENT_CITY
  YEAR
  TOURNAMENT_ORDINAL
  ORDINAL
  ZONE
  ORIGIN
  COUNTRY
  LOCALITY
  CITY
  ORGANIZATION
  FORM
  SCORING
  AGE 
  GENDER
);

my %HEADER_HASH_CHECK;
$HEADER_HASH_CHECK{$_} = 1 for @HEADER_FIELDS;

my @CHAPTER_FIELDS = qw(
  YEAR
  MEET
  WEEKEND
  AGE
  GENDER
  DATE_START
  DATE_END
  MOVEMENT
  STAGE
);

my %CHAPTER_HASH_CHECK;
$CHAPTER_HASH_CHECK{$_} = 1 for @CHAPTER_FIELDS;


my @PRUNE_HEADER_FIELDS = (
  ['TOURNAMENT_ORDINAL', 'TITLE_ORDINAL'],
  ['TOURNAMENT_NAME', 'TITLE_TNAME'],
  ['YEAR', 'TITLE_YEAR'],
  ['ZONE', 'TITLE_ZONE'],
  ['ORIGIN', 'TITLE_ORIGIN'],
  ['COUNTRY', 'TITLE_COUNTRY'],
  ['CITY', 'TITLE_CITY'],
  ['ORGANIZATION', 'TITLE_ORGANIZATION'],
  ['FORM', 'TITLE_FORM'],
  ['FORM', 'TEAM1_FORM'],
  ['FORM', 'TEAM2_FORM'],
  ['SCORING', 'TITLE_SCORING'],
  ['SCORING', 'SCORING'],
  ['AGE', 'TITLE_AGE'],
  ['GENDER', 'TITLE_GENDER']
);

my @PRUNE_CHAPTER_FIELDS = (
  ['YEAR', 'TITLE_YEAR'],
  ['MOVEMENT', 'EVENT_MOVEMENT'],
  ['STAGE', 'TITLE_STAGE'],
  ['STAGE', 'EVENT_STAGE']
);

my %SCORING_CORRECTIONS = (
  # Says P in BBO file, but is IMPs
  # Or says I in BBO file, but is MPs
  'European Transnational Mixed Pairs' => [
    18826, 18828, 18829, 18832, 18833, 18834, 18835, 18836, 18837,
    18840, 18841, 18842, 18843, 18844, 18845, 18846, 18847, 18849,
    18850, 18851, 18852, 18853, 18854, 18855, 18856],
  'European Transnational Open Pairs' => [
    18995, 18996, 18997, 18998, 18999, 19000, 19001, 19002, 19003,
    19004, 19005, 19006, 19007, 19008, 19011, 19012, 19013, 19014,
    19015, 19016, 19017, 19018, 19019, 19020, 19021, 19022, 19023,
    19024, 19025, 19027, 19028, 19029, 19030, 19031, 19032, 19033,
    19034, 19035, 19036, 19037, 19038, 19039, 19040, 19041, 19042,
    19043, 19044, 19045, 19046, 19047, 19048, 19049, 19050, 19052,
    19053, 19054, 19055, 19056, 19057, 19058, 19059, 19060, 19061,
    19062, 19063, 19064, 19065, 19066, 19067],
  'Greek Open Pair Trials' => [
    12439, 12440, 12441, 12447, 12463, 12464, 12465, 12468, 12470,
    12471, 12484, 12486, 12487, 12489, 12490, 12492, 12520, 12543,
    12548, 12550, 12554, 12560, 12562, 12564, 12565, 12584, 12587,
    12588, 12596, 12600],
  "Gro's Supercup" => [15059, 15070, 
    19725, 19732, 19745,
    24988, 24989, 29535, 29536, 29540, 29541, 29548, 29549,
    34123, 34129, 34132, 34133,
    39117, 39120, 39145, 39146, 39151,
    44699, 44700, 44702, 44704, 44709, 44710, 44723, 44724,
    44730, 44731, 44736, 44737, 44738, 44739, 44764, 44765, 44766]
);

  # 'Finnish Swiss Teams' => [
    # 16711, 16718, 16719, 16720, 16723, 16724, 16727, 16728, 16730,
    # 16731, 16736, 16739, 16742, 16743, 16746],

my %FORM_CORRECTIONS = (
  # Says Team 1, Team 2 in BBO file, but is pairs or individual
  'All India Corporate Invitational Pairs' => [
    25406, 25408,
    30537,
    46420, 46433],
  'All India HCL Pairs' => [
    19955, 19968,
    25115, 25129,
    29833],
  'All India Open Pairs' => [
    27043, 27045,
    37060,
    39616],
  'Argentinian Mixed Pairs' => [
    43946],
  'Australian Senior Pairs' => [
    13315, 13316, 13317, 13318, 13319, 13321, 13323, 13324, 13329,
    13332, 13350, 13351, 13352, 13353, 13355, 13356, 13357, 13359,
    32882, 32883, 32884, 32886, 32889, 32904, 32907, 32908],
  'Australian Youth IMP Pairs' => [
    16490, 16491, 16492, 16493, 16494, 16495, 16496, 16497, 16499,
    16500, 16501, 16502, 16503, 16504, 16505, 16506, 16506, 16507,
    16508],
  'Australian Youth Tri Individual' => [
    21284],
  'Australian Youth Tri Pairs' => [
    21303,
    31483, 31484],
  'Belgian Open Pairs' => [3075, 3076, 9813, 9824, 18125,18133],
  'Chilean Cup' => [26199, 26218, 26237, 26265],
  'Chilean Open Pairs' => [31502, 31503],
  'Copenhagen Invitational Pairs' => [36915, 36941, 36954],
  'Copenhagen Open Pairs' => [
    27782, 27784, 27789, 27790,
    32623, 32631, 32640, 32644,
    38027, 38046],
  'Danish Mixed Pairs' => [
    19096, 19103, 19105, 19107, 19120, 19124, 19125, 19130, 19133, 19134,
    24114, 24128, 24132, 24133,
    29177, 29184, 29188, 29192,
    34362, 34368, 34373,
    45696, 45707, 45724, 45728],
  'Danish Open Pairs' => [
    10471, 10474,
    14732, 14733, 14736, 14737, 14738,
    19209, 19211, 19219, 19223, 19236, 19242, 19250,
    24207, 24212, 24217, 24236, 24240,
    29278, 29286, 29301, 29328, 29338,
    34427, 34438, 34464, 34471],
  'Danish Women Pairs' => [
    14716,
    19120, 19124, 19125, 19130, 19133, 19134],
  'Delhi Gymkhana Club Open Pairs' => [
    26251],
  'Estonian Open Pair Trials' => [
    40645],
  'European Transnational Mixed Pairs' => [
    28786, 28787, 28788, 28789, 28790, 28791, 28792, 28793, 28794,
    28795, 28796, 28797, 28798, 28799, 28800, 28801, 28802, 28803,
    28804, 28805, 28806, 28807, 28808, 28809, 28810, 28811, 28812,
    28813, 28814, 28815, 28816, 28817, 28818, 28819, 28820, 28821,
    28822, 28824, 28825, 28826, 28827, 28828, 28829, 28830, 28831,
    28832, 28833, 28834, 28835, 28836, 28837, 28838, 28839, 28840,
    28841, 28842, 28843, 28844, 28845, 28846, 28847, 28848, 28849,
    28850, 28851, 28852, 28853, 28854, 28855, 28856, 28857, 28858,
    28859, 28860, 28862, 28863, 28864, 28865, 28866, 28867, 28868,
    28869, 28870, 28871, 28872, 28873, 28874, 28875, 28876, 28878,
    28879, 28880, 28881, 28882, 28883, 28884, 28885, 28886, 28887,
    39759, 39760, 39761, 39762, 39763, 39764, 39765, 39766, 39767,
    39768, 39769, 39770, 39771, 39772, 39773, 39774, 39775, 39776,
    39777, 39778, 39779, 39780, 39781, 39782, 39783, 39784, 39785,
    39786, 39787, 39788, 39789, 39790, 39791, 39792, 39793, 39794,
    39795, 39796, 39797, 39798, 39799, 39800, 39801, 39802, 39803,
    39804, 39805, 39806, 39807, 39808, 39809, 39810, 39811, 39812,
    39813, 39814, 39815, 39816, 39817, 39818, 39819, 39820, 39821,
    39822, 39823, 39824, 39825, 39826, 39827, 39828, 39829, 39830,
    39831, 39832, 39833, 39834, 39835, 39836, 39837, 39838],
  'European Transnational Open Pairs' => [
    10351, 10352, 10355, 10356, 10367, 10368, 10372, 10373,
    29084, 29085, 29086, 29087, 29088, 29089, 29090, 29091, 29092,
    29093, 29094, 29095, 29096, 29097, 29098, 29099, 29100, 29101,
    29102, 29103, 29104, 29105, 29106, 29107, 29108, 29109, 29110,
    29111, 29112, 29113, 29114, 29115, 29116, 29117, 29118, 29119,
    29120, 29121, 29122, 29123, 29127, 29128, 29129, 29130, 29131,
    29132, 29133, 29134, 29135, 29136, 29137, 29138, 29139, 29140,
    29141, 29142, 29143, 29144, 29145, 29146, 29148, 29149, 29150,
    29151, 29152, 29153, 29154, 29155, 29156, 29157, 29158, 29159,
    29160, 29161, 29162, 29163, 29164, 29165, 29166, 29167,
    39944, 39945, 39946, 39947, 39948, 39949, 39950, 39951, 39952,
    39953, 39954, 39955, 39956, 39957, 39958, 39959, 39960, 39961,
    39962, 39963, 39964, 39965, 39966, 39967, 39968, 39969, 39970,
    39971, 39972, 39973, 39975, 39976, 39977, 39978, 39979, 39980,
    39981, 39982, 39983, 39984, 39985, 39986, 39987, 39988, 39989,
    39990, 39991, 39992, 39993, 39994, 39995, 39996, 39997, 39998,
    39999, 40000, 40001, 40002, 40003, 40004, 40005, 40006, 40007,
    40008, 40009, 40010, 40011, 40012, 40013, 40014, 40015, 40016,
    40017, 40018, 40019, 40021, 40022, 40023, 40024, 40025, 40026,
    40027],
  'Finnish Open Pairs' => [
     1282,  1287,  1288,  1289,  1293,  1295,  1296,
     2900,  2901,  2902,  2903,  2904,  2905,  2906,  2907,  2908,
     2909,  2910,  2911,  2912,  2913,  2914,  2915,  2916,  2917,
     2918,  2919,
     4717,  4718,
    11737, 11746, 11750, 11768, 11781,
    15783, 15786,
    30627, 30646, 30657, 30670, 30683, 30687,
    35809, 35825, 35845, 35859, 35860,
    41675, 41688],
  'Finnish Swiss Pairs' => [
    22031, 22034, 22035, 22037, 22040, 22041, 22045, 22048, 22053,
    22055, 22056, 22059, 22060,
    26966, 26970, 26973, 26977, 26980, 26984, 26989, 26992, 26993,
    26999, 27003, 27004, 27006, 27009,
    32863,
    39104, 39106, 39107, 39108, 39109, 39110, 39112, 39114, 39115, 
    39116, 39125, 39128, 39129, 39135, 39136, 39142],
  'Full Tilt Irish Bridge Masters' => [
    29654, 29666, 29677 ],
  'German Open Pairs' => [
    11914, 11917, 11920, 11921, 11932, 11933,
    21016, 21039, 
    26012, 26020, 26027,
    31218, 31228, 31250],
  'German Women Pairs' => [26011, 26021, 26028],
  'Goksu-Yalikavak Pairs' => [
    10507, 10531],
  'Grand Prix of Poland Pairs' => [
     3077,  3078,
     3453,  3454,  3455,
     4979,  4980,  4981,  4982,
     9230,  9235,
    11229, 11232, 11233, 11234, 11237, 11239, 11242, 11243, 11245,
    11247,
    12222, 12223, 12236, 12240, 12253,
    15457, 15458, 15460, 15461, 15462, 15463,
    16307, 16309, 16312, 16317, 16324,
    20051, 20055, 20059, 20062, 20063,
    21520, 21521, 21523, 21531, 21534, 21541, 21543, 21544, 21552,
    21553,
    37029, 37032,
    38023, 38028],
  'Greek Central Regional Pairs' => [
    20136, 20162, 20176],
  'Greek Mixed Pairs' => [
    18103, 18134, 18148],
  'Greek Open Pair Trials' => [
    12439, 12440, 12441, 12447, 12463, 12464, 12465, 12468, 12470,
    12471, 12484, 12486, 12487, 12489, 12490, 12492, 12520, 12526,
    12527, 12528, 12529, 12530, 12542, 12543, 12547, 12548, 12550,
    12552, 12553, 12554, 12558, 12560, 12561, 12562, 12563, 12564,
    12565, 12567, 12581, 12584, 12586, 12587, 12588, 12590, 12593,
    12594, 12595, 12596, 12599, 12600],
  "Gro's Supercup" => [
    15059, 15070, 
    19725, 19732, 19745,
    24988, 24989,
    29535, 29536, 29540, 29541, 29548, 29549,
    34116, 34117, 34121, 34123, 34129, 34132, 34133,
    44699, 44700, 44702, 44704, 44709, 44710, 44723, 44724,
    44730, 44731, 44736, 44737, 44738, 44739, 44764, 44765, 44766],
  'Hungarian IMP Pairs' => [
     1113,  1117,  1126,
    12005, 12016],
  'Karlovo Open Pairs' => [
    9134],
  'Iceland Express Pairs' => [
    12516, 12517, 12518],
  'Icelandair Open Pairs' => [
     1725,  1727,  1729],
  'IMSA Elite Open Individual' => [
    43540, 43541, 43542],
  'IMSA Elite Open Pairs' => [
    43519, 43520, 43521, 43522, 43523],
  'IMSA Elite Women Individual' => [
    43532, 43533, 43535, 43536, 43544, 43546, 43547, 43548, 43549],
  'IMSA Elite Women Pairs' => [
    43508, 43511, 43513, 43514, 43516, 43527, 43528, 43531],
  'Indonesian Mixed Pair Trials' => [
    43761, 43762, 43763, 43764, 43765, 43766, 43767, 43768, 43772, 
    43773, 43774, 43775, 43776, 43778, 43798, 43799, 43800, 43801, 
    43802, 43803, 43836, 43837, 43839, 43840, 43841, 43842, 43870, 
    43871, 43873, 43875],
  'Indonesian Open Pair Trials' => [
    43671, 43672, 43673, 43674, 43675, 43676, 43678, 43679, 43680,
    43681, 43682, 43684, 43685, 43686, 43692, 43693, 43697, 43698,
    43707, 43708, 43710, 43712, 43713, 43714, 43718, 43720, 43739,
    43740, 43744, 43745, 43747, 43748, 43752, 43753],
  'Indonesian U16 Pair Trials' => [
    43896, 43898, 43905, 43907, 43909, 43910, 43912, 43913, 43928,
    43929, 43931, 43932, 43935, 43936, 43937, 43949, 43950, 43951,
    43952, 43953, 43954],
  'Indonesian U21 Pair Trials' => [
    42937, 42939, 42942, 42945, 42947, 42948, 42951, 42956, 42979,
    42980, 42983, 42985, 42986, 42989, 42990, 42993, 42999, 43023,
    43026, 43027, 43029, 43031, 43033, 43035, 43037, 43040, 43044,
    43046, 43048, 43049, 43053, 43054, 43057, 43060, 43062, 43064,
    43065, 43068, 43072, 43076, 43078, 43081],
  'Indonesian U26 Pair Trials' => [
    42938, 42940, 42941, 42944, 42946, 42950, 42953, 42955, 42978,
    42981, 42982, 42984, 42987, 42988, 42992, 42996, 42997, 43024,
    43025, 43028, 43030, 43032, 43034, 43036, 43038, 43039, 43043,
    43045, 43047, 43050, 43052, 43055, 43056, 43059, 43061, 43063,
    43066, 43067, 43073, 43075, 43080, 43084],
  'Indonesian U26 Women Pair Trials' => [
    42775, 42778, 42779, 42780, 42783, 42784, 42785, 42786, 42787,
    42788, 42790, 42791, 42793, 42795, 42797, 42798, 42812, 42813,
    42814, 42815, 42816, 42818, 42821, 42822, 42826, 42827, 42829,
    42830, 42831, 42832, 42835, 42837, 42841, 42843, 42852, 42855,
    42857, 42858, 42859, 42861, 42863, 42866, 42867, 42869, 42870,
    42873, 42874, 42877, 42878, 42883, 42885, 42888, 42889, 42893,
    42894, 42896, 42900, 42903, 42904, 42907, 42908, 42909, 42910,
    42911, 42912, 42913, 42914, 42915, 42916, 42917, 42918, 42919,
    42920, 42923, 42924, 42925, 42926, 42927, 42928, 42929, 42930],
  'Indonesian Women Pair Trials' => [
    43611, 43612, 43613, 43614, 43617, 43618, 43629, 43632, 43652,
    43653, 43655, 43656, 43657, 43658, 43661, 43662, 43663, 43664,
    43665, 43666, 43667, 43669],
  'Irish Invitational Pairs' => [
    44185, 44186,
    45160, 45161, 45164, 45166, 45168, 45171, 45172],
  'Israel IMP Pairs' => [ 
     3814,
     9383, 9385 ],
  'Israel Juniors Pairs' => [ 
     1781,  1783,  
    12273, 12274 ],
  'Israel School Trials' => [ 12406 ],
  'Italian Mixed Pairs' => [
    36287, 36289, 36293, 36295, 36296, 36308, 36309,
    41672, 41674, 41691, 41692, 41704, 41705],
  'Justice J M Lal All India Open Pairs' => [
    27505],
  'L C Sunil Rajendra Memorial' => [
    30177, 30181],
  'Maharaja Yeshwantrao Holkar National Pairs' => [
    12268, 12269, 12270,
    16299, 16304,
    21381, 21391,
    26606, 26607, 26614, 26616],
  'Maharashtra State Pairs' => [
    22116, 22117, 22118, 22119, 22122, 22129, 22130, 22131, 22133, 
    22135],
  'Mohan Sicka Pairs' => [
    32032, 32033],
  'Mohanlal Bhartia Memorial Pairs' => [
    16734, 16745],
  'Nordic Junior Pairs' => [
    13268, 13269, 13272, 13273, 13275, 13278, 13283, 13286,
    22642, 22646, 22650, 22654, 22658, 22662, 22664, 22668, 22673,
    44077, 44091, 44098, 44119, 44122],
  'Northern Territory Gold Swiss Pairs' => [
     1242,  1244,  1245,  1246,  1247,  1248],
  'Norwegian Mixed Pairs' => [
     6085,  6095,  6108,
     8013,
    10654, 10658, 10664,
    14888, 14889, 14895,
    19425, 19428, 19442,
    24646, 24654, 24661,
    29651, 29655, 29673,
    34704, 34707, 34716, 34721,
    45938, 45970, 45973],
  'Norwegian Open Pairs' => [
     6087,  6091,  6093,  6105,  6106,  6109,
     8010,  8020,  8027,  8028,  8031,
    10679, 10684, 10685, 10689, 10693,
    14904, 14907, 14916, 14920, 14925, 14928,
    19459, 19461, 19463, 19469, 19473, 19483, 19486,
    24672, 24673, 24676, 24677, 24678, 24679, 24680,
    29701, 29708, 29719, 29727, 29746, 29753,
    34833, 34834, 34836, 34837,
    35598, 35613, 35637, 35647, 35672,
    40946, 40956, 40962, 40971, 40977, 40990
    ],
  'Norwegian Swiss Pairs' => [
     6086,  6089,  6100,
     8012,  8016,  8017,
    10667, 10672, 10675,
    14896, 14898, 14899,
    19444, 19449, 19451,
    24668, 24670, 24671,
    29678, 29682, 29691
    ],
  'Norwegian Women Invitational Pairs' => [
    11749,
    15763,
    20881,
    25874, 25888,
    31002, 31013,
    36221, 36225,
    41679, 41686],
  'Olrud Easter Mixed Pairs' => [
     2210,  2212,  2215],
  'Olrud Easter Swiss Pairs' => [
     2204,  2205,  2207,  2213,
     9405,  9409,  9417,  9421,
    13239, 13248, 13249, 13252],
  'Polish Individual Championship' => [
    13235, 13236, 13237, 13242,
    16511, 16513, 16514, 16515, 16526, 16532, 16537],
  'Polish Junior Pairs Trials' => [
    22677, 22678, 22679, 22680, 22681],
  'Polish Open Pairs' => [
     4285,  4286],
  'PYC Hindu Gymkhana Royale' => [
    11718, 11719, 11720, 11721, 11722, 11723, 11725, 11726, 11727, 
    11733, 11734, 11736, 11738, 11740, 11743, 11745, 11758, 11761, 
    11762, 11763, 11766, 11767, 11774, 11775, 11777, 11780, 11783, 
    11788, 11790, 11792, 11796, 11798, 11801, 11803],
  'Rajasthan Invitational Pairs' => [
    27959,
    32569, 32582],
  'Riga Invitational Pairs' => [
    19565,
    25013,
    34854,
    46294],
  'R N Bagla Memorial Pairs' => [
    19678],
  'Rondane Pairs Cup' => [
    15526, 15532,
    20358, 20372,
    25662, 25674,
    30655,
    35795, 35816],
  'Russian IMSA Cup' => [
     2808, 2809,  2810,  2811,  2812,  2813,  2814,  2815,  2816,
     2817],
  'South American Open Pairs' => [
    23494, 23522, 23524, 23532, 23533,
    33722, 33723, 33724, 33725,
    38743, 38744, 38745,
    44966, 44967, 44968, 44969, 44973, 44974, 44976, 44977, 44978,
    44979],
  'Swedish Juniors Pairs' => [
    20033, 20046, 20054, 20060,
    25392, 25396, 25405, 25409,
    30165, 30173, 30178, 30180,
    35275, 35290, 35301, 35310],
  'Swedish Open Pair Trials' => [
    11729, 11735, 11742, 11744, 11748, 11751, 11753, 11764, 11772, 
    11778, 11784],
  'Swedish Open Pairs' => [
    14966,
    19519, 19529, 19530, 19538, 19544,
    24638, 24643, 24645, 24657, 24662,
    29650, 29652, 29656, 29672, 29674,
    34703, 34705, 34706, 34714, 34719,
    40235, 40236, 40237, 40240, 40242,
    46116, 46123, 46129, 46146,46148],
  'Swedish Women Pair Trials' => [
    22916, 22919, 22923, 22926, 22929, 22933, 22934, 22939, 22940],
  'Swiss Open IMP Pairs' => [
    39271, 39282,
    44262, 44279],
  'Trondheim Pairs Cup' => [
    17764, 17774],
  'Turkish Junior Pairs' => [
    21824, 21825],
  'Turkish Open Pair Trials' => [
    13277, 13280, 13289, 13295, 13299, 13300, 13302, 13303, 13305,
    13306, 13312,
    45624, 45627, 45629, 45632, 45640, 45644, 45647, 45651, 45654,
    45657, 45658, 45659],
  'Turkish U16 Pairs' => [
    45642, 45646],
  'Turkish Women Pair Trials' => [
    13292, 13304],
  'Victorian Women Trials' => [
    44237, 44241],
  'Vilnius BAM Pairs' => [
    15275, 15276, 15277, 15278, 15291, 15293, 15295, 15297, 15298],
  'Vilnius Club Pairs' => [
    17990, 17995, 18011],
  'Vilnius IMP Pairs' => [
    11340, 11341, 11342, 11344, 11345, 11346, 11347, 11403, 11406,
    11410, 11413, 11414, 11420, 11421, 11423, 11424,
    20193, 20194],
  'World Masters Individual' => [
      245,   246,   247,   248,
     6824,  6826,  6827,  6828],
  'World Mixed Pairs' => [
    35961, 35962, 35963, 35964, 35965, 35966, 35968, 35969, 35970,
    35971, 35972, 35973, 35975, 35976, 35977, 35978, 35979, 35980,
    35982, 35983, 35984, 35985, 35986, 35987, 35990, 35991, 35992,
    35993, 35994, 35995, 35998, 36000, 36001, 36002, 36003, 36004,
    36005, 36006, 36007, 36008, 36009, 36010, 36012, 36013, 36014,
    36015, 36016, 36017, 36018, 36019, 36021, 36024, 36026, 36027,
    36028, 36029, 36030, 36031],
  'World Open Girl Pairs' => [
    29684, 29694, 29699, 29702, 
    40507, 40508, 40509, 40510, 40512, 40513, 40514],
  'World Open Junior IMP Pairs' => [
    10838, 10839, 10859, 10861, 10865, 10867, 10876, 10878],
  'World Open Junior Pairs' => [
    10842,
    19755, 19756, 19757, 19758, 19759, 19760, 19761, 19762, 19764, 
    19765, 19766, 19767, 19768, 19770, 19771, 19772, 19773, 19774, 
    19775, 19776,
    29685, 29687, 29688, 29690, 29693, 29695, 29696, 29697, 29703, 
    29704, 29707, 29709,
    40460, 40461, 40462, 40464, 40466, 40468, 40474, 40475, 40477, 
    40478, 40480, 40481, 40485, 40486, 40487, 40489, 40493, 40495, 
    40496, 40497, 40500, 40501, 40502],
  'World Open Pairs' => [
     6172,  6173,  6174,  6175,  6176,
    15612, 15613, 15618, 15619, 15624, 15625, 15629, 15630,
    36154, 36155, 36156, 36157, 36158, 36159, 36160, 36161, 36162,
    36163, 36164, 36165, 36166, 36167, 36168, 36169, 36170, 36171,
    36172, 36173, 36174, 36175, 36176, 36177, 36178, 36179, 36180,
    36181, 36182, 36183, 36196, 36197, 36198, 36199, 36200, 36201,
    36202, 36203, 36204, 36205, 36206, 36207, 36208, 36209, 36210,
    36211, 36212, 36213, 36214, 36215, 36216, 36217, 36218, 36219],
  'World Top Tournament' => [
     6622,  6623,  6624,  6625,  6626,  6627,  6628,  6629,  6630,  
     6631,  6632,  6632,  6633,  6634,  6635,  6636,  6637,  6638,
     6639,  6640,  6641,  6642,  6643,  6644,  6645,  6646,  6647,
     6648,  6649,  6650,  6651,  6652,  6653,  6654,  6655,  6656,
     6657,  6658,  6659,  6660,  6661,  6662,  6663,  6664,  6665,
     6666,  6667,  6668,  6669,  6670,  6671,  6672,  6673,  6674,
     6675,  6676,  6677,  6678,  6679,  6680,  6681,  6682,  6683,
     6684,  6685,  6686,  6687,  6688,  6689,  6690,  6691,  6692,
     6693,  6694,  6695,  6696,  6697,  6698,  6699,  6700,  6701,
     6702,  6703,  6704,  6705,  6706,  6707,  6708,  6709,  6710,
     6711,  6712,  6713,  6714,  6715,  6716,  6717,  6718,  6719,
     6720,  6722,  6723,  6724,  6725,  6726,  6727,  6728,  6729,
     6730,  6731,  6732,  6733,  6734,  6735,  6736,  6737,  6738,
     6739,  6740,  6741,
     6856,  6857,  6858,  6859,  6860,  6861,  6862,  6863,  6864,
     6865,  6866,  6867,  6868,  6869,  6870,  6871,  6872,  6873,
     6874,  6875,  6876,  6877,  6878,  6879,  6880,  6881,  6882,
     6883,  6884,  6885,  6886,  6887,  6888,  6889,  6890,  6891,  
     6892,  6893,  6894,  6895,  6896,  6897,  6898,  6899,  6900,  
     6901,  6902,  6903,  6904,  6905,  6906,  6907,  6908,  6909,  
     6910,  6911,  6912,  6913,  6914,  6915,  6916,  6917,  6918,  
     6919,  6920,  6921,  6922,  6923,  6924,  6925,  6926,  6927,  
     6928,  6929,  6930,  6931,  6932,  6933,  6934,  6935,  6936,  
     6937,  6938,  6939,  6940,  6941,  6942,  6943,  6944,  6945,  
     6946,  6947,  6948,  6949,  6950,  6951,  6952,  6953,  6954,  
     6955,  6956,  6957,  6958,  6959,  6960,  6961,  6962,  6933,  
     6934,  6935,  6936,  6937,  6938,  6939,  6940,  6941,  6942,  
     6943,  6944,  6945,  6946,  6947,  6948,  6949,  6950,  6951,  
     6952,  6953,  6954,  6955,  6956,  6957,  6958,  6959,  6960,  
     6961,  6962,  6963,  6964,  6965,  6966,  6967,  6968,  6969,  
     6970,  6971,  6972,  6973,  6974,  6975,
     7437,  7438,  7439,  7440,  7441,  7442,  7443,  7444,  7445,
     7446,  7447,  7448,  7449,  7450,  7451,  7452,  7453,  7454,
     7455,  7456,  7457,  7458,  7459,  7460,  7461,  7462,  7463,
     7464,  7465,  7466,  7467,  7468,  7469,  7470,  7471,  7472,
     7473,  7474,  7475,  7476,  7477,  7478,  7479,  7480,  7481,
     7482,  7483,  7484,  7485,  7486,  7487,  7488,  7489,  7490,
     7491,  7492,  7493,  7494,  7495,  7496,  7497,  7498,  7499,
     7500,  7501,  7502,  7503,  7504,  7505,  7506,  7507,  7508,
     7509,  7510,  7511,  7512,  7513,  7514,  7515,  7516,  7517,
     7518,  7519,  7520,  7521,  7522,  7523,  7524,  7525,  7526,
     7527,  7528,  7529,  7530,  7530,  7531,  7532,  7533,  7534,  
     7535,  7536,  7537,  7538,  7539,  7540,  7541,  7542,  7543,  
     7544,  7545,  7546,  7547,  7548,  7549,  7550,  7551,  7552,  
     7553,  7554,  7555,  7556,
     7590,  7591,  7592,  7593,  7594,  7595,  7596,  7597,  7598,
     7599,  7600,  7601,  7602,  7602,  7603,  7604,  7605,  7606,
     7607,  7608,  7609,  7610,  7611,  7612,  7613,  7614,  7615,
     7616,  7617,  7618,  7619,
     7703,  7704,  7705,  7706,  7707,  7708,  7709,  7710,  7711,
     7712,  7713,  7714,  7715,  7716,  7717,  7718,  7719,  7720,
     7721,  7722,  7723,  7724,  7725,  7726,  7727,  7728,  7729,
     7730,  7731,  7732,  7733,  7734,  7735,  7736,  7737,  7738,
     7739,  7740,  7741,  7742,  7743,  7744,  7745,  7746,  7747,
     7748,  7749,  7750,  7751,  7752,  7753,  7754,  7755,  7756,
     7757,  7758,  7759,  7760,  7761,  7762,  7763,  7764,  7765,
     7766,  7767,  7768,  7769,  7770,  7771,  7772,  7773,  7774,
     7775,  7776,  7777,  7778,  7779,  7780,  7781,  7782,  7783,
     7784,  7785,  7786,  7787,  7788,  7789,  7790,  7791,  7792,
     7793,  7794,  7795,  7796,  7797,  7798,  7799,  7800,  7801,
     7802,  7803,  7804,  7805,  7806,  7807,  7808,  7809,  7810,
     7811,  7812,  7813,  7814,  7814,  7815,  7816,  7816,  7817,
     7818,  7819,  7820,  7821,  7822],
  'World Open Youngster Pairs' => [
    29683, 29688, 29689, 29692, 29698, 29705, 29706],
  'WMG Men Individual' => [
    21500, 21501, 21504, 21505, 21514, 21515,
    26542, 26544, 26545, 26546, 26548, 26550, 26553, 26554],
  'WMG Men Pairs' => [
    26498, 26502, 26503, 26506, 26511, 26512, 26525, 26526, 26527,
    26528, 26529, 26530, 26531, 26532, 26533, 26534, 26535, 26536],
  'WMG Open Individual' => [
    26544, 26545, 26546,
    31630, 31631, 31633, 31634, 31635, 31636, 31637, 31638, 31639, 
    31640, 31641, 31642, 31643, 31644, 31645, 31646, 31647, 31648, 
    31649, 31650,
    36984, 36989, 36990, 36993, 36994, 36996, 36997, 37000, 37002],
  'WMG Open Pairs' => [
    21483, 21484, 21487, 21488, 21489, 21490, 21493, 21494,
    31588, 31592, 31593, 31597, 31598, 31614, 31621, 31624, 31626, 
    31627, 31628, 31629, 
    36929, 36930, 36931, 36944, 36947, 36949, 36961, 36963, 36965,
    36972, 36974],
  'WMG Women Individual' => [
    21502, 21503, 21506, 21507, 21512, 21513,
    26542, 26543, 26544, 26545, 26546, 26547, 26548, 26553, 26554, 
    26558, 26560, 26561, 26562, 26564,
    36986, 36988, 36992, 36995, 36998, 37001],
  'WMG Women Pairs' => [
    21481, 21482, 21485, 21486, 21491, 21492, 21495, 21496, 
    26494, 26495, 26496, 26497, 26498, 26500, 26506, 26526, 26527,
    31581, 31582, 31583, 31584, 31585, 31586, 31615, 31616, 31617,
    31618, 31619, 31620,
    36933, 36934, 36935, 36940, 36945, 36948, 36960, 36962, 36964,
    36973, 36976],
  'Zurich Open Pairs' => [
    32511, 32515, 32549, 32561],
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub read
{
  my ($self, $fh) = @_;

  %$self = ();

  my $line;
  return 0 unless defined($line = <$fh>);

  die "Not a BBONO: $line" unless $line =~ /^BBONO\s+(\d+)$/;
  $self->{BBONO} = $1;

  do
  {
    $line = <$fh>;
    chomp $line;
  }
  while ($line ne '');

  while (1)
  {
    $line = <$fh>;
    chomp $line;
    return 1 if $line eq '';

    if ($line !~ /^([A-Z0-9_]+)\s(.*)$/)
    {
      die "$self->{BBONO}: Malformed line $line";
    }

    my ($tag, $value) = ($1, $2);
    push @{$self->{$tag}}, $value;
  }

  return 1;
}


sub set
{
  my ($self, $fields) = @_;
  for my $tag (keys %$fields)
  {
    $self->{$tag} = $fields->{$tag};
  }
}


sub fix_some_fields
{
  my ($self) = @_;
  if (exists $self->{TITLE_ROF})
  {
    if (exists $self->{TITLE_STAGE})
    {
      warn "Confused";
      return;
    }
    for my $v (@{$self->{TITLE_ROF}})
    {
      push @{$self->{TITLE_STAGE}}, 'Rof' . $v;
    }
    delete $self->{TITLE_ROF};
  }

  if ($self->field('TITLE_TNAME') eq 'Reisinger BAM Teams')
  {
    if ($self->field('TITLE_ORDINAL'))
    {
      delete $self->{TITLE_ORDINAL};
    }
  }
}


sub prune_field_using
{
  my ($self, $field, $value, $header) = @_;

  return unless defined $self->{$field};
  my $len = $#{$self->{$field}};
  for my $i (0 .. $len)
  {
    if ($self->{$field}[$i] eq $value)
    {
      if ($len == 0)
      {
        delete $self->{$field};
      }
      else
      {
        splice(@{$self->{$field}}, $i, 1);
      }
      return;
    }
  }

  if ($field eq 'SCORING')
  {
    die "Multiple scoring values" unless $len == 0;
    my $read = $self->{$field}[0];
    if (($read eq 'I' && $value eq 'IMP') ||
        ($read eq 'P' && ($value eq 'MP' || $value eq 'Pairs')))
    {
      delete $self->{$field};
      return;
    }

    if ($read eq 'B' && $value eq 'BAM')
    {
      delete $self->{$field};
      return;
    }

    if (($read eq 'P' && $value eq 'IMP') ||
        ($read eq 'I' && $value eq 'MP'))
    {
      if (exists $header->{TOURNAMENT_NAME})
      {
        my $tname = $header->{TOURNAMENT_NAME};
        if (exists $SCORING_CORRECTIONS{$tname})
        {
          for my $ok (@{$SCORING_CORRECTIONS{$tname}})
          {
            if ($ok eq $self->{BBONO})
            {
              # Value is deemed correct.
              delete $self->{$field};
              return;
            }
          }
        }
      }

      warn "$self->{BBONO}, $header->{TOURNAMENT_NAME}: Scoring";
      return;
    }
  }
  elsif ($field eq 'TEAM1_FORM' || $field eq 'TEAM2_FORM')
  {
    die "Multiple form values" unless $len == 0;
    my $read = $self->{$field}[0];
    if (($read eq 'Teams' || $read eq 'Pairs') && 
        ($value eq 'Pairs' || $value eq 'Individual'))
    {
      if (exists $header->{TOURNAMENT_NAME})
      {
        my $tname = $header->{TOURNAMENT_NAME};
        if (exists $FORM_CORRECTIONS{$tname})
        {
          for my $ok (@{$FORM_CORRECTIONS{$tname}})
          {
            if ($ok eq $self->{BBONO})
            {
              # Value is deemed correct.
              delete $self->{$field};
              return;
            }
          }
        }
      }

      warn "$self->{BBONO}, $header->{TOURNAMENT_NAME}, $field: " .
        "Form $read, $value";
      return;
    }
  }
  elsif ($field eq 'TITLE_ORDINAL')
  {
    die "Multiple ordinal values" unless $len == 0;
    my $read = $self->{$field}[0];
    if ($value !~ /^(\d+)([a-z]+)$/)
    {
      die "Strange ordinal: $value";
    }

    my ($number, $ending) = ($1, $2);

    if ($read ne $number)
    {
      die "Ordinal $read is not $number";
    }

    if ($ending ne 'st' && $ending ne 'nd' &&
        $ending ne 'rd' && $ending ne 'th')
    {
      die "Ordinal ending: $value";
    }

    delete $self->{$field};
    return;
  }
  elsif ($field eq 'TITLE_STAGE')
  {
    die "Multiple ordinal values" unless $len == 0;
    my $read = $self->{$field}[0];

    if ($read eq 'Final' || $read eq 'Playoff')
    {
      delete $self->{$field};
      return;
    }
  }


  warn "$self->{BBONO}, pruning field $field, value $value, but have " .
    join '|', @{$self->{$field}};
}


sub match_letter_to_number
{
  my ($self) = @_;

  for my $field (qw(TITLE_MATCH EVENT_MATCH))
  {
    next unless defined $self->{$field};
    my $len = $#{$self->{$field}};
    next unless $len == 0;

    my $value = uc($self->{$field}[0]);
    if ($value =~ /^[A-E]$/)
    {
      $self->{$field}[0] = ord($value) - ord('A') + 1;
    }
  }
}


sub prune_using
{
  my ($self, $header, $chapter) = @_;

  for my $pair (@PRUNE_HEADER_FIELDS)
  {
    $self->prune_field_using($pair->[1], $header->{$pair->[0]}, $header) if
      exists $header->{$pair->[0]};
  }

  for my $pair (@PRUNE_CHAPTER_FIELDS)
  {
    $self->prune_field_using($pair->[1], $chapter->{$pair->[0]}, $header) if
      exists $chapter->{$pair->[0]};
  }

  $self->match_letter_to_number();

  # This is not so clean -- modifying a method argument.
  if (exists $header->{YEAR} && exists $chapter->{YEAR})
  {
    die "Different years: $header->{YEAR} vs $chapter->{YEAR}" 
      unless $header->{YEAR} eq $chapter->{YEAR};
    delete $chapter->{YEAR};
  }

  # This is not so clean -- modifying a method argument.
  $header->transfer_list_tag_from($self, 'TITLE_ORDINAL', 'ORDINAL');
  $header->transfer_list_tag_from($self, 'TITLE_COUNTRY', 'COUNTRY');
  $header->transfer_list_tag_from($self, 'TITLE_LOCALITY', 'LOCALITY');


  # TODO TWORD?
}


sub find_tname_index
{
  # Not a class method.
  # For a given DATE_START.
  my ($data, $date_start, $tname, $index) = @_;
  return 0 unless exists $data->{$date_start};

  for my $i (0 .. $#{$data->{$date_start}})
  {
    if ($data->{$date_start}[$i]{HEADER}{TOURNAMENT_NAME} eq $tname)
    {
      $$index = $i;
      return 1;
    }
  }
  return 0;
}


sub check_tname
{
  my ($self, $datum, $tname, $edition, $header_entry) = @_;

  if ($datum->{TOURNAMENT_NAME} ne $tname)
  {
    warn "$self->{BBONO}: $datum->{TNAME} vs $tname";
  }

  for my $key (keys %$header_entry)
  {
    if (exists $datum->{$key} && $datum->{$key} ne $header_entry->{$key})
    {
      warn "$self->{BBONO}, $key: $datum->{$key} vs $header_entry->{$key}";
    }
  }
}


sub check_chapter
{
  my ($self, $dchapter, $chapter_entry) = @_;

  for my $key (keys %$chapter_entry)
  {
    if (exists $chapter_entry->{$key} && exists $dchapter->{$key})
    {
      if ($chapter_entry->{$key} ne $dchapter->{$key})
      {
        warn "$self->{BBONO}, $key: $chapter_entry->{$key} vs " .
          "$dchapter->{$key}";
      }
    }
  }
}


sub update_tournaments
{
  my ($self, $data, $tname, $edition, $chapter,
    $header_entry, $chapter_entry) = @_;

  my $tindex;
  if (find_tname_index($data, $chapter_entry->{DATE_START},
    $tname, \$tindex))
  {
    my $dhdr = $data->{$chapter_entry->{DATE_START}}[$tindex]{HEADER};
    $self->check_tname($dhdr, $tname, $edition, $header_entry);
  }
  else
  {
    $tindex = 1 + $#{$data->{$chapter_entry->{DATE_START}}};
  }

  $data->{$chapter_entry->{DATE_START}}[$tindex]{HEADER} //= EntryT->new();
  my $datum = $data->{$chapter_entry->{DATE_START}}[$tindex];
  $datum->{HEADER}->set($header_entry);

  if (exists $datum->{CHAPTER}{$chapter})
  {
    my $dchapter = $datum->{CHAPTER}{$chapter};
    $self->check_chapter($dchapter, $chapter_entry);
  }

  $datum->{CHAPTER}{$chapter}{HEADER} //= EntryT->new();
  my $dchapter = $datum->{CHAPTER}{$chapter};
  $dchapter->{HEADER}->set($chapter_entry);

  my $dindex = 1 + $#{$dchapter->{LIST}};
  $dchapter->{LIST}[$dindex] = EntryT->new();
  $dchapter->{LIST}[$dindex]->set($self);
}


sub delete_list_tag_if
{
  my ($self, $tag, $value) = @_;

  return unless exists $self->{$tag};
  for my $n (reverse 0 .. $#{$self->{$tag}})
  {
    if ($self->{$tag}[$n] eq $value)
    {
      splice(@{$self->{$tag}}, $n, 1);
    }
  }

  if ($#{$self->{$tag}} == -1)
  {
    delete $self->{TITLE_TWORD};
  }
}


sub tag_list_contains
{
  my ($self, $tag, $value) = @_;

  for my $v (@{$self->{$tag}})
  {
    return 1 if ($v eq $value);
  }
  return 0;
}


sub transfer_list_tag
{
  my ($self, $tag_from, $tag_to) = @_;

  return unless exists $self->{$tag_from};

  if (! exists $self->{$tag_to})
  {
    @{$self->{$tag_to}} = @{$self->{$tag_from}};
    delete $self->{$tag_from};
    return;
  }

  for my $value (@{$self->{$tag_from}})
  {
    if (! $self->tag_list_contains($tag_to, $value))
    {
      push @{$self->{$tag_to}}, $value;
    }
  }
  delete $self->{$tag_from};
}


sub transfer_list_tag_from
{
  my ($self, $from, $tag_from, $tag_to) = @_;

  return unless exists $from->{$tag_from};
  if ($#{$from->{$tag_from}} != 0)
  {
    die "Need exactly one $tag_from";
  }

  my $value_from = $from->field($tag_from);

  if (exists $self->{$tag_to})
  {
    if ($self->field($tag_to) ne $value_from)
    {
      die "Attempting to rewrite $tag_to";
    }
  }
  else
  {
    $self->{$tag_to} = $value_from;
  }

  delete $from->{$tag_from};
}


sub fix_list_tags
{
  my ($self) = @_;

  $self->delete_list_tag_if('TITLE_TWORD', 'Championship');

  $self->transfer_list_tag('DATE_ADDED', 'DATE');
  $self->transfer_list_tag('EVENT_DATE', 'DATE');

  $self->transfer_list_tag('TITLE_SESSION', 'SESSION');
  $self->transfer_list_tag('EVENT_SESSION', 'SESSION');

  $self->transfer_list_tag('EVENT_SECTION', 'SECTION');

  $self->transfer_list_tag('TITLE_SEGMENT', 'SEGMENT');
  $self->transfer_list_tag('EVENT_SEGMENT', 'SEGMENT');

  $self->transfer_list_tag('TITLE_STANZA', 'STANZA');
  $self->transfer_list_tag('EVENT_STANZA', 'STANZA');

  $self->transfer_list_tag('TITLE_SET', 'SET');
  $self->transfer_list_tag('EVENT_SET', 'SET');

  $self->transfer_list_tag('EVENT_AGE', 'AGE');

  $self->transfer_list_tag('EVENT_GENDER', 'GENDER');

  $self->transfer_list_tag('EVENT_HALF', 'HALF');

  $self->transfer_list_tag('TITLE_ROUND', 'ROUND');
  $self->transfer_list_tag('EVENT_ROUND', 'ROUND');

  $self->transfer_list_tag('TITLE_MATCH', 'MATCH');
  $self->transfer_list_tag('EVENT_MATCH', 'MATCH');

  $self->transfer_list_tag('TITLE_QUARTER', 'QUARTER');
  $self->transfer_list_tag('EVENT_QUARTER', 'QUARTER');

  $self->transfer_list_tag('EVENT_MATCH', 'MATCH');

  $self->transfer_list_tag('TITLE_YEAR', 'YEAR');

  $self->transfer_list_tag('TITLE_PHASE', 'PHASE');

  $self->transfer_list_tag('TITLE_TABLE', 'TABLE');
}


sub fix_counters
{
  my ($self, $field_map, $of_map) = @_;

  for my $field (keys %$field_map)
  {
    next unless exists $self->{$field};

    if ($field_map->{$field} ne $field)
    {
      if ($field_map->{$field} eq 'TO_DELETE')
      {
        delete $self->{$field};
      }
      else
      {
        $self->transfer_list_tag($field, $field_map->{$field});
      }
    }
  }

  # Now fix OF.
  for my $orig_field (keys %$of_map)
  {
    next if $of_map->{$orig_field} == 0;
    next unless exists $field_map->{$orig_field};
    my $mapped = $field_map->{$orig_field};
    next if $mapped eq 'TO_DELETE';
    next unless exists $self->{$mapped};

    # So we still have the ones mapped to themselves here.
    for my $i (0 .. $#{$self->{$mapped}})
    {
      my $value = $self->{$mapped}[$i];
      if ($value =~ /^(\d+)$/)
      {
        $self->{$mapped}[$i] .= " of " . $of_map->{$orig_field};
      }
    }
  }
}


sub spaceship
{
  my ($self, $other, $priorities) = @_;

  # This is a sorting operator.
  for my $field (@$priorities)
  {
    if (exists $self->{$field})
    {
      if (! exists $other->{$field})
      {
        # Empty is ranked before full.
        return 1;
      }
      else
      {
        if ($#{$self->{$field}} != 0)
        {
          die "Need a single value: $field, " . $self->str_as_read();
        }
        if ($#{$other->{$field}} != 0)
        {
          die "Need a single value: $field, " . $other->str_as_read();
        }

        my $value_self = $self->{$field}[0];
        my $value_other = $other->{$field}[0];

        my $num_self;
        if ($value_self eq 'last')
        {
          $num_self = 9999;
        }
        elsif ($value_self =~ /^(\d+)/)
        {
          $num_self = $1;
        }
        else
        {
          die "No leading number: $value_self";
        }

        my $num_other;
        if ($value_other eq 'last')
        {
          $num_other = 9999;
        }
        elsif ($value_other =~ /^(\d+)/)
        {
          $num_other = $1;
        }
        else
        {
          die "No leading number: $value_other";
        }
        
        return -1 if ($num_self < $num_other);
        return 1 if ($num_self > $num_other);
      }
    }
    elsif (exists $other->{$field})
    {
      # Empty is ranked before full.
      return -1;
    }
  }

  if (exists $self->{DATE} && exists $other->{DATE})
  {
    my $d0 = Time::Piece->strptime($self->{DATE}[0], "%Y-%m-%d");
    my $d1 = Time::Piece->strptime($other->{DATE}[0], "%Y-%m-%d");
    return -1 if ($d0 < $d1);
    return 1 if ($d1 < $d0);
  }

  return $self->{BBONO} <=> $other->{BBONO};
}


sub number
{
  my ($self, $field) = @_;

  if (exists $self->{$field})
  {
    return $self->{$field};
  }
  else
  {
    return '';
  }
}


sub field
{
  my ($self, $field) = @_;

  if (exists $self->{$field})
  {
# TODO For now.  What is there is more than one?
    return $self->{$field}[0];
  }
  else
  {
    return '';
  }
}


sub bbono
{
  my ($self) = @_;
  return $self->{BBONO};
}


sub str_fields
{
  my ($self, $key) = @_;

  my $s = '';
  for my $v (@{$self->{$key}})
  {
    $s .= "$key $v\n";
  }
  return $s;
}


sub str_as_read
{
  my ($self) = @_;

  my $s;
  $s = "BBONO $self->{BBONO}\n";

  for my $key (qw(YEAR DATE PHASE SECTION SESSION 
    ROUND MATCH SEGMENT HALF TABLE))
  {
    $s .= $self->str_fields($key) if exists $self->{$key};
  }

  for my $order (qw(TITLE_ DATE_ EVENT_ TEAM1_ TEAM2_))
  {
    for my $key (sort keys %$self)
    {
      if ($key =~ /^$order/)
      {
        $s .= $self->str_fields($key);
      }
    }
  }

  $s .= $self->str_fields('BOARDS') if exists $self->{BOARDS};
  $s .= $self->str_fields('SCORING') if exists $self->{SCORING};

  return "$s\n";
}


sub str_by_ordered_fields
{
  my ($self, $fields, $check_fields) = @_;

  my $s = '';

  for my $key (@$fields)
  {
    # This form of an entry only has one value per key.
    $s .= "$key $self->{$key}\n" if exists $self->{$key};
  }

  for my $key (keys %$self)
  {
    next if $key =~ /[a-z]/; # E.g., 'major' and 'minor'
    warn "Unprinted field $key" unless exists $check_fields->{$key};
if (! exists $check_fields->{$key})
{
print "WARNING: Unprinted $key\n";
}
  }

  return "$s\n";
}


sub str_header
{
  my ($self) = @_;
  return $self->str_by_ordered_fields(\@HEADER_FIELDS,
    \%HEADER_HASH_CHECK);
}


sub str_chapter
{
  my ($self) = @_;
  return $self->str_by_ordered_fields(\@CHAPTER_FIELDS,
    \%CHAPTER_HASH_CHECK);
}


1;
