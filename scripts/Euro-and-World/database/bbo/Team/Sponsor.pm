#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Team::Sponsor;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_sponsor set_hashes);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '101 Fasteignasala',
  "A-Media Sieradz",
  'Abadi Adimulia',
  'Adaro Energy',
  'Advisor Revisjon Norge',
  'Agsar Paints',
  'AJ Diament',
  'Alfa Romeo',
  'Alfa-Compensa Gdynia',
  'Aliaga Kyme',
  'Andromeda Baroda',
  'Ant Teknik',
  'APRA Clothing',
  'Apreo Logistic Poland',
  'Asindo Prima',
  'Astro A/S',
  'Atlantic Trade',
  'Balcova Termal',
  'Baltic Express',
  'Bangkok Bank',
  'Bangur Cement',
  'Bank Indonesia',
  'Bank Mandiri',
  'Bank Negara Indonesia',
  'Bank Tabungan Negara',
  'Baroda Bank',
  'Beijing Capital',
  'Beijing Cartoon',
  'Beijing Dazhong',
  'Beijing Evertrust',
  'Beijing Huayuan',
  'Beijing Hull Technology',
  'Beijing Jinghua',
  'Beijing Lawyers',
  'Beijing Liuhe',
  'Beijing Longxin',
  'Beijing Railway Bureau',
  'Beijing ShouChuang',
  'Beijing Trinergy',
  'Beijing Wan Jia',
  'Beijing Yue Ze',
  'Beijing Yindi',
  'Bengkalis PT',
  'Bokadirekt SE',
  'Bozzetto Azzurro',
  'Breki Jarðverk',
  'Bridge i Norge',
  'bridge24.pl',
  'BridgeBertheau.com',
  'Bridgefélag Reykjavíkur',
  'Bridgemagasiner.no',
  'BridgeYes.com',
  'Bridge Winners',
  'Brink Plast',
  'Bústólpi ehf',
  'Cai Fu Zheng Quan',
  'Cap Gemini',
  'Caretta International',
  'Carlo Bossi',
  'Central Secretariat',
  'Century Insurance',
  'Chateau Rossenovo',
  'Chennai Online',
  'China Evertrust',
  'China Finance',
  'China Global Times',
  'China National Petroleum Corporation',
  'China Ping An',
  'China Renshou',
  'China Resources',
  'China Trinergy',
  'Chinese Hailian',
  'Construction Kielce',
  'Consus Carbon',
  'Consus Oil',
  'Dalian Dichan',
  'Dama Kupa',
  'Darles Santerm',
  'Data Steel',
  'Dauna Winaza',
  'Dhampur Sugar',
  'Dian Zi Cheng',
  'Djarum Black',
  'Dobre Zegary',
  'Doga Naturale',
  'domwaluty.pl',
  'Dongfang Tairong',
  'E-Service',
  'Eden Realty Kolkata',
  'eDOT Goa',
  'Eko-Al',
  'Elektromonta¯',
  'Euro Agro',
  'Electric Center',
  'Elektrik P3B',
  'Falck Medical',
  'Fanhua Jituan',
  'Fantoni Vacations',
  'Ferðaskrifstofa Vesturlands',
  'Fisk Seafood',
  'Fora Lastik',
  'forumbridge.pl',
  'FX Securities',
  'Garðar & Vélar',
  'Garðs Apotek',
  'Garsu Pasaulis',
  'Geely Automobile',
  'Geo Kideco',
  'Geo Pertamina',
  'Geo Timah',
  'Geo Vale',
  'Geologi Banpu',
  'Geoportal Kutai Kartanegara',
  'Godfrey Phillips',
  'Gong Hang Jin Ying',
  'Guangdong Huachu Chemicals',
  'Guangzhou Hongmian',
  'Guangzhou Huachu Chemicals',
  'Guangzhou Pearl River',
  'Guiyuang Bank',
  'Haerbin Bingxue',
  'Hai Long',
  'Hainan Shichuang',
  'Hainan Window',
  'Hangzhou Jinjiang',
  'Heilongjiang Tea',
  'Heng Yuan Xiang',
  'Hengsha Haijiu',
  'Hengsha Ke Ji',
  'HF Verðbréf',
  'Hong Kong Vico',
  'Hong Zhu',
  'Hotel Senator',
  'Hotell Strand',
  'Hreint ehf',
  'Huangshi Qixing',
  'Hubei Dongfeng',
  'Hubei Yihua',
  'Hunan Tou Zhan',
  'Iceland Express',
  'Inci Ayakkabi',
  'India Glycols',
  'Indian Medical',
  'Indian Oil',
  'Indian Overseas Bank',
  'Indian Railways',
  'Indonesian Power',
  'ING Bank',
  'Interbud Plock',
  'Jain Group',
  'Jasa Marga Jakarta',
  'Jiang You',
  'Jilin Dingyuan',
  'Jin Rong',
  'Jin Jing',
  'Jing Tie',
  'JP Morgan',
  'Kare Dam',
  'Kaushik Hyderabad',
  'KH Power',
  "Kini's Bangalore",
  "Kini's Goa",
  'Klika Murcki',
  'Kombi Tondano',
  'Konga-Väster',
  'KONKRET Chelmno',
  'konkurs.no',
  'Kosmos Delhi',
  'Krishnapatnam Port',
  'Kuncheng Group',
  'Kurt-Royce',
  'Lag os',
  'Latteria TS Rzepin',
  'Lianzhong Shi Jie',
  'Logi Smart',
  'Lögfræðiskrifstofa Islands',
  'Lögfræðistofa Bjarna',
  'Lu Cheng',
  'Lu Ning Coal',
  'Lupo Veloce',
  'Lv Hua',
  'Mai Zi Fu Shi',
  'Málning hf',
  'Mandiri Minahasa',
  'Magpa-Grup',
  'Maksoy-Deniz',
  'Mayur Renergy',
  'MB-Transit',
  'Mech-Ok',
  'Meditepe Tip',
  'Mega-Tech',
  'Mei Kuang',
  'Meilin Qing Cheng',
  'Mitra Buana',
  'Moscow Sunday Times',
  'Mutiara Energy',
  'Nanfang Dianwang',
  'Nanguang Power',
  'Nanning Yalun',
  'Nest Inn',
  'Nimbusz',
  'Nong Fa Hang',
  'Nordfyns Finans',
  'Nordic Security',
  'Novi Kod',
  'OCI Copper',
  'OICO Maesa',
  'Oly-Star',
  'Orbis Investment Management',
  'PD Real Estate',
  'PD Times',
  'PD Transnational',
  'Palma Karya Mandiri',
  'Pan China Construction',
  'Penajam PU',
  'Perbankan Jatim',
  'Pharma Plus',
  'Poddar Developers',
  'Poddar Housing',
  'PRI Investment',
  'PU Bitung',
  'PU Minsel',
  'PU Sulut',
  'Perusahaan Listrik Negara',
  'Qingnian Qiche',
  'Quik Tea',
  'Phoenix TV',
  'Polarman Regnskap',
  'Ponar Unia',
  'Pro Consul',
  'PLN Suluttenggo',
  'Prestige Development',
  'PT Bayu Buana Gemilang',
  'PT Bumi Siak Pusako',
  'Ragn Sells',
  'Red Bull',
  'Red Cotton',
  'Rigainvites.lv',
  'Rio-Sampa',
  'Ronke Camping',
  'Rosa dei Venti',
  'Russian Sunday Times',
  'Ryan Express',
  'SAIC VW',
  'Samadhan Academy',
  'Samtronic Constanta',
  'San-Sac',
  'San Chen',
  'San Yutian',
  'Sanliurfa Tarim',
  'Sanya Jiguan',
  'Sanya Tianze',
  'SAPW Poland',
  'Sarunta Waya',
  'Scania Bridgekonsul',
  'SD Associates',
  'SD Enterprises',
  'See Fah/Thai',
  'Semangat Baru Makassar',
  'Semen Gresik',
  'Shan Hai',
  'Shanghai Automobile',
  'Shanghai Financial',
  'Shanghai Gaohe',
  'Shanghai Jiahua',
  'Shanghai Jinchang',
  'Shanghai Ling Mu',
  'Shanghai Municipal Engineering Group',
  'Shanghai Qiche',
  'Shanghai Qihao',
  'Shanghai Qi Zhong',
  'Shanghai Weiyu',
  'Shanghai Zhongfu',
  'Shanxi Luning',
  'Shanxi Qinlian',
  'Shen Jiu',
  'Sheng Tao Sha',
  'Sheng Yu Tian',
  'Sheng Yuan',
  'Shenzhen Electronic City',
  'Shenzhen Lanpu',
  'Shenzhen Nangang',
  'Shenzhen Ping An',
  'Shenzhen Qiayao',
  'Shenzhen Topone Car',
  'Shi He Dong Li',
  'Shi You',
  'Shiji Changda',
  'Shree Cement',
  'Shree Radhey',
  'Sichuan Dahe',
  'Siwik Holiday Mragowo',
  'Siwik Intertrade',
  'Skinney-Þinganes',
  'Société Générale',
  'Sölufélag Garðyrkjumanna',
  'Son Dakika',
  'Sparisjóður Keflavik',
  'Sparisjóður Norðfjörður',
  'Sparisjóður Siglufjarðar',
  'Spasso Food',
  'SPS Construction',
  'SR Group',
  'Staryi Master',
  'Statu Denizcilik',
  'Sunchime Cartoon',
  'Sunchime Fund',
  'Sung Tao',
  'Suzhou Youtong',
  'Swara Kita',
  'SY Sheng Yutain',
  'Syabas Energy',
  'Sygnity',
  'Synergia Lublin',
  'TAM Dabrowa',
  'Tannlege Kvaran',
  'Taste of Goa',
  'Team Audita',
  'Team PharmaService',
  'Team Secure',
  'Telkom Groovia',
  'Telkom IndiSchool',
  'Telkom Indonesia',
  'Telkom Jabar',
  'Telkom Jakarta',
  'Telkom Speedy',
  'Telkom UseeTV',
  'Telkom@wifi.id',
  'Thai Oil',
  'TianJin JS2',
  'Tielu Jixie',
  'Tin Fok',
  'TJ Jabung Brt',
  'Tolani Shipping Ltd',
  'Trambak Rubber',
  'Tricon Infotech',
  'Triglav Osiguranje',
  'TTK Healthcare',
  'TVS Tread',
  'Unia Leszno',
  'Unia Winkhaus',
  'Unia Sygnitas',
  'UTI Bank',
  'VBS Fjárfestingarbanki hf.',
  'Vestel',
  'Vidbot ehf',
  'Viego Regnskap',
  'Vinex Preslav',
  'Viru Valge',
  'VVE Beheer',
  'Wuhan Dongfang',
  'Xiamen Xiashun',
  'Xiao Ying',
  'XP Digital',
  'Yalu Group',
  'Yeh Bros',
  'Yibin China Resources',
  'Yi Tong',
  'YOU Singapore',
  'Yufeng Electric',
  'Yunnan Dikuang Resources',
  'Yunnan Tongya',
  'zagraj.pl',
  'Z-Tech',
  'Zhe Da Wang Xin',
  'Zhejiang Jingfan',
  'Zhejiang Jinjian',
  'Zhejiang Xinxiang',
  'Zhenjiang Hanbang',
  'Zhong Guo Ren Bao',
  'Zhong Liang Y LW',
  'Zhong Yuan',
  'Zhongshan Jiegao',
  'Zhongtong Jiangsu',
  'Zhu Jiang'
);

