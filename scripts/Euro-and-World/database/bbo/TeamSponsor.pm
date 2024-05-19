#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package TeamSponsor;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes_team_sponsor);

use lib '.';
use TeamBBO;

my @MULTI_WORDS =
(
  '101 Fasteignasala',
  'Abadi Adimulia',
  'Adaro Energy',
  'Advisor Revisjon Norge',
  'Agsar Paints',
  'AJ Diament',
  'Alfa Romeo',
  'Aliaga Kyme',
  'APRA Clothing',
  'Apreo Logistic Poland',
  'Asindo Prima',
  'Asko-Tech',
  'Astro A/S',
  'Balcova Termal',
  'Baltic Express',
  'Bangur Cement',
  'Bank Indonesia',
  'Bank Mandiri',
  'Bank Tabungan Negara',
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
  'Cai Fu Zheng Quan',
  'Carlo Bossi',
  'Century Insurance',
  'Chateau Rossenovo',
  'Chennai Online',
  'China Evertrust',
  'China Finance',
  'China Global Times',
  'China Ping An',
  'China Renshou',
  'China Resources',
  'China Trinergy',
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
  'e-bridge',
  'E-Service',
  'Eden Realty Kolkata',
  'eDOT Goa',
  'Eko-Al',
  'Eko-Al',
  'Elektromonta¯',
  'Euro Agro',
  'Electric Center',
  'Elektrik P3B',
  'Falck Medical',
  'Fanhua Jituan',
  'Ferðaskrifstofa Vesturlands',
  'Fisk Seafood',
  'Garðar & Vélar',
  'Garðs Apotek',
  'Garsu Pasaulis',
  'Geely Automobile',
  'Geologi Timah',
  'Geoportal Kutai Kartanegara',
  'Gong Hang Jin Ying',
  'Guangzhou Hongmian',
  'Guangzhou Huachu Chemicals',
  'Guangzhou Pearl River',
  'Haerbin Bingxue',
  'Hai Long',
  'Hainan Shichuang',
  'Hangzhou Jingjiang',
  'Heilongjiang Tea',
  'Heng Yuan Xiang',
  'Hengsha Haijiu',
  'Hengsha Ke Ji',
  'HF Verðbréf',
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
  'Indian Railways',
  'Indonesian Power',
  'Jasa Marga Jakarta',
  'Jiang You',
  'Jilin Dingyuan',
  'Jin Rong',
  'Jin Jing',
  'Jing Tie',
  'K H Power',
  'Kare Dam',
  'Kaushik Hyderabad',
  'KH Power',
  "Kini's Bangalore",
  "Kini's Goa",
  'Klika Murcki',
  'Kombi Tondano',
  'Kong Chou',
  'Konga-Väster',
  'KONKRET Chelmno',
  'konkurs.no',
  'Kosmos Delhi',
  'Kuncheng Group',
  'Kurt-Royce',
  'Lag os',
  'Latteria TS Rzepin',
  'Lianzhong Shi Jie',
  'Lögfræðiskrifstofa Islands',
  'Lögfræðistofa Bjarna',
  'Lu Cheng',
  'Lu Ning Coal',
  'Lupo Veloce',
  'Mai Zi Fu Shi',
  'Málning hf',
  'Mandiri Minahasa',
  'Magpa-Grup',
  'Mega-Tech',
  'Mei Kuang',
  'Meilin Qing Cheng',
  'Mitra Buana',
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
  'PD Real Estate',
  'PD Times',
  'PD Transnational',
  'Palma Karya Mandiri',
  'Pan China Construction',
  'Perbankan Jatim',
  'Pharma Plus',
  'Poddar Developers',
  'Poddar Housing',
  'PRI Investment',
  'PU Minsel',
  'Quik Tea',
  'Red Bull',
  'Red Cotton',
  'Phoenix TV',
  'Polarman Regnskap',
  'Pro Consul',
  'Ronke Camping',
  'Ryan Express',
  'Samtronic Constanta',
  'San Chen',
  'San Yutian',
  'Sanya Jiguan',
  'Sanya Tianze',
  'SAPW Poland',
  'Scania Bridgekonsul',
  'SD Associates',
  'SD Enterprises',
  'Semangat Baru Makassar',
  'Shan Hai',
  'Shanghai Automobile',
  'Shanghai Chuangyu',
  'Shanghai Financial',
  'Shanghai Jiahua',
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
  'Shi He Dong Li',
  'Shiji Changda',
  'Shree Cement',
  'Shree Radhey',
  'Siwik Holiday Mragowo',
  'Siwik Intertrade',
  'Société Générale',
  'Sölufélag Garðyrkjumanna',
  'Son Dakika',
  'Sparisjóður Keflavik',
  'Sparisjóður Norðurland',
  'Sparisjóður Norðfjörður',
  'Sparisjóður Siglufjarðar',
  'Spasso Food',
  'SPS Construction',
  'SR Group',
  'Sunchime Cartoon',
  'Sunchime Fund',
  'Suzhou Youtong',
  'Syabas Energy',
  'Sygnity',
  'Synergia Lublin',
  'Taste of Goa',
  'Team Audita',
  'Team PharmaService',
  'Team Secure',
  'Telkom Groovia',
  'Telkom Indonesia',
  'Telkom Jabar',
  'Telkom Speedy',
  'Telkom UseeTV',
  'Telkom@wifi.id',
  'Thai Oil',
  'Tin Fok',
  'Tolani Shipping Ltd',
  'Trambak Rubber',
  'Tricon Infotech',
  'Unia Leszno',
  'Unia Winkhaus',
  'VBS Fjárfestingarbanki hf.',
  'Vestel',
  'Vidbot ehf',
  'Viego Regnskap',
  'Viru Valge',
  'Wuhan Dongfang',
  'Xiamen Xiashun',
  'Xiao Ying',
  'Yalu Group',
  'Yeh Bros',
  'Yibin China Resources',
  'Yi Tong',
  'Yufeng Electric',
  'Yunnan Dikuang Resources',
  'Yunnan Tongya',
  'Z-Tech',
  'Zhe Da Wang Xin',
  'Zhejiang Hanbang',
  'Zhejiang Jingfan',
  'Zhejiang Jinjian',
  'Zhejiang Xinxiang',
  'Zhong Guo Ren Bao',
  'Zhong Yuan',
  'Zhongshan Jiegao',
  'Zhu Jiang'
);

