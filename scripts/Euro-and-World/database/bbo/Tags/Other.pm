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

  'a-TMPC',
  'A-chanzu',
  'Absolut Bridge',
  'A.C.L.A.',
  'A.z.f.e.n.a',
  'A Takimi',
  'ABA Nuno Paz',
  'ABB Tomas',
  'Ace Metes',
  'Ai Bait',
  'Air Traffic Management',
  'AJD & Varna',
  'Aka Maru',
  'Aklindo Musi 88',
  'Alunand Plus',
  'Andrea L.',
  'Ar Tush',
  'Arab Club',
  "Archie's",
  "Asha's 4",
  'Asketické samice',
  'Aslinda Bric',
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
  'Bimal Sicca',
  'BMW J',
  'Brans BS',
  'Bric Klinik',
  'Bridgekam 17',
  'Bridgerama Milan',
  'Bridgetime 45',
  'Bu Mu',
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
  'Da Zhiran',
  'Dalian ABC',
  'Dalian BA',
  'Dalian Hong',
  'Daqin Shihua',
  'Daqin Xinghan',
  'Daqin Xinghua',
  'Daqing Xinghan',
  'Dauna Winazza',
  'Deccan Chargers',
  'Deceptive AHM',
  'Delhi Diamonds',
  'Delhi Gym Aces',
  'DELTA 2',
  'Dersim38',
  'Deutsche Senioren',
  'Director Team',
  'Diren Noname',
  'DK Notus',
  'DK Nationalchampion',
  'DK-Tworzywa',
  'DKI Maesa',
  'Doca Bridge',
  'Dong Ming',
  'Dong Qi 9',
  'Dr. Cladius',
  'Dr. Gittipatq',
  'DS 1',
  'Duo Bid Online',

  'e-bridge',
  'EBL Emeritus President',
  'Ege & Besli Major',
  'El Gezira',
  'El Hazem',
  'El Play',
  'El Yamo',
  'Ella-Jamie',
  'EM-76',
  'England and Pharon',
  'English Premier League',
  'Equator 1771',
  'Erdal Abi',
  'Erdal Tekin',
  'Esso-sveitin',
  'Etna Bridge',
  'Eviza Plambata',
  'EX S',

  'Figo-Fago',
  'Fire Club',
  'First Club',
  "Flint's Crew",
  'Former J',
  'Frankie Holidays',
  'Friends of Academy',
  'Friends of Lalit',
  'FT 79',

  'G&HGK',
  'Garuda Sakti',
  'Gatwick WC',
  'Gerganin Izvor',
  'GG Bridge',
  'Gobbi San Siro',
  'Gold Cup',
  'Gosti Ch.B',
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

  'Jai Ganesh',
  'Jan Wellem',
  'Japan SARA',
  'Japan SAYN',
  'Jarum LA',
  'Jenny-Chang',
  'Ji Jin',
  'Jia Zhou Ai Qiao',
  'Jian Hua Club',
  'Jie Fang He Ji',
  'Jin Fu',
  'Jin Hui',
  'Jin Mei',
  'Jiu Jiu',
  'JJ Maxrod',
  'JL Crew',
  'JM&Co',
  'JT2',
  'Juras Ezi',

  'Kacho Fugetsu',
  'KaiCheng RL',
  'Karamel IN',
  'Kawanua Selection',
  'Ke Da',
  'Keda Xiaoyou',
  'Kent Romeos venner',
  "Kitty's",
  'KM 23',
  'KOC67',
  'Kong Chou',
  'Kontrat Kirmizi',
  'Korry and Trenk',
  'Kozyrnye Oleni',
  'KM AT',
  'KSK Deniz',

  'Lal Mati',
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
  'Liu Miu',
  'Logos GPS',
  'Los Feos',
  'Los Malos',
  'Los Salgado',
  'Los Tollos',
  'Loy Krathong',
  'LT Ilanka',
  'Lucy-Ellena',
  'LV 2014',

  'Maa Sarada',
  'Maccabi dacordar',
  'MAJB Lommorna',
  'Mal - Phi',
  'Malatya Basket',
  'Malung Janne',
  'Manny Herrings',
  'Marki-Macki',
  'Massachusetts Association',
  'Mavý Ankara',
  'MBS Meski',
  'Mega-S',
  'Meng Qing Xin',
  'Mid Open',
  'Mike Lawrence Club',
  'Minas Trith',
  'Mo i Raneran',
  'Mo Yan',
  'Moki011',
  'Monte Carlos',
  'MPM Mix',
  'Multi Gen Indonesia',
  'Mumbai Indians',
  'MY-Bridge',
  'myvatnhotel.is',
  'Mýra Kontrat',
  'MW&P',
  'Møllers Team',

  "'n Vidar & Andersen",
  'N.O.Seniori',
  'Nav Chaitanya',
  'Nazar Boncugu',
  'Nazionale Cantanti',
  'NBS Lind',
  'New Bridge',
  'New Chi',
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
  'Polar Star',
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

  'S-K',
  'Saevar Karl',
  'San Sac',
  'San3PDX',
  'Sana Rival',
  'Sang ae',
  'Sanghi Tivoli',
  'Sarunta Toar',
  'Saruntawaya Minahas',
  'S.B.F.',
  'Scottish President',
  'Seckin C',
  'Sengkol Lombok',
  'Sfora Bez Cibora',
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
  'Sredna Vashtar',
  'Staff Team',
  'Stall Dieden',
  'Stojanov Izbor',
  'Swami Samarth',
  'Såpjohansen & co',

  'Tasher Desh',
  'Team Bru',
  'Team Zang',
  'Team Lanka',
  'Team Saju',
  'Team Z',
  'Teyzenin Yeri',
  'Tida-Steli',
  'The Lombard',
  "The Naising's",
  'Til Valhall',
  'Tim Team',
  'Tinutuan Manado',
  'TRK - V',
  'Top Bucuresti',
  "Tor Ivar's",
  'Transfer 6',
  'Tupac Amaru',
  'Turk Kahvesi',
  'Tzoko-Mokko',

  'Ucurtma Avcisi',
  'UKS Olimpia',
  'Umisen Yamasen',
  'Umut Baris',
  'Unelmien Piina',
  'University Union Team',

  'Valar Morghulis',
  'Vesko M',
  'Villi Jr.',
  'Visoki Napon',

  'Waldi-S',
  'Wan Jian Club',
  'Wei De',
  'Wei Ming Dui',
  'World All Star',

  'X.D.X.J',
  'Xiao Jun Gan Dui',
  'XiBu VIP',
  'Xin Yuan',

  'Yitang QIAO',
  "Yttakjær`s",
  'Yun-Kai',
  'Yura Taschit',

  'Z Lasu',
  'Zabina i Zolza',
  'Zara Bridge',
  'Zen Ho',
  'ZG HC',
  'Zhong Jia Lian Dui',
  'Zuid West'
);