my %MULTI_TYPOS =
(
  'Abadi Adimulia' => ['abadi adi mulia', 'abadi adimulya'],
  'Adaro Energy' => ['geo adaro'],
  'Agsar Paints' => ['agsar pints'],
  'AJ Diament' => ['aj diamonds', 'diament'],
  'Alfa-Compensa Gdynia' => ['alfa gdynia'],
  'Apreo Logistic Poland' => ['apreo logistic pol', 'apreo logistic pola'],
  'Asko-Tech' => ['asco tech', 'asko tech', 'asko-tech'],
  'Atlantic Trade' => ['atlantic grupa', 'antlantic trade'],
  'Baltic Express' => ['baltic expres'],
  'Bangur Cement' => ['bangur cements', 'bangur cment'],
  'Bank Tabungan Negara' => ['bank btn'],
  'Baroda Bank' => ['baroda bang'],
  'Beidike' => ['bei di ke'],
  'Beijing Wan Jia' => ['bei jing wan jia'],
  'Beijing Huayuan' => ['beijing hua yuan'],
  'Beijing Hull Technology' => ['beijing hull tech'],
  'Beijing Railway Bureau' => ['beijing ry. bureau'],
  'Beijing ShouChuang' => ['bj shouchuang'],
  'Beijing Trinergy' => ['beijing trinergyy'],
  'Beijing Yue Ze' => ['bei jing yue ze'],
  'PU Bitung' => ['bitung pu'],
  'Breki Jarðverk' => ['breki jarðverk ehf'],
  'bridge24.pl' => ['bridge 24', 'bridge24', 'bridge24pl', 'bridge24_pl'],
  'Bridgefélag Reykjavíkur' => ['bridgefélag Reykjav'],
  'Bridge Winners' => ['bridge winner', 'bridgewinners.com'],
  'Cai Fu Zheng Quan' => ['cai fu'],
  'Caretta International' => ['caretta int'],
  'China Finance' => ['china finance ba'],
  'China Ping An' => ['zg pingan', 'zg  pingan', 'china pingan',
    'ping an'],
  'China Resources' => ['cr power', 'china res. power', 'cr enterprise',
    'cr_ power'],
  'Chateau Rossenovo' => ['chatteau rossenovo', 'chatteu rossenovo',
    'chaetou rosenovo', 'shato rosenovo', 'shato rossenovo'],
  'China Global Times' => ['chinal global times', 'huan qiu Shi bao'],
  'China Trinergy' => ['chinatrinergy'],
  'CONNECTOR' => ['aj-connector', 'aj connector'],
  'Data Steel' => ['datta steel'],
  'Dhampur Sugar' => ['dhampur sugar mills', 'dhampur sugars', 
    'dhampur suger mills', 'dhampor sugar mills', 'dhampu sugar mills',
    'sugar mills'],
  'Djarum Black' => ['djarum black capp', 'djarum black mild'],
  Djarum => ['djarum la', 'djarum mld'],
  'Dobre Zegary' => ['dobre_zegary', 'dobrezegary.pl'],
  'domwaluty.pl' => ['domwaluty_pl'],
  Dongfeng => ['dongfeng automobile', 'dong feng', 'dongfeng qiche'],
  EcoSoft => ['eco soft'],
  'Eden Realty Kolkata' => ['eden city', 'eden city kolkata',
    'eden reality kolkat'],
  'Eko-Al' => ['eko al', 'eko_al'],
  Elastron => ['elastron (taurus)'],
  'Elektrik P3B' => ['elektrik merapi', 'electric merapi'],
  'Falck Medical' => ['falck med'],
  'Fanhua Jituan' => ['fan hua'],
  'Fantoni Vacations' => ['fantoni vacation', 'fantoni vacatiosn'],
  'Ferðaskrifstofa Vesturlands' => ['ferðask. vesturl.',
    'ferðaskrifstofa ves'],
  'forumbridge.pl' => ['forumbridge_pl'],
  'Garðar & Vélar' => ['garðar & vélar ehf.', 'garðar og vélar',
    'gardar og velar'],
  'Garðs Apotek' => ['garðs apótek', 'garðs apoótek', 'garps apótek'],
  'Geely Automobile' => ['geely auto', 'gely auto', 'chaina geely',
    'china geely', 'jili', 'china geely auto', 'jili qiche', 'ji li'],
  'Geo Timah' => ['geo tima', 'geologi timah'],
  Geologi => ['badan geologi', 'geo coal', 'geo tanito harum'],
  'Geologi Banpu' => ['geo banpu'],
  'Godfrey Phillips' => ['gofrey phillips'],
  'Gong Hang Jin Ying' => ['gonghang jinying', 'jin ying club',
    'jin ying', 'gonghang jinying'],
  'Guangdong Huachu Chemicals' => ['g.d. huach', 'guang dong hua chu'],
  'Guangzhou Huachu Chemicals' => ['gz huachu chem'],
  'Guangzhou Pearl River' => ['gz pearl river', 
    'guangzhou pearl river development'],
  'Guiyuang Bank' => ['gy yinhang'],
  'Hangzhou Jinjiang' => ['hangzhou jingjiang'],
  'Hengsha Haijiu' => ['hengsha jiuhai'],
  'Hengsha Ke Ji' => ['heng sha ke ji'],
  'HF Verðbréf' => ['h.f. verðbréf'],
  'HNA' => ["hna's"],
  Huayuan => ['hua yuan'],
  'Hubei Dongfeng' => ['hb dongfeng', 'hu bei dong feng qi'],
  'Hunan Tou Zhan' => ['hn  tuozhan'],
  Lavazza => ['il bridge - lavazza'],
  'India Glycols' => ['india glycol', 'india glycols ltd.',
    'india glyclos', 'indian glycols'],
  'Indian Medical' => ['indian medical asso'],
  'Indian Railways' => ['indianrailways', 'indian railyaws',
    'indin railways', 'indian railway', 'indian rail', 'indians railways'],
  'Indonesian Power' => ['indo power', 'indonesia power',
    'elektrika ind power', 'elektrika bc', 'i p'],
  'ING Bank' => ['ng bank'],
  'Jasa Marga Jakarta' => ['jasa marga'],
  'Kaushik Hyderabad' => ['kaushik hyd.'],
  'KH Power' => ['k h power'],
  "Kini's Bangalore" => ["kini's bengalore"],
  "Kini's Goa" => ['p.keni goa'],
  'KONKRET Chelmno' => ['konkret che³mno'],
  'Krishnapatnam Port' => ['krishnapatam port'],
  'Kuncheng Group' => ['kucheng group'],
  'Latteria TS Rzepin' => ['Latteria ts rzeppin',
    'latteria t-s rzepin', 'latteria rzepin'],
  'Lögfræðiskrifstofa Islands' => ['lögfr.stofa íslands', 'lögfr.íslands', 
    'lögfrst. íslands', 'lögfrst.íslands', 'lögfræðisk. ísl.',
    'lögfræðiskrifst. ís', 'lögfræðist. ísl.', 'lögfræðisk. ísl.',
    'lögfræðist. ísl.', 'lögfræðist. íslands', 'lögfræðist.íslands',
    'lögfræðistofa ísl', 'lögfræðistofa ísl.'],
  'Lögfræðistofa Bjarna' => ['lögfr.st bjarna', 'lögfr.stofa bjarna',
    'lögfr.stofa ´bjarna'],
  'Magpa-Grup' => ['magma-grup'],
  'Málning hf' => ['målning hf'],
  'Meditepe Tip' => ['medýtepe tip', 'meditepe týp'],
  Modalfa => ['modalfa/umw'],
  'Mutiara Energy' => ['mutiara energy indo', 'mutiara energi indo',
    'mutiara energi p.', 'mutiara energi.p'],
  'Nanfang Dianwang' => ['nan fang dian wang', 'dian wang'],
  'Nanyuan' => ['nan-yuan'],
  'PD Times' => ['p d times', 'pd shidai', 'pd  shidai'],
  'Pan China Construction' => ['pan-china const', 'pan china construct'],
  'Pan China Group' => ['pan-china group'],
  'Perbankan Jatim' => ['perbankan_jatim'],
  'Pertamina' => ['pertamina ep', 'p-ep', 'pertamina ft', 
    'pertamina field', 'pertamina ge', 'pertamina indonesia', 
    'pertamina l.', 'pertamina field tmb'],
  'Phoenix TV' => ['feng huang wei shi', 'fenghuang tv'],
  'Poddar Developers' => ['poddar development', 'poddar dev',
    'podder dev', 'podder developers', 'poddar devekopers',
    'poddar dovelopers'],
  'POLFA' => ['polfa wzbs'],
  'PT Bayu Buana Gemilang' => ['pt bbg'],
  'PT Bumi Siak Pusako' => ['pt.bumi siak pusako',
    'bumi siak pusako', 'pt bsp'],
  Pufa => ['pu fa'],
  'Ragn Sells' => ['ragn-sells'],
  'Ryan Express' => ['ryan_express'],
  'Samtronic Constanta' => ['samtronic ct'],
  'Sanliurfa Tarim' => ['urfa tarim'],
  'Sanya Tianze' => ['san ya tian ze'],
  'SAPW Poland' => ['sapw-poland'],
  'See Fah/Thai' => ['seefa/thai'],
  'Semangat Baru Makassar' => ['semangat baru mks', 'semangat baru mks.',
    'semangat br', 'semangat baru', 'semangat baru mksr',
    'makassar semangat b'],
  'Shanghai Automobile' => ['shanghai automoblie', 'sh  qiche',
    'sh qiche'],
  'Shanghai Changyu' => ['sh chuangyu'],
  'Shanghai Gaohe' => ['shanghai gaowe'],
  'Shanghai Jiahua' => ['shanghai jia hua'],
  'Shanghai Ling Mu' => ['ling mu'],
  'Shanghai Qiche' => ['shanghai qi che'],
  'Shanghai Qihao' => ['sh qihao'],
  'Shanghai Qi Zhong' => ['shang hai qi zhong'],
  'Shanghai Zhongfu' => ['shang hai zhong fu'],
  'Shanxi Qinlian' => ['shan xi qin lian', 'shanxi qinlian',
    'qin lian club', 'qin lian'],
  'Shenzhen Nangang' => ['shen zhen nan gang', 'shenzen nangang',
    's.z. nangang power', 'nangang dongli', 'shenzeh nangang', 'nan gang'],
  'Shenzhen Ping An' => ['shen zhen ping an', 'shenzhen pingan'],
  'Shenzhen Topone Car' => ['shenzhen topone', 'sz topone car'],
  'Shiji Changda' => ['chang da', 'shijichangda', 'shi ji chang da'],
  'Shree Cement' => ['shre cement', 'shree cements', 'sree cement',
    'sri cements', 'shree ceement'],
  'Shree Radhey' => ['shree radhye', 'shri radhey', 'shri radheya',
    'sree radhye'],
  'Siwik Holiday Mragowo' => ['siwik holiday bt', 'siwik holiday mrag',
    'siwik mragowo'],
  'Société Générale' => ['societe generale', 'societè general'],
  'Sölufélag Garðyrkjumanna' => ['sölufélag garð'],
  'Sparisjóður Keflavik' => ['sparisjóður kef'],
  'Sparisjóður Norðfjörður' => ['sparisjóður norðfj',
    'sparisjóður norð.'],
  'Sparisjóður Siglufjarðar' => ['sparisjóður sigl',
    'sparisjóður sigluf', 'sparisjóður siglufj', 'sparisj. siglufjarð',
    'sparisj.siglufj', 'sparisj.siglufjarð',
    'sparisj.siglufjarða', 'sarpisj.siglufjarð', 'spariisj.siglufjarð'],
  'Spasso Food' => ['spassofood'],
  SportAccord => ['sport accord'],
  'SY Sheng Yutain' => ['s.y. shengyutain'],
  'Syabas Energy' => ['syabas energi', 'syabas e'],
  'Synergia Lublin' => ['synergia lubin'],
  'Team PharmaService' => ['pharma service', 'pharmaservice'],
  'Telkom Indonesia' => ['telkom ind indihome', 'telkom indonesia',
    'telkom wifi.id', 'telkom wifi. id'],
  'Telkom Speedy' => ['telkom speedy bpn'],
  Timah => ['pt_ timah limited', 'pt timah limited'],
  'Tolani Shipping Ltd' => ['tolani shipping'],
  'Trambak Rubber' => ['trumpak rubber'],
  'Triglav Osiguranje' => ['triglav osig.'],
  'Unia Sygnitas' => ['unia-sygnitas'],
  'Unia Winkhaus' => ['winkhaus unia', 'winkhaus-unia'],
  'Viego Regnskap' => ['viego regnskap as'],
  'VVE Beheer' => ['vve-beheer'],
  'Wuhan Dongfang' => ['dongfang'],
  'Xiao Ying' => ['xiao ying inn'],
  'Yalu Group' => ['js yalu'],
  'Yeh Bros' => ['yeh brothers', 'yer bros', "yeh's bros", 'yehs bros',
    'yer bros', 'yeoh bros'],
  'Yibin China Resources' => ['yibin cr gas', 'yibin china resourc'],
  'Yunnan Dikuang Resources' => ['yunnan dikuang', 'yun nan'],
  'zagraj.pl' => ['zagraj pl'],
  'Zhejiang Huamen' => ['zhe jiang hua men', 'hua men'],
  'Zhejiang Jingfan' => ['zj jingfan', 'jing fan club', 'jin fan',
    'jing fan'],
  'Zhongshan Jiegao' => ['zhong shan jie gao'],
  'Zhongtong Jiangsu' => ['zhongtong js']
);

