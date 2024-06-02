#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Other;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_other);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  'A.C.L.A.',
  'A.z.f.e.n.a',
  'A Takimi',
  'ABA Nuno Paz',
  'ABB Tomas',
  'Ai Bait',
  'Air Traffic Management',
  'Aka Maru',
  'Aklindo Musi 88',
  'Alizee',
  'Alunand Plus',
  'Andrea L.',
  "Archie's",
  "Asha's 4",
  'Asketické samice',
  'Aso Pika',
  'AV Maria',
  'Avesta',
  'Aylan Kurdý',
  'Azure Hooda',

  'Balkanski Minior',
  'Baltic Club',
  'Bandhav Samity',
  'Banteng Selatan',
  'Banteng Sitaro',
  'Bate Tot',
  'Batterfly with HK',
  'BBE Hungary',
  'Bes-Can',
  'Besli Major',
  'Beto BO',
  'Bez Nazwy',
  'Bimal Sicca',
  'BMW J',
  'Brans BS',
  'Bridgekam 17',
  'Bridgerama Milan',
  'Buyur Teyze',

  'Can Aren',
  'CC&FC',
  'Cemara Putra',
  "Chairman's Choice",
  'Czarna Papuga Plus',
  'Chicho Itsi',
  'Cliff Wake',
  'Coca Joja',
  "Colonel's Team",
  'City Bridge',
  'Contact 1',
  'Cookie Potter',
  "Crockford's Cup",
  'Curt-Lennart',
  'Czarna Owca',

  'D-MaTK',
  "D'Coup",
  'D POK',
  'Dalian ABC',
  'Dalian BA',
  'Dalian Hong',
  'Daqin Shihua',
  'Daqin Xinghan',
  'Daqin Xinghua',
  'Daqing Xinghan',
  'Deccan Chargers',
  'Deceptive AHM',
  'Delhi Diamonds',
  'Delhi Gym Aces',
  'DELTA 2',
  'Dersim38',
  'Deutsche Senioren',
  'Diren Noname',
  'DK Notus',
  'DK Nationalchampion',
  'DK-Tworzywa',
  'DKI Maesa',
  'domwaluty.pl',
  'Dong Ming',
  'Dong Qi 9',
  'Dr. Gittipatq',
  'DS 1',

  'e-bridge',
  'Ege & Besli Major',
  'El Gezira',
  'El Hazem',
  'El Play',
  'El Yamo',
  'Ella-Jamie',
  'EM-76',
  'England and Pharon',
  'Equator 1771',
  'Erdal Abi',
  'Erdal Tekin',
  'Esso-sveitin',
  'Etna Bridge',
  'Eviza Plambata',

  'Figo-Fago',
  'Fire Club',
  "Flint's Crew",
  'Former J',
  'Frankie Holidays',
  'Friends of Academy',
  'Friends of Lalit',
  'FT 79',

  'Garuda Sakti',
  'Gerganin Izvor',
  'Gobbi San Siro',
  'Gold Cup',
  'Goyancho Sayeba',
  'Grefstad and co',
  'Greswe Axon',

  'HKHZ Connection',
  'Hong Chou',
  'Hum Paanch',
  'Hummer & Kanari',
  'Hungarian Olympic',
  'HZ Connection',

  'Idea Bridge Torino',
  'IGB sports.com',
  'Institute of Chemical Technology',
  'Isen Mulang',

  'Jai Ganesh',
  'Jan Wellem',
  'Japan SARA',
  'Japan SAYN',
  'Jarum LA',
  'Jenny-Chang',
  'Jia Zhou Ai Qiao',
  'Jian Hua Club',
  'Jie Fang He Ji',
  'Jin Fu',
  'Jin Hui',
  'Jin Mei',
  'Jiu Jiu',
  'JT2',
  'Juras Ezi',

  'Kacho Fugetsu',
  'KaiCheng RL',
  'Ke Da',
  "Keni's Team",
  'Kent Romeos venner',
  "Kitty's",
  'KM 23',
  'KOC67',
  'Kong Chou',
  'Kozyrnye Oleni',
  'KM AT',

  'Las Flores',
  'Las Olas',
  'Las Overum',
  'Late S.S. Jain',
  'Lawrence Allstars',
  'Le Colonial',
  'Le Romain boys',
  'Leonardonun Robotu',
  'Lew Lodzki',
  'Limo Puzzi',
  'Logos GPS',
  'Los Feos',
  'Los Malos',
  'Los Salgado',
  'Los Tollos',
  'Loy Krathong',
  'Lucy-Ellena',
  'LV 2014',

  'MAJB Lommorna',
  'Mal - Phi',
  'Malatya Basket',
  'Manny Herrings',
  'Marki-Macki',
  'Massachusetts Association',
  'Meng Qing Xin',
  'Mike Lawrence Club',
  'Minas Trith',
  'Mo i Raneran',
  'Monte Carlos',
  'Multi Gen Indonesia',
  'Mumbai Indians',
  'MY-Bridge',
  'myvatnhotel.is',
  'Møllers Team',

  "'n Vidar & Andersen",
  'N.O.Seniori',
  'Nav Chaitanya',
  'Nazar Boncugu',
  'Nazionale Cantanti',
  'NBS Lind',
  'Novi Tim',
  'NT-iosa-gutta',

  'Ojasta Ahoon',
  'Old Sports Jarov',
  'Oni-Taka',
  'OPF Meets Nepal',
  'Oruva Eesti',
  'os.se',
  'Ööklubi Strand',

  'Paak Festival',
  "Pai's",
  "Pal's Four",
  'Park Bridge',
  'Poismenon Vaari',
  'POL-CH',
  "Pradeep's Four",
  "President's Team",
  "Priya's Four",
  'P.S.',
  'PS CZ',
  'Pu De',

  'Raag Brigeshwari',
  'Rajjan',
  'Ram Charan',
  'Red Sea Festival',
  'Rodos Suns',
  'Roheline Lammas',
  'RPB Leader',

  'Saevar Karl',
  'San Sac',
  'San3PDX',
  'Sang ae',
  'Sanghi Tivoli',
  'Sarunta Toar',
  'Saruntawaya Minahas',
  'S.B.F.',
  'Scottish President',
  'Seckin C',
  'Sengkol Lombok',
  'Sham Sharma',
  'Shegoestobadat8',
  'Si Fu Te',
  'Sing-Sunn',
  'Sir Bhalchandra',
  'slaveykov.bg',
  'Sliven Haiduci',
  'SM BTC',
  'So-Va',
  'South Zone',
  'SPG Club',
  'Spring Foursomes',
  'Stall Dieden',
  'Swami Samarth',
  'Såpjohansen & co',

  'Tasher Desh',
  'Team Bru',
  'Team Zang',
  'Team Lanka',
  'Team Z',
  'Teyzenin Yeri',
  'The Lombard',
  "The Naising's",
  'Til Valhall',
  'Tim Team',
  'Tinutuan Manado',
  'TRK - V',
  "Tor Ivar's",
  'Tupac Amaru',
  'Turk Kahvesi',
  'Tzoko-Mokko',

  'Ucurtma Avcisi',
  'UKS Olimpia',
  'Umisen Yamasen',
  'Umut Baris',
  'Unelmien Piina',

  'Valar Morghulis',
  'Villi Jr.',
  'Visoki Napon',

  'Wan Jian Club',
  'Wei De',

  'X.D.X.J',
  'XiBu VIP',
  'Xin Yuan',

  'Yitang QIAO',
  "Yttakjær`s",
  'Yura Taschit',

  'Zara Bridge',
  'Zen Ho',
  'Zia and Friends'
);

