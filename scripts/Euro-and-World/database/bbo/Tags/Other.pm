#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Other;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  '07', 

  'A.C.L.A.',
  'A.z.f.e.n.a',
  'A Takimi',
  'ABA Nuno Paz',
  'ABB Tomas',
  'Ai Bait',
  'Air Traffic Management',
  'Aka Maru',
  'Aklindo Musi 88',
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
  'Bes-Can',
  'Besli Major',
  'Beto BO',
  'Bez Nazwy',
  'Bhinneka Garuda',
  'Bimal Sicca',
  'BMW J',
  'Brans BS',
  'Bridgekam 17',
  'Bridgerama Milan',
  'Buyur Teyze',

  'Can Aren',
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
  'Kent Romeos venner',
  "Kitty's",
  'KM 23',
  'KOC67',
  'Kong Chou',
  'Kozyrnye Oleni',
  'KM AT',
  'KSK Deniz',

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
  'Moki011',
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
  'PABF Open',
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
  'Zen Ho'
);

my %MULTI_TYPOS =
(
  'ABA Nuno Paz' => ['ABA - Nuno Paz', 'ABA-Nuno Paz'],
  'AIC' => ['a i c'],
  'Air Traffic Management' => ['air traffic managem'],
  'Aklindo Musi 88' => ['musi 88', 'musi88'],
  Arnab => ["arnab's"],
  Azores => ['açores team'],
  Ayan => ["ayan's"],

  'Beto BO' => ['beto b o'],
  'Bhinneka Garuda' => ['bhineka garuda'],
  'Bridgerama Milan' => ['bridgerama mi'],

  "Chairman's Choice" => ["chairman's team"],
  'Chicho Itsi' => ['chicho ici'],

  Crossfatek => ['cross fatek'],

  'Deceptive AHM' => ['deceptive  ahm'],
  'Delhi Gym Aces' => ['d g aces', 'dgc aces'],
  DSM => ['d s m'],

  'El Gezira' => ['el-gezira'],
  'England and Pharon' => ['england plus pharon'],
  'Equator 1771' => ['equator1771'],
  'Esso-sveitin' => ['esso - sveitin', 'esso -sveitin'],
  'Eviza Plambata' => ['eviza_plambata'],

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
  MMRMC => ['mmrmc(pkb)'],
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

   AABC ABBK ABBKI ABC Acolvik ACR Aeras AIC Alertplus Alioth Alpha 
   ASDBB Aslanli Aspe Asya Atrium AUE Augerne Aurora AUTBUL AUTHOL 
   Avagard Aytalus Azores Azure

   BAB BABK Bacch Bade BAHABAWI Bahaj Baias Bajm Bajozero BAK Balti
   Baltic BARC BARP BAST Bat Batmix Bato Batusida BBN BBO BCBR
   Begigütje BEIH BELSPA Bem Beton BHDM Bhide Bhinneka
   Biachite BIN Biriceri BKSE Blandat Blund BMAL BMP BNS BNT
   BOC Boek Boriana Borko Bridgebutikken BRK Buaigh Bubu Busiaki Butler

   Cabal Cabriole Calaca Cammello Camrose Canadonia Canukusa
   Carsi Cask Catz Cavendish CBLTI Cendrawasih Center Cerkez
   Chass Chateau Chime CHPIK Chuanpit Cité CMN Colorado Concurrent
   Coopers Coor Costantina Couples Croanglopol Crockfords Crossfatek
   CS CSTO Czteropak

   Dallas DanEng DanFar Dash Debonecos DeeJee Defne Demony Demýrbaþ 
   DenmarS Deppo Dilligaf Dimmat Dingyuan Dino Dinos DJB Doki DSM 
   Duros Dvizhenie 

   Econ Efsane Egesarpdoruk Eikka Ekenboda Ekoap Elektrownia 
   Elio Elips EMA Engelen Ephesus Epsilon Equator Era Ertým ErUS 
   ESA Eses Esesss Esperanza 

   Fakel FAM² FAMA Farta Fenix Ferfi Feszek Fil Filur Flagship 
   FNCC Formosa Fortuna Fortune FOS Foundation Francest Frieolt 
   Frusci Fundacja FWK

   Gabrisem Galim Gambitas Gamma Garp Garuda Gata Gelin 
   Gewanna Gezi Gibs Gjesp Gkobra GMM Goroco Göktürk GP 
   Greecoura GRNC Grup Guayacos Gudok Gullberg Gullvi 

   Hade Hai Hakl Hansa HayirlisI Hebat Helgeness Hellé Heliopolis 
   HengSha Hist HKES Holders Holifera Holport House Huispaus 

   IBBSK IBE Iff Ijseide IMAN IMLUK InFran Irukangi Ismo Israbel 
   Isrmany ITB Itnoraunz ITS IVAR Iza

   JanTC JAPCAN JAS JASS Jassica Javel Jaya Jecization Jinjing 
   Jirin Jiujiu Joter Juanval Juls Juniorklubben Juste Justplay 
   Jutek JuuTools

   Kaardivägi Kagama Kalbar Kalca Kalkarna Kaltim Kamyk Karaarslan 
   Kark Kasty Kasuang Katipunan KBA KBC Kebiya Kenlong Kerasus Kibe 
   Kjelskos Klasik Klio KMC Knösel Kodin Koiraperhe Kokoelma Kolbasti 
   Komleposs Konga Kordam Korsikalý Kortai Koukouselis KPPM KrASK 
   Kratos Krem Ksenia KSOS Kultur Kvazar Kwiecisty

   Lahjattomat LAKT Laleler Lancia Langy Laplas Lataka Lateria 
   LatSwe LBC LBSK LCF Legeanka Lema Lemanus Lenz Letve Leveni 
   Lianas Liban Lillebaluba Lipa Lira Livius Ljónin LNWers Lo 
   Loaknath Lolly Longzhu LOS Lowel Löparn LPMS LXA Lyubcho 

   Makara Makriköy Malmölaget Marosamitawa Marynarz Masal Matujona 
   Mavs Mayamira Mer Mesna MGM MGTH Minut MMRMC Mochu 
   Monaconf Morot Mostingan Movember Mölnlycke MPEC MRSMC Muumio 
   Mýna Møremix 

   NAD Nadide Narbisk Narre Necos Neduk Nessuno Nikotiimi 
   Nislije NMRT NoNed Noralia Norsu NOS Noto NTiosagutta Nula

   Obezit OEI Ognisty Oksijen Olimp OMC Omega Omelas Onnela Onu 
   Oprosti Orakulas OSA Osam OSMO Oto Otta Oyzum Ozbiljni

   Öncü

   Pagonia Palukas Panteros Pasam Pasanci Passé Patagonia Paulistas 
   PBL PCBA PDC Pennant Perjuangan Piast Piryoli Pjäxa PKM Pleschi 
   Pleyada Plia PMC PMS Pojat Polirish Polus Polýsgücü Pompapompa 
   Poss Prapar Prasetya Prijatelj Prim Primabridge Prosan Proto Ptacol 
   PTT Pude Pyon Pyton PZIM 

   QLJB Quantum 

   Radeks Radhey RAG Raifles Rakinnett RAM RASH Raskasammen 
   RBP Recaptan Regeldur Rem Ribitas RKK Rofoi Rosajora Royston Rozle 
   RS Rüya Rylai Rylal Ryo

   Sabari SAGG Salost Salvo Sansouci SANY Sargam SaTu Saty Sbamby 
   Sbanda SBC Scapros Schmuckles Scot SDK Senaattorit SFG SGG Shan 
   Shaoshen Sherdils SHHG Sigdonnemann Sigma Sihai Silbersee 
   Simpleksas SISU Sitespor Sivves Siyabend Skalman Skaronga SKB 
   SKBS Skotii SKR Þlem Slostria SMBC SMJ SMK SNAP SNP Soba Sober 
   Sobers Sogn Solo Sonchel Soumitra Spamirs Spandan Spartak Spektr 
   Spin Spring Srimapuna Srykeir SSBC SSSR Stafani Stagge Starsbridge 
   STB Steinars Steinlager Strata Studentene StZ St?vel Sucharek 
   SuHuQiaoYou SweDanes SweNor Swest Syabas SYL Syly SYT SZPAK 
   SZPAR Sør 

   TAC Take Takk Takým Taksim Tally Tangra Task Tefo Tiglatpalasar 
   Tihkur Tiz Toar Todremor Tollemache Tongxin Topozero Totani 
   Totoro Tömör TPI Traker Triks Troll Trøndermøringen Tuason 
   Tulipano Turuncu 

   UAB Udarnik Úlfurinn Underberg UTU

   Vahakabinetti Vakrandi Valen Valyo Vanko Varan Varoslu Vasallid 
   Västanfläkten Veegees Vega* Veggen Verder Verons Vicho Vilmar 
   Vilttiketju Vilttiukko Viña Voff Volta Vucko Vurgun Vürst Vytas

   Wanghong WBack WBBA WBFIT WBGO WDP Weiqun Wengens Winatalya 
   WinBridge Winterfell WLKP Wolf WSWT

   Xatzopoulos XC XFIP Xinhai XMing 

   Ybs YBM Yaðmur Yamata Yansimasiz YeJun Yildizlar Yogakshema 
   Yokozuna YSD YYD YYY

   Zabavljaci Zamek Zana Zaraz Zeyno Zhihaole Zimmkonis Zivac 
   ZKS Zmaj Zozoura Zurzits Zvanger Zweili

   Øssur
);