my @SINGLE_WORDS = qw(
  ABAX Abnegat Accenture Actavis Aerospace AIA Akaylar Akebono
  Aklindo Allianz Altinay Aquatrans Arboned Argento Arkas Arma 
  Artotec Asindo Avia Ayýntab

  Bajaj Baykar Beibao Beidike Bnerg BridgePlus Budimex

  Cable Candyland Cempaka Changyu Chemikartel Chlodnia Chuanmei 
  Cimentas COMAL Compensa Computerland CONNECTOR CONSUS Constellation 
  Continental Copia Cosmos

  Datang Denizgucu Dermika Derofe Dianwang DISKI Djarum 
  Dongfeng Dostlar Druva

  EcoSoft Effcontrol Eimskip Eksprompt Elastron Elektrika Elektrociepl
  Energetyk Enorma Enterprise ESSO Evertrust

  Fatek Forta Frissan Funbridge

  GAMAX Gazprom Generali Geologi Genkad Gevalia Gillette Gomad 
  Gözgöz GSE

  Hana Harke Haustak HCL HNA Honesta Hongyu Huachu Huayuan

  IBM IMAX Impress Indoarsip Intan Inteligent Interface Interkala

  Jetox Jiegao JHS Jinfan Junibacken

  Kadimex Kancelaria Kayseria Kilogrupp Konstanta Kvika

  Lacznosc Laima Lavazza LCG Lianbo Likom Longjiangfu Lukomorie 
  Lyfjaver

  Makus Malkia Manyavar Melchemie Mireo Modalfa Morgunblaðið 
  Multicoms Myndform

  NALCO Nanyuan Navachaitanya Navayuga Nazwa NEC Nefka Niewiem Nongken 
  Norco Nortemp NOTUS Näkösoppi

  Ozyuva

  P2TEL Paulaner Pealinn Penline Pertagas Pertamina Petroconas Pexis 
  Petro Pharon Pimara POLFA Praterm Printerikeskus Pufa Pusula

  Qiaoyou

  Raam Radex Ráðgjöf Ravebo Relpol Ruyi Ryka

  Sagaplast Samsung Scandic Scania Sehati Sevtopolis Shichuang Shimuzu 
  Shouchuang Signity Skeljungur Solakoglu Solox Sparisjóður 
  SportAccord Srenniw SSDA Stalgast Stiga Struma Synective

  Tekser Telkom Termika Termoavion Termochem Timah Topeko Transearly 
  Tricon Tridaya Tryggingamiðstöðin Tsingtao Tundem Twentebelt
  Tyco Tzilis

  UMW Unibet Unicat

  Velbazhd Velbujd Videocon Vinabær Virnet VÍS Visoft Vito Vyceska

  Wellknit Wellwise Wise

  Yuetao

  Zhaoeng Zhonghai Zolza
);

