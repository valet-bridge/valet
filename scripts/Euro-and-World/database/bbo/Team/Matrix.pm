#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Matrix;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_matrix);

use lib '.';
use TeamBBO;


my %COUNTRY_TO_REGION =
(
  Australia => ['australian central territory', 'new south wales',
    'northern territory', 'queensland', 'south australia', 
    'tasmania', 'victoria', 'western australia'],
  Austria => ['oberloiben', 'wachau'],
  Belarus => ['druts'],
  China => ['anhui', 'fukien', 'gansu', 'guangdong', 'guangxi',
    'guizhou', 'hainan', 'haixing', 'hebei', 'hunan', 'jiangsu',
    'jilin', 'liaoning', 'pearl river', 'ren shou', 'shanxi', 
    'sichuan', 'tianya', 'tinglin', 'wujin', 'yongjia',
    'yunnan', 'zhejiang'],
  Denmark => ['bornholm', 'midtsjælland', 'sydvest'],
  France => ['corsica', 'new caledonia'],
  Iceland => ['eyjafjallajokull'],
  Hungary => ['hegyvidék'],
  India => ['bihar', 'ganges', 'goa', 'gujarat', 'jaipur', 'jharkhand',
    'karnataka', 'kerala', 'madhya pradesh', 'maharashtra', 'nagbagan', 
    'punjab', 'rajasthan', 'rajputana', 'tamil nadu', 'uttar pradesh', 
    'uttarakhand', 'west bengal'],
  Indonesia => ['bali', 'banten', 'bekasi regency', 'belitung',
    'bengkayang', 'bisma semarang', 'boeven digoel', 'bogor regency', 
    'bone bolango', 'bungo', 'central celebes', 'central java', 
    'central sulawesi', 'cianjur regency', 'east borneo', 'east jakarta', 
    'east java', 'east kalimantan', 'gabungan malaku', 'garut regency', 
    'gorontalo', 'java bali', 'kawanua', 'kayong',
    'kedungwaru', 'kepri', 'kepulauan riau', 'kutai kartanegara', 
    'lampung', 'lebak', 'lombok', 'lumajang', 'malaku', 'minahasa',
    'north minahasa', 'north celebes', 'north sulawesi', 
    'nusa tenggara barat', 'nusantara', 'papua', 'porong', 'sintang',
    'south celebes', 'south east celebes', 'south jakarta',
    'south kalimantan', 'south sulawesi', 'south sumatra', 'tambun',
    'west borneo', 'west java', 'west kalimantan', 
    'west nusa tenggara', 'west sumatra'],
  Iraq => ['akkad'],
  Italy => ['liguria', 'val di magra'],
  Japan => ['kansai'],
  'New Zealand' => ['central districts', 'otago', 'southland', 'waikato'],
  Norway => ['agder', 'buskerud', 'haugaland', 'midt trøndelag', 
    'mjøsa', 'møre romsdal', 'nord-norge omegn', 'nordafjells', 
    'rogaland', 'rosfjord', 'salten', 'telemark', 'troms og ofoten', 
    'vest agder', 'vest finnmark', 'østfold follo'],
  Pakistan => ['sindh'],
  Poland => ['lower silesia', 'silesia', 'slask'],
  Portugal => ['madeira', 'norte ilhas'],
  Russia => ['siberia'],
  Scotland => ['ayrshire'],
  Serbia => ['vojvodina'],
  Singapore => ['tengah'],
  'South Africa' => ['central gauteng', 'eastern cape',
    'kwazulu natal', 'northern gauteng', 'western province'],
  'South Korea' => ['silla'],
  Spain => ['catalonia'],
  Sweden => ['norrland', 'norrorts', 'skåne', 'south sweden'],
  Taiwan => ['west district'],
  Thailand => ['krabi', 'nakhon nayok', 'ratchaburi', 'samut prakan', 
    'samut sakhon', 'suphan buri'],
  Tunisia => ['hammamet'],
  Turkey => ['aegean', 'akdeniz', 'cappadocia', 'central anatolia', 
    'datca yarimada', 'dersým', 'hatay', 'kinali', 'marmara', 'muallim', 
    'munzur', 'mysia', 'orontes', 'sakarya', 'taskopru', 'tigris', 
    'tuncelý'],
  USA => ['Bridge Winners', 'district of columbia', 'florida',
    'missouri', 'PRI Investment'],
  Zimbabwe => ['matopos']
);