my %MULTI_TYPOS =
(
  'ABA Nuno Paz' => ['ABA - Nuno Paz', 'ABA-Nuno Paz'],
  'Air Traffic Management' => ['air traffic managem'],
  'Aklindo Musi 88' => ['musi 88', 'musi88'],
  'Alex is Beautiful' => ['alex is beatiful'],
  'All Stars' => ['all-stars'],
  'Alle presidentens menn' => ['alle presidentens'],
  'Applied Math' => ['aplied math'],
  Arnab => ["arnab's"],
  Azores => ['açores team'],
  Ayan => ["ayan's"],

  Baneet => ["Baneet's IV"],
  Begijntje => ['begijnt je'],
  'Beto BO' => ['beto b o'],
  BNMR => ['b n m r'],
  'Bridgerama Milan' => ['bridgerama mi'],
  'Butterfly from HK' => ['babochka s hk'],

  "Chairman's Choice" => ["chairman's team", "chairman's"],
  'Chicho Itsi' => ['chicho ici'],
  "Colonel's Team" => ["colonel's  team"],

  Crossfatek => ['cross fatek'],

  'Deceptive AHM' => ['deceptive  ahm'],
  'Delhi Gym Aces' => ['d g aces', 'dgc aces'],
  DSM => ['d s m'],

  'El Gezira' => ['el-gezira'],
  'England and Pharon' => ['england plus pharon'],
  'Equator 1771' => ['equator1771'],
  'Esso-sveitin' => ['esso - sveitin', 'esso -sveitin'],
  'Eviza Plambata' => ['eviza_plambata'],

  "Flint's Crew" => ["flint`s crew"],
  'FOS' => ['f o s'],
  'Friends of Academy' => ['friends of akademy'],
  'Frankie Holidays' => ['frankie hollydays'],

  'Hum Paanch' => ['hum paach'],
  'Hungarian Olympic' => ['hungar olimp', 'hungarian olimp',
    'hungar olimpics', 'hungar olimpic'],

  'Idea Bridge Torino' => ['gs idea br. to', 'idea bridge'],
  'Institute of Chemical Technology' => ['inst.of chem.tech.', 
    'inst.of chem.techn.'],

  'Jan Wellem' => ['jan wel'],
  'Jian Hua Club' => ['jian hua'],

  Kebiya => ['ke bi ya', 'ke bi ya club'],
  'Kent Romeos venner' => ['kent romeos veenner'],
  'KM 23' => ['km23'],

  'Late S.S. Jain' => ['late ss jain', 'lss jain', 'l s s jain',
     'late sssk jain'],
  'Lawrence Allstars' => ['ml allstars'],
  'Le Romain boys' => ["leroumain's boys", 'le romain', 'le roumains'],
  'Lew Lodzki' => ['new lodzki'],
  'Logos GPS' => ['logos gpg'],

  'Massachusetts Association' => ['massachussets assoc'],
  'Mo i Raneran' => ['mo i raneran :)'],
  'Multi Gen Indonesia' => ['multi gen ina'],
  'Møllers Team' => ['møllers t'],

  NAD => ['n a d'],

  "Pal's Four" => ["pal's"],
  Polýsgücü => ['polýs gücü s', 'polýs gücü', 'polis gucu', 'polisgucu'],
  "Pradeep's Four" => ["pradeep's 4", "Pradeep's Team"],
  "President's Team" => ["president's"],
  "Priya's Four" => ["priya's iv", "priya's4"],
  'P.S.' => ['p. s.'],

  'Rajjan' => ["rajjan's"],

  'Saevar Karl' => ['svaer karl'],
  'S.B.F.' => ['s.b.f'],
  'slaveykov.bg' => ['slaveikov.bg'],
  SMBC => ['s m b c'],
  'SM BTC' => ['sm-btc'],
  'Spring Foursomes' => ['spring 4s', 'spring fours', "spring 4's"],

  'Valar Morghulis' => ['valar morgulis'],

  'Yitang QIAO' => ['qiao yi tang']
);