my %SINGLE_TYPOS =
(
  Acolvik => ['acolvick'],
  'Alunand Plus' => ['alunand'],

  Bhinneka => ['bhineka', 'bhinneke'],
  Boriana => ['boryana'],

  Dilligaf => ['dilligraf'],
  Dingyuan => ['dinyuan'],

  Eikka => ['eikkaa'],
  'El Gezira' => ['elgezira'],

  Feszek => ['Fészek'],

  Gelin => ['gelýn'],
  Göktürk => ['gokturk'],

  'HZ Connection' => ['hzconnection'],

  Juls => ['julst'],

  Kibe => ['kýbe'],

  'Late S.S. Jain' => ['lssjain'],
  'Le Romain boys' => ['leromain'],
  Leveni => ['levini'],
  'Logos GPS' => ['logos'],
  'Loy Krathong' => ['longkatong'],
  Löparn => ['loparn'],

  'Meng Qing Xin' => ['mengqingxin'],

  'Nav Chaitanya' => ['navchaitanya'],

  Pagonia => ['pagonya'],
  Patagonia => ['patagonya'],
  Paulistas => ['paulistanas'],
  Prasetya => ['prasetia'],
  "President's Team" => ['president', 'presidents'],

  Quantum => ['qantum'],

  'Ram Charan' => ['ramcharan'],

  'Sarunta Toar' => ['sarunta'],
  'Sham Sharma' => ['shamsharma'],
  Sigdonnemann => ['sigdonneman'],
  Skotii => ['skoti'],
  Soumitra => ['soumtra'],
  Spamirs => ['spamýrs'],
  'Stall Dieden' => ['dieden'],
  Syabas => ['syahbas'],

  Valyo => ['valýo'],
  Vürst => ['vuerst'],

  'Wei De' => ['weide'],

  'Xin Yuan' => ['xinyuan'],

  Yogakshema => ['yogakhema', 'yogakshem'],

  Zvanger => ['zvunger']

);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