my %COUNTRY_TO_CITY =
(
  Argentina => ['buenos aires', 'san luis'],
  Australia => [
    'adelaide', 'brisbane', 'cairns', 'canberra',
    'melbourne', 'perth', 'sydney'],
  Austria => ['mautern', 'vienna'],
  Belarus => ['minsk'],
  Belgium => ['antwerpen', 'bruges', 'brussels', 'gent', 'leuven',
    'ostend'],
  Brazil => ['assis', 'belo horizonte', 'brasilia', 'pelotas',
    'rio de janeiro', 'são paulo'],
  Bulgaria => ['asenovec', 'asenovgrad', 'balchik', 'dimitrovgrad', 
    'dobrich', 'kesten', 'kyustendil', 'la marina', 'pelotas', 'pernik', 
    'pleven', 'plovdiv', 'popovo', 'sofia', 'stara zagora', 'varna', 
    'vraca', 'yambol'],
  Chile => ['paimado', 'santiago', 'temuco'],
  China => [
    'beijing', 'changzhou', 'chengdu', 'chongqing', 'dalian', 'dongguan',
    'guangzhou', 'hangzhou', 'jiamusi', 'jianshe', 'jiangsu',
    'jinchang', 'jincheng', 'jinjiang', 'jiujiang', 'kunchan', 'lanzhou',
    'liushu', 'meilin qingcheng', 'nanchang', 'nanning', 'ningbo',
    'panzhihua', 'qingdao', 'sanya', 'shanghai', 'shaoguan', 'shenyang',
    'shenzhen', 'shijiazhuang', 'suzhou', 'taicang', 'taihu lake',
    'taizhou', 'tianjin', 'wuhan', 'wuxi', 'xin zhu', 'xinyi', 'yanshi', 
    'ye chi', 'zhaoqing', 'zhong jian', 'zhongshan', 'zhuzhou', 'zigong'],
  Colombia => ['bogotá', 'medellin'],
  'Costa Rica' => ['heledia'],
  Croatia => ['opatija', 'pula', 'rijeka', 'split', 'zagreb'],
  Cyprus => ['nicosia'],
  'Czech Republic' => ['nové město', 'prague'],
  Denmark => [
    'aabenraa', 'aalborg', 'ballerup', 'copenhagen', 'esbjerg',
    'greve strand', 'haderslev', 'herning', 'hillerød', 'hornbæk', 
    'kalundborg', 'morud', 'næstved', 'odense', 'ravnkilde', 'rødovre', 
    'slagelse', 'åkirkeby', 'århus'],
  Ecuador => ['guayaquil'],
  Egypt => ['al-rabwa', 'alexandria', 'cairo', 'el-maadi'],
  England => ['altrincham', 'bath', 'canterbury', 'coventry',
    'eastbourne', 'lincoln', 'london', 'manchester', 'oxford',
    'petersfield', 'worcester'],
  Estonia => ['derpt', 'otepää', 'pärnu', 'rakvere', 'sindi', 'tallinn'],
  Finland => ['helsinki', 'lappeenranta', 'kuopio', 'vasa'],
  France => [
    'aix en provence', 'annecy', 'antony', 'bergues', 'biarritz',
    'bordeaux', 'caen', 'chaville', 'clichy', 'courseulles-sur-mer', 
    'deauville', 'le bouscat', 'lille', 'lyon', 'massy', 'montpellier', 
    'nancy', 'paris', 'reims', 'toulouse', 'val de seine'],
  Germany => ['bamberg', 'berlin', 'bielefeld', 'bonn', 'bremen',
    'burghausen', 'darmstadt', 'düsseldorf', 'essen', 'frankfurt', 
    'hamburg', 'hannover', 'karlsruhe', 'ketsch', 'kiel', 'köln', 
    'leverkusen', 'mannheim', 'munich', 'nürnberg', 'oldenburg',
    'potsdam', 'saarbrücken', 'stuttgart'],
  Greece => ['athens', 'nea moudania', 'thessaloniki'],
  Hungary => ['balaton', 'balatonföldvár', 'budapest', 'gyor', 
    'nagykanizsa', 'pecs', 'szeged'],
  Iceland => ['reykjavik'],
  India => [
    'ahmedabad', 'allahabad', 'ambon', 'bangalore', 'bansi',
    'bhilwara', 'bhubaneshwar', 'bikaner', 'chennai', 'dombivli', 
    'hyderabad', 'kalyani', 'kanpur', 'kashi', 'kolkata', 'kota', 
    'madras', 'mitra vihar', 'mumbai', 'nagpur', 'nashik', 'pune', 
    'puri', 'sukma', 'udaipur'],
  Indonesia => [ 
    'airmadidi', 'balikpapan', 'banda aceh', 'bandar lampung', 'bandung',
    'banjarmasin', 'batam', 'batu', 'bekasi', 'bengkulu', 'bitung', 
    'blitar', 'bogor', 'boven digoel', 'cirebon', 'delhi', 'depok',
    'gresik', 'hatay', 'jakarta', 'jember', 'karimun', 'kedungwaru', 
    'klabat', 'kota bandung', 'kota bekasi', 'kota bogor', 
    'kota mataram', 'kudus', 'langkat', 'lhokseumawe', 'lumajang',
    'magetan', 'makassar', 'malang', 'manado', 'mandobo bodi', 
    'martapura', 'medan', 'moradabad', 'muara bungo', 'padang', 
    'palembang', 'palu', 'pariaman', 'pekanbaru', 'penajam', 
    'pontianak', 'samarinda', 'secunderabad', 'semarang', 
    'semburat jingga', 'serang', 'seulawah agam', 'siddha eden lakeville', 
    'sidoarjo', 'sleman', 'solok', 'sukomoro', 'surabaya', 
    'tanjung pinang', 'thane', 'thanjavur', 'tomohon', 'yogyakarta'],
  Iraq => ['baghdad'],
  Italy => [
    'bologna', 'catania', 'cuneo', 'firenze', 'genoa',
    'milan', 'monticiano', 'napoli', 'padova', 'palermo', 'pesaro',
    'pescara', 'pisa', 'reggio emilia', 'rimini', 'rome', 'salerno', 
    'san giorgio del sannio', 'siena', 'torino', 'trieste',
    'varese', 'villa fabbriche'],
  Japan => ['takayama', 'tokyo', 'yokohama'],
  Kazakhstan => ['aral'],
  Latvia => ['riga'],
  Lithuania => ['alytus', 'vilnius'],
  Malaysia => ['kuala lumpur'],
  Mexico => ['jalisco'],
  Monaco => ['monte carlo'],
  Morocco => ['casablanca', 'marrakech'],
  Netherlands => ['amsterdam', 'delft', 'leiden', 'maastricht', 
    'nijmegen', 'the hague', 'utrecht'],
  'New Zealand' => ['auckland', 'wellington'],
  'North Macedonia' => ['gevgelija', 'skopje'],
  Norway => [
    'arendal', 'bergen', 'bodø', 'brandbu', 'farsund', 'flekkefjord', 
    'gudbrandsdal', 'gjøvik og vardal', 'hamar',
    'huldretråkket', 'jessheim', 'kirkeby', 'kolbotn', 'kristiansand', 
    'kverndalen', 'kølabånn', 'namsos', 'narvik', 'nærbø', 'nøtterøy', 
    'ogndal', 'olrud', 'oslo', 'ottadalen', 'sandefjord', 'sarpsborg', 
    'singsås', 'skien', 'sortland', 'stavanger', 'steinkjer', 
    'sunndalsøra', 'sørreisa', 'trondheim', 'tromsø', 'vestfold', 
    'vestvågøy', 'vikersund', 'ørland'],
  Peru => ['ayacucho', 'lima'],
  Poland => ['chelmno', 'elblag', 'gdansk', 'gdynia', 'gniezno',
    'gorzow', 'kalisz', 'katowice', 'kielce', 'kornik', 'krakow', 
    'leszno', 'lodz', 'lowicz', 'lublin', 'olsztyn', 'poznan', 
    'rzeszow', 'silesia gliwice', 'skawina', 'tarnów', 'warsaw', 
    'wisla', 'wroclaw', 'wronie', 'zyrardow'],
  Portugal => ['cascais', 'estoril', 'lisbon', 'porto'],
  Romania => ['braila', 'brasov', 'bucharest', 'cluj', 'iasi',
    'piatra neamt', 'sibiu', 'targoviste', 'timisoara'],
  Russia => ['lokotok', 'saint petersburg'],
  Scotland => ['edinburgh', 'glasgow'],
  Serbia => ['belgrade', 'beograd', 'jagodina', 'niš', 'novi sad', 
    'pancevo', 'vrnjacka banja'],
  Singapore => ['singapore city'],
  Slovakia => ['kosice', 'michalovce'],
  Slovenia => ['ljubljana'],
  Spain => ['barcelona', 'begues', 'cuenca', 'madrid', 'marbella',
    'palma', 'sabadell'],
  'South Africa' => ['durban'],
  Sweden => [
    'bromölla', 'fredrikstad', 'gnesta', 'göteborg', 'harplinge', 
    'lerum', 'linköping', 'malmö', 'näsby', 'norrbyskär', 'norrøna', 
    'stockholm', 'storsjöbygden', 'stureby', 'skara', 'täby', 'täfteå', 
    'uppsala', 'varberg', 'västervik', 'överum'],
  Switzerland => ['la chaux-de-fonds', 'nyon', 'zürich'],
  Taiwan => ['changhua', 'chiayi', 'hsinchu', 'jiangyou', 'keelung', 
    'miaoli', 'taichung', 'tainan', 'taipei city', 'new taipei city'],
  Thailand => ['bangkok', 'chumphon', 'pattaya', 'rayong', 'udon thani'],
  Turkmenistan => ['bereket'],
  Turkey => ['adana', 'akhisar', 'ankara', 'antalya', 'aydin', 'ayvalik', 
    'balikesir', 'bodrum', 'burdur', 'bursa', 'cerkezkoy', 'cesme', 
    'corlu', 'datca', 'denizli', 'diyarbakir', 'edirne',
    'eskisehir', 'fethiye', 'foca', 'gaziantep zeugma', 'gelibolu',
    'geyve', 'gölcük', 'iskenderun', 'istanbul', 'izmir', 'kadirli', 
    'kastamonu', 'kayseri', 'kirklarelý', 'kirsehir', 'kocaeli', 
    'konak', 'konya', 'koycegiz', 'kusadasi', 'kütahya', 'luleburgaz', 
    'malatya', 'manisa', 'mersin', 'midyat', 'milas', 'muðla', 
    'nazilli', 'orhangazi', 'sakarya', 'samsun', 'seferihisar', 'söke', 
    'tekýrdag', 'tire', 'usak', 'van', 'yatagan', 'yedi eylul'],
  Ukraine => ['kiev'],
  USA => ['berkeley', 'chicago', 'evanston', 'ithaca', 
    'kansas city', 'new york city', 'philadelphia',
    'st louis', 'stanford'],
  Venezuela => ['caracas']
);