my %MULTI_TYPOS =
(
  'Abadi Adimulia' => ['abadi adi mulia', 'abadi adimulya'],
  'Agsar Paints' => ['agsar pints'],
  'AJ Diament' => ['aj diamonds'],
  'Apreo Logistic Poland' => ['apreo logistic pol', 'apreo logistic pola'],
  'Asko-Tech' => ['asco tech'],
  'Baltic Express' => ['baltic expres'],
  'Bangur Cement' => ['bangur cements', 'bangur cment'],
  'Bank Tabungan Negara' => ['bank btn'],
  'Beidike' => ['bei di ke'],
  'Beijing Wan Jia' => ['bei jing wan jia'],
  'Beijing Huayuan' => ['beijing hua yuan', 'beijing huayuan property'],
  'Beijing Hull Technology' => ['beijing hull tech'],
  'Beijing Railway Bureau' => ['beijing ry. bureau'],
  'Beijing ShouChuang' => ['beijing capital group', 'bj shouchuang'],
  'Beijing Trinergy' => ['beijing trinergyy'],
  'Beijing Yue Ze' => ['bei jing yue ze'],
  'Breki Jarðverk' => ['breki jarðverk ehf'],
  'bridge24.pl' => ['bridge 24', 'bridge24', 'bridge24pl'],
  'Bridgefélag Reykjavíkur' => ['bridgefélag Reykjav'],
  'Bridge Winners' => ['bridge winner', 'bridgewinners.com'],
  'Cai Fu Zheng Quan' => ['cai fu'],
  'China Finance' => ['china finance ba'],
  'China Ping An' => ['zg pingan', 'zg  pingan'],
  'China Resources' => ['china resources power', 'cr power',
    'china res. power'],
  'Chateau Rossenovo' => ['chatteau rossenovo', 'chatteu rossenovo',
    'chaetou rosenovo', 'shato rosenovo', 'shato rossenovo'],
  'China Global Times' => ['chinal global times', 'huan qiu Shi bao'],
  'China Trinergy' => ['chinatrinergy'],
  'Data Steel' => ['datta steel'],
  'Dhampur Sugar' => ['dhampur sugar mills', 'dhampur sugars', 
    'dhampur suger mills', 'dhampor sugar mills', 'dhampu sugar mills',
    'sugar mills'],
  'Djarum Black' => ['djarum black capp', 'djarum black mild'],
  Djarum => ['djarum la', 'djarum mld'],
  'Dobre Zegary' => ['dobre_zegary'],
  Dongfeng => ['dongfeng automobile', 'dong feng', 'dongfeng qiche'],
  'Eden Realty Kolkata' => ['eden city', 'eden city kolkata',
    'eden reality kolkat'],
  'Eko-Al' => ['eko al', 'eko_al'],
  Elastron => ['elastron (taurus)'],
  'Elektrik P3B' => ['elektrik merapi', 'electric merapi'],
  'Falck Medical' => ['falck med'],
  'Fanhua Jituan' => ['fan hua'],
  'Ferðaskrifstofa Vesturlands' => ['ferðask. vesturl.',
    'ferðaskrifstofa ves'],
  'Garðar & Vélar' => ['garðar & vélar ehf.', 'garðar og vélar',
    'gardar og velar'],
  'Garðs Apotek' => ['garðs apótek', 'garðs apoótek', 'gards apótek'],
  'Geely Automobile' => ['geely auto', 'gely auto', 'chaina geely',
    'china geely', 'jili', 'china geely auto'],
  'Geologi Timah' => ['geo timah', 'geo tima'],
  'Geoportal Kutai Kartanegara' => ['geo gutai gartanega'],
  'Gong Hang Jin Ying' => ['gonghang jinying'],
  'Guangzhou Huachu Chemicals' => ['gz huachu chem'],
  'Guangzhou Pearl River' => ['gz pearl river', 
    'guangzhou pearl river development'],
  'Hengsha Haijiu' => ['hengsha jiuhai'],
  'Hengsha Ke Ji' => ['heng sha ke ji'],
  Huayuan => ['hua yuan'],
  'Hubei Dongfeng' => ['hb dongfeng', 'hu bei dong feng'],
  'Hunan Tou Zhan' => ['hn  touzhan'],
  'India Glycols' => ['india glycol', 'india glycols ltd.',
    'india glyclos', 'indian glycols'],
  'Indian Medical' => ['indian medical asso'],
  'Indian Railways' => ['indianrailways', 'indian railyaws',
    'indin railways', 'indian railway', 'indian rail', 'indians railways'],
  'Indonesian Power' => ['indo power', 'indonesia power',
    'elektrika ind power', 'elektrika bc'],
  'Jasa Marga Jakarta' => ['jasa marga'],
  'Kaushik Hyderabad' => ['kaushik hyd.'],
  "Kini's Bangalore" => ["kini's bengalore"],
  "Kini's Goa" => ["keni's goa"],
  'KONKRET Chelmno' => ['konkret che³mno'],
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
  'Mutiara Energy' => ['mutiara energy indo', 'mutiara energi indo',
    'mutiara energi p.', 'mutiara energi.p'],
  'Nanfang Dianwang' => ['nan fang dian wang'],
  'Nanguang Power' => ['nangang dongli'],
  'Nanyuan' => ['nan-yuan'],
  'PD Times' => ['p d times'],
  'Pan China Construction' => ['pan-china const', 'pan china construct'],
  'Pan China Group' => ['pan-china group'],
  'Perbankan Jatim' => ['perbankan_jatim'],
  'PD Times' => ['pd shidai', 'pd  shidai'],
  'Pertamina' => ['pertamina ep', 'pertamina ft', 'pertamina field', 
    'pertamina ge', 'pertamina indonesia'],
  'Phoenix TV' => ['feng huang wei shi'],
  'Poddar Developers' => ['poddar development', 'poddar dev',
    'podder dev', 'podder developers', 'poddar devekopers',
    'poddar dovelopers'],
  Pufa => ['pu fa'],
  'Ryan Express' => ['ryan_express'],
  'Samtronic Constanta' => ['samtronic ct'],
  'Sanya Tianze' => ['san ya tian ze'],
  'SAPW Poland' => ['sapw-poland'],
  'Semangat Baru Makassar' => ['semangat baru mks', 'semangat baru mks.'],
  'Shanghai Automobile' => ['shanghai automoblie', 'sh  qiche',
    'sh qiche'],
  'Shanghai Changyu' => ['sh chuangyu'],
  'Shanghai Jiahua' => ['shanghai jia hua'],
  'Shanghai Ling Mu' => ['ling mu'],
  'Shanghai Qiche' => ['shanghai qi che'],
  'Shanghai Qihao' => ['sh qihao'],
  'Shanghai Qi Zhong' => ['shang hai qi zhong'],
  'Shanghai Zhongfu' => ['shang hai zhong fu'],
  'Shanxi Qinlian' => ['shan xi qin lian', 'shanxi qinlian'],
  'Shenzhen Nangang' => ['shen zhen nan gang', 'shenzen nangang'],
  'Shenzhen Ping An' => ['shen zhen ping an', 'shenzhen pingan'],
  'Shiji Changda' => ['chang da', 'shijichangda', 'shi ji chang da'],
  'Shree Cement' => ['shre cement', 'shree cements', 'sree cement',
    'sri cements'],
  'Shree Radhey' => ['shree radhye', 'shri radhey', 'shri radheya',
    'sree radhye'],
  'Siwik Holiday Mragowo' => ['siwik holiday bt', 'siwik holiday mrag',
    'siwik mragowo'],
  'Société Générale' => ['societe generale', 'societè general'],
  'Sölufélag Garðyrkjumanna' => ['sölufélag garð'],
  'Sparisjóður Keflavik' => ['sparisjóður kef'],
  'Sparisjóður Norðurland' => ['sparisjóður nord'],
  'Sparisjóður Norðfjörður' => ['sparisjóður norðfj',
    'sparisjóður norð.'],
  'Sparisjóður Siglufjarðar' => ['sparisjóður sigl',
    'sparisjóður sigluf', 'sparisjóður siglufj', 'sparisj. siglufjarð',
    'spariisj.siglufjar', 'sparisj.siglufj', 'sparisj.siglufjarð',
    'sparisj.siglufjarða'],
  'Spasso Food' => ['spassofood'],
  'Syabas Energy' => ['syabas energi', 'syabas e'],
  'Synergia Lublin' => ['synergia lubin'],
  'Team PharmaService' => ['pharma service', 'pharmaservice'],
  'Telkom Indonesia' => ['telkom ind indihome', 'telkom indonesia'],
  'Telkom Speedy' => ['telkom speedy bpn'],
  'Tolani Shipping Ltd' => ['tolani shipping'],
  'Trambak Rubber' => ['trumpak rubber'],
  'Unia Winkhaus' => ['winkhaus unia', 'winkhaus-unia'],
  'Viego Regnskap' => ['viego regnskap as'],
  'Xiao Ying' => ['xiao ying inn'],
  'Yalu Group' => ['js yalu'],
  'Yeh Bros' => ['yeh brothers', 'yer bros', "yeh's bros", 'yehs bros',
    'yer bros', 'yeoh bros'],
  'Yibin China Resources' => ['yibin cr gas', 'yibin china resourc'],
  'Yunnan Dikuang Resources' => ['yunnan dikuang', 'yun nan'],
  'Zhejiang Huamen' => ['zhe jiang hua men'],
  'Zhejiang Jingfan' => ['zj jingfan'],
  'Zhongshan Jiegao' => ['zhong shan jie gao']
);

