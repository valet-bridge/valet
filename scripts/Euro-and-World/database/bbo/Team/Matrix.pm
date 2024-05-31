#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Matrix;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_team_city_to_country);

use lib '.';
use TeamBBO;

my %MULTI_CITY =
(
  Australia => [
    'adelaide', 'brisbane', 'cairns', 'canberra',
    'melbourne', 'perth', 'sydney'],
  Austria => ['Vienna'],
  Belarus => ['minsk'],
  Belgium => ['antwerpen', 'gent', 'leuven'],
  Brazil => ['assis', 'belo horizonte', 'brasilia', 'pelotas'],
  Bulgaria => ['asenovgrad', 'dimitrovgrad', 'dobrich', 'kesten',
    'kyustendil', 'la marina', 'pelotas', 'pernik', 'pleven', 
    'plovdiv', 'popovo', 'sofia', 'stara zagora', 'varna', 'vraca',
    'yambol'],
  Chile => ['paimado', 'santiago', 'temuco'],
  China => [
    'beijing', 'changzhou', 'chengdu', 'chongqing', 'dalian', 'dongguan',
    'guangzhou', 'hangzhou', 'jiamusi', 'jianshe', 'jiangyou',
    'jinchang', 'jincheng', 'jinjiang', 'jiujiang', 'kunchan', 'lanzhou',
    'liushu', 'meilin qingcheng', 'nanchang', 'nanning', 'ningbo',
    'panzhihua', 'qingdao', 'sanya', 'shanghai', 'shaoguan', 'shenyang',
    'shenzhen', 'shijiazhuang', 'suzhou', 'taicang', 'taizhou',
    'tianjin', 'wuhan', 'xin zhu', 'xinyi', 'yanshi', 'ye chi', 
    'zhaoqing', 'zhong jian', 'zhongshan', 'zhuzhou', 'zigong'],
  'Costa Rica' => ['heledia'],
  Croatia => ['pula', 'rijeka', 'split', 'zagreb'],
  'Czech Republic' => ['prague'],
  Denmark => [
    'aabenraa', 'aalborg', 'ballerup', 'copenhagen', 'esbjerg',
    'haderslev', 'herning', 'hillerød', 'hornbæk', 'kalundborg', 'morud',
    'næstved', 'odense', 'ravnkilde', 'rødovre', 'slagelse', 
    'åkirkeby', 'århus'],
  Ecuador => ['guayaquil'],
  Egypt => ['al-rabwa', 'alexandria', 'el-maadi'],
  England => ['altrincham', 'bath', 'canterbury', 'coventry',
    'eastbourne', 'lincoln', 'london', 'manchester', 'oxford',
    'petersfield', 'worcester'],
  Estonia => ['derpt', 'otepää', 'pärnu', 'rakvere', 'sindi', 'tallinn'],
  Finland => ['helsinki', 'kuopio', 'vasa'],
  France => [
    'aix en provence', 'annecy', 'antony', 'bergues', 'bordeaux', 
    'caen', 'chaville', 'clichy', 'le bouscat', 'lille', 'massy',
    'montpellier', 'paris', 'reims', 'toulouse',
    'val de seine'],
  Germany => ['bamberg', 'berlin', 'bielefeld', 'bonn', 'bremen',
    'burghausen', 'darmstadt', 'düsseldorf', 'essen', 'frankfurt', 
    'hamburg', 'hannover', 'karlsruhe', 'ketsch', 'kiel', 'köln', 
    'leverkusen', 'mannheim', 'munich', 'nürnberg', 'oldenburg',
    'potsdam',
    'saarbrücken', 'stuttgart'],
  Greece => ['athens', 'thessaloniki'],
  Hungary => ['budapest', 'gyor', 'nagykanizsa', 'pecs', 'szeged'],
  India => [
    'ahmedabad', 'allahabad', 'ambon', 'bangalore', 'bansi', 'bhilwara', 
    'bhubaneshwar', 'bikaner', 'chennai', 'dombivli', 'kalyani', 
    'kanpur', 'kashi', 'kolkata', 'mitra vihar', 'mumbai', 'nagpur', 
    'nashik', 'pune', 'puri', 'sukma', 'udaipur'],
  Indonesia => [ 
    'balikpapan', 'banda aceh', 'bandar lampung', 'bandung',
    'banjarmasin', 'batam', 'batu', 'bekasi', 'bengkulu', 'bitung', 
    'blitar', 'bogor', 'boven digoel', 'delhi', 'gresik', 'jakarta', 
    'jember', 'klabat', 'kota bandung', 'kota bekasi', 'kota bogor', 
    'kota mataram', 'kudus', 'langkat', 'lhokseumawe', 'makassar',
    'manado', 'mandobo bodi', 'martapura', 'medan', 'moradabad',
    'muara bungo', 'padang', 'palembang', 'palu', 'pariaman', 
    'pekanbaru', 'penajam', 'pontianak', 'samarinda', 'secunderabad',
    'semarang ' 'semburat jingga', 'serang', 'seulawah agam', 
    'siddha eden lakeville', 'sidoarjo', 'sleman', 'solok',
    'surabaya', 'tanjung pinang', 'thane', 'thanjavur', 'tomohon',
    'yogyakarta'],
  Italy => [
    'bologna', 'catania', 'cuneo', 'fabbriche', 'firenze', 'genoa',
    'lucignano', 'milan', 'napoli', 'padova', 'palermo', 'pesaro',
    'pescara', 'pisa', 'reggio emilia', 'rimini', 'rome', 
    'salerno', 'san giorgio del sannio', 'siena', 'torino', 'trieste',
    'varese'],
  Japan => ['narita', 'takayama', 'tokyo', 'yokohama'],
  Kazakhstan => ['aral'],
  Latvia => ['riga'],
  Lithuania => ['alytus', 'vilnius'],
  Malaysia => ['kuala lumpur'],
  Monaco => ['monte carlo'],
  Netherlands => ['amsterdam', 'delft', 'leiden', 'maastricht', 
    'nijmegen', 'the hague', 'utrecht'],
  'New Zealand' => ['auckland', 'wellington'],
  'North Macedonia' => ['skopje'],
  Norway => [
    'arendal', 'bergen', 'bodø', 'brandbu', 'farsund', 'flekkefjord', 
    'gudbrandsdal', 'gjøvik og vardal', 'Heimdal', 'huldretråkket', 
    'jessheim', 'kirkeby', 'kolbotn', 'kristiansand', 'kverndalen', 
    'kølabånn', 'namsos', 'narvik', 'nærbø', 'nøtterøy', 'ogndal', 
    'oslo', 'ottadalen', 'sandefjord', 'sarpsborg', 'singsås', 
    'skien', 'sortland', 'stavanger', 'steinkjer', 'sunndalsøra', 
    'sørreisa', 'trondheim', 'tromsø', 'vestfold', 'vestvågøy', 
    'vikersund', 'ørland'],
  Peru => ['ayacucho', 'lima'],
  Poland => ['chelmno', 'elblag', 'gdansk', 'gdynia', 'gorzow',
    'kalisz', 'katowice', 'kielce', 'kornik', 'krakow', 'leszno',
    'lodz', 'lowicz', 'olsztyn', 'poznan', 'rzeszow',
    'silesia gliwice', 'skawina', 'tarnów', 'warsaw', 'wisla',
    'wroclaw', 'zyrardow'],
  Portugal => ['cascais'],
  Romania => ['braila', 'brasov', 'bucharest', 'cluj', 'iasi',
    'piatra neamt', 'sibiu', 'targoviste', 'timisoara'],
  Russia => ['lokotok', 'saint petersburg'],
  Serbia => ['belgrade', 'beograd', 'jagodina', 'novi sad', 'pancevo',
    'vrnjacka banja'],
  Slovakia => ['kosice', 'michalovce'],
  Slovenia => ['ljubljana'],
  Spain => ['barcelona', 'begues', 'cuenca', 'madrid', 'marbella',
    'palma'],
  Sweden => [
    'bromölla', 'gnesta', 'harplinge', 'lerum',
    'malmö', 'näsby', 'norrbyskär', 'norrøna', 'storsjöbygden', 
    'stureby', 'skara', 'täby', 'täfteå', 'uppsala', 'västervik', 'överum'],
  Switzerland => ['la chaux-de-fonds', 'nyon'],
  Taiwan => ['tainan'],
  Thailand => ['bangkok', 'chumphon', 'pattaya', 'rayong', 'udon thani'],
  Turkmenistan => ['bereket'],
  Turkey => ['adana', 'akhisar', 'ankara', 'antalya', 'ayvalik', 
    'balikesir', 'bodrum', 'burdur', 'bursa', 'cerkezkoy', 'cesme', 
    'corlu', 'datca', 'denizli', 'diyarbakir', 'edirne',
    'eskisehir', 'fethiye', 'foca', 'gaziantep zeugma', 'geyve',
    'gölcük', 'iskenderun', 'istanbul', 'izmir', 'kadirli', 
    'kastamonu', 'kirklarelý', 'kocaeli', 'konak', 'koycegiz', 'kusadasi', 
    'kütahya', 'luleburgaz', 'malatya', 'manisa', 'mersin', 'midyat',
    'milas', 'muðla', 'nazilli', 'orhangazi', 'sakarya', 'samsun',
    'seferihisar', 'söke', 'tekýrdag', 'tire', 'usak', 'van', 
    'yatagan', 'yedi eylul'],
  Ukraine => ['kiev'],
  USA => ['amarillo', 'chicago', 'kansas city', 'st louis'],
  Venezuela => ['caracas']


);