my %SINGLE_TYPOS =
(
  'Adaro Energy' => ['adaro'],
  'Advisor Revisjon Norge' => ['advisor'],
  'Agsar Paints' => ['agsar'],
  'Alfa-Compensa Gdynia' => ['compensa'],
  'Bank Negara Indonesia' => ['bni'],
  'Bank Tabungan Negara' => ['btn'],
  'Beijing Trinergy' => ['beijingtrinergy'],
  'Bengkalis PT' => ['bengkalis'],
  'BridgeBertheau.com' => ['bridgebertheau', 'bridgeberteau'],
  'Carlo Bossi' => ['carlobossi'],
  'Chateau Rossenovo' => ['rossenovo', 'rosenovo'],
  'Chennai Online' => ['chennaionline'],
  'China Ping An' => ['chinapingan', 'zhongguopingan', 'pingan'],
  'China National Petroleum Corporation' => ['cnpc'],
  Cimentas => ['çimentaþ'],
  Computerland => ['computerlan'],
  CONNECTOR => ['conector'],
  'Data Steel' => ['datasteel'],
  'Dhampur Sugar' => ['dhampur'],
  DISKI => ['dsi', 'dsý',],
  Eksprompt => ['ekspromt'],
  'Elektrik P3B' => ['elektrik', 'electric'],
  Elektrika => ['elektric'],
  'Fanhua Jituan' => ['fanhua'],
  'Garðs Apotek' => ['garðsapótek'],
  Geologi => ['geo'],
  'Geoportal Kutai Kartanegara' => ['geokutaikartanegara',
    'geo kutai kartanegra'],
  Gevalia => ['gevalía'],
  Gillette => ['gilette'],
  'Gong Hang Jin Ying' => ['jinying'],
  Gözgöz => ['gozgoz'],
  'Guangzhou Hongmian' => ['guangzhouhongmian', 'hongmian'],
  'Guangzhou Pearl River' => ['guangzhoupearlriver', 
    'guangzhouperalriver'],
  'Heng Yuan Xiang' => ['hyx'],
  'Hong Kong Vico' => ['vico'],
  'Hong Zhu' => ['hongzhu'],
  'Indian Overseas Bank' => ['iob'],
  'Indian Railways' => ['railways'],
  Indoarsip => ['indoarship'],
  'Jasa Marga Jakarta' => ['jasamarga'],
  'Jilin Dingyuan' => ['jilindingyuan'],
  'Jin Rong' => ['jinrongjia'],
  'KH Power' => ['khpower'],
  'Kideko' => ['kideco'],
  'KONKRET Chelmno' => ['konkret'],
  'Kosmos Delhi' => ['kosmos'],
  'Krishnapatnam Port' => ['krishnapatnamport'],
  'Lianzhong Shi Jie' => ['lianzhongshijie'],
  'Magpa-Grup' => ['magpa'],
  'Málning hf' => ['málning'],
  'Meilin Qing Cheng' => ['meilinqingcheng'],
  'Mei Kuang' => ['meikuang'],
  'Mitra Buana' => ['mitrabuana'],
  Multicoms => ['multicom'],
  'Nanning Yalun' => ['nanning yalun'],
  'Nest Inn' => ['nestinn'],
  'Oly-Star' => ['olyster'],
  'Orbis Investment Management' => ['orbis'],
  'Perbankan Jatim' => ['perbankan'],
  'Poddar Developers' => ['poddar'],
  'Pro Consul' => ['proconsul', 'consul'],
  'PU Minsel' => ['minsel'],
  'Perusahaan Listrik Negara' => ['pln'],
  'PT Bayu Buana Gemilang' => ['bbg'],
  'Rigainvites.lv' => ['rigainvites'],
  'SAIC VW' => ['saic'],
  'Samadhan Academy' => ['samadhan', 'samadgan'],
  'Samtronic Constanta' => ['samtronic'],
  'San Chen' => ['sanchen'],
  'SD Associates' => ['sdassociates'],
  'SD Enterprises' => ['sdenterprises', 'sdenterprizes'],
  'Shanghai Automobile' => ['shangqi'],
  'Shanghai Municipal Engineering Group' => ['smeg'],
  'Shenzhen Lanpu' => ['lanpu'],
  'Shenzhen Nangang' => ['nangangdongli', 'nanggang', 'nangang'],
  'Shi You' => ['shiyou'],
  'Shiji Changda' => ['changda'],
  'Shree Cement' => ['shreecement', 'shree'],
  'Sichuan Dahe' => ['sichuandahe'],
  'Siwik Holiday Mragowo' => ['siwik'],
  'Son Dakika' => ['sondakika'],
  'Sparisjóður' => ['sparisjodur'],
  'SPS Construction' => ['sps'],
  'Team Audita' => ['teamaudita', 'audita'],
  'Timah' => ['tima'],
  'Tricon Infotech' => ['tricon'],
  Tsingtao => ['tsingthao'],
  'UTI Bank' => ['utibank'],
  Velbazhd => ['velbuzhd'],
  Videocon => ['videcon'],
  'Viego Regnskap' => ['viego'],
  'Vinex Preslav' => ['vinex'],
  Wellwise => ['wellwiss'],
  'Yeh Bros' => ['yeh', 'yehbros'],
  'Zhejiang Huamen' => ['huamen'],
  'Zhejiang Jingfan' => ['jingfan']
);


sub set_hashes_team_sponsor
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