my @SINGLE_WORDS = qw(
  ABAX Abnegat Accenture Actavis Aerospace AIA Akaylar Akebono
  Aklindo Allianz Alfa Aquatrans Arboned Argento Arkas Arma Artotec
  Asindo Ayýntab

  Bajaj Banpu Beidike

  Cable Candyland Changyu Chemikartel Chlodnia Chuanmei Cimentas 
  COMAL Compensa Computerland CONSUS Continental Copia Cosmos

  Datasteel Denizgucu Derofe Dianwang DISKI Djarum Dongfeng Druva

  Effcontrol Eimskip Eksprompt Elastron Elektrika Energetyk
  Enorma Enterprise 
  Everfresh Evertrust

  Frissan Funbridge

  GAMAX Gazprom Gevalia Gillette Gözgöz

  Hana Haustak Honesta Huayuan

  IMAX Impress Inteligent Interface

  Jetox JHS Jinfan Junibacken

  Kadimex Kancelaria Kilogrupp KONKRET Konstanta Kvika

  Lancia Lacznosc Laima Lavazza Likom Longjiangfu Lukomorie Lyfjaver

  Manyavar Meikuang Mitrabuana Morgunblaðið Myndform

  NALCO Nanyuan Navachaitanya Navayuga Nefka Niewiem Norco Näkösoppi

  Ozyuva

  P2TEL Paulaner Pealinn Penline Pertagas Pertamina Pexis Petro 
  Pharon Pimara POLFA Praterm Primabridge Printerikeskus Pufa Pusula

  Qiaoyou

  Radex Ráðgjöf Ravebo Relpol Rofoi

  Sagaplast Samsung Samtronic Scania Sekans Sevtopolis Shimuzu 
  Shouchuang Signity Skeljungur Solakoglu Solox Sparisjóður Stiga Synective

  Tekser Termika Termoavion Termochem Topeko Transearly Tricon Tridaya 
  Triton Tryggingamiðstöðin Tsingtao Tundem Tyco Tzilis

  Underberg Unibet

  Velbazhd Velbujd Vilmar Vinabær Visoft Vito Voff

  Wellknit Wellwise Winbridge

  Yuetao

  Zaraz Zhonghai Zolza Zweili
);

