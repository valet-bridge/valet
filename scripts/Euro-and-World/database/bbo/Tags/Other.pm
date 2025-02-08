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
  '08SQ',
  '16Flights',
  '2Mark',
  '3Punkti',
  '4XL',

  'a-TMPC',
  'A-chanzu',
  'AAA',
  'AAMM',
  'AB2P2S',
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
  'Bridgetime45',
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
  "Erni's",
  'Esso-sveitin',
  'Etna Bridge',
  'Eviza Plambata',
  'EX S',

  'FISA Team',
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

  "L'Argent",
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
  'Lupii Galbeni',
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
  'Polish Ekstraklasa',
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
  'Sanna Kathrine',
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
  'Top of the South',
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

   AABC ABBK ABBKI ABC ABCT Abisco Access Accord Acolvik ACR Acropolis
   AdAyAzrA Aeras AFTA Aganus AIC Airoldi Airways AKYA Alertplus Alioth 
   Alli Alpha ALWI Amalin Anbaklupa Ania Anka Antre Apaheili Archi 
   AREA Armander Armex Arrow Armut Arvechico Arya ASDBB Aslanli Aspe 
   Asya Atena Atmosfera Atrium AUE Augerne Aurora AusPolRus AUTBUL 
   AUTHOL Avagard Ayranka Aytalus Azores Azure

   BAB BABK Bacch Badajara Bade Baden Badoell BAHABAWI Bahaj Baias Bajm 
   Bajozero BAK Balia Balti Baltic Bambu Bappa BARC BARP Barsa BAST 
   BASZ Bat Batmix Bato Batusida BBCF BBN BBO BCBR BEAlert Begigütje 
   BEIH BELSPA Bem Bemix Bergmen Berksma Beton BHDM Bhide Bhinneka
   Biachite BICI BIN Biriceri Biz BKSE Blaca Blanda Blandat Blund BMAL 
   BMP BMS BNS BNT BOC Boek Boriana Borko Brica Bridgebutikken Broen
   BRK Brulibu Buaigh Bubu BulGer BulNed Busiaki Butler

   Cabal Cabriole Calaca Cammello Camrose Canadonia Canukusa Cardano
   Carsi Cask Catz Cavendish CBLTI Cendrawasih Center Cerkez CFSC
   Champicann Chass Chateau Chill Chikan Chikorita Chime CHPIK 
   Chuanpit Cicek Ciger Cios Circle Cité Clairis CMN Cocacolos Colorado 
   Comfort Compass Concurrent Coopers Coor Coriandre Cosmic Costantina 
   Couples Croanglopol Crockfords Cross Crossfatek CRSCB CS CSTO CUHK 
   Czela Czerbia Czteropak

   DAE Dalas Dalida Dallas DanEng DanFar DanMar Darff Dash Dasky DBC
   DBL DBS DCLIM Debonecos DeeJee Defne DEJT Demony Demýrbaþ DenmarS 
   Deppo Dharmawangsa Diazem Dilligaf Dimmat Dingyuan Dino Dinos 
   Dinotask Dinozorlar Diofa Disk DJB Doksandokuz Dolphin Dombo Doki 
   Doubl DoVar DÖF DUBB Duniya Duros Dvizhenie 

   EAV Econ ECU Eferuh Efsane Egetor Egesarpdoruk Eikat Eikka EISK 
   Ekenboda Ekinsu Ekoap Elacz Elektrownia Elfida Elio Elips Elit 
   Ellee Elte EMA EMBO Emmer Engelen EngRom Ephesus Epik Epsilon 
   Equator Era Ertým ErUS ESA Esbrici Eses Esesss Esperanza Evici 
   Express Exprompt Ezis

   Fakel FAM² FAMA Farta Fasulye Federal Fenix Fepanandra Ferfi Feszek 
   Fevbazi FII Fil Filur Findik Fit Flagship FNCC Formosa Fortuna Fortune 
   FOS Foundation Frak Francest Frieolt Frusci FSM Fuli Fundacja Future 
   ZZFWK

   Gabrisem Galaktika Galim Gambitas Gamma Gaoshan Garp Garuda Gata 
   GBRD Gelin Gepi Gerilim Gewanna Gezi Gezzer Ghandi Gibs Gjesp 
   Gkobra GMM Goldwest Goroco Gorsi Göktürk GP Greecoura Greisnor 
   Greps GRNC Grup Guayacos Gudok Gullberg Gullvi Guronii Guti

   Hade Hai Hakl Hane Hansa Haribda Haruss Hasvel Hayir HayirlisI Haziran 
   Hebat Helgeness Hellé Heliopolis HengSha HIK Hist Hit HKB HKES Hodor
   Holders Holifera Holport Hotmix House Huispaus Hypochondriac

   IBSK IBBSK IBE IBISK Icerde Iff Ijseide IMAN IMLUK InFran Inremawi
   Instruktor Inwitofitka IRG Irukangi Isant ISE Ismo IsPolta Israbel 
   Isrmany Italianos iTeam ITB Itnoraunz ITS ITSRC IVAR Iyiler Iza

   Jakabaya JANC JanTC Japaradise JAPCAN Jareja JAS JASS Jassica Javel Jaya 
   Jecization Jinjing Jirin Jiujiu JMMT Jobilato Johha Joter Juanval 
   Juls Junisar Juste Justplay Jutek JuuTools

   Kaardivägi Kaczan Kadimera Kagama Kalbar Kalca Kalkarna KALM Kaltim 
   Kampisky Kamyk Kaptenen Kaptenerna Karaarslan Kark Kartagena Kasty 
   Kasuang Katipunan KBA KBC Kebiya Kenlong Kerasus Kibe Kiko Kings 
   Kjelskos KK Klasik Klio KMC Knösel Kodin Kohoch Koiraperhe Kokoelma 
   Kolbasti Kombinasi Komleposs Kopru Kordam Kormoran Korsikalý Kortai 
   Kosing Kote Koukouselis KrASK Kratos Krem Kritik Ksenia KSOS Kultur 
   Kuzeyata Kvazar Kwai Kwiecisty

   Lacznosc Lahjattomat LAKT Laleler Lancia Langy Laplas Laposte Lataka 
   Lateria LatSwe LBC LBSK LCF Legeanka Lema Lemanus Lemoss Lenz Leo
   Leones Lepsi Lesh Letve Levant Leveni Lianas Liban Liberty Lillebaluba 
   Lio Lipa Lira Liro Livius Ljónin LNWers Lo Loaknath Lolly Loluda 
   Longzhu Lorin LOS Loti Lowel Löparn LPMS LTC Lupii LXA Lyubcho Lyuil 
   LZSS

   Maca Maestro Magenta Magistrati Mahoscay Makara Makriköy MALE 
   Malmölaget Mamalire Manucho Marieli Marosamitawa Marpalaki Marron 
   Marynarz Masal Matujona Mavilo Mavs Mayamira Mazeto MBSK Mer Mercury 
   Mesna Mey MFF MGM MGTH MHDlev MHMS Milus Minerva Minut MMRMC MNEPO 
   Mochu Monaconf Monas Monperi Morot Mostingan Mountain Movember 
   Mölnlycke MPEC MRSMC Mufreze Mutos Muumio Mýna Møremix 

   Nadide Nambawan Narbisk Naresuan Narre Nautilus Navjyoti Nawrot Nayaka 
   Naytingel Nebbinn Necos Neduk Nessuno NIB Nikotiimi Nislije NMRT 
   Nokon Nonage NoNed Nopasaran Noralia Norsu NOS Noto Nova Novo NPP 
   NRC NSK NTiosagutta NTTW Nula

   Obezit Obezyum Objectivity Oceania Odwoj OEI Ogama Ognisty Oksijen 
   Olimp OMC Omega Omelas Onnela Onu Oprosti Opustoshitelite Orakulas 
   Orfoz Orion OSA Osam OSMO Oto Otta Oyzum Ozbiljni

   Öncü

   Pagonia Palapa Palcan Palukas Panteros Paragon Pasam Pasanci Pass 
   Passé Patagonia Paulistas Pawkol PBL PCBA PDC Pennant Perjuangan 
   Petras Phelcyldrm Phoenix Piast Pikonlu Pingo Piryoli Piqwiz Piro 
   Pisoy Pjäxa PKM Pleemar Pleschi Pleyada Plia PMC PMS Poasp Pobeditel 
   Pojat Pokoman Polirish Polonez Polus Pompapompa PomSonata Ponks 
   Poptoom Portalia Portos Portugalês Poss Pottkieker Prapar Prasetya 
   Preservasi Prijatelj Prim Primabridge Prosan Proto PSV Ptacol PTK 
   PTT Pude Puente Pyon Pyton PZIM 

   QLJB Quantum Quartet

   Radca Radeks Radhey RAG Raifles Raiga Rakinnett RAM Rams RASH 
   Raskasammen RBP Recaptan Reconstruction Redouble Regeldur Relation
   Rem Rembros Resi Respect Rest Revuelta Riba Ribitas Rich Rio RKK 
   Rofoi Romamiami Rosajora Royston Rozle RPG RPIH RS Rüya RVG Rylai 
   Rylal Ryo Rys

   Sabari SAGG Salost Salvo Sammarty Sampicann Sandfia Sangam Sansouci 
   SANY Sargam Sarj SaTu Saty SaX Sbamby Sbanda SBC SBS Scapros 
   Schmuckles Scorway Scot SDK Senaattorit Sensei Sepuluh SFG SGG Shan 
   Shaoshen Sherdils SHHG Shinpi Shiraz Sigdonnemann Sigma Sihai 
   Sikorka Silbersee Silpersnanev Simpleksas Sinantos SinPhi SISU 
   Sivves Siyabend Sjunjuang Skaffatar Skalman Skam Skaronga SKB 
   SKBS Skol Skotii SKR Skurets Þlem Slostria Sky Sly SMBC SMJ SMK 
   Smysio SNAP SNP Soba Sober Sobers Sogn Soley Solo Sommai Sonchel 
   Soumitra Spaima Spamirs Spandan Sparta Spartak Spektr Spin Spring 
   SQR Srimapuna Sriwijaya Srykeir SSAB SSBC SSSR Stafani Stagge 
   Starka Starsbridge STB Steinars Steinlager STG Strata Strela 
   StZ St?vel Sucharek SuHuQiaoYou Sukhothai Superformiweldig 
   Südwest SweDanes Sweece SweNed SweNor Swest SWOP SXPEONY Syabas 
   Sydsydvest SYL Syly Synsyn SYSS Sysyt SYT Szaika Szlem SZPAK 
   SZPAR Szpilki Sør Sørlendingane

   TAC Take Takk Takým Taksim Tally Tangra Task TBA TBRT TBW Tefo 
   Teraz Tianya Tiglatpalasar Tihkur Tiz TNT Toar Todremor TOFO 
   Tollemache Tongxin Toopet Topozero Topping TOPS Toranaga 
   Tornatae Totani Totoro Toyota Tömör TPI Traker Triks Troll 
   Trump Trøndermøringen TSDB TTIM Tuason Tubi Tulipano Turuncu 

   UAB Udarnik Úlfurinn Ultraneglinka Underberg Upos Urcsus Uski UTU

   VAJM Vahaboðlu Vahakabinetti Vajra Vakrandi Valen Valyo Vanko Varan 
   Varoslu VarSofWar Vasallid Västanfläkten Vedic Veegees Vega* Veggen 
   Verder Verons VFJ Vicho Vilmar Vilttiketju Vilttiukko Viña Visnelik 
   Viva Voff Volqueteros Volta VQP Vucko Vurgun Vürst Vytas

   Walec Wanghong Watt WBack WBBA WBFIT WBG WBGO WDP Wega Weiqun Wengens 
   Winatalya WinBridge Winterfell Wiz WLKP Wolf WSWT Wynn

   Xatzopoulos XC XFIP Xinhai XMing XXXYXXXY XYZ

   Ybs YBM YBO YBT Yaðmur Yamata Yansimasiz YeJun Yildizlar Yogakshema 
   Yokozuna YSD Yuanlong Yuma Yuzbir YYD YYY

   Zabavljaci Zaehringens Zamek Zamer Zana Zang Zapata Zaraz Zeyno 
   Zhihaole 
   Zimba Zimmkonis Zivac ZKS Zmaj Zozoura Zurzits Zvanger Zwederland 
   Zweili

   Øssur
);