my %MULTI_QUARTER =
(
  Argentina => ['recoleta'],
  Belgium => ['uccle'],
  Brazil => ['unaós'],
  Bulgaria => ['albena', 'avren', 'beroe', 'kaylaka', 'lozenets',
    'serdika', 'sredec'],
  'Czech Republic' => ['radkov'],
  China => ['pudong', 'qiaoxie', 'shihua', 'taihu', 'tianya',
    'yizhuang', 'yuquan', 'zhujiang'],
  Colombia => ['tequendama'],
  Cyprus => ['katok'],
  Egypt => ['maadi'],
  England => ['chelsea', 'chislehurst'],
  Estonia => ['männiku'],
  Finland => ['lappee'],
  France => ['baragnon', 'brotteaux', 'courseulles'],
  Germany => 'freidorf'],
  Greece => ['lemvourgeio', 'moudania'],
  India => ['amanora', 'borivli'],
  Indonesia => ['arjasa', 'cemara', 'leilem', 'losari', 'makaliwe',
    'manahasa', 'poncol', 'senayan', 'simal', 'sukomoro', 'tambun',
    'wadas'],
  Iraq => ['akkad'],
  Italy => ['olgiata', 'parioli', 'piloni'],
  Mexico => ['perula'],
  Netherlands => ['buitenhof'],
  'North Macedonia' => ['mrzenci'],
  Norway => ['ridabu'],
  Poland => ['bieniewo', 'korwin', 'sarniak', 'slaska', 'unia',
    'wratislavia', 'wroble'],
  Serbia => ['niski'],
  Singapore => ['tengah'],
  Spain => ['sabadel'],
  Sweden => ['varbergshus'],
  Thailand => ['jomtien'],
  Turkey => ['akçeşme', 'atakoy', 'bahce', 'bahcesehir', 'balcova',
    'bayrampaþa', 'bogazici', 'bormali', 'bornova', 'bozdogan', 'buca',
    'çayyolu', 'ege', 'esenkent', 'fatih', 'gundogan', 'kadikoy',
    'karaçay', 'kardelen', 'karsiyaka', 'kartal', 'kocamustafapasa', 
    'konak', 'kucukcekmece', 'küp', 'meski', 'muratpasa', 'narlidere',
    'pamukkale', 'pasham', 'pinarbasi', 'polonezkoy', 'sansar',
    'sirinyer', 'suleymanpasa', 'suralaya', 'taskopru', 'viþnelik',
    'yalikavak', 'yarimada', 'yarýmca', 'yenisehir', 'yildirim']

  
);

my %MULTI_REGION =
(
  Iceland => ['eyjafjallajokull'],
  India => ['nagbagan', 'rajasthan'],
  Indonesia => ['nusantara'],
  Poland => ['slask'],
  Sweden => ['norrorts']
);

my @SINGLE_WORDS = qw(
);


sub set_value_to_country
{
  my ($key) = @_;

  TeamBBO::set_country_hashes(\%MULTI_CITY, 'TEAM_CITY');
}

1;