my %CITY_TO_QUARTER =
(
  Ankara => ['çayyolu', 'kardelen', 'sansar'],
  Antalya => ['muratpasa'],
  Aydin => ['bozdogan'],
  Baghdad => ['akkad'],
  Balchik => ['albena'],
  Beijing => ['shihua', 'yizhuang', 'yuquan'],
  Bekasi => ['tambun'],
  Bodrum => ['gundogan', 'yalikavak'],
  Brussels => ['uccle'],
  'Buenos Aires' => ['recoleta'],
  Bursa => ['yenisehir', 'yildirim'],
  Cairo => ['maadi'],
  'Courseulles-sur-Mer' => ['courseulles'],
  Denizli => ['akçeşme', 'pamukkale'],
  Eskisehir => ['viþnelik'],
  Frankfurt => ['freidorf'],
  Gevgelija => ['mrzenci'],
  Guangzhou => ['zhujiang'],
  Hamar => ['ridabu'],
  Hatay => ['karaçay'],
  Istanbul => ['atakoy', 'bahce', 'bahcesehir', 'bayrampaþa',
    'bogazici', 'bormali', 'esenkent', 'fatih', 'kadikoy', 'kartal',
    'kocamustafapasa', 'kucukcekmece', 'küp', 'pasham', 'polonezkoy',
    'suralaya', 'taskopru'],
  Izmir => ['balcova', 'bornova', 'buca', 'ege', 'karsiyaka',
    'konak', 'narlidere', 'sirinyer'],
  Jakarta => ['makaliwe', 'senayan'],
  Jalisco => ['perula'],
  Jember => ['arjasa'],
  Katowice => ['slaska'],
  Kayseri => ['pinarbasi'],
  Kocaeli => ['yarýmca'],
  Krakow => ['korwin'],
  Lappeenranta => ['lappee'],
  London => ['chelsea', 'chislehurst'],
  Lublin => ['sarniak'],
  Lyon => ['brotteaux'],
  Magetan => ['sukomoro'],
  Makassar => ['losari'],
  Manado => ['leilem', 'manahasa'],
  Medan => ['cemara', 'simal'],
  Mersin => ['meski'],
  Monticiano => ['piloni'],
  Mumbai => ['borivli'],
  Nancy => ['jarville'],
  'Nea Moudania' => ['moudania'],
  Nicosia => ['katok'],
  Niš => ['niski'],
  'Nové Město' => ['radkov'],
  Oslo => ['gardermoen'],
  Paris => ['palaiseau'],
  Pattaya => ['jomtien'],
  Pleven => ['kaylaka'],
  Poznan => ['wroble'],
  Pune => ['amanora'],
  Rome => ['olgiata', 'parioli'],
  Sabadell => ['sabadel'],
  Sanya => ['tianya'],
  'São Paulo' => ['unaós'],
  Semarang => ['poncol'],
  Shanghai => ['pudong', 'qiaoxie'],
  'Singapore City' => ['tengah'],
  Sofia => ['lozenets', 'serdika', 'sredec'],
  'Stara Zagora' => ['beroe'],
  Sumedang => ['wadas'],
  Tallinn => ['männiku'],
  Tekýrdag => ['suleymanpasa'],
  'The Hague' => ['buitenhof'],
  Tianjin => ['huochetou'],
  Thessaloniki => ['lemvourgeio' ],
  Tokyo => ['narita'],
  Toulouse => ['baragnon'],
  Trondheim => ['heimdal'],
  Varberg => ['varbergshus'],
  Varna => ['avren'],
  Warsaw => ['bieniewo', 'unia'],
  Wroclaw => ['wratislavia'],
  Wuxi => ['taihu'],
);