my %MULTI_TYPOS =
(
  'ABA Nuno Paz' => ['ABA - Nuno Paz', 'ABA-Nuno Paz'],
  'AIC' => ['a i c'],
  'Air Traffic Management' => ['air traffic managem', 'air-trfc',
    'air-trf'],
  'AJD & Varna' => ['ajd&varna'],
  'Aklindo Musi 88' => ['musi 88', 'musi88'],
  'Alunand Plus' => ['alunand pdg prm',
    'alunand pdgpariaman', 'alunand pdg pariama'],
  Arnab => ["arnab's"],
  Azores => ['açores team'],
  Ayan => ["ayan's"],

  'Beto BO' => ['beto b o'],
  'Bridgerama Milan' => ['bridgerama mi'],

  "Chairman's Choice" => ["chairman's team"],
  'Chicho Itsi' => ['chicho ici'],

  Crossfatek => ['cross fatek'],

  'Dauna Winazza' => ['daunna winazza', 'dauna winazaa'],
  'Deceptive AHM' => ['deceptive  ahm'],
  'Delhi Gym Aces' => ['d g aces', 'dgc aces'],
  'DK Notus' => ['notus df'],
  'Dr. Cladius' => ['dr cladius'],

  'El Gezira' => ['el-gezira'],
  'EBL Emeritus President' => ['EBL Emer.Presi',
    'EBL. Emer. Presi'],
  'England and Pharon' => ['england plus pharon'],
  'Equator 1771' => ['equator1771'],
  'Esso-sveitin' => ['esso - sveitin', 'esso -sveitin'],
  'Eviza Plambata' => ['eviza_plambata'],

  'FOS' => ['f o s'],
  'Friends of Academy' => ['friends of akademy'],
  'Frankie Holidays' => ['frankie hollydays'],

  Hotmix => ['gbc hotmix'],
  'Hum Paanch' => ['hum paach'],
  'Hungarian Olympic' => ['hungar olimp', 'hungarian olimp',
    'hungar olimpics', 'hungar olimpic'],

  'Idea Bridge Torino' => ['gs idea br. to', 'idea bridge'],

  'Jan Wellem' => ['jan wel'],
  'Ji Jin' => ['ji jing'],
  'Jian Hua Club' => ['jian hua'],
  'JM&Co' => ['jm& co'],

  Kebiya => ['ke bi ya', 'ke bi ya club'],
  'Kent Romeos venner' => ['kent romeos veenner'],
  'KM 23' => ['km23'],

  'Late S.S. Jain' => ['late ss jain', 'lss jain', 'l s s jain',
     'late sssk jain'],
  'Lawrence Allstars' => ['ml allstars'],
  'Le Romain boys' => ["leroumain's boys", 'le romain', 'le roumains'],
  'Lew Lodzki' => ['new lodzki'],
  'Logos GPS' => ['logos gpg'],

  'Maa Sarada' => ['maa sarda', 'maa saarada'],
  'Massachusetts Association' => ['massachussets assoc'],
  'Mike Lawrence Club' => ['lawrence club'],
  MMRMC => ['mmrmc(pkb)'],
  'Mo i Raneran' => ['mo i raneran :)'],
  'Multi Gen Indonesia' => ['multi gen ina'],
  'Møllers Team' => ['møllers t'],

  Obezit => ['obezit tatilde', 'obezit intl', 'öz obezýt'],

  "Pal's Four" => ["pal's"],
  "Pradeep's Four" => ["pradeep's 4", "Pradeep's Team"],
  Preservasi => ['preservasi plus'],
  "President's Team" => ["president's"],
  "Priya's Four" => ["priya's iv", "priya's4"],
  'P.S.' => ['p. s.'],

  'Rajjan' => ["rajjan's"],

  'Saevar Karl' => ['svaer karl'],
  'San Sac' => ['zan zac'],
  'S.B.F.' => ['s.b.f'],
  'slaveykov.bg' => ['slaveikov.bg'],
  SMBC => ['s m b c'],
  'SM BTC' => ['sm-btc'],
  'Spring Foursomes' => ['spring 4s', 'spring fours', "spring 4's"],
  'Sredna Vashtar' => ['sredni vashtar'],

  "Tor Ivar's" => ['tor ivars'],

  'University Union Team' => ['union team', 'university unions',
    'university union'],

  'Valar Morghulis' => ['valar morgulis'],

  'Waldi-S' => ['waldi s'],

  'Yitang QIAO' => ['qiao yi tang']
);