my %SINGLE_TYPOS =
(
  'Adaro Energy' => ['adaro'],
  'Agsar Paints' => ['agsar'],
  'Aliaga Kyme' => ['kyme'],
  'Bank Tabungan Negara' => ['btn'],
  'Beijing Longxin' => ['beijinglongxin'],
  'Beijing Trinergy' => ['beijingtrinergy'],
  'BridgeBertheau.com' => ['bridgebertheau'],
  'Carlo Bossi' => ['carlobossi'],
  'Chateau Rossenovo' => ['rossenovo', 'rosenovo'],
  'Chennai Online' => ['chennaionline'],
  'China Ping An' => ['chinapingan', 'zhongguopingan'],
  Computerland => ['computerlan'],
  'Dhampur Sugar' => ['dhampur'],
  DISKI => ['dsi'],
  Eksprompt => ['ekspromt'],
  'Elektrik P3B' => ['elektrik', 'electric'],
  Elektrika => ['elektric'],
  'Fanhua Jituan' => ['fanhua'],
  'Garðs Apotek' => ['garðsapótek'],
  'Geoportal Kutai Kartanegara' => ['geokutaikartanegara'],
  Gevalia => ['gevalía'],
  Gillette => ['gilette'],
  Gözgöz => ['gozgoz'],
  'Guangzhou Hongmian' => ['guangzhouhongmian', 'hongmian'],
  'Guangzhou Pearl River' => ['guangzhoupearlriver', 'guangzhouperalriver'],
  'Haerbin Bingxue' => ['harbin bingxue'],
  'Indian Railways' => ['railways'],
  'Jilin Dingyuan' => ['jilindingyuan'],
  'Jin Rong' => ['jinrongjia'],
  'KH Power' => ['khpower'],
  'Kosmos Delhi' => ['kosmos'],
  'Lianzhong Shi Jie' => ['lianzhongshijie'],
  'Magpa-Grup' => ['magpa'],
  'Málning hf' => ['málning'],
  'Meilin Qing Cheng' => ['meilinqingcheng'],
  'Nanning Yalun' => ['nanning yalun'],
  'Perbankan Jatim' => ['perbankan'],
  'Pro Consul' => ['proconsul'],
  'San Chen' => ['sanchen'],
  'Sanya Jiguan' => ['sanyajiguan'],
  'SAPW Poland' => ['sapw'],
  'SD Associates' => ['sdassociates'],
  'SD Enterprises' => ['sdenterprises', 'sdenterprizes'],
  'Shanghai Automobile' => ['shangqi'],
  'Shanghai Municipal Engineering Group' => ['smeg'],
  'Shenzhen Lanpu' => ['lanpu'],
  'Shiji Changda' => ['changda'],
  'Shree Cement' => ['shreecement'],
  'Son Dakika' => ['sondakika'],
  'Sparisjóður' => ['sparisjodur'],
  'SPS Construction' => ['sps'],
  'Team Audita' => ['teamaudita', 'audita'],
  Tsingtao => ['tsingthao'],
  'Viego Regnskap' => ['viego'],
  Wellwise => ['wellwiss'],
  'Yeh Bros' => ['yeh']
);


sub set_hashes_team_sponsor
{
  my ($key) = @_;

  TeamBBO::set_overall_hashes(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