my %CITY_TO_UNIVERSITY =
(
  Airmadidi => ['Airmadidi Senior High School'],
  Ankara => ['Ankara University', 'Bilkent University',
    'Middle East Technical University'],
  Antalya => ['Akdeniz University', 'Antalya Halk Egitim'],
  Antwerp => ['Karel de Grote'],
  Bandung => ['Telkom University', 'Institut Teknologi Bandung'],
  Batu => ['batusida senior high school'],
  Beijing => ['Ren Da Fu Zhong', 'china central university of business'],
  Bengkulu => ['bengkulu senior high school'],
  Berkeley => ['University of California at Berkeley'],
  Bogor => ['bogor senior high school'],
  Budapest => ['Budapest University'],
  Changhua => ['Chien Kuo Senior High School'],
  'Chapel Hill' => ['University of North Carolina'],
  Chiayi => ['National Chung Cheng University'],
  Chicago => ['University of Chicago'],
  Depok => ['gunadarma university', 'gunadarma'],
  Edime => ['Trakya University'],
  Eskisehir => ['Anadolu University', 'Osmangazi University'],
  Evanston => ['Northwestern University'],
  Gdansk => ['University of Gdansk'],
  Gresik => ['Universitas Muhammadiyah Gresik'],
  Hamburg => ['UBC Hamburg'],
  Hsinchu => ['Chung Hua University',
    'National Chiao Tung University',
    'National Tsing Hua University'],
  Istanbul => ['ITÜ Vakfi', 'Koc University', 
    'Yildiz Technical University'],
  Ithaca => ['Cornell University'],
  Izmir => ['Ege University'],
  Jakarta => ['Gunadurma', 'ITS IKOMA', 'Kusuma Bangsa',
    'Nahdlatul Ulama Alumni', 'Sekolah Tinggi Ilmu Statistik',
    'Sekolah Tinggi Teknologi'],
  Jember => ['University of Jember', 'Jember Senior High School'],
  Jiangsu => ['Jiangsu Tianyi'],
  Kedungwaru => ['kedungwaru senior high school'],
  Keelung => ['National Taiwan Ocean University'],
  Kirsehir => ['Kirsehir Republic Primary School'],
  Kocaeli => ['Kocaeli University'],
  Konya => ['Selçuk University'],
  Krakow => ['AGH Krakow'],
  Langkat => ['Langkat Senior High School'],
  Leuven => ['KU Leuven'],
  Lumajang => ['lumajang senior high school'],
  Makassar => ['Makassar University'],
  Malang => ['Brawijaya University'],
  Manado => ['Manado State University', 'Sam Ratulangi University'],
  Medan => ['Universitas Sumatera Utara'],
  Mersin => ['Tarsus American College'],
  Miaoli => ['Miaoli Senior High School'],
  'New Taipei City' => ['Fu Jen Catholic University'],
  'New York City' => ['Columbia University'],
  Nijmegen => ['radboud university', 'radboud'],
  Padang => ['Andalas University', 'University of Bung Hatta'],
  Paris => ['Paris ECE'],
  Paris => ['École Polytechnique'],
  Palembang => ['Universitas Sriwijaya'],
  Pekanbaru => ['Riau University', 'Universitas Riau Bridge Club'],
  Pontianak => ['University of Tanjungpura'],
  Porto => ['University of Porto'],
  Potsdam => ['Universität Potsdam'],
  Rijeka => ['University of Rijeka'],
  Semarang => ['Diponegoro University'],
  Shenyang => ['Shenyang Ligong'],
  Stanford => ['Stanford University'],
  Sukomoro => ['sukomoro senior high school'],
  Surabaya => ['University of Airlangga', 'University of Surabaya',
    'Surabaya Senior High School'],
  Taichung => ['Chung Hwa Medical and Pharmaceutical University',
    'National Chung Hsing University'],
  'Taipei City' => ['National Chengchi University',
    'National Taiwan Normal University',
    'National Taiwan University',
    'Soochow University'],
  Targoviste => ['Valahia University'],
  Tyoyuan => ['Chang Gung University'],
  Umeå => ['Umeå University'],
  'Urbana-Champaign' => ['University of Illinois'],
  Waltham => ['Brandeis'],
  Warsaw => ['University of Warsaw', 'Warsaw University of Technology'],
  Wroclaw => ['University of Wroclaw',
    'Wroclaw University of Science and Technology'],
  Yogyakarta => ['Universitas Gadjah Mada'],
  Zagreb => ['Croatia University', 'Zagreb University'],
);


# TODO Are these all cities?