my @SINGLE_WORDS = qw(
   1den1e

   AABC ABBK ABBKI ABC Acolvik ACR Aeras AFTA AIC Alertplus Alioth 
   Alpha ASDBB Aslanli Aspe Asya Atrium AUE Augerne Aurora 
   AUTBUL AUTHOL Avagard Aytalus Azores Azure

   BAB BABK Bacch Bade BAHABAWI Bahaj Baias Bajm Bajozero BAK Balti
   Baltic BARC BARP BAST Bat Batmix Bato Batusida BBCF BBN BBO BCBR
   Begigütje BEIH BELSPA Bem Beton BHDM Bhide Bhinneka
   Biachite BIN Biriceri BKSE Blandat Blund BMAL BMP BNS BNT
   BOC Boek Boriana Borko Brica Bridgebutikken BRK Buaigh Bubu 
   Busiaki Butler

   Cabal Cabriole Calaca Cammello Camrose Canadonia Canukusa
   Carsi Cask Catz Cavendish CBLTI Cendrawasih Center Cerkez
   Chass Chateau Chime CHPIK Chuanpit Cité CMN Colorado Concurrent
   Coopers Coor Costantina Couples Croanglopol Crockfords Crossfatek
   CS CSTO Czteropak

   Dallas DanEng DanFar Dash DBS Debonecos DeeJee Defne Demony 
   Demýrbaþ DenmarS Deppo Dilligaf Dimmat Dingyuan Dino Dinos DJB 
   Dombo Doki Duros Dvizhenie 

   Econ Efsane Egesarpdoruk Eikka Ekenboda Ekoap Elektrownia 
   Elio Elips EMA EMBO Engelen Ephesus Epsilon Equator Era Ertým ErUS 
   ESA Eses Esesss Esperanza 

   Fakel FAM² FAMA Farta Fenix Ferfi Feszek Fil Filur Fit Flagship 
   FNCC Formosa Fortuna Fortune FOS Foundation Francest Frieolt 
   Frusci Fundacja FWK

   Gabrisem Galim Gambitas Gamma Garp Garuda Gata Gelin 
   Gewanna Gezi Gibs Gjesp Gkobra GMM Goroco Göktürk GP 
   Greecoura GRNC Grup Guayacos Gudok Gullberg Gullvi 

   Hade Hai Hakl Hansa HayirlisI Hebat Helgeness Hellé Heliopolis 
   HengSha Hist HKES Holders Holifera Holport Hotmix House Huispaus 

   IBBSK IBE Iff Ijseide IMAN IMLUK InFran Inwitofitka Irukangi 
   Ismo Israbel Isrmany ITB Itnoraunz ITS IVAR Iza

   JanTC JAPCAN JAS JASS Jassica Javel Jaya Jecization Jinjing 
   Jirin Jiujiu Joter Juanval Juls Juste Justplay 
   Jutek JuuTools

   Kaardivägi Kagama Kalbar Kalca Kalkarna Kaltim Kamyk Karaarslan 
   Kark Kasty Kasuang Katipunan KBA KBC Kebiya Kenlong Kerasus Kibe 
   Kings Kjelskos Klasik Klio KMC Knösel Kodin Koiraperhe Kokoelma 
   Kolbasti Kombinasi Komleposs Kopru Kordam Korsikalý Kortai 
   Koukouselis KrASK Kratos Krem Ksenia KSOS Kultur Kvazar Kwai 
   Kwiecisty

   Lahjattomat LAKT Laleler Lancia Langy Laplas Lataka Lateria 
   LatSwe LBC LBSK LCF Legeanka Lema Lemanus Lenz Letve Leveni 
   Lianas Liban Lillebaluba Lio Lipa Lira Livius Ljónin LNWers Lo 
   Loaknath Lolly Longzhu LOS Lowel Löparn LPMS LXA Lyubcho 

   Makara Makriköy Malmölaget Marosamitawa Marpalaki Marynarz Masal 
   Matujona Mavs Mayamira Mer Mercury Mesna MGM MGTH Minut MMRMC 
   Mochu Monaconf Morot Mostingan Movember Mölnlycke MPEC MRSMC 
   Muumio Mýna Møremix 

   Nadide Narbisk Narre Necos Neduk Nessuno Nikotiimi 
   Nislije NMRT NoNed Noralia Norsu NOS Noto NRC NTiosagutta Nula

   Obezit OEI Ognisty Oksijen Olimp OMC Omega Omelas Onnela Onu 
   Oprosti Orakulas OSA Osam OSMO Oto Otta Oyzum Ozbiljni

   Öncü

   Pagonia Palukas Panteros Pasam Pasanci Passé Patagonia Paulistas 
   PBL PCBA PDC Pennant Perjuangan Piast Piryoli Pjäxa PKM Pleschi 
   Pleyada Plia PMC PMS Pojat Polirish Polus Pompapompa Poss Prapar 
   Prasetya Preservasi Prijatelj Prim Primabridge Prosan Proto 
   Ptacol PTT Pude Pyon Pyton PZIM 

   QLJB Quantum 

   Radeks Radhey RAG Raifles Rakinnett RAM RASH Raskasammen 
   RBP Recaptan Regeldur Rem Ribitas RKK Rofoi Rosajora Royston Rozle 
   RS Rüya Rylai Rylal Ryo

   Sabari SAGG Salost Salvo Sansouci SANY Sargam SaTu Saty Sbamby 
   Sbanda SBC Scapros Schmuckles Scot SDK Senaattorit Sensei Sepuluh 
   SFG SGG Shan Shaoshen Sherdils SHHG Sigdonnemann Sigma Sihai 
   Silbersee Simpleksas SISU Sivves Siyabend Skalman Skaronga SKB 
   SKBS Skotii SKR Þlem Slostria SMBC SMJ SMK SNAP SNP Soba Sober 
   Sobers Sogn Solo Sonchel Soumitra Spamirs Spandan Spartak Spektr 
   Spin Spring Srimapuna Sriwijaya Srykeir SSBC SSSR Stafani Stagge 
   Starsbridge STB Steinars Steinlager Strata StZ St?vel Sucharek 
   SuHuQiaoYou SweDanes SweNor Swest Syabas SYL Syly SYSS SYT 
   Szlem SZPAK SZPAR Sør 

   TAC Take Takk Takým Taksim Tally Tangra Task Tefo Tiglatpalasar 
   Tihkur Tiz Toar Todremor Tollemache Tongxin Topozero Totani 
   Totoro Tömör TPI Traker Triks Troll Trøndermøringen Tuason 
   Tulipano Turuncu 

   UAB Udarnik Úlfurinn Underberg UTU

   Vahaboðlu Vahakabinetti Vakrandi Valen Valyo Vanko Varan 
   Varoslu Vasallid Västanfläkten Veegees Vega* Veggen Verder 
   Verons Vicho Vilmar Vilttiketju Vilttiukko Viña Voff Volta 
   Vucko Vurgun Vürst Vytas

   Wanghong WBack WBBA WBFIT WBGO WDP Weiqun Wengens Winatalya 
   WinBridge Winterfell WLKP Wolf WSWT

   Xatzopoulos XC XFIP Xinhai XMing 

   Ybs YBM Yaðmur Yamata Yansimasiz YeJun Yildizlar Yogakshema 
   Yokozuna YSD YYD YYY

   Zabavljaci Zamek Zana Zang Zaraz Zeyno Zhihaole Zimmkonis Zivac 
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

  'Ji Jin' => ['jijin'],
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
  'Polar Star' => ['polarstar'],
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