my @SINGLE_WORDS = qw(
   1den1e

   AABC ABBK ABBKI ABC Acolvik ACR Aditya Aeras Ahmetizm Akinom 
   Alertplus Alex Alf Alfredo Ali Alioth Allam Alpha Amrapali Amul 
   Andrzejki Anna Anni Anol Anuj Apaçý Apek Arangan Arnab Arno 
   Arunas ASDBB Aslanli Aspe Asya Atrium AUE Augerne Auni Aurora 
   AUTBUL AUTHOL Avagard Ayan Aytalus Azores Azure

   BAB BABK Bacch Bade BAHABAWI Bahaj Baias Bajm Bajozero BAK Balti 
   Baltic Baneet BARC BARP BAST Bat Batmix Bato Batusida Bauhinia 
   BBE BBN BBO BCBR Begigütje Begijntje BEIH BELSPA Bem Ben 
   Beniaminek Berik Beton BHDM Bhide Bhinneka Biachite Bilal BIN 
   Biriceri BKSE Blandat Blund BMAL BMP BNMR BNS BNT BOC Boek Boriana 
   Borko Breno Bridgebutikken BRK Buaigh Bubu Busiaki Butler

   Cabal Cabriole Calaca Cammello Camrose Canadonia Canukusa Carlitos 
   Carsi Cask Cathy Catz Cavendish CBLTI Cem Cendrawasih Center Cerkez 
   Chass Chateau Chime Chiranjeev CHPIK Chuanpit Cité Claudili CMN 
   Colorado Concurrent Conie Coopers Coor Costantina Couples 
   Croanglopol Crockfords Crossfatek CS CSTO Czteropak

   Dada Dadya Dahsyat Dallas DanEng DanFar Daniel Dash Dauna Dawn 
   Debonecos DeeJee Defne Demony Demýrbaþ DenmarS Deppo Diana Didi 
   Dido Diego Dieter Dilligaf Dimmat Dingyuan Dino Dinos Dion DJB 
   Doki Dora DSM Dukens Duros Dvizhenie 

   Ece Econ Edi Efsane Egesarpdoruk Eikka Ekenboda Ekoap Elektrownia 
   Elio Elips Eliza Ellen EMA Emre Engelen Ephesus Epsilon Equator 
   Era Eren Eric Erikas Erla Ertým ErUS ESA Eses Esesss Esperanza 
   Ewa

   Fakel FAM² FAMA Farta Felix Fenia Fenix Ferfi Feszek Fharon Fifi 
   Fil Filur Flagship FNCC Formosa Fortuna Fortune FOS Foundation 
   Francest Frank Franz Frieolt Frirond Frusci Fundacja FWK

   Gabrisem Galim Gambitas Gamma Garry Garp Garuda Gata Gelin George 
   Gewanna Gezi Gibs Gjesp Gkobra GMM Goroco Gosho Göktürk GP 
   Greecoura Greta GRNC Grup Guayacos Gudok Gulce Gullberg Gullvi 
   Guptas Gürsel

   Hade Hai Hakl Hanan Hande Hansa Harvin Havin HayirlisI Hayet 
   Hebat Heino Heis Hel Helgeness Hella Hellé Heliopolis HengSha 
   Hilda Hist HKES Holders Holifera Holport House Hridhaan Hubsi 
   Hunaja Huispaus 

   IBBSK IBE Ida Iff Ijseide Ilya IMAN Imanuel IMLUK InFran Iris 
   Irukangi Ismo Israbel Isrmany ITB Itnoraunz ITS IVAR Iza

   Jagg Jaiganesh Janko Jans JanTC JAPCAN JAS JASS Jassica Javel 
   Jaya Jelena Jessi Jessica Jecization JHIC Jinjing Jirin Jiujiu 
   Jóannes Jonathan Joter Juanval Juls Juniorklubben Juste Justplay 
   Justyna Justynka Jutek JuuTools

   Kaardivägi Kagama Kalbar Kalca Kalkarna Kaltim Kamlakars Kamyk 
   Karaarslan Karin Kark Kasiyahan Kasty Kasuang Katipunan KBA KBC 
   Kebiya Keni Kenji Kenlong Kerasus Kibe Kinga Kitty Kjelskos
   Klasik Klio KMC Knösel Kodin Koiraperhe Kokoelma Kolbasti 
   Komleposs Konga Kordam Korsikalý Kortai Koukouselis KPPM KrASK 
   Kratos Krem Kris Kriston Krisztina Ksenia KSOS Kuglana Kultur 
   Kvazar Kwiecisty

   Lahjattomat LAKT Laleler Lancia Langy Laplas Larry Lasse Lataka 
   Lateria LatSwe LBC LBSK LCF Lebron Legeanka Lema Lemanus Lenz 
   Leszek Leta Letve Leveni Lianas Liban Lili Lillebaluba Lipa 
   Lira Livius Ljónin LNWers Lo Loaknath Lolly Loloc Longzhu 
   Loreng LOS Lowel Löparn LPMS LXA Lyubcho 

   Macak Mach Madhav Mads Magnus Maija Maj Makara Makriköy Mali 
   Malinka Malmölaget Manashda Manena Manno Mano Manu Manywar Margitta 
   Marianne Mark Marosamitawa Marynarz Masal Matilde Mats Matujona 
   Mavi Mavs Mayamira Medik Mer Mesna MGM MGTH Mia Michal Mihai Mikke 
   Miguel Milo Minut Miro MMRMC Mochu Moki Monaconf Moritz Morot 
   Mostingan Movember Mölnlycke MPEC MRSMC Munawar Muumio Mýna 
   Myoni Møremix 

   Nabil NAD Nadide Narbisk Narre Natalia Nathans NBB Necos Neduk 
   Nessuno Nico Nik Nikita Nikitopoulos Niko Nikos Nikotiimi Nina Nis 
   Nislije NMRT NoNed Noralia Noriko Norsu NOS Noto NTiosagutta Nula

   Obezit OEI Ognisty Oguzhan Oksijen Olena Olimp OMC Omega Omelas 
   Onirepsou Onnela Onu Oprosti Orakulas OSA Osam OSMO Oto Otta Oyku 
   Oyzum Ozbiljni

   Öncü

   Paco Pagonia Pal Palukas Panteros Paoli Pasam Pasanci Passé 
   Patagonia Paulette Paulina Paulistas PBL PCBA PDC Pennant Perjuangan 
   Pero Peter Petra Pia Piast Piryoli Piter Pjäxa PKB PKM Pleschi 
   Pleyada Plia PMC PMS Pojat Polirish Polus Polýsgücü Pompapompa 
   Poss Prapar Prasetya Prijatelj Prim Primabridge Prosan Proto Ptacol 
   PTT Pude Pyon Pyton PZIM 

   QLJB Quantum 

   Radeks Radhey Radikk Rafael RAG Raifles Rakinnett RAM Ramkumar RASH 
   Raskasammen RBP Recaptan Regeldur Rem Rene Rica Rob Ribitas Rike 
   Rima RKK Robertinho Robi Rofoi Rosajora Royston Rozle RS Rüya 
   Rylai Rylal Ryo

   Sabari Sabina SAGG Salost Salvo Sansouci SANY Sara Sargam Sarp 
   SaTu Saty Sbamby Sbanda Scapros Schmuckles Scot SDK Selin 
   Senaattorit Severin Sevil SFG SGG Shan Shane Shankars Shaoshen 
   Shavaz Sherdils SHHG Shona Shrikant Shuai Shushi Sid Siddheshwar 
   Sigdonnemann Sigma Sigrid Sihai Silbersee Simonetta Simpleksas 
   Sindhu SISU Sitespor Sivves Siyabend Skalman Skaronga SKB SKBS 
   Skotii SKR Þlem Slostria SMBC SMJ SMK SNAP SNP Soba Sober Sobers 
   Sogn Solo Sonchel Soumitra Spamirs Spandan Spartak Spektr Spin 
   Spring Srimapuna Srykeir SSBC SSSR Stafani Stagge Starsbridge 
   STB Stefany Steinars Steinlager Steliana Steve Strata Studentene 
   StZ St?vel Sucharek Sue SuHuQiaoYou Suz Svetla Swanand SweDanes 
   SweNor Swest Syabas SYL Syly SYT SZPAK SZPAR Sør 

   TAC Tadeu Take Takk Takým Taksim Tally Tamae Tangra Task Tefo 
   Tiglatpalasar Tihkur Tita Tiz Toar Todremor Tofi Tollemache 
   Toma Tongxin Topozero Totani Totoro Tömör TPI Traker Triks Troll 
   Trøndermøringen Tuason Tulipano Turuncu Tushar Tusio Tvist

   UAB Udarnik Úlfurinn Underberg Unlu UTU

   Vahakabinetti Vakrandi Valen Valentino Valyo Vanko Varan Varoslu 
   Vasallid Västanfläkten Veegees Vega* Veggen Verder Verons 
   Vicho Vicky Victor Vilmar Vilttiketju Vilttiukko Viña Virginia 
   Vivi Voff Volta Vucko Vurgun Vürst Vytas

   Wael Wafa Wala Waldi Wanghong WBack WBBA WBFIT WBGO WDP 
   Weiqun Wengens Winatalya WinBridge Winterfell WLKP Wolf WSWT

   Xatzopoulos XC XFIP Xinhai XMing 

   Ybs YBM Yaðmur Yamata Yansimasiz YeJun Yelena Yildizlar
   Ylajai Yogakshema Yokozuna YSD YYD YYY

   Zabavljaci Zamek Zana Zara Zaraz Zen Zeyno Zhihaole Ziggy Zimmkonis 
   Zivac ZKS Zlatan Zmaj Zozoura Zurzits Zvanger Zweili

   Øssur
);