my %CITY_TO_CLUB =
(
  Aachen => ['Aachener'],
  Aalborg => ['BK Nord'],
  Adapazan => ['Ada Briç SK'],
  Amsterdam => ['Trifolium', 'Witte Huis'],
  Ankara => ['Ankara Kontrat', 'Ankara Sistematik', 'Baþkent Sekans BSK',
    'BH Koru BK', 'Jeofizik'],
  Antalya => ['Antalya BSK', 'Antalya Tabip Odasi'],
  Augsburg => ['Augsburg Augusta'],
  Aydin => ['Aydin 1923 BBSK'],
  Bamberg => ['Bamberger Reiter'],
  Bangkok => ['Bangkok Bridge Club', 'RBSC Polo Club'],
  Barcelona => ['BCN Almirall', 'Bridge House', 'Bridge Turó'],
  Batman => ['Batman Genclik'],
  Beijing => ['Beijing Baxi Football'],
  Beirut => ['Hamra Club'],
  Belgrade => ['Crvena Zvezda'],
  Beograd => ['btbk'],
  Bergen => ['Bergen Akademiske', 'Åsane'],
  Berlin => ['BC 52 Berlin'],
  Bhubaneshwar => ['Odisha Secretariat Recreation Club'],
  'Bielsko-Biala' => ['Bielski Klub Brydżowy GOK cards'],
  Brussels => ['Brussels Bridge Club'],
  Bucharest => ['ATU Bucharest', 'Romana'],
  Budapest => ['Bajnok Bridzs Egyesület'],
  Burdur => ['Bucak Bel.'],
  Bursa => ['BSB Kurek Ihtisas', 'Nilüfer Bld. BSK', 'Tofas',
    'Yildirimspor'],
  Bytom => ['BUKS Bytom'],
  Cairo => ['El Ahly', 'El-Karma', 'El Shams Club', 'Wadi Degla'],
  Cannareggio => ['Circolo del Bridge Cannareggio'],
  Cimahi => ['GB Cimahi'],
  'Czech-Pan' => ['jzd'],
  Copenhagen => ['One Eyed Jacks'],
  Corlu => ['corlu yildiz'],
  Darmstadt => ['Darmstadt Alert'],
  Debrecen => ['Debrecen DEAC'],
  Delhi => ['Delhi Gymkhana Club'],
  Denizli => ['Akceþme Spor'],
  Diyarbakir => ['Diyarbakýr Sur BSK', 'Dýcle Gençlýk'],
  Doha => ['Shemokh Club'],
  Drammen => ['Drammen Arbeiderparti'],
  Enschede => ['Drienerlo'],
  Erzurum => ['Cedýt Ilica Sports'],
  Eskisehir => ['Anadolu Bridge Club', 'Eskisehir Adalar', 
    'Eskisehir Baðlar', 'Eskisehir Sports'],
  Essen => ['Essen 86'],
  Lodi => ['Fanfulla'],
  Firenze => ['Circolo del Bridge Firenze'],
  Fjends => ['Fjends BK'],
  Frankfurt => ['Frankfurter TBC'],
  Førde => ['Førde BK'],
  Garches => ['BC Garches'],
  Geyve => ['Geyve Sports'],
  Giza => ['El Rabwa Club', 'Rabwa Club'],
  Göteborg => ['BK Everfresh', 'BK Lyx'],
  Groningen => ['BC de Zeerob', 'Hok Studiecentrum'],
  Hamar => ['Hamar BK'],
  Hamburg => ['Hanseatic Hamburg BC'],
  Harstad => ['Harstad S&B'],
  Havirov => ['Dorost Havirov'],
  Hedmark => ['Østerdal'],
  Hendek => ['Hendek Kazimiye'],
  Hyderabad => ['Deccan Club'],
  'Indonesia-Pan' => ['Balai Pelaksanaan Jalan Nasional',
    'Bridge Tunas Cahaya'],
  Isparta => ['Isparta Club'],
  Istanbul => ['Altinay SK', 'Atletik Basket', 'Bakýrköy Briç SK',
    'Besiktas', 'Camlica Sports', 'Fatih Karagumruk', 'Fenerbahce',
    'Galata', 'Galatasaray', 'Göktürk SK', 'Heybeliada SK', 'Hosgoru', 
    'Istanbul Sports', 'Karagümrük', 'Major Hosgoru', 'Majör Boğaziçi', 
    'Pamukspor', 'Slem Bric SK', 'Vefa SK'],
  Izmir => ['Altay Genclik', 'Bornova BSK', 'Buca Sports',
    'Goztepe Hilal SK', 'Sirinyer Sports'],
  Jakarta => ['Gabrial UI', 'Jakarta BBG', 'Laksamana', 'Pelatnas',
    'Siwo Persatuan Wartawan Indonesia'],
  Kaohsiung => ['Kao Hsiung Club'],
  Karlsruhe => ['Karlsruher BSC', 'karlsruher'],
  Kolkata => ['Hindusthan Club', 'Lalit Mohanka'],
  Kota => ['Kota Club'],
  Köln => ['Köln Lindenthal'],
  Krakow => ['Cracovia 1906'],
  'Kuala Lumpur' => ['Royal Selangor Club'],
  Kunshan => ['Kunshan Qiaoxie'],
  'La Spezia' => ['Spezia'],
  Lecco => ['Resegone LC'],
  Leksand => ['DBK Dalom'],
  Leverkusen => ['Nachteulen Leverkusen'],
  Lille => ['BC de Lille'],
  Lindesberg => ['Lindesbergs BS'],
  Linköping => ['Smedstadens BK'],
  Lisbon => ['Associação Viviane Gonçalves Pereira',
    'Benfica', 'Núcleo De Bridge Do Círculo'],
  Lom => ['Øvre Ottadalen'],
  London => ['TGR'],
  Lüleburgaz => ['LÜKSAD'],
  Makassar => ['Makassar Utama'],
  Malatya => ['Malatya Yildiz Dogu', 'Malatyagücü'],
  Manado => ['CFT Bridge', 'Sekolah Bridge Tonaas Wangko'],
  Manna => ['Manna Bridge Club'],
  Mannheim => ['Alert Mannheim', 'BC Universität Mannheim'],
  Marseille => ['Ocean BC'],
  Mersin => ['Mersin Club'],
  Milan => ['BC Milano', 'Milan CPK Milanowek'],
  Minahasa => ['Gereja Masehi Injili di Minahasa'],
  'Mo i Rana' => ['Mo'],
  Moscow => ['Avalanche BC'],
  Moss => ['Moss BK'],
  Mragowo => ['Mragowia'],
  Mumbai => ['Matunga', 'Otters Club', 'The West End Mumbai', 
    'WCG Mumbai'],
  Nancy => ['Nancy Jarville BC'],
  Naples => ['Circolo Nautico Posillipo'],
  Nice => ['Colonial BC'],
  Niš => ['nbk'],
  Norrorts => ['Norrorts Bridge'],
  'Novi Sad' => ['NS-1'],
  Nürnberg => ['Nürnberg Museum'],
  Odense => ['BK 1936'],
  Oltenita => ['Phoenix Oltenita'],
  Oslo => ['Hoppklubbene', 'OBK Kløverknekt', 'Solli', 'Top Bridge BC'],
  Örebro => ['Örebridgen'],
  Padang => ['Agriculture Bridge Club', 'Semen Padang'],
  Palermo => ['Circolo del Tennis Palermo'],
  Papua => ['Wampon Bodi Papua'],
  Parioli => ['Tennis Club Parioli'],
  Paris => ['Paris Sud'],
  Pekanbaru => ['Rumah Sakit Umum Daerah Pekanbaru'],
  Pescara => ['Pescara Bridge'],
  Vraca => ['Botev'],
  Pontianak => ['Fakultas Teknik Bridge Club Universitas Tanjungpura'],
  Porto => ['Dragao', 'Porto Club'],
  Poznan => ['RAL Poznan'],
  Prague => ['Acol Praha', 'Zmrzlina'],
  'Reggio Calabria' => ['Circolo del Bridge N. Ditto Reggio Calabria'],
  Rennes => ['BC Rennais'],
  Reykjavik => ['Grant Thornton', 'Vestri'],
  Rieneck => ['Kultcamp Rieneck'],
  Saarbrücken => ['BC Saarbrücken 1984'],
  Samsun => ['Amisos'], 
  'San Luis' => ['Salmun BC'],
  Sarpsborg => ['Østfold og Follo'],
  'Schwäbisch Hall' => ['BC Schwäbisch Hall'],
  Seferihisar => ['Seferihisar Municipality'],
  Shanghai => ['Qi Zhong Club', 'Qizhong'],
  Sharjah => ['Sharja Club'],
  Sichuan => ['Shou Chuang'],
  Sivas => ['Sivasspor'],
  Ski => ['Ski BK'],
  Slagelse => ['BK 83 Slagelse'],
  Sofia => ['Bonsist', 'Quantum BC'],
  Steinkjer => ['Nord Trøndelag'],
  Stockholm => ['BC Herkules', 'BK Lavec Smile', 'Lavec', 'St:Erik'],
  Suzhou => ['suzhou qiaoxie'],
  Søborg => ['Blakset Klubberne'],
  Tekýrdag => ['Cerkezkoy Dinamik BSK', 'Kapakli Sýte', 'Tekirdað Club'],
  'Tel Aviv' => ['ASA University of Tel Aviv'],
  Tonya => ['Tonyaspor'],
  Torino => ['Torino Allegra'],
  Toulouse => ['Bridge Académie'],
  Tours => ['Cercle Tourangeau'],
  Trondheim => ['Midt Trøndelag', 'Studentenes BK'],
  Umeå => ['BK Björken'],
  Uppsala => ['BK Fyris Skalman', 'Uppsalabridgen'],
  Utrecht => ['BC Star', 'Bridgeclub Oog', 'NDC Den Hommel'],
  Van => ['Van Bric'],
  Västerås => ['ABB BK', 'Västeråsbridgen', 'Top Bridge BC'],
  Vejle => ['Klør 10 Vejle'],
  Venice => ['Circolo del Bridge Venezia'],
  Vorden => ["'t Onstein"],
  Warsaw => ['Auguri Warsaw', 'Spojnia'],
  Wroclaw => ['Ruch AZS', 'Ruch SA'],
  Zagreb => ['Locomotiva'],
  Zürich => ['Zurich Enge'],
  Ålesund => ['BK Grand', 'Møre og Romsdal']
);