my %SINGLE_TYPOS =
(
  'Ace Metes' => ['acemates'],
  Acolvik => ['acolvick'],
  'Alunand Plus' => ['alunand'],

  'Besli Major' => ['beslimajor'],
  Bhinneka => ['bhineka', 'bhinneke'],
  Boriana => ['boryana'],

  Chikorita => ['cikorita'],
  Cicek => ['cýcek'],

  Darff => ['darfff'],
  Dasky => ['daski'],
  Diazem => ['dýazem', 'dýyazem'],
  Dilligaf => ['dilligraf'],
  Dingyuan => ['dinyuan'],
  Dinozorlar => ['dýnozorlar'],
  Dolphin => ['dolfin'],

  Egetor => ['egator'],
  Eikka => ['eikkaa'],
  'El Gezira' => ['elgezira'],
  Elit => ['elýt'],
  'Eviza Plambata' => ['plambata'],
  Express => ['expres'],

  Feszek => ['Fészek'],
  Fevbazi => ['fevzabi'],

  Gelin => ['gelýn'],
  Göktürk => ['gokturk'],

  Haziran => ['hazýran'],
  Hypochondriac => ['hýpokondrýyak'],
  'HZ Connection' => ['hzconnection'],

  'Ji Jin' => ['jijin'],
  Jobilato => ['jobalito'],
  Juls => ['julst'],

  Kibe => ['kýbe'],
  Kaptenen => ['kapten'],
  'KOC67' => ['koç67'],

  Lacznosc => ['lacznasc'],
  'Late S.S. Jain' => ['lssjain'],
  'Le Romain boys' => ['leromain', 'leroumain'],
  Lemanus => ['lémanus'],
  Leveni => ['levini'],
  'Logos GPS' => ['logos'],
  Lorin => ['lorýn'],
  'Loy Krathong' => ['longkatong'],
  Löparn => ['loparn'],
  'Lupii Galbeni' => ['lupiigalbeni'],

  'Meng Qing Xin' => ['mengqingxin'],

  'Nav Chaitanya' => ['navchaitanya'],
  Naytingel => ['naytengel', 'naitingel'],

  Olimp => ['olymp'],

  Pagonia => ['pagonya'],
  Pass => ['paaass'],
  Patagonia => ['patagonya'],
  Paulistas => ['paulistanas'],
  Phoenix =>['pheonix'],
  Pikonlu => ['pikonli'],
  Pleemar => ['plemaar'],
  'Polar Star' => ['polarstar'],
  Prasetya => ['prasetia'],
  "President's Team" => ['president', 'presidents'],

  Quantum => ['qantum'],

  Raiga => ['raica'],
  'Ram Charan' => ['ramcharan'],
  Redouble => ['recontra'],

  'Sanna Kathrine' => [
    'kathrineföljarna',
    'sannaKathrine', 
    'sannakathrineföljar',
    'sannaakathrinefölja'],
  'Sarunta Toar' => ['sarunta'],
  Scorway => ['scoreway'],
  'Sham Sharma' => ['shamsharma'],
  Sigdonnemann => ['sigdonneman'],
  Skotii => ['skoti'],
  Soumitra => ['soumtra'],
  Spamirs => ['spamýrs'],
  'Stall Dieden' => ['dieden'],
  Syabas => ['syahbas'],

  Tornatae => ['torentae', 'torantae', 'tornatau', 'tornatoae'],

  Valyo => ['valýo'],
  Vedic => ['vedik'],
  Vürst => ['vuerst'],

  'Wei De' => ['weide'],

  'Xin Yuan' => ['xinyuan'],

  Yogakshema => ['yogakhema', 'yogakshem'],

  Zvanger => ['zvunger'],
  Zwederland => ['zwenderland']

);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