my %SINGLE_TYPOS =
(
  Acolvik => ['acolvick'],
  Aditya => ['aaditya'],
  Alizee => ['alize'],
  'Alunand Plus' => ['alunand'],
  Ambassador => ['ambassadors', 'ambassdor'],

  Bhinneka => ['bhineka', 'bhinneke'],
  Bilal => ['balil'],
  Boriana => ['boryana'],
  Buaigh => ['buaijh'],

  Dilligaf => ['dilligraf'],
  Dingyuan => ['dinyuan'],

  Eikka => ['eikkaa'],
  'El Gezira' => ['elgezira'],
  Erikas => ['ericas'],

  Feszek => ['Fészek'],

  Gelin => ['gelýn'],
  Göktürk => ['gokturk'],

  Hridhaan => ['hridhan', 'haridhaan', 'hrridhaan', 'hrridhaan',
    'hridaan'],
  'HZ Connection' => ['hzconnection'],

  Imanuel => ['imanual'],

  Jonathan => ['joanthan'],
  Juls => ['julst'],

  Kibe => ['kýbe'],

  'Late S.S. Jain' => ['lssjain'],
  'Le Romain boys' => ['leromain'],
  Leveni => ['levini'],
  'Logos GPS' => ['logos'],
  'Loy Krathong' => ['longkatong'],
  Löparn => ['loparn'],

  'Meng Qing Xin' => ['mengqingxin'],

  Natalia => ['nataliya'],
  'Nav Chaitanya' => ['navchaitanya'],

  Pagonia => ['pagonya'],
  Patagonia => ['patagonya'],
  Paulistas => ['paulistanas'],
  Prasetya => ['prasetia'],
  "President's Team" => ['president', 'presidents'],

  Quantum => ['qantum'],

  'Ram Charan' => ['ramcharan'],
  Radikk => ['radekk', 'radik'],

  'Sarunta Toar' => ['sarunta'],
  'Sham Sharma' => ['shamsharma'],
  Shrikant => ['srikant'],
  Sigdonnemann => ['sigdonneman'],
  Skotii => ['skoti'],
  Soumitra => ['soumtra'],
  Spamirs => ['spamýrs'],
  'SPG Club' => ['spg'],
  'Stall Dieden' => ['dieden'],
  Syabas => ['syahbas'],

  Valyo => ['valýo'],
  Vürst => ['vuerst'],

  'Wei De' => ['weide'],

  'Xin Yuan' => ['xinyuan'],

  Yogakshema => ['yogakhema', 'yogakshem'],

  Zvanger => ['zvunger']

);


sub set_hashes_team_other
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