my %COUNTRY_TO_SPONSOR =
(
  Australia => ['Derofe', 'Penline'],
  Austria => ['Lupo Veloce'],
  Belarus => ['MB-Transit'],
  Brazil => ['Rio-Sampa'],
  Bulgaria => ['Chateau Rossenovo', 'Gillette', 'Impress', 'Malkia', 
    'Mech-Ok', 'Sevtopolis', 'Struma', 'Unicat', 'Velbazhd',
    'Velbujd', 'Vito'],
  China => ['Beibao', 'Beidike', 'Beijing Capital', 'Beijing Cartoon', 
    'Beijing Dazhong', 'Beijing Evertrust', 'Beijing Huayuan', 
    'Beijing Hull Technology', 'Beijing Jinghua', 'Beijing Lawyers', 
    'Beijing Liuhe', 'Beijing Longxin', 'Beijing Railway Bureau', 
    'Beijing ShouChuang', 'Beijing Trinergy', 'Beijing Wan Jia', 
    'Beijing Yue Ze', 'Beijing Yindi', 'Bnerg', 'Cai Fu Zheng Quan',
    'Changyu', 'China Evertrust', 'China Finance', 'China Global Times',
    'China National Petroleum Corporation', 'China Ping An',
    'China Renshou', 'China Resources', 'China Trinergy', 
    'Chinese Hailian', 'Chuanmei', 'Copia', 'Dalian Dichan', 'Datang', 
    'Dian Zi Cheng', 'Dianwang', 'Dongfeng', 'Dongfang Tairong', 
    'Evertrust', 'Fanhua Jituan', 'Geely Automobile', 'Gong Hang Jin Ying', 
    'Guangdong Huachu Chemicals', 'Guangzhou Hongmian',
    'Guangzhou Huachu Chemicals', 'Guangzhou Pearl River',
    'Guiyuang Bank', 'Haerbin Bingxue', 'Hai Long', 'Hainan Shichuang',
    'Hainan Window', 'Hangzhou Jinjiang', 'Heilongjiang Tea',
    'Heng Yuan Xiang', 'Hengsha Haijiu', 'Hengsha Ke Ji', 'HNA',
    'Hong Zhu', 'Hongyu', 'Huachu', 'Huangshi Qixing', 'Huayuan', 
    'Hubei Dongfeng', 'Hubei Yihua', 'Hunan Tou Zhan', 'Jetox',
    'Jiang You', 'Jiegao', 'Jilin Dingyuan', 'Jin Rong', 'Jin Jing', 
    'Jinfan', 'Jing Tie', 'Kuncheng Group', 'LCG', 'Lianbo', 
    'Lianzhong Shi Jie', 'Longjiangfu', 'Lu Cheng', 'Lu Ning Coal', 
    'Lv Hua', 'Mai Zi Fu Shi', 'Mei Kuang', 'Meilin Qing Cheng', 
    'Nanfang Dianwang', 'Nanguang Power', 'Nanning Yalun', 'Nanyuan', 
    'Nong Fa Hang', 'Nongken', 'Norco', 'Oly-Star', 'PD Real Estate', 
    'PD Times', 'PD Transnational', 'Pan China Construction', 'Pufa',
    'Qiaoyou', 'Qingnian Qiche', 'Red Cotton', 'Ruyi', 'SAIC VW',
    'San Yutian', 'Sanya Jiguan', 'Sanya Tianze', 'Shan Hai', 
    'Shanghai Automobile', 'Shanghai Financial', 'Shanghai Gaohe', 
    'Shanghai Jiahua', 'Shanghai Jinchang', 'Shanghai Ling Mu', 
    'Shanghai Municipal Engineering Group', 'Shanghai Qiche', 
    'Shanghai Qihao', 'Shanghai Qi Zhong', 'Shanghai Weiyu', 
    'Shanghai Zhongfu', 'Shanxi Luning', 'Shanxi Qinlian', 'Shen Jiu', 
    'Sheng Tao Sha', 'Sheng Yu Tian', 'Sheng Yuan', 
    'Shenzhen Electronic City', 'Shenzhen Lanpu', 'Shenzhen Nangang', 
    'Shenzhen Ping An', 'Shenzhen Qiayao', 'Shenzhen Topone Car', 
    'Shi He Dong Li', 'Shi You', 'Shichuang', 'Shiji Changda', 
    'Shouchuang', 'Sichuan Dahe', 'Sunchime Cartoon', 'Sunchime Fund', 
    'Sung Tao', 'Suzhou Youtong', 'SY Sheng Yutain', 'TianJin JS2',
    'Tielu Jixie', 'Tin Fok', 'Tsingtao', 'Wuhan Dongfang', 
    'Xiamen Xiashun', 'Xiao Ying', 'Yalu Group', 'Yibin China Resources', 
    'Yi Tong', 'Yuetao', 'Yufeng Electric', 'Yunnan Dikuang Resources', 
    'Yunnan Tongya', 'Zhaoeng', 'Zhe Da Wang Xin', 'Zhejiang Jingfan', 
    'Zhejiang Jinjian', 'Zhejiang Xinxiang', 'Zhenjiang Hanbang', 
    'Zhong Guo Ren Bao', 'Zhong Liang Y LW', 'Zhong Yuan', 'Zhonghai', 
    'Zhongshan Jiegao', 'Zhongtong Jiangsu', 'Zhu Jiang'],
  Croatia => ['Mireo', 'Termoavion'],
  Denmark => ['Nordfyns Finans', 'Team Audita', 'Team PharmaService'],
  England => ['Pharon', 'Red Bull'],
  Estonia => ['Baltic Express', 'Druva', 'Eksprompt', 'Kilogrupp',
    'Pealinn', 'Printerikeskus', 'Raam', 'Unibet', 'Viru Valge',
    'Z-Tech'],
  Finland => ['Näkösoppi', 'Nordic Security'],
  France => ['BridgePlus', 'Funbridge', 'Société Générale'],
  Germany => ['Allianz', 'Paulaner'],
  Greece => ['Tzilis'],
  Hungary => ['Elastron', 'GAMAX', 'Interface', 'Nimbusz', 'Visoft'],
  Iceland => ['101 Fasteignasala', 'Actavis'],
  India => ['Accenture', 'Andromeda Baroda', 'APRA Clothing', 'Bajaj', 
    'Bangur Cement', 'Baroda Bank', 'BridgeYes.com', 'Cable',
    'Central Secretariat', 'Chennai Online', 'Constellation',
    'Cosmos', 'Dhampur Sugar', 'Eden Realty Kolkata', 'eDOT Goa',
    'Enterprise', 'India Glycols', 'Indian Medical', 'Indian Oil',
    'Indian Railways', 'Interkala', 'Kaushik Hyderabad', 'KH Power',
    "Kini's Bangalore", "Kini's Goa", 'Kosmos Delhi', 'Manyavar', 
    'Mayur Renergy', 'NALCO', 'Navachaitanya', 'Navayuga', 'Nest Inn',
    'OCI Copper', 'Poddar Developers', 'Poddar Housing', 'Quik Tea',
    'Ryan Express', 'Ryka', 'SD Associates', 'SD Enterprises',
    'Shree Cement', 'Shree Radhey', 'Srenniw', 'SSDA', 'Taste of Goa',
    'Team Secure', 'Tekser', 'Tolani Shipping Ltd', 'Trambak Rubber',
    'Tricon Infotech', 'TVS Tread', 'Wellknit'],
  'Hong Kong' => ['AIA', 'Hong Kong Vico', 'Phoenix TV', 'Wellwise'],
  Iceland => ['Breki Jarðverk', 'Bridgefélag Reykjavíkur',
    'Bústólpi ehf', 'Eimskip', 'Enorma', 'ESSO',
    'Ferðaskrifstofa Vesturlands', 'Fisk Seafood', 'Garðar & Vélar',
    'Garðs Apotek', 'Gevalia', 'GSE', 'Haustak', 'HF Verðbréf', 
    'Hreint ehf', 'Iceland Express', 'Kvika',
    'Lögfræðiskrifstofa Islands', 'Lögfræðistofa Bjarna', 'Lyfjaver',
    'Málning hf', 'Morgunblaðið', 'Myndform', 'Ráðgjöf', 'Sagaplast',
    'Skeljungur', 'Skinney-Þinganes', 'Sölufélag Garðyrkjumanna',
    'Sparisjóður', 'Sparisjóður Keflavik', 'Sparisjóður Norðfjörður',
    'Sparisjóður Siglufjarðar', 'SR Group', 'VBS Fjárfestingarbanki hf.',
    'Vidbot ehf', 'Vinabær', 'Virnet', 'VÍS', 'Tryggingamiðstöðin',
    'Wise'],
  Indonesia => ['Abadi Adimulia', 'Adaro Energy', 'Aerospace', 
    'Agsar Paints', 'Aklindo', 'Asindo', 'Asindo Prima', 
    'Bank Indonesia', 'Bank Mandiri', 'Bank Negara Indonesia', 
    'Bank Tabungan Negara', 'Bengkalis PT', 'Cempaka', 'Dauna Winaza',
    'Djarum', 'Djarum Black', 'Electric Center', 'Elektrik P3B',
    'Elektrika', 'Geo Kideco', 'Geo Pertamina', 'Geo Timah', 'Geo Vale',
    'Geologi', 'Geologi Banpu', 'Geoportal Kutai Kartanegara', 'Harke',
    'Indoarsip', 'Intan', 'Inteligent', 'Indonesian Power',
    'Jasa Marga Jakarta', 'JHS', 'Kombi Tondano', 'Makus', 
    'Mandiri Minahasa', 'Mitra Buana', 'Mutiara Energy', 'OICO Maesa',
    'P2TEL', 'Palma Karya Mandiri', 'Penajam PU', 'Perbankan Jatim',
    'Pertagas', 'Pertamina', 'Petroconas', 'PU Bitung', 'PU Minsel',
    'PU Sulut', 'Perusahaan Listrik Negara', 'Pimara',
    'PLN Suluttenggo', 'PT Bayu Buana Gemilang', 'PT Bumi Siak Pusako',
    'Samadhan Academy', 'Sarunta Waya', 'Sehati',
    'Semangat Baru Makassar', 'Semen Gresik', 'Siwik Holiday Mragowo',
    'Siwik Intertrade', 'Swara Kita', 'Syabas Energy', 'Telkom',
    'Telkom Groovia', 'Telkom IndiSchool', 'Telkom Indonesia',
    'Telkom Jabar', 'Telkom Jakarta', 'Telkom Speedy', 'Telkom UseeTV',
    'Telkom@wifi.id', 'Timah', 'TJ Jabung Brt', 'Tridaya'],
  Italy => ['Argento', 'Bozzetto Azzurro', 'Carlo Bossi', 'Lavazza',
    'Rosa dei Venti', 'Spasso Food'],
  Japan => ['Akobono', 'Hana', 'IMAX', 'Shimuzu'],
  Latvia => ['Laima', 'Pexis', 'Rigainvites.lv'],
  Lithuania => ['Garsu Pasaulis'],
  Malaysia => ['Likom', 'UMW'],
  Netherlands => ['Aquatrans', 'Arboned', 'Continental',
    'Modalfa', 'Ravebo'],
  Norway => ['ABAX', 'Advisor Revisjon Norge', 'Astro A/S',
    'Bridge i Norge', 'Bridgemagasiner.no', 'konkurs.no', 'Nortemp',
    'Polarman Regnskap', 'Tannlege Kvaran', 'Viego Regnskap'],
  Pakistan => ['Candyland', 'Century Insurance', 'Data Steel',
    'Solox'],
  Poland => ['A-Media Sieradz', 'Abnegat', 'AJ Diament', 
    'Alfa-Compensa Gdynia', 'Apreo Logistic Poland', 'bridge24.pl',
    'Chemikartel', 'Chlodnia', 'COMAL', 'Computerland', 'CONNECTOR',
    'Construction Kielce', 'CONSUS', 'Consus Carbon', 'Consus Oil',
    'Darles Santerm', 'Dermika', 'Dobre Zegary', 'E-Service',
    'Effcontrol', 'Eko-Al', 'Elektrociepl', 'Elektromonta¯',
    'Euro Agro', 'Energetyk', 'Falck Medical', 'Forta', 'Gomad',
    'Honesta', 'Hotel Senator', 'Interbud Plock', 'Kadimex',
    'Kancelaria', 'Klika Murcki', 'KONKRET Chelmno', 'Konstanta',
    'Kurt-Royce', 'Lacznosc', 'Latteria TS Rzepin', 'Mega-Tech',
    'Nazwa', 'Niewiem', 'NOTUS', 'Petro', 'POLFA', 'Ponar Unia',
    'Praterm', 'Relpol', 'Radex', 'Samsung', 'SAPW Poland', 'Signity',
    'SPS Construction', 'Stalgast', 'Sygnity', 'Synergia Lublin',
    'TAM Dabrowa', 'Termika', 'Termochem', 'Topeko', 'Unia Leszno',
    'Unia Winkhaus', 'Unia Sygnitas', 'Vyceska', 'zagraj.pl', 'Zolza'],
  Romania => ['Logi Smart', 'Pharma Plus', 'Pro Consul', 
    'Samtronic Constanta'],
  Russia => ['Gazprom', 'Lukomorie', 'Staryi Master'],
  Serbia => ['Novi Kod'],
  Singapore => ['Tyco', 'YOU Singapore'],
  Slovenia => ['Triglav Osiguranje'],
  Sweden => ['artotec', 'Bokadirekt SE', 'Brink Plast',
    'BridgeBertheau.com', 'Frissan', 'Hotell Strand', 'Konga-Väster',
    'Lag os', 'Junibacken', 'Ronke Camping', 'San-Sac', 'Scania',
    'Scania Bridgekonsul', 'Scandic', 'Stiga', 'Synective',
    'Transearly'],
  Taiwan => ['Fatek', 'San Chen', 'Yeh Bros'],
  Thailand => ['See Fah/Thai', 'Thai Oil'],
  Turkey => ['Akaylar', 'Alfa Romeo', 'Aliaga Kyme', 'Altinay',
    'Ant Teknik', 'Arkas', 'Arma', 'Ayýntab', 'Balcova Termal', 'Baykar',
    'Caretta International', 'Cimentas', 'Dama Kupa', 'Denizgucu',
    'DISKI', 'Doga Naturale', 'Dostlar', 'Fora Lastik', 'Genkad',
    'Gözgöz', 'IBM', 'Inci Ayakkabi', 'Kare Dam', 'Magpa-Grup',
    'Maksoy-Deniz', 'Meditepe Tip', 'Ozyuva', 'Pusula',
    'Sanliurfa Tarim', 'Solakoglu', 'Son Dakika', 'Statu Denizcilik',
    'Vestel', 'Tundem']
);


sub set_matrix
{
  TeamBBO::set_link_matrix(\%COUNTRY_TO_REGION, 
    'TEAM_COUNTRY', 'TEAM_REGION');
  TeamBBO::set_link_matrix(\%COUNTRY_TO_CITY, 
    'TEAM_COUNTRY', 'TEAM_CITY');
  TeamBBO::set_link_matrix(\%CITY_TO_QUARTER, 
    'TEAM_CITY', 'TEAM_QUARTER');
  TeamBBO::set_link_matrix(\%CITY_TO_UNIVERSITY, 
    'TEAM_CITY', 'TEAM_UNIVERSITY');
  TeamBBO::set_link_matrix(\%CITY_TO_CLUB, 
    'TEAM_CITY', 'TEAM_CLUB');
  TeamBBO::set_link_matrix(\%COUNTRY_TO_SPONSOR, 
    'TEAM_COUNTRY', 'TEAM_SPONSOR');
}

1;
