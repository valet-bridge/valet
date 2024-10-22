#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tname;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
  ### These are the only ones that are not specific (in time/place)
  ### tournament "names".

 'Challenge Match',
 'Exhibition Match',
 'Friendly Match',
 'Friendly Pairs',
 "New Year's Teams",
 'Opening Tournament',
 'Practice Match',

  # AFRICA
  'African Zonal Open Teams',
  'African Zonal Senior Teams',
  'African Zonal Women Teams',
  "Pigg's Peak All Africa",

  # ARGENTINA
  'Argentinian Club Teams',
  'Argentinian Copa Republica',
  'Argentinian Flags Day Championship',
  'Argentinian Mixed Pairs',
  'Argentinian Mixed Teams',
  'Argentinian Open Teams',
  'Argentinian Open Trials',
  'Argentinian Seniors Teams',
  'Argentinian Senior Trials',
  'Argentinian Women Teams',
  'Argentinian Women Trials',
  'Copa Zanalda River Plate',
  'Mar del Plata Open Teams',

  # AUSTRALIA
  'Altman Swiss Pairs',
  'Australian Autumn National Open Teams',
  'Australian Grand National Open Teams',
  'Australian Junior Teams',
  'Australian National Open Teams',
  'Australian National Senior Teams',
  'Australian National Women Teams',
  'Australian Open Teams',
  'Australian Senior Pairs',
  'Australian Senior Teams',
  'Australian Spring Open Teams',
  'Australian Spring Senior Teams',
  "Australian Spring Women Teams",
  "Australian Women Teams",
  'Australian Youth IMP Pairs',
  'Australian Youth Teams',
  'Australian Youth Tri Individual',
  'Australian Youth Tri Pairs',
  'Australian Youth Tri Teams',
  'Bobby Evans Senior Teams',
  'Cliff Wake Challenge',
  "Hans Rosendorff Memorial Women's Teams",
  'John Arkinstall State Teams',
  'Kings and Queens Blaine Howe Teams',
  "Linda Stern Women's Teams",
  'New South Wales Open Teams',
  'New South Wales Open Trials',
  'Northern Territory Gold Swiss Pairs',
  'Northern Territory Gold Teams',
  'Queensland Women Trials',
  'Queensland Senior Trials',
  'Smirnov Cup',
  'Victor Swiss Pairs',
  'Victor Open Teams',
  'Victoria Cup',
  'Victorian Mixed Teams',
  'Victorian Open Trials',
  'Victorian Pennant',
  'Victorian Senior Trials',
  'Victorian Women Trials',
  'Victorian Youth Trials',
  'Watermark Open Teams',

  # AUSTRIA
  'Austrian Open Teams',

  # BALTIC (Estonia, Latvia, Lithuania)
  'Baltic Open Teams',
  'Estonian First League',
  'Estonian Open Pair Trials',
  'Estonian Open Teams',
  'Estonian-Latvian Open Team Trials',
  'Latvia Invites',
  'Lithuanian Open Teams',
  'Riga Invitational Pairs',
  'Riga Open Teams',
  'Vilnius BAM Pairs',
  'Vilnius Club Pairs',
  'Vilnius IMP Pairs',
  'Vilnius Open Pairs',
  'Vilnius Open Teams',

  # BELARUS
  'Belarusian Open Teams',

  # BELGIUM
  'Belgian Open Pairs',
  'Belgian Open Teams',
  'Belgian Open Trials',
  'Belisol Invitational Pairs',

  # BRAZIL
  'Brazilian Senior Trials',
  'Brazilian Open Teams',
  'Brazilian Open Trials',
  'Brazilian Women Trials',
  'Rio de Janeiro Open Teams',
  'Rio de Janeiro Christmas Individual',
  'Roberto Taunay Cup',
  'Sao Paulo Cup',
  'Sao Paulo State Championship',

  # BULGARIA
  'Albena Open Teams',
  'Asenovgrad Open Teams',
  'Bulgarian Open Pairs',
  'Bulgarian Open Teams',
  'Bulgarian Open Trials',
  'Bulgarian Women Trials',
  'Cherven Briag National Tournament',
  'Dobrich Open Teams',
  'Karlovo Open Pairs',
  'Karlovo Open Teams',
  'Pleven Open Teams',
  'Plovdiv Open Teams',
  'Serdika Open Teams',
  'Stara Zagora Open Teams',
  'Varna Intercity Teams',
  'Varna Titan Open Teams',

  # CANADA
  'Canadian National Teams Championship',
  'Canadian Seniors Teams Championship',
  'Canadian Women Teams Championship',

  # CHILE
  'Chilean Cup',
  'Chilean Invitational Teams',
  'Chilean Open Pairs',
  'Chilean Open Teams',
  'Chilean Open Trials',
  'Chilean Senior Teams',
  'Chilean Women Teams',
  'Chilean Women Trials',

  # CHINESE TAIPEI
  'Antonio Chong Cup',
  'Chinese Taipei Open Trials',

  # CROATIA
  'Atlantic Trade Bridge Cup',
  'Samobor Open Teams',

  # CZECH
  'Czech First League',
  'Czech Open',
  'Grand Prix of Prague',

  # DENMARK
  'Copenhagen Invitational Pairs',
  'Copenhagen Open Pairs',
  'Danish Club Teams',
  'Danish Cup',
  'Danish First Division',
  'Danish Junior Teams',
  'Danish Mixed Pairs',
  'Danish Mixed Teams',
  'Danish Open Pairs',
  'Danish Open Pairs Trials',
  'Danish Open Teams',
  'Danish Open Trials',
  'Danish Women Pairs',
  'Hecht Cup',
  'Prince Henrik Trophy',
  'Vinoble Open',

  # ECUADOR
  'Ecuador Open Teams',

  # EGYPT
  'Egyptian Cup',
  'Egyptian League',

  # EUROPE
  "European Open Champions' Cup",
  'European National Mixed Teams',
  'European National Open Teams',
  'European National Seniors Pairs',
  'European National Seniors Teams',
  'European National Women Pairs',
  'European National Women Teams',
  'European Small Federation Games',
  'European Transnational Mixed Pairs',
  'European Transnational Mixed Teams',
  'European Transnational Open Pairs',
  'European Transnational Open Teams',
  'European Transnational Seniors Teams',
  'European Winter BAM Trophy',
  'European Winter Teams',
  'European Winter Transnational Teams',
  "European Women Open Champions' Cup",
  'Generali European Open Teams',
  'Generali European Women Pairs',
  'Generali European Women Teams',

  # EURO-YOUTH
  'European U16 Open Pairs',
  'European U16 Open Teams',
  'European U21 Open Pairs',
  'European U21 Open Teams',
  'European U26 Mixed Pairs',
  'European U26 Open IMP Pairs',
  'European U26 Open Pairs',
  'European U26 Open Teams',
  'European U26 Women Pairs',
  'European U26 Women Teams',
  'European U31 Open Pairs',
  "European U31 President's Cup",
  'European University Bridge Championship',
  'European University Team Championship',

  # FINLAND
  'Finnish Cup',
  'Finnish Easter Teams',
  'Finnish Open Pairs',
  'Finnish Open Pair Trials',
  'Finnish Open Trials',
  'Finnish Open Teams',
  'Finnish Senior Trials',
  'Finnish Swiss Teams Championship',
  'Finnish Women Trials',

  # GERMANY
  'Bonn Nations Cup',
  'German Bundesliga',
  'German Club Cup',
  'German Mixed Teams',
  'German Open Pairs',
  'German Open Teams',
  'German Open Trials',
  'German Team Trophy',
  'German Women Pairs',
  "Gro's Supercup",
  'König Ludwig Cup',

  # GREECE
  'Greek Central Regional Pairs',
  'Greek Mixed Pairs',
  'Greek Northern Regional',
  'Greek Open Teams',
  'Greek Open Pair Trials',
  'Greek Open Team Trials',
  'Greek Women Trials',

  # HUNGARY
  'Balaton Invitational Teams',
  'Balatonföldvár Open Teams',
  'EcoSoft Cup',
  'Hungarian Cup',
  'Hungarian IMP Pairs',
  'Hungarian Open Pairs',
  'Hungarian Open Teams',
  'Hungarian Open Trials',
  'Hungarian Senior Trials',
  'Hungarian Women Trials',

  # ICELAND
  'Iceland Express Pairs',
  'Iceland Express Teams',
  'Icelandair Open Pairs',
  'Icelandair Open Teams',
  'Icelandic Cup',
  'Icelandic Open Teams',

  # INDIA
  'All India Bangur Cement Hindusthan Club',
  'All India Corporate Invitational Pairs',
  'All India HCL Pairs',
  'All India HCL Teams',
  'All India Open Pairs',
  'All India Shree Cement',
  'All India UTI Bank Masters Championship',
  'Bhabha Atomic Research Centre Open',
  'B L Rao Memorial Open',
  'Dainik Navjyoti All India Inter-State',
  'Delhi Gymkhana Club Open Pairs',
  'Delhi Gymkhana Club Open Teams',
  'Godfrey Phillips All India Open',
  'Hindusthan Club Teams',
  'Indian Inter-State Teams',
  'Indian Open Trials',
  'Indian Senior Trials',
  'Indian State Championship',
  'Indian Western Zone Championship',
  'Jaya Jain Memorial',
  'Justice J M Lal All India Open Pairs',
  'Justice J M Lal All India Open Teams',
  'Karnataka State Teams',
  'Krishnapatnam Port National Masters',
  'Lalit Mohanka Memorial',
  'L C Sunil Rajendra Memorial',
  'Madras Gymkhana Club Open',
  'Maharaja Yeshwantrao Holkar National Pairs',
  'Maharaja Yeshwantrao Holkar National Teams',
  'Maharashtra State Pairs',
  'Maharashtra State Teams',
  'Mohan Sicka BAM Teams',
  'Mohan Sicka Pairs',
  'Mohanlal Bhartia Memorial Grand Prix',
  'Mohanlal Bhartia Memorial Pairs',
  'Poddar National Masters',
  'Prashant Desai Memorial',
  'PYC Hindu Gymkhana Royale',
  'Rai Bahadur Modi Memorial All India Open',
  'Rajasthan Invitational Pairs',
  'Rajasthan Invitational Teams',
  'R N Bagla Memorial Pairs',
  'R R Gupta Memorial Championship',
  'R Ratnam Memorial',
  'Ruia Gold Cup',
  'Ruia Silver Cup',
  'Shree Keni Trophy',
  'Tolani Gold Trophy',
  'Tolani Grand Prix',
  'Tolani Silver Cup',
  'Uttar Pradesh State Pairs',
  'Uttar Pradesh State Teams',

  # INDONESIA
  'Gabrial UI Bastaman Cup',
  'Geologi Cup',
  'Indonesian Inter-City Championship',
  'Indonesian Inter-Club Championship',
  'Indonesian Inter-Province Championship',
  'Indonesian Invitational Teams',
  'Indonesian Junior League Online',
  'Indonesian Mixed Pair Trials',
  'Indonesian Mixed Teams',
  'Indonesian Open Pair Trials',
  'Indonesian Open Teams',
  'Indonesian Open Trials',
  'Indonesian Premier League',
  'Indonesian U16 Pair Trials',
  'Indonesian U18 Teams',
  'Indonesian U21 Pair Trials',
  'Indonesian U21 Teams',
  'Indonesian U26 Pair Trials',
  'Indonesian U26 Teams',
  'Indonesian U26 Women Pair Trials',
  'Indonesian U31 Teams',
  'Indonesian U31 Women Teams',
  'Indonesian Women Pair Trials',
  'Indonesian Women Teams',
  'Indonesian Women Trials',
  "Kepri Governor's Cup",
  'PT Timah Invitational Teams',
  'Telkom Indonesia Open',

  # IRELAND
  'Irish Invitational Pairs',
  'Irish Open Trials',
  'Full Tilt Irish Bridge Masters',

  # ISRAEL
  'Israel Cup',
  'Israel Juniors Pairs',
  'Israel Juniors Trials',
  'Israel IMP Pairs',
  'Israel Open Pairs',
  'Israel Open Teams',
  'Israel Open Trials',
  'Israel School Trials',
  'Israel Women Pairs',

  # ITALY
  'Italian Club Open Championship',
  'Italian Club Women Championship',
  'Italian Men Cup',
  'Italian Mixed Cup',
  'Italian Mixed Pairs',
  'Italian Mixed Teams',
  'Italian Open Cup',
  'Italian Open Teams',
  'Italian Open Trials',
  'Italian Senior Cup',
  'Italian Senior Trials',
  'Italian U36 Teams',
  'Italian Women Cup',

  # JAPAN
  'Japanese District KO Teams',
  'Japanese Open Trials',
  'Kanto Teams',
  'NEC Cup',
  'Prince Takamatsu Cup',

  # JORDAN
  'Jordan Mixed Pairs',
  'Jordan Open Pairs',
  'Jordan Open Teams',

  # LEBANON
  'Lebanese Invitational Teams',

  # NEW ZEALAND
  'New Zealand Inter-Provincial Open Teams',
  'New Zealand Open Teams',
  'New Zealand Open Trials',
  'New Zealand Women Trials',

  # NORDIC
  'Nordic Cup',
  'Nordic Junior Pairs',
  'Nordic Junior Teams',
  'Nordic Open Teams',
  'Nordic Security Pro-Am Pairs',
  'Nordic Women Teams',

  # NORWAY
  'Norwegian Club Pairs',
  'Norwegian Club Teams',
  'Norwegian Corporate Championship',
  'Norwegian Mixed Pairs',
  'Norwegian Mixed Teams',
  'Norwegian Open Pairs',
  'Norwegian Open Teams',
  'Norwegian Premier League',
  'Norwegian Senior Teams',
  'Norwegian Swiss Pairs',
  'Norwegian Swiss Teams',
  'Norwegian Team Trials',
  'Norwegian Women Invitational Pairs',
  'Norwegian Women Teams',
  'Olrud Easter Mixed Pairs',
  'Olrud Easter Swiss Pairs',
  'Olrud Easter Swiss Teams',
  'Rondane Pairs Cup',
  'Rondane Teams Cup',
  'Rosfjord Swiss Teams',
  'Trondheim Pairs Cup',
  'Trondheim Teams Cup',

  # POLAND
  'Andrzej Wilkosz Memorial Pairs',
  'Grand Prix of Poland Pairs',
  'Grand Prix of Poland Teams',
  'Janina Wielkoszewska Memorial Open',
  'Janos Levai Memorial',
  'Józef Pochron Jubilee Pairs',
  'Krakow Spring Teams',
  'Leszek Kwiatkowski Memorial Pairs',
  'Leszek Kwiatkowski Memorial Teams',
  'Polish BAM Cup',
  'Polish BAM Teams',
  'Polish Boys Championship',
  'Polish Business League',
  'Polish Business Pairs',
  'Polish First League',
  'Polish Girls Championship',
  'Polish Girls Trials',
  'Polish IMP Pairs',
  'Polish Individual Championship',
  'Polish Junior Pairs Trials',
  'Polish Mixed Pairs',
  'Polish Mixed Teams',
  'Polish Open Pairs',
  'Polish Open Teams',
  'Polish Open Trials',
  'Polish Pairs Cup',
  'Polish Patton Teams',
  'Polish Premier League',
  'Polish School Championship',
  'Polish Second League',
  'Polish Senior Trials',
  'Polish U16 Pairs',
  'Polish U16 Teams',
  'Polish U20 Trials',
  'Polish U25 Trials',
  'Polish Women Trials',
  'Pomerania Cup',
  'Sigismund Bell Krakow',
  'SPS Trophy',
  'Staszek Wybranowski Memorial',
  'Warsaw Online Teams',
  'Wronie Summer Teams',
  'Zulawski Cup',

  # PORTUGAL
  'Madeira Open Teams',
  'Portuguese Grand Prix',
  'Portuguese IMP Pairs',
  'Portuguese Open Teams',
  'Portuguese Open Trials',
  'Portuguese Northern Regional Open Teams',
  'Rui Pinto Cup',

  # ROMANIA
  'Romanian League',
  'Romanian Second League',
  'Romanian Open Teams',
  'Romanian Open Trials',

  # SERBIA
  'Serbian Cup',
  'Serbian Inter-City Teams',
  'Serbian Open Teams',
  'Serbian Open Trials',
  'Serbian Premier League',

  # SOUTH AMERICA
  'South American Junior Teams',
  'South American Open Pairs',
  'South American Open Teams',
  'South American Open Trials',
  'South American Senior Trials',
  'South American Seniors Teams',
  'South American Women Teams',
  'South American Women Trials',

  # SPAIN
  'Spanish Central Zone Teams',
  'Spanish Mixed Teams',
  'Spanish Open Teams',
  'Spanish Open Trials',
  'Spanish Senior Trials',

  # SWEDEN
  "Chairman's Cup",
  'Stockholm Teams',
  'Swedish Cup',
  'Swedish District Teams',
  'Swedish Juniors Pairs',
  'Swedish Juniors Teams',
  'Swedish Mixed Teams',
  'Swedish Open Pairs',
  'Swedish Open Teams',
  'Swedish Open Pair Trials',
  'Swedish Open Team Trials',
  'Swedish Premier League',
  'Swedish Senior Team Trials',
  'Swedish Women Pair Trials',
  'Swedish Women Team Trials',

  # SWITZERLAND
  'Jean Besse Cup',
  'Swiss Club Championship',
  'Swiss Cup',
  'Swiss Open IMP Pairs',
  'Swiss Open Teams',
  'Zurich Open Pairs',
  'Zurich Open Teams',

  # TURKEY
  'Ankara Summer Teams',
  'Goksu-Yalikavak Pairs',
  'Istanbul Teams',
  'Istanbul Winter Teams',
  'Izmir Teams Cup',
  'Murat Kilercioglu Turkish Spring Teams',
  'Necmettin Sunget Teams Cup',
  'Turkish Club Championship',
  'Turkish East Mediterranean Teams',
  'Turkish Junior Pairs',
  'Turkish Mixed Team Trials',
  'Turkish Mixed Teams',
  'Turkish Open Teams',
  'Turkish Open Pair Trials',
  'Turkish Open Team Trials',
  'Turkish Swiss Mixed Teams',
  'Turkish U16 Pairs',
  'Turkish University Teams',
  'Turkish Winter Open Teams',
  'Turkish Winter Women Teams',
  'Turkish Women Pair Trials',
  'Turkish Women Team Trials',
  'Turkish Women Teams',

  # UNITED KINGDOM
  'British Gold Cup',
  'Camrose Trophy',
  'English Open Trials',
  'English Premier League',
  'English Senior Trials',
  'English U28 Trials',
  'English Women Teams',
  'English Women Trials',
  'Junior Camrose',
  'Lady Milne Trophy',
  'Lederer Memorial Trophy',
  'Scottish Cup',
  'Scottish National League',
  'Spring Foursomes',
  'Teltscher Trophy',
  'TGR Auction Pairs',
  'TGR Auction Teams',
  'TGR Super League',
  'Welsh Invitational Pairs',
  'Welsh Open Trials',
  'Young Chelsea Knock-out',

  # USA
  '0 to 1500 Spingold',
  'Reisinger BAM Teams',
  'Spingold Teams',
  'US Girls Trials',
  'US Juniors Training',
  'US Junior Trials',
  'US Open Trials',
  'US Senior Teams',
  'US Senior Trials',
  'US University Trials',
  'US Women Teams',
  'US Women Trials',
  'US Youngster Trials',
  'USBF Challenge Match',
  'Vanderbilt Teams',
  'Wagar Teams',

  # VENEZUELA
  'Venezuelan Mixed Teams',
  'Venezuelan Swiss Pairs',

  # WORLD
  'APBF Women Elite Tournament',
  'Bermuda Bowl',
  'Damiani Trophy',
  "d'Orsi",
  'Huayuan Cup',
  'IMSA Elite Open Individual',
  'IMSA Elite Open Pairs',
  'IMSA Elite Open Teams',
  'IMSA Elite Women Individual',
  'IMSA Elite Women Pairs',
  'IMSA Elite Women Teams',
  'IOC Grand Prix',
  'McConnell Cup',
  'Oly-Star Cup',
  'Rona Cup',
  'Rosenblum Cup',
  'Tianjin Binhai Cup',
  'Venice Cup',
  'World Kids Teams',
  'World Masters Individual',
  'World Mixed Pairs',
  'World Mixed Teams',
  'World Open Girl Pairs',
  'World Open Girl Teams',
  'World Open Junior IMP Pairs',
  'World Open Junior Pairs',
  'World Open Junior Teams',
  'World Open Pairs',
  'World Open Youngster Pairs',
  'World Open Youngster Teams',
  'World Open Youth BAM Teams',
  'World Top Tournament',
  'World Transnational Mixed Teams',
  'World Transnational Open Teams',
  'World University Teams',
  'World Youngster Teams',
  'WMG Men Individual',
  'WMG Men Pairs',
  'WMG Men Teams',
  'WMG Open Individual',
  'WMG Open Pairs',
  'WMG Open Teams',
  'WMG Senior Teams',
  'WMG U21 Teams',
  'WMG U26 Teams',
  'WMG U28 Teams',
  'WMG Women Individual',
  'WMG Women Pairs',
  'WMG Women Teams',

  # ----------------------------------------------------

  # Asia
  'APBF Championships',
  'APBF Youth Championships',
  'ASEAN Club Championship',
  'ASEAN Mixed Teams',
  'ASEAN Open Teams',
  'Asia Cup',
  'Asian University Championship',
  'Southeast Asian Games',
  'South Pacific Zone 7 Championship',
  'SPBF Championship',

  # Asia Middle East
  'BFAME Championship',
  'BFAME Friendship Pairs',
  'Pan Arab Inter-Club Championship',

  # Balkan
  'Balkan Championship',
  'Balkan Intercity Cup',
  'Balkan Teams',

  # Baltic
  'VV Cup',

  # Bolivia
  'Bolivian Open Teams',

  # Bulgaria
  'ARIS Cup',
  'Haskovski Mineralni Bani',
  'Vito Teams',

  # Central America
  'Central American & Caribbean Championship',
  'Central American Zonal Championships',

  # Chile
  'Copa de Oro',
  'Copa de Plata',

  # China
  'All-China Games',
  'Aoda Cup',
  'Avia Inter-City Championship',
  'China Elite Tournament',
  'China Friend City Senior Team Tournament',
  'China First League',
  'China Hosts Europe in Rome',
  'China Inter-City Teams',
  'China Resources Inter-City',
  'Chinese Club Championship',
  'Chinese Mixed Teams',
  'Chinese Open Teams',
  'Chinese Open Trials',
  'Cross Strait Invitational',
  'Dongfeng Cup',
  'Dongming Knock-out Teams',
  'Chung Hua Cup',
  'GHTD Cup',
  'Guangdong Club Championship',
  'Guangdong Club Invitational',
  'Guangdong Elite Tournament',
  'Guangzhou-HK-Macau Interport',
  'Haikou Fitness Day',
  'Hainan Air Cup',
  'High-Tech Zone Workers Invitational',
  'HNA Open Teams',
  'Jianshe Cup',
  'Jili Cup',
  'JPD Cup',
  'Mountain Sea Cup',
  'Sanchen Cup',
  'Sanya Cup',
  'Shenhua Cup',
  'Shenyang Spring',
  'Shenzhen Lanpu Cup',
  'Shenzhen Nangangdongli Cup',
  'Sunchime Fund Cup',
  'Tielu Jixie Invitational',
  'Xinyuan Cup',
  'Yeh Bros Cup',
  'Zhejiang Huamen Cup',

  # England
  'Garden Cities',
  'Higson Cup',

  # Europe: Same as European Champions' Cup
  "Champions' Cup",

  # Faroe Islands
  'Faroese Open Teams',

  # Finland
  'Hanko Teams',
  'Pärnu Summer Invitational Pairs',
  'Pärnu Summer Open Teams',
  'Puutalo Open',
  'Salo Midsummer Juniors',
  'Suomen Cup',

  # France
  'Biarritz Hiver',
  'Division Nationale',
  'French Cup',
  'French First Division',
  'French Intercircle',
  'French Junior Trials',
  'French Mixed Teams',
  'French Open Teams',
  'French Open Trials',
  'French Senior Trials',
  'French Women Trials',
  'French U28 Trials',
  'Mondial de Deauville',

  # Greece
  'Thanos Capayiannides Memorial Simultaneous',

  # Hong Kong
  'Hong Kong Inter-City',
  'JP Morgan Inter-City Championship',


  # India
  'Ashok Kapur Memorial Swiss Pairs',
  'Bagla Pairs Royale',
  'Golden Jubilee',
  'IBWI Cup',
  'Kalani Trophy',
  'Karnik-Vaidya Open',
  'Lokmanya Jubilee',
  'Nandu Oke Memorial IAF Swiss Pairs',
  'Narain Bhojwani Memorial',
  'Otters Inter-Club Teams',
  'PRBA State Level Open',
  'PSN Sarma Centenary Memorial',
  'Samadhan Summer League',
  'Summer Monsoon League',
  'TATA Open',
  'Thane Champion of Champions Teams',
  'Videocon WCG Open',
  'WCG Open',
  'Wellingdon Swiss Pairs',
  'Willingdon Sports Club Swiss Pairs',

  # Indonesia
  'Electric Cup',
  'FTBC Tanjungpura University',
  'Menpora-Pertamina Cup',
  'Pahlawan Cup',
  'Pesta Sukan',
  'PLN Cup',
  'Pertamina Field Tambun Cup',
  'Rector University of Brawijaya Cup',
  'Riau Governor Cup',
  'Sarundajang Cup',
  'Semen Padang Cup',

  # Israel
  'Dr. Rand Masters',
  'Four Nations Cup',
  'Maccabi Games',
  'Rand Cup',

  # Italy
  'Angelini Teams',
  'Bologna Trophy',
  'Coppie Viareggio',
  'Milan Trophy',
  'Olona International Teams',
  'Rome Challenger Trophy',
  'Torneo di Rastignano',
  'Torneo di Roma',
  'Toscana Cup',

  # Monaco
  'Patton de Monaco',
  'Prince Albert II Cup',

  # New Zealand
  'Centre Island Teams',

  # Netherlands
  'ArboNed Team Cup',
  'Arnhem Interbridge Tournament',
  'Carrousel Cup',
  'Dutch Knock-Out Cup',
  'Dutch Meesterklasse',
  'Dutch Women',
  'Forbo Nations Cup',
  'Jaap Kokkes Tournament',
  'Krommenie Nations Cup',
  'Petit Grand Prix van Driene',
  'The Hague Bridge Experience',
  'Top Circuit',
  'White House International',
  'White House Juniors',
  'White House Top 12',
  'White House Top 16',

  # Norway
  'Bergen Grand Tournament',
  'Codan Cup',
  'Farmen Invitational',
  'FOSS Grand Tournament',
  'FOSS-Tren',
  'FX Securities Cup',
  'Gardermoen Airport Hotel Pairs',
  'Gardermoen Airport Hotel Cup',
  "Jessheim New Year's Cup",
  'Marit Sveaas Tournament',
  'Mo i Rana Ladies Invitational',
  'Namsos Cup',
  'Ragn-Sells International Grand Tournament',
  'Ruter 7 Open',
  'Snåsa Cup',
  'Vest-Agder Regional Team Championship',
  'Willy Brown Memorial',

  # Pakistan
  'Pakistan Day Bridge Championship',
  'Pakistan Open Trials',

  # Poland
  # https://wyniki.pzbs.pl/2016/baltycki/
  # Should probably be Poland: Grand Prix of Poland Teams, 2016D.
  'Baltic Bowl',
  'bridge24.pl Trophy',
  'Forest Trophy',
  'Fortuna Cup',
  'Mondi Cup',
  'MTP Cup',
  'Palace Cup',
  'Plock District League',
  'Towns Cup', # Tallinn


  # Russia
  'Goulyash by E. Gladysh',
  'Moscow Sunday Times',
  'NN Cup',
  'Russian IMSA Cup',
  'Russian Open Teams',
  'Russian Premier League',
  'Slava Cup',

  # Serbia
  'Vrnjacka Banja Open Teams',

  # Singapore
  'Singapore Open Teams',

  # Slovakia
  'Slovakian Open Teams',

  # South Africa
  'FullBridge International Teams',
  'South African Championship',
  'South African Inter-Province Teams',
  'South African Teams',

  # Spain
  'Las Palmas Simultaneous Pairs',
  'Las Palmas Women Pairs',
  'Madrid Senior Teams',
  'Open Catalunya Preferent',

  # Supra
  'Bermuda Triangle Cup',
  'BKBT Teams',
  'Buffett Cup',
  'Cavendish Pairs',
  'Cavendish Teams',
  'Computer World Championship',
  'Channel Trophy', # Europe
  'Neighbor Challenge',
  'NYSA Euroregion Nations Cup',
  'Shield of Thoisy',
  'Stern-Cornell Trophy', # Australia - New Zelsn
  'Youth Open Bridge Paris',
  'Paris Youth Open Teams',

  # Sweden
  'Filbyter Cup',
  'Nordic Race', # Actually a Swedish trial.
  'Park Hotell Swiss Teams',
  'S:t Erik Championship Series',
  'Stena Line Cup',

  # Taiwan
  'NTU Cup',
  'Taiwan University Cup',
  'Taiwan University Cup Teachers',
  'Taiwanese Open Trials',
  'Taiwanese Teams',
  'Taiwanese Senior Trials',

  # Turkey
  'Anatolian Club Qualifying',
  'Anatolian Fall Teams',
  'Anatolian Open Teams',
  'Anatolian Spring Teams',
  'Assael Invitational Calcutta',
  'Balikcioglu Teams Championship',
  'Fatih Kiral Cup',
  'Gelibolu Peace Cup',
  'Lüleburgaz Liberation Cup',
  'Marmara Inter-Club Championship',
  'Salvador Assael IMP Pairs',
  'Salvador Assael Pro-Am',
  'Thrace Club Teams',
  'Thrace Cup League',
  'Western Mediterranean Club Teams',
  'Winter Open Teams',

  # UK
  'Commonwealth Nations Bridge Championships',
  'Corn Cairdis',
  'Glasgow Transnational Open Teams',
  'Peggy Bayer',
  'Whitelaw Cup',

  # USA
  'Baze Senior Knock-out',
  'Collegiate Bowl',
  'Grand National Teams', # Add ABCL or US to name
  "Missouri Braggin' Rights",
  'Solomon Teams',
  "Sternberg Women's BAM Teams",


  # ----------------------------------------------------

  'Mike Lawrence Exhibition', # Friendly, probably Scotland
  'Spring Nationals', # Many probably Australian
  'Transnational Open Teams', # Try to make unused
);

my %MULTI_TYPOS =
(
  ### These are the only ones that are not specific (in time/place)
  ### tournament "names".

  'Friendly Match' => ['match amical', 'friendly tm'],
  'Practice Match' => ['practice session', 'training match', 
    'practice match', 'test match', 'tes match', 'practise match', 
    'practice matche', 'practice matches'],

  ### AAA

  'African Zonal Open Teams' => [
    'african zonal open trials',
    'african zone 8 open teams',
    'zonal africa open'],
  'African Zonal Senior Teams' => [
    'african zonal senior trials'],
  'African Zonal Women Teams' => [
    'african zonal women trials',
    'zonal africa ladies',
    'zonal africa women'],

  'Albena Open Teams' => ['ibf albena'],
  'All India Bangur Cement Hindusthan Club' => [
    'bangur cement hindusthan club'],
  'All India Corporate Invitational Pairs' => [
    'all india corporate invitational',
    'all india invitational corporate',
    'corporate pairs', 
    'corporate invitational pairs'],
  'All India UTI Bank Masters Championship' => [
    'ull aindia uti bank masters championship',
    'all india uti national masters championship',
    'all india utibank masters championship'],
  'Anatolian Club Qualifying' => ['eastern anatolian qualification',
    'eastern anatolýa qualýfýcatýon',
    'turkish interclubs champ_ anatolia elections'],
  'Anatolian Fall Teams' => ['anatolian side fall teams'],
  'Anatolian Open Teams' => ['anatolian side bridge clubs open teams'],
  'Anatolian Spring Teams' => ['anatolia spring teams'],
  'Andrzej Wilkosz Memorial Pairs' => ['a_ wilkosz pro memoriam'],
  'Ankara Summer Teams' => ['ankara summer team championship'],
  'APBF Championships' => ['pabf championship', 'pabf c',
    'asia pacific bridge federation championship',
    'asia pacific bridge federation championships',
    'asia pacific bridge federation champio teams'],
  'ArboNed Team Cup' => ['arbo ned team cup', 'arbo ned teams cup'],

  # ARGENTINA -- mapped in detail
  'Argentinian Copa Republica' => ['copa republica'],
  'Argentinian Mixed Pairs' => ['argentina national mixed pairs'],
  'Argentinian Mixed Teams' => ['argentina equipos mixtos',
    'campeonato nacional equipos mixtos argentino'],
  'Argentinian Open Teams' => [
    'argentina national team championship',
    'argentina open team',
    'argentina open teams',
    'argentina team championship',
    'argentine team', 
    'argentinian open team',
    'cn equipos libres argentina',
    'equipo libres argentina',
    'equipos libres argentina',
    'open argentin team'], 
  'Argentinian Open Trials' => [
    'argentina open trials',
    'argentine team trials', 
    'argentinian team trials',
    'open argentina team trials',
    'open team argentina trials',
    'openargentin team trials', 
    'opteamsudamargentina',
    'seleccion libre argentina',
    'seleccion argentina libre'],
  'Argentinian Seniors Teams' => [
    'clasificatoria seniors argentina',
    'clasificatoria argentina seniors sudamericano'],
  'Argentinian Senior Trials' => [
    'senior argentina team trials',
    'open senior argentina trials', 
    'seleccion argetina seniors',
    'seleccion argentina seniors'],

  'Arnhem Interbridge Tournament' => ['interbridge tournament'],
  'ASEAN Club Championship' => [
    "aseam bridge club c'ship",
    "asean bridge club c'ship",
    'asean bridge club', 
    'asean bridge club championship', 
    'asean bridge club championships',
    'asean bridge club open championships',
    'asean bridg club championship', 
    "asean bridge c'ship",
    'asean bridge cship', 
    'asean bridge championship',
    'asean bridge championships',
    'asean club championships', 
    'asean clubs championships open teams'],
  'ASEAN Open Teams' => [
    'asean bridge finals', 
    'asean bridge open team finals', 
    'asean open'],
  'Asenovgrad Open Teams' => [
    'asenovgrad tournament',
    'national bridge tournament asenovgrad'],
  'Ashok Kapur Memorial Swiss Pairs' => ['ashok kapur memorial',
    'Ashok Kapur Memrial swiss pairs',
    'Ashok Kapur Memrial  swiss pairs',
    'Ashok Kapoor Memorial Swiss Pairs',
    'Ashok Kapoor Memorial  Swiss Pairs',
    'Ashok Kapur Memorial Sw2iss Pairs',
    'Ashok Kapur Memorial  Annual All India Pairs',
    'Ashok Kapur Memorial Swiis Pairs',
    'Ashok Kapur Memorial Swiss IMP Pairs'],
  'Asian University Championship' => [
    'asian university bridge championship'],
  'Atlantic Trade Bridge Cup' => ['atlantic grupa bridge cup'],

  # AUSTRALIA
  'Australian Autumn National Open Teams' => [
    'abf anot',
    'australian autumn national open  teams',
    'autumn national open teams'],
  'Australian Grand National Open Teams' => [
    'abf gnot',
    'grand national open teams'],
  'Australian National Open Teams' => [
    'abf national open teams', 
    'national open teams',
    'national openteams'],
  'Australian Open Teams' => [
    'abf open team trials', 
    'abf oprn trials',
    'aust open', 
    'aust open trials', 
    'austalian open team selections',
    'australian open championships',
    'australian open selection',
    'australian open tream',
    'australian open team',
    'australian open team trials',
    'australian open trials',
    'australian open team trials', 
    'australian open team selection', 
    'australian open teams playoff', 
    'australian open tream selection',
    'australian playoffs'], 
  'Australian Senior Pairs' => [
    'aust seniors pairs',
    'austalian seniors pairs'],
  'Australian Senior Teams' => [
    'abf seniors playoff',
    'aus seniors',
    'aus seniors playoff',
    'aus seniors playoffs',
    'aust seniors open', 
    'aust seniors team trial', 
    'aust senriors open', 
    'australian seniors', 
    'australian seniors playoff', 
    'australian seniors playoffs', 
    'australian seniors po', 
    'australian seniors teams', 
    'australian seniors teams playoffs', 
    'australain seniors',
    'sen australian',
    'sen australian playoffs'],
  'Australian Spring Open Teams' => [
    'spring national open teams',
    'spring open teams'],
  'Australian Spring Senior Teams' => [
    'aust spring seniors teams',
    'aust spring seniors', 
    'australian spring seniors',
    'australian spring seniors teams',
    'snot seniors'],
  'Australian Spring Women Teams' => [
    "australian spring women's teams",
    'australian spring womens',
    'snot womens'],
  'Australian Women Teams' => [
    'aust women open team',
    "aust women's team",
    'aust womens team', 
    'aust womens teams', 
    'australian women',
    'australian women po',
    'australian women team selection',
    'australian women team trials',
    'australian women trials',
    "australian women's", 
    "australian women's po", 
    "australian women's team selection",
    "australian women's teams",
    "australian women's selection",
    "australian women's team selection",
    "australian women's team selelection",
    "australian women's trials",
    'australian womens team selection',
    'australian womens team trial', 
    'australian womens teams',
    'australian womens trial',
    'australian womens trials'],
  'Australian Youth IMP Pairs' => [
    'aust youth butler',
    'australian youth butler'],
  'Australian Youth Teams' => [
    'aust youth',
    'aust youth playoff',
    'aust youth selection', 
    'australian youth', 
    'australian youth selection',
    'oz youth selection'],
  'Australian Youth Tri Individual' => ['youth tri individual'],
  'Australian Youth Tri Pairs' => ['youth triathlon pairs'],

  'Austrian Open Teams' => [
    'austrian team championship',
    'austrian team championships'],
  'Avia Inter-City Championship' => [
    'avia inter-city bridge championships'],

  ### BBB

  'Bagla Pairs Royale' => ['r_n_bagla pairs royale',
    'r_n_bagla memorial pairs royale', 'r_nbagla pairs royale'],
  'Balaton Invitational Teams' => [
    'balaton international teams',
    'balaton invitation teams'],
  'Balatonföldvár Open Teams' => [
    'balatonfoldvar teams'],
  'Balkan Championship' => ['balkan bridge ch', 
    'balkanbridge championship', 'balkan championships',
    'balkan bridge championship'],
  'Balkan Teams' => ['bolkan team championship',
    'bolkan teams championship', 'bolkan championship'],
  'Baltic Open Teams' => [
    'baltic open teams cup',
    'baltic teams cup'],
  'Baze Senior Knock-out' => ['baze senior ko', 'baze sr_ ko',
    'baze sr_ ko', 'baze sr ko'],
  'Belarusian Open Teams' => ['belarus teams',
    'belarus cup', 'belarus national teams',
    'belarus team championship', 'belarus teams cup',
    'belarusian team championship'],

  # BELGIUM
  'Belgian Open Pairs' => ['belgian open paris'],
  'Belgian Open Teams' => ['belgian teams', 'belgian team',
    'belgian team championship', 'belgium championship',
    'belgium open teams', 'belgian open team'],

  'Bergen Grand Tournament' => ['bergen open',
    'bergen storturnering', 'bergen grand tournamnet',
    'bergen storturnering mester', 'bergen stor mester',
    'bst mester'],
  'Bermuda Bowl' => ['bermuda bow', 'bemruda bowl'],
  'Bermuda Triangle Cup' => ['bermuda triangle teams cup'],
  'BFAME Championship' => ['zone 4 bridge championship',
    'zone4 bridge championship', 'bfame chp', 'bfame championships',
    'bfame bridge championship', 'bfame chamionship'],
  'Bhabha Atomic Research Centre Open' => ['barc open'],
  'BKBT Teams' => ['bkbt match'],
  'B L Rao Memorial Open' => ['open b_l_rao memorial',
    'open b_r_rao  memorial', 'b_l_rao memorial open'],
  'Bobby Evans Senior Teams' => [
    "bobby evans senior's teams",
    'bobby evans seniors teams'],

  # BOLIVIA
  'Bolivian Open Pairs' => ['bolivariano open pairs'],
  'Bolivian Open Teams' => [
    'bbolivariano open teams',
    'bolivariano open teams',
    'bolivarian tournament',
    'campeonato bolivariano de equipos',
    'torneo bolivariano equipos'],

  'Bologna Trophy' => ["trofeo citta' di bologna",
    "trofeo citta' bologna", "citta' di bologna", 
    "trofeo citta' bologna"],

  # BRAZIL
  'Brazilian Open Teams' => [
    'brasil champ', 
    'brasilian championship',
    'brazilian championship',
    'brazilian championships',
    'brazilian chapionship', 
    'brazilian national championship', 
    'brazilian open championship', 
    'brazilian team',
    'brazilian teams',
    'open brazilian championship'],
  'Brazilian Senior Trials' => ['brazilian senior'],
  'Brazilian Women Trials' => ['brazilian ladies trials'],

  'bridge24.pl Trophy' => ['bridge24_pl trophy'],
  'British Gold Cup' => ['gold cup', 'british gold'],
  'Buffett Cup' => ['buffet cup', 'bufett cup'],

  # BULGARIA
  'Bulgarian Open Pairs' => ['bulgaria open pairs championship'],
  'Bulgarian Open Teams' => ['bulgarian national teams championship',
    'bulgarian national championship',
    'bulgaria national teams championship'],
  'Pleven Open Teams' => [
    "bridge tournament \"gabi\"",
    "national bridge tournament \"gabi\"",
    "national tournament \"gabi\"", 
    'national tournament gabi'],
  'Bulgarian Open Trials' => [
    'bulgaria national team trials',
    'bulgarian national team qualification', 
    'bulgarian national team qualifications', 
    'bulgarian national team trial', 
    'bulgarian national team trials',
    'bulgarian national trials'],
  'Bulgarian Women Trials' => [
    'bulgaria women national team trials',
    'bulgarian ladies trial'],

  ### CCC


  # CANADA -- mapped in detail
  'Canadian National Teams Championship' => [
    'canadian a tm', 
    'canadian champ open', 
    'canadian national team',
    'canadian open teams',
    'canadian open teams championship',
    'canadian tm a',
    'can open teams championship',
    'can open team championship', 
    'can_ champ open'],
  'Canadian Seniors Championship' => [
    'canadian champ senior', 
    'canadian champs senior',
    'canadian senior championship',
    'canadian senior teams',
    'canadian senior tm'],
  'Canadian Women Teams Championship' => [
    'can ladies bridge champs',
    'can ladies team champ',
    'cbc womens finals',
    'cbf womens final',
    'cbf womens finals'],

  'Cavendish Teams' => ['cavendish tms', 'cavendish team'],
  'Central American & Caribbean Championship' => [
    'central america & caribean championship'],
  'Central American Zonal Championships' => ["cacbf zonal ch'ships",
    'cacbf zonal championship', "cacbf zonal cha'ships",
    "cacbf zonal c'ships", 'cac final'],
  'Centre Island Teams' => ['ci teams'],
  "Chairman's Cup" => ['chairmans cup', "chariman's cup",
    "chairmans's cup", "swedish chairman's cup", 'chairmans cup'],
  "Champions' Cup" => [
    'champions cup', 
    "champion's cup", 
    'chamions cup', 
    'champs cup', 
    'champion cup', 
    "champion'scup", 
    "champions'cup"],
  'Channel Trophy' => ['channel trpohy'],
  'Cherven Briag Open Teams' => [
    'cherven briag',
    'cherven briag national tournament',
    'national tournament cgerven briag',
    'national tournament cherven briag'], 

  # CHILE -- mapped in detail
  'Chilean Cup' => ['copa aniversario'],
  'Chilean Open Pairs' => ['chilean pairs'],
  'Chilean Open Teams' => ['torneo nacional de chile'],
  'Chilean Open Trials' => [
    'chile open team trials',
    'chile team trials',
    'chilean team trials',
    'chilean open trials'],

  # CHINA
  'China Elite Tournament' => ['china elite inivitational tournament',
    'china bridge elite tournament',
    'china bridge elite invitational tournament',
    'bridge elite tournament china'],
  'China First League' => ['the national class a club league',
    'national club league china', 'national club league'],
  'Chinese Club Championship' => ['china bridge club championship',
    'club championships china'],
  'Chinese Mixed Teams' => [
    'ccba mix teams',
    'mixed teams china'],
  'Chinese Open Teams' => ['team championship china'],
  'China Resources Inter-City' => [
    'china resources inter-city bridge championships',
    'china resources land inter-city bridge cham',
    'china resources land  inter-city bridge cham',
    'cr power intercity'],

  'Chinese Taipei Open Trials' => [
    'ctcba chinese taipei open team trials',
    'ctcba chinese taipei open trial',
    'ctcba open team trial',
    'ctcba open team trials',
    'ctcba open trail',
    'ctcba open trial',
    'ctcba trial',
    'chinese taipei open team trail',
    'chinese taipei open team trial',
    'chinese taipei open team trials',
    'chinese taipei team trial', 
    'chinese taipei trails',
    'chinese taipei trials',
    'taipei open trials'],
  'Cliff Wake Challenge' => ['cliff wake invitational'],
  'Commonwealth Nations Bridge Championships' => [
    'commonwealth beidge championship', 
    'commonwealth nations bridge championship', 
    "commonwealth nation's bridge championship",
    'commomwealth bridge championship',
    'commonwealth championship',
    'commonwealth bridge championship'],

  # CZECH
  'Czech Championship' => ['czech bridge championship',
    'czech bridge championships'],
  'Czech First League' => ['czech bridge league', 'czech bridge league',
    'czech premier league'],
  'Czech Team Championship' => ['czech team championships',
    'czech teams champ_'],
  'Czech First League' => ['czech 1st league', 'czech bridge league',
    'czech premier league'],

  'Collegiate Bowl' => ['collegiate championship',
    'collegiate championships', 'collegiate champs'],
  'Computer World Championship' => ['computer bridge championship',
    'computer bridge', 'computer world bridge championships'],

  ### DDD

  'Damiani Trophy' => [
    'damiani cup',
    'world junior teams'],
  "d'Orsi" => ["d'orsi senior bowl",
    'seniors bowl', 'senior bowl'],
  'Dainik Navjyoti All India Inter-State' => [
    'Dainik Navjyoti All India Interstate',
    'Dainik Navjyoti All India Inter -State'],

  # DENMARK: Mapped in detail
  'Copenhagen Open Pairs' => ['km åben par'],
  'Danish Club Teams' => [
    'danish club team', 
    'danish district teams championship',
    'dm klubhold',
    'dm i klubhold', 
    'dm i knubhold', 
    'dm i klub hold',
    'dmi i klubhold'],
  'Danish Cup' => [
    'danmark pokal', 
    'danmark pokal match', 
    'denmark pokal',
    'vinoble cup'],
  'Danish First Division' => [
    '1_ division danmark',
    'danish 1st division', 
    'danish 1_division',
    'danish team', 
    'danish team champions',
    'danish team championship',
    'danish team championships', 
    'danmark 1_ division',
    'danmark 1_division', 
    'danmark 1st division', 
    'denmark 1st division',
    'denmark 1_division',
    'denmark team championship',
    'dm hold'], 
  'Danish Junior Teams' => [
    'danish junior team championship', 
    'dansih junior team championship', 
    'junior dm'],
  'Danish Mixed Pairs' => [
    'dm mix',
    'dm mix par', 
    'danish championship mixed pairs',
    'danish mix-pair championship', 
    'danish mix pair championship',
    'danish mix pairs',
    'danish national mix-pairs championship'], 
  'Danish Open Pairs' => [
    'danish championship open pairs', 
    'danish open pairs championship', 
    'denmark national open pair championship',
    'denmark national open pairs championship',
    'danish open pairs championships',
    'danish pairs championship',
    'open pairs - danish championship'],
  'Danish Open Teams' => [
    'danish open',
    'danish open team', 
    'danish open teams'],
  'Danish Open Pairs Trials' => [
    'danish team test',
    'danish teams test'], 
  'Danish Open Trials' => [
    'danish open team trials',
    'danish team trial',
    'danish team trials',
    'denmark team test'],
  'Danish Women Pairs' => [
    'danish championship ladies pairs', 
    'danish champoinship ladies pairs',
    'ladies pairs - danish championship'],

  'Delhi Gymkhana Club Open Teams' => [
    'delhi gymkhana centenary celebrations',
    'delhi gymkhana championship',
    'delhi gymkhana club centenary',
    'delhi gymkhana club centenary celebrations',
    'delhi gymkhana club championship',
    'delhi gymkhana club open',
    'delhi gymkhana club open championship',
    'delhi gymkhana open championship',
    'delhi gymkhana open chmpionship',
    'dgc centenary celebrations',
    'dgc centenary tournament',
    'dgc open championship'],
  'Division Nationale' => ['division natonale', 'division ntionale',
    'division natinale', 'divison nationale', 'french dn1', 'div_nat',
    'france div_ nat_ 1', 'div_ nat_', 'division nationale 1',
    'divisionnationale 1', 'nationale interclubs division 1', 'dn1',
    'nationale division 1', 'division nationale 1'],
  'Dongming Knock-out Teams' => ['dong ming knockout teams',
    'dong ming knockour teams', 'ding ming knockout teams'],
  'Dr. Rand Masters' => ['dr_ rand masters'],
  'Dutch Knock-Out Cup' => ['knock-out team cup netherlands',
    'knock out team cup netherlands'],
  'Dutch Meesterklasse' => [
    'dutch mk', 
    'dutch team',
    'dutch teams',
    'dutch club teams'],
  'Dutch Women' => ['ducth woman'],

  ### EEE

  'EcoSoft Cup' => ['eco soft cup'],
  'Ecuador Open Teams' => [
    'ecuador open team trials',
    'ecuador teams champinonship'],

  # EGYPT
  'Egyptian Cup' => ['egy-cup', 'egypt cup', 'egypt-cup', 'egy cup',
    'egy_cup'],
  'Egyptian League' => ['egy_league', 'egy-league',
    'egyptian premier league'],

  # ENGLAND
  'English Open Trials' => [
    'english open trial',
    'enlish open trials', 
    'english open team trials',
    'english open teams trial',
    'english open teams trials'],
  'English Premier League' => ['engish premier league',
    'england premier league', 'english premie league',
    'englush premier league', 'english premier lge'],
  'English Senior Trials' => [
    'england senior trial',
    'england senior trials', 
    'england senior teams trial',
    'england senior trial',
    'english seniors',
    'english senior european trials',
    'english seniors european trials',
    'english senior teams',
    'englnd senior trials'], 
  'English U28 Trials' => ['england u28 trials'],
  'English Women Teams' => ['english national womens teams'],
  'English Women Trials' => [
    "england ladies' trials",
    'english ladies trials',
    "english ladies' trials",
    'lady milne trials'],

  # ESTONIA
  'Estonian First League' => ['estonian a- league',
    'estonia a- league'],
  'Estonian Open Teams' => ['estonian team championship',
    'estonian team championships', 'estonian open teams',
    'estonia teams championships', 'est teams champs',
    'estonian teams championships'],
  'Estonian Open Pair Trials' => [
    'estonian open trials',
    'estonian team trials'],
  'Estonian-Latvian Open Team Trials' => [
    'estonian-latvian national team trials',
    'estonian-latvian open trials',
    'estonian latvian team trial',
    'estonian latvian team trials',
    'estonian-latvian team trials'],

  'Estoril Open Teams' => [
    'estoril international teams', 
    'estoril internacional teams',
    'estoril swiss teams',
    'estoril teams'],

  # EUROPE -- mapped in detail
  "European Champions' Cup" => ['european champs cup'],
  'European National Mixed Teams' => [
    'euro mixed teams',
    'european mixed teams'],
  'European National Open Teams' => [
    'eur champ pau open'],
  'European National Women Teams' => [
    'eur champ pau woman',
    'eur champ pau women',
    'eur women champ'],
  'European National Seniors Teams' => [
    'eur champ pau senior',
    'eur champ pau seniors'],
  'European Small Federation Games' => ['ebl small federation trophy',
    'ebl small federations trophy', 'games of small federations',
    'european small federations games', 'small federation games',
    'small federations games', 'small ffederations games',
    'small federation cup', 'european small feds games',
    'small f federations games', 'europian small federation games'],
  'European Transnational Mixed Teams' => [
    'euro open mixed teams'],
  'European Winter Teams' => [
    'zimmermann cup'],
  'Generali European Open Teams' => [
    'generali euro team champs',
    'generali european team championships'],

  ### EURO-YOUTH: Mapped in detail
  'European U16 Open Teams' => [
    'ebl schools'],
  'European U21 Open Teams' => [
    'euro yongster championships',
    'euro youngster championship',
    'euro youngster championships',
    'euro youngsters championship',
    'euro youngsters championships',
    'european youngster bridge championship'],
  'European U26 Mixed Pairs' => [
    'em pairs junior mix',
    'european mixed pairs pairs',
    'eyjc mixed pairs',
    'junior em mix'],
  'European U26 Open Pairs' => [
    'european youth bridge pairs championship',
    'european youth pairs'],
  'European U26 Open Teams' => [
    'ebl juniors',
    'euro juniors championship',
    'euro juniors championships',
    'european junior teams',
    'european junior teams championship',
    'european junior teams championships',
    'euroepan junior teams championships',
    'european juniors championship',
    'european juniors championships',
    'european youth teams u26',
    'european youth bridge team champ', 
    'european youth teams'],
  'European U26 Women Teams' => [
    'european girls championships',
    'european girls teams',
    'euro girls championships'],
  'European University Bridge Championship' => [
    'european university championship',
    'european universities bridge championship',
    'european univeristies bridge championship',
    'european universities championship',
    'european unibridge championship',
    'european uni bridge championship',
    'european uni championship'],
  'European University Team Championship' => [
    'european universities bridge trophy',
    'eusa games'],

  ### FFF

  'Faroese Open Teams' => [
    'faroese tc', 
    'faroese team championships',
    'faroese teams'],
  'Filbyter Cup' => ['filbyer cup'],

  # FINLAND
  'Finnish Open Pairs' => [
    'finnish open pairs championship', 
    'finnish pair championship',
    'finnish pair championships', 
    'finnish pairs',
    'finnish pairs championship',
    'finnish pairs champs'],
  'Finnish Open Teams' => [
    'finnish team championship',
    'finnish team championships',
    'finnish teams championship',
    'finnish teams championships',
    'finnish teams'],
  'Finnish Open Trials' => [
    'finnish national team qualifications',
    'finnish open team qualifications',
    'finnish team trials',
    'finnish teams trials'],
  'Finnish Senior Trials' => [
    'finnish senior qualifications',
    'finnish senior teams trial', 
    'finnish senior teams trials',
    'finnish teams senior trials'],
  'Finnish Swiss Pairs' => [
    'finnish open imp championship',
    'finnish swiss imps championship',
    'finnish swiss imps championships',
    'finnish swiss-imps championships', 
    'finnish swiss-ims championships'],
  'Finnish Women Trials' => [
    'finnish women teams trials'],

  'Forest Trophy' => ['forest bridge trophy'],
  'forumbridge.pl Top Individual' => ['forumbridge_pl top individual'],
  'forumbridge.pl Top Pairs' => ['forumbridge_pl top pairs'],
  'FOSS Grand Tournament' => ['foss grand tourney', 'foss grnad tourn',
    'foss grand tourament', 'foss grand tournement',
    'foss grand toruney', 'ftredriklstad and sarpsborg grand tournet',
    'foss grand torunament', 'foss grand torurnament',
    'foss grand torurney'],
  'Four Nations Cup' => ['4 nations cupn', '4 nations cup'],

  # FRANCE
  'French Cup' => ['coupe de france', 'de la coupe de france'],
  'French First Division' => [
    'division natinale open _ 4 d1',
    'division nationale', 
    'division nationale 1',
    'division nationale1_4',
    'division nationale1 _4',
    'division nationale open 1_ 4',
    'division nationale open 1 _4',
    'division nationale open 1 _ 4',
    'division nationale open_4 d1',
    'division nationale open_ 4 d1',
    'division nationale open _4 d1',
    'division nationale open _ 4 d1',
    'division nationale 1 open_4 d1', 
    'dno_4 d1',
    'dn0_4 division 1',
    'dn0_4 d1',
    'dno0_4 d1',
    'interclub d1',
    'interclubs d1', 
    'interclubs division1', 
    'interclub finale d1',
    'interclubs finale nationale division1',
    'nationale interclub d1'],
  'French Intercircle' => ['finale intercercle'],
  'French Junior Trials' => ['french junior trial',
    'french juniors trials', 'french juniors trial',
    'sélection junior france',
    'selection junior france'],
  'French Open Teams' => ['french teams championship'],
  'French Open Trials' => ['french open team trial',
    'french opentrial', 'french teams trial', 'french teams trials',
    'french open trial', 'french opentrial',
    'selection pekin', 'séléction pékin',
    'selection francaise pau',
    'selection francaise - pau',
    'selection francaise pour pau',
    'sélection pau', 'selection pau'],
  'French Senior Trials' => ['french seniors trials',
    'french senior trials', 'french seniors selection',
    'french senior trial', 'french seniors trial',
    'selection senior france',
    'selection senior pekin',
    'selection senior pau', 'sélection senior pau'],
  'French U28 Trials' => ['selection junior pekin', 'selection u28 pekin'],
  'French Women Trials' => ['entrainement venice cup'],

  'FTBC Tanjungpura University' => ['ftbc university tanjungpura'],
  'FullBridge International Teams' => ['internacional equipos full bridge',
    'internacional full bridge'],
  'FX Securities Cup' => ['fx sec_ cup'],

  ### GGG

  'Gabrial UI Bastaman Cup' => [
    'bastaman cup',
    'gabrial-ui cup',
    'gabrial ui cup'],
  'Geologi Cup' => ['geo cup'],
  'Glasgow Transnational Open Teams' => ['tnt glasgow'],
  'Goulyash by E. Gladysh' => ['goulyash by e_gladysh'],

  # GERMANY -- mapped in detail
  'Bonn Nations Cup' => ['nations cup germany', 'bonn cup'],
  'German Club Cup' => [
    'german cup', 
    'vereinspokal', 
    'dbv-cup', 
    'dbv cup',
    'dbv-pokal'],
  'German Mixed Teams' => [
    'deutsche mixed-teammeisterschaft',
    'deutsche mixed teammeisterschaft'],
  'German Open Pairs' => [
    'german men pairs', 
    'german mens pairs',
    'germany mens pairs',
    'Dr. Heinz von Rotteck Pokal',
    'dr_-heinz-von-rotteck-pokal',
    'v_-rotteck-pokal'],
  'German Open Teams' => [
    'offene deutsche teammeisterschaft',
    'offene team meisterschaft',
    'offene team meistershaft', 
    'german open team championships',
    'german open', 
    'german open team',
    'open german team'],
  'German Open Trials' => [
    'deutsche open qualifikation',
    'german open qualification'],
  'German Team Trophy' => [
    'german bridge team trophy',
    'german team bridge trophy', 
    'german bridge trophy'],
  'German Women Pairs' => ['damen-paar'],
  "Gro's Supercup" => ["gro's super-cup", 'gros supercup'],
  'König Ludwig Cup' => ['koenig ludwig nationen cup'],

  'Grand National Teams' => ['gnt championship'],

  # GREECE
  'Greek Central Regional Pairs' => [
    'regional championship of central greece'],
  'Greek Mixed Pairs' => [
    'hellenic mixed pairs',
    'hellenik mixed pairs'],
  'Greek Northern Regional' => [
    'n_ greece regional championship'],
  'Greek Open Teams' => [
    'greek natioanal teams', 
    'greek open nationa team',
    'grekk open national team', 
    'greek open team', 
    'greek open team championship', 
    'greek team',
    'greek teams',
    'hellenic teams championship'],
  'Greek Open Team Trials' => [
    'greek national team trials',
    'greek national teams trials',
    'greek national trials', 
    'greek open nationa team trials',
    'greek open national team trials',
    'greek open team trials',
    'greek trials', 
    'grekk open national team trials',
    'helenic national team trials',
    'hellenic national team trials',
    'hellenic national teams trials',
    'hellenic open team trials',
    'hellenic team trials',
    'hellenic teams trials'], 
  'Greek Women Trials' => [
    'hellenic ladies team trials',
    'hellenic ladies teams trials'],

  'Guangdong Club Championship' => ['guang dong club championship',
    'guang dong club bridge championship'],
  'Guangdong Club Invitational' => [
    'Guangdong province the bridge club invitational t'],
  'Guangdong Elite Tournament' => [
    'guangdong bridge club elites tournament',
    'guangdong bridge club  elites  tournament',
    'guangdong bridge club  elites tournament'],

  'Grand Prix of Prague' => [
    'grand prix prague', 'gp prague'],

  ### HHH

  "Hans Rosendorff Memorial Women's Teams" => [
    'hans rosendorff memorial womens teams',
    'hans rosendorff memorial  womens teams',
    'han rosendorff memorial womens teams'],
  'HNA Open Teams' => ['hna cup', 'hna openteams', 'hna open team',
    "hna's hainan bridge tournament"],
  'Hong Kong Inter-City' => ['hong kong iner-city'],

  # HUNGARY
  'Hungarian IMP Pairs' => ['hungarian imp'],
  'Hungarian Open Pairs' => ['hungarian national pairs'],
  'Hungarian Open Teams' => [
    'hungarian championships',
    'hungarian team championships',
    'hungarian teams', 
    'hungarian teams championship',
    'hungarian teams championships',
    'hungary teams'], 
  'Hungarian Open Trials' => [
    'hungarian team trial',
    'hungarian team trials'],
  'Hungarian Women Trials' => [
    'hungarian woman trials',
    "hungarian woman's trials"],

  ### III

  # ICELAND
  'Iceland Express Teams' => ['iceland express team'],
  'Icelandair Open Teams' => [
    'icelandair open',
    'icelandair team championship',
    'icelandari open'],
  'Icelandic Cup' => [
    'bikarkeppni bsí', 
    'icelandoc cup',
    'iceland cup'],
  'Icelandic Open Teams' => [
    'iceland teams',
    'icelandic team', 
    'icelandic team championship', 
    'icelandic team championsship',
    'icelandic team chapmionship', 
    'icelandic team championships',
    'icelandic teamhampionship', 
    'icelandic teams'],

  # INDIA
  'Indian Open Trials' => [
    'indian open selection trial',
    'indian open selection trials',
    'indian open team selection trials',
    'indian open team selectiontrials',
    'indian open teams selection trial',
    'indian open teams selection trials',
    'india selection trial'],
  'Indian Senior Trials' => [
    'indian senior selection triaals',
    'indian senior selection trials',
    'indian senior team selection',
    'indian senior team selection triaals',
    'indian senior team selection trial',
    'indian senior team selection trials',
    'indian senior teams selection',
    'indian senior teams selection trials',
    'indian seniors team selection trials',
    'indian seniors team trials',
    "indian seniors' team trials",
    'indian seniors selection trials',
    "indian seniors' team trials"],
  'Indian State Championship' => ['state level bridge championship',
    'state level bridge tournament',
    'state level bridgee championship'],
  'Indian Western Zone Championship' => [
    'cba wz India'],
  'Karnataka State Teams' => [
    'ksba golden jubily'],
  'Mohan Sicka BAM Teams' => [
    'mohan sicka',
    'mohan sicka bam',
    'mohan sicka trophy'],
  'Mohan Sicka Pairs' => [
    'sickka pairs'],

  # INDONESIA
  'Indonesian U26 Women Pair Trials' => [
    'indonesian girls u26 selection',
    'indonesia girls u26 selection'],
  'Indonesian Inter-City Championship' => [
    'ina intercity national chams',
    'ina intercity national champs'],
  'Indonesian Inter-Club Championship' => [
    'ina interclub national champs',
    'national indonesian championship (inter-club'],
  'Indonesian Inter-Province Championship' => [
    'uji coba'],
  'Indonesian Junior League Online' => [
    'icba junior league online'],
  'Indonesian U16 Pair Trials' => [
    'indonesian kids national selection',
    'indonesian kids trials'],
  'Indonesian Premier League' => [
    'indonesian bridge league',
    'indonesia bridge league', 
    'indonesia premier league'],
  'Indonesian Mixed Pair Trials' => [
    'indonesian mixed national selection'],
  'Indonesian Open Pair Trials' => ['indonesian pairs trials'],
  'Indonesian Open Teams' => [
    'indonesia open team',
    'indonesian open team',
    'indonesia national open team',
    'indonesian national open team'],
  'Indonesian Open Trials' => ['indonesian men national selection',
    'indonesian men selection'],
  'Indonesian U21 Trials' => ['indonesian u21 selection',
    'indonesia u21 selection', 'indoneian u21 selection',
    'indonesian u21 selekction'],
  'Indonesian U26 Trials' => ['indonesian u26 selection'],
  'Indonesian Women Trials' => ['indonesian women national selection'],


  # IRELAND -- mapped in detail
  'Irish Invitational Pairs' => [
    'ireland invitational pairs',
    'irish invitational matchpoints'],
  'Irish Open Trials' => [
    'ibu trials',
    'ireland trials', 
    'ireland camrose trials', 
    'ireland lady milne trials', 
    'irish bridge union trials',
    'irish bridge union open trials',
    'irish camrose trials', 
    'irish trials'],

  # ISRAEL
  'Israel Cup' => [
    'israel team cup', 
    'israel team of four cup', 
    'israeli teams cup'],
  'Israel Juniors Pairs' => [
    'israel juniours pairs'],
  'Israel Juniors Trials' => [
    'israel juniors team trials',
    'israeli juniors trials',
    'israeli juniors team trials'],
  'Israel Open Pairs' => [
    'israel pairs', 
    'israel pairs champ',
    'israeli pairs championship'],
  'Israel Open Teams' => [
    'israeli open team', 
    'israel teams',
    'israel team champ_',
    'israel team championship', 
    'israelairs champ_',
    'israeli team champ_'],
  'Israel Open Trials' => [
    'israel open team trials',
    'israel open trials', 
    'israel team trials',
    'israeli open team trials'],
  'Israel School Trials' => [
    'israel schools trials',
    'israel schools teams trials'],

  'Istanbul Teams' => [
    'istanbul team championship', 
    'istanbul team championships',
    'istanbul club teams championship',
    'ýstanbul championship',
    'ýstanbul teams'],
  'Istanbul Winter Teams' => [
    'istanbul kis dortlu takimlar',
    'istanbul kis dortlu takim', 
    'istanbul winter champs',
    'istanbul kis'],
  'Izmir Teams Cup' => [
    'izmir open teams championship',
    'izmir open teams championships',
    'izmir teams',
    'izmir teams championship',
    'izmýr teams cup'],

  # ITALY -- mapped in detail
  'Italian Club Open Championship' => ['camp_ soc_ open'],
  'Italian Club Women Championship' => [
    'italian club team champ women',
    'italian club women championships'],
  'Italian Mixed Cup' => ['italy mixed cup'],
  'Italian Mixed Pairs' => ['italy mixed pairs'],
  'Italian Mixed Teams' => ['italian mixed teams championships'],
  'Italian Open Teams' => [
    'italian open team championships',
    'italian team championship',
    'camp.it.squadre',
    'camp.it. squadre'],
  'Italian Open Trials' => ['italian open teams trials'],
  'Italian Senior Trials' => ['italian senior teams trials'],
  'Italian U36 Teams' => ['Italian Master U36'],

  ### JJJ

  'Jaap Kokkes Tournament' => [
    'jaap kokkes toernooi',
    'jaap kookes toernooi',
    'jaap kokkes'],
  'Janina Wielkoszewska Memorial Open' => [
    'memorial im_ janiny wielkoszewskiej open'],
  'Janos Levai Memorial' => [
    'levai janos cup',
    'levai janos memorial'],
  'Japanese Open Trials' => ['japanese open team trial',
    'japanese open team trials'],
  'Jaya Jain Memorial' => ['mrs_ jaya jain memorial'],
  'Jean Besse Cup' => ['cup jean besse', 'cup jean besser'],
  "Jessheim New Year's Cup" => ['jessheim new years cup',
    'jesshiem new years cup', 'jessheim new years cup swiss teams'],
  'Jordan Open Pairs' => [
    'jordanese open pairs'],
  'Jordan Mixed Pairs' => [
    'jordan spring mix pairs',
    'jordan spring mixed pairs'],
  'Józef Pochron Jubilee Pairs' => [
    'around 52 cards in 80 years by joe pochron'],
  'JP Morgan Inter-City Championship' => [
    'JP Morgan Inter-City Bridge Championship',
    'JP Morgan Intercity Bridge Championships',
    'JP Morgan Intercity Bridge Championships-Open',
    'JP Morgan Intercity Bridge Championships-Open T_',
    'JP Morgan Intercity Bridge Championships-Open  T_'],
  'Junior Camrose' => ['juniior camrose'],
  'Justice J M Lal All India Open Teams' => [
    'justice j m lal all india open',
    'justice j m lal memorial',
    'justice j m lal memorial championship',
    'justice j_m_lal memorial championship',
    'justice j_m_lal memorial  championship',
    'justice jm lal memorial championship',
    'justice  j m lal memorial all india open',
    'justice lal memorial',
    'j m lal memorial'],

  ### KKK

  'Kalani Trophy' => ['kalani bridge championship', 'kalani trohy',
    'kalani bridge champioship'],
  'Karlovo Open Pairs' => ['karlovo pairs'],
  'Karlovo Open Teams' => ['karlovo teams'],
  'Karnik-Vaidya Open' => ['karnik vaidya open',
    'karnik-vaidya annual'],
  "Kepri Governor's Cup" => [
    'bi cup',
    'gov bi cup', 
    'governor cup', 
    'governor kepri cup', 
    'gubernur kepri cup', 
    'guvernor kepri cup',
    'kepri bridge championship', 
    'kepri cup',
    'kepri governor cup', 
    'kepri governors cup', 
    'kepri international tournament',
    'kepri international bridge tournament'],
  'Krakow Spring Teams' => [
    'krakowska wiosna',
    'spring of cracow'],
  'Krommenie Nations Cup' => [
    'forbo krommenie teams',
    'forbo teams',
    'forbo-krommenie tournament',
    'forbo-krommenie international bridge event',
    'international forbo krommenie bridge event',
    'forbo-krommenie tourname'],

  ### LLL

  'Lady Milne Trophy' => ['lady milne', 'lady mile'],
  'Lalit Mohanka Memorial' => ['lalit mohanka memorials'],
  'Las Palmas Simultaneous Pairs' => ['simultaneo de mayo las palmas'],
  'L C Sunil Rajendra Memorial' => ['l_c_sunil rajendra memorial'],
  'Lebanese Invitational Teams' => [
    'lebanese invitational team',
    'lebanon invitational team',
    'lebanon invitational teams'],
  'Lederer Memorial Trophy' => ['lederer memorial',
    'lederer trophy'],
  'Leszek Kwiatkowski Memorial Teams' => [
    'teams memorial of leszek kwiatkowski'],
  "Linda Stern Women's Teams" => ['linda stern womens teams'],
  'Lithuanian Open Teams' => ['lithuanian teams championship'],
  'Lokmanya Jubilee' => ['lokmanya ss silver jubilee',
    'lokmanya ss siver jubliee', 'lokmanya golden jubilee'],
  'Lüleburgaz Liberation Cup' => ['luleburgaz kurtulus kupasi'],

  ### MMM

  'Maccabi Games' => ['maccabi-games', 'europ_ maccabi games'],
  'Madeira Open Teams' => [
    'madeira internacional', 
    'madeira internacional open',
    'madeira international open',
    'madeira international teams',
    'madeira international teams open´s',
    'madeira international teams open',
    'madeira swiss',
    'madeira swiss teams',
    'madeira teams', 
    'swiss teams madeira'], 
  'Madras Gymkhana Club Open' => [
    'madras gymkhana open',
    'mgc open',
    'iob madras gymkhana club championship',
    'iob madras gymkhana open',
    'iob maras gymkhana open'],
  'Madrid Senior Teams' => ['equipos senior madrid'],
  'Maharaja Yeshwantrao Holkar National Pairs' => [
    'holkar pairs'],
  'Maharaja Yeshwantrao Holkar National Teams' => [
    'holkars trophy',
    'm yeswantrao holkar bridge championship',
    'm yeswantrao holkar national bridge championship',
    'm yeshwantrao holkar bridge championship',
    'maharaja yashwantrao holkar bridge championship',
    'maharaja yashwant rao holkar bridge championship',
    'yashawantrao holkar championship',
    'yashwant rao holkar bridge championship'],
  'Maharashtra State Teams' => [
    'mitravihar centenary state level',
    'mitravihar club centenary state level',
    'mitravihar nasik centenary state level'],
  'Marit Sveaas Tournament' => [
    'marit sveaas international bridge tournament',
    'marit sveaas international  bridge tournament'],
  'McConnell Cup' => ['mc connell'],
  'Mike Lawrence Exhibition' => ['m lawrence exhibiton'],
  'Milan Trophy' => ["trofeo citta' di milano", "citta' di milano"],
  "Missouri Braggin' Rights" => ['bragging rights'],
  'Mohanlal Bhartia Memorial Grand Prix' => [
    'bhartia memorial gran prix',
    'bhartia memorial grand prix',
    'mohanlal bharatia grand prix', 
    'mohanlal bharatia memorial grand prix',
    'mohanlal bharatiya memorial gran prix',
    'mohanlal bharia memorial',
    'mohanlal bharia memorial grand prix',
    'mohanlal bhartia grand prix',
    'mohanlal bhartia memorial',
    'mohanlal bhartia memorial gp',
    'mohanlal bhartia memorial grand prix',
    'mohanlal bhartiya grand prix',
    'mohanlal bhartiya memorial',
    'mohanlal bhartiya memorial grand prix',
    'mohanlal bhartiya memorial gran prix',
    'mohon lal bharatia grand pix',
    'mohnlal bhartia grand prix'],
  'Mohanlal Bhartia Memorial Pairs' => [
    'bhartiya memorial'],
  'Mondial de Deauville' => [
    "barrière champion's cup",
    "barriere champion's cup", 
    'barriere championship', 
    'barriere championship deauville', 
    'barrière championship', 
    'champion ship barriere',
    'champions barriere',
    "deauville championship's tournament",
    'mondial barriere deauville', 
    'mondial barrière de deauville',
    'mondial deauville',
    'mondial de deauille',
    'montial de deauville', 
    'tournoi des champions',
    'tournoi des champions barriere'],
  'Moscow Sunday Times' => ['russian sunday times'],
  'Murat Kilercioglu Turkish Spring Teams' => [
    'Murat Kilercioglu Spring Teams'],

  ###  NNN

  'NABC Senior Knock-Out Teams' => ['nabc senior ko teams'],
  'Nandu Oke Memorial IAF Swiss Pairs' => [
    'nandu oke memorial',
    'nandu oke memorial swiss pairs',
    'nandu oke memorial swiis pairs'],
  'Narain Bhojwani Memorial' => [
    'Narayan bhojwani cup',
    'narayan bhojwani cup teams',
    'n_ bhojwani cup',
    "otter's cup open",
    "otter's club open"],
  'NEC Cup' => [
    'nec cup bridge festival'],
  'Necmettin Sunget Teams Cup' => [
    'necmettin sunget teams',
    'necmettin sünget dörtlü',
    'necmettin sünget dörtlü takýmlar'],
  'Neighbor Challenge' => ['neighbour challenge'],
  'New South Wales Open Teams' => [
    'new south wales state teams',
    'nsw open teams',
    'nsw state teams'],
  'New South Wales Open Trials' => [
    'nsw interstate open team trials',
    'nsw interstate open team selection',
    'nsw interstate open teams selection',
    'nsw interstate team selection',
    'nsw interstate teams selection'],
 "New Year's Teams" => ['new year greet tm'],

  # NEW ZEALAND -- mapped in detail
  'New Zealand Inter-Provincial Open Teams' => [
    'nz interprovincial',
    'nz interprovincials',
    'new zealand inter provincials'],
  'New Zealand Open Teams' => ['nz teams'],
  'New Zealand Open Trials' => [
    'new zealand trials',
    'nz trials'],

  'NN Cup' => ['nn-cup'],

  'Nordic Cup' => [
    'rottneros cup',
    'rottneros nordic cup'],
  'Nordic Junior Pairs' => [
    'nordic junior pair championship',
    'open nordic junior pair', 
    'open nordic junior pairs'],
  'Nordic Junior Teams' => [
    'nordic junior team championship',
    'nordic junior team championships',
    'nordic junior teams championship',
    'nordic junior teams championships'],
  'Nordic Open Teams' => [
    'nordic championship open class',
    'nordic open championship'],
  'Nordic Security Pro-Am Pairs' => [
    'Nordic Security Play against the stars'],
  'Nordic Women Teams' => [
    'nordic women championship',
    'nordics (women)'],

  'Northern Territory Gold Teams' => ['nt gold teams'],
  'Northern Territory Gold Swiss Pairs' => ['nt gold swiss pairs',
    'nt gold swis pairs', 'nt gold swiss piars'],

  # NORWAY
  'Norwegian Club Teams' => [
    'club team championship norway', 
    'nor club teams ch_ship', 
    'nor_club teams ch_ship',
    'nor club teams',
    'nor. club teams ch.ship',
    'norwegian ch ship teams', 
    'norwegian club team',
    'norwegian club-team',
    'norwegian club team championship',
    'norwegian clubteams championship',
    'norwegian clubteams ch_ship',
    'norwegian clubteam championship', 
    'norwegian clubs team', 
    'norway club team championship',
    'norway club-team championship',
    'norway km teams'], 
  'Norwegian Corporate Championship' => ['norwegian corp_ championship'],
  'Norwegian Mixed Pairs' => [
    'nm mix pairs',
    'nor mixed pairs ch_ship', 
    'norwegian championship mix swiss pair',
    'norwegian championship mix swiss pairs',
    'norwegian championship mixed swiss pairs',
    'norwegian championship open mixed pairs',
    'norwegian championships mixed pairs',
    'norwegian mixed pair championship',
    'norwegian mixed pairs championship',
    'norwegian mix pairs championship'],
  'Norwegian Mixed Teams' => [
    'norwegian championship mix swiss teams',
    'norwegian championship mix teams'],
  'Norwegian Open Pairs' => [
    'nbf norwegian pairs', 
    'nm pairs',
    'nm-pairs', 
    'norwegian championship open pairs',
    'norwegian pairs championship',
    'norwegain pairs', 
    'norwegian pairs'],
  'Norwegian Open Teams' => [
    'nm open teams',
    'norwegian championship open teams',
    'norwegian chship teams',
    'norwegian chships teams',
    'norwgian open teams championship', 
    'norwegian chmp teams'],
  'Norwegian Premier League' => [
    'norw premier league',
    'norway sm',
    'norwegian prremier league',
    'nbf premier league', 
    'nor premier league',
    'norvegian premier league',
    'sm norway'], 
  'Norwegian Senior Teams' => ['nbf senior team championship'],
  'Norwegian Swiss Pairs' => [
    'nm monrad pairs', 
    'nm swiss pairs', 
    'nor swiss pairs',
    'norwegian championship siwss pairs',
    'norwegian open swiss pairs',
    'norwegian swiss open pairs',
    'norwegian swiss pairs championship'],
  'Norwegian Swiss Teams' => [
    'nm-monrad-lag', 
    'nm monrad lag', 
    'nm-monrad-teams', 
    'nm-monrad teams', 
    'nor swiss teams',
    'norwegian championship open teams swiss',
    'norwegian championship swiss teams',
    'norwegian swiss team championship'], 
  'Norwegian Team Trials' => ['nor team trials',
    'norwegian open trials',
    'norwegian wbg qualification'],
  'Norwegian Teams' => [
    'norewegian chship temas',
    'norwegian championships teams',
    'norwegian team championship', 
    'norwegian team championships', 
    'norwegian teams ch_ship',
    'norwegian teams ch.ship',
    'norwegian teams ch.ships', 
    'norway team championship',
    'norway teams championship',
    'norway teams championships'],
  'Norwegian Women Teams' => ['norwegian ladies team championship',
    'norwegian ladies teams',
    'nbf women team championship',
    'nbf women teams championship',
    'nbf womens team championship',
    'norwegian women team championship',
    'norwegian womens team championship'],

  'NYSA Euroregion Nations Cup' => ['cup of euroregion nysa'],

  ### OOO

  'Olona International Teams' => [
    'international olona bridge team'],
  'Olrud Easter Mixed Pairs' => ['olrud easter mixed'],
  'Olrud Easter Swiss Pairs' => [
    'olrud easter pairs'],
  'Olrud Easter Swiss Teams' => [
    'olrudpaasken monrad lag',
    'olrud easter',
    'olrud easter tournament',
    'olrud easter swiss event', 
    'olrud easter swiss team', 
    'olrud easter teams',
    'olrud easter team-event',
    'olrud easter tourn',
    'olrud estern teamevent', 
    'olrud estern team-event',
    'olrud paasken monrad lag', 
    'olrud swiss teams', 
    'olrudpaasken teams'],

  'Open Catalunya Preferent' => ['open catalunya equips',
    'open cataluña preferent', 'open preferent equips',
    'open preferent', 'open equips preferent'],
 'Opening Tournament' => ['opening tournement'],
  'Otters Inter-Club Teams' => [
    'otters club open',
    'otters interclub championship'],

  ### PPP

  'Pakistan Day Bridge Championship' => ['pakistan day bridge'],
  'Pakistan Open Trials' => [
    'pakistan national trials',
    'pakistan open national trials',
    'pakistan open team national bridge trials',
    'pakistan open team naational trials',
    'pakistan open team national trials',
    'pakistan open team trials', 
    'pakistan trial'],
  'Pan Arab Inter-Club Championship' => ['pan arab championship',
    'pan arab inter_club', 'pan arab interclub',
    'pan arab inter-club', 'pan arab inter club', 'pan arab iner club'],
  'Patton de Monaco' => ["monaco's patton", 'patton international monaco',
    'patton international monte-carlo',
    'patton international monte carlo', 'patton monte carlo'],
  'Pärnu Summer Invitational Pairs' => [
    'pärnu summer_ invitational pairs_', 
    'parnu summer tournament_ invitatoinal pairs',
    'pärnu summer tournament_ invitational pairs_'],
  'Petit Grand Prix van Driene' => ['petit grand prix',
    'grand prix van driene'],
  'Pertamina Field Tambun Cup' => ['pertamina ep field tambun cup'],
  'PLN Cup' => ['pln fortuga'],
  'Plock District League' => ['plockiej ligi okregowej'],
  'Poddar National Masters' => ['poddar national master',
    'poddar nationals masters', 'podder national masters',
    'podder nationals masters'],

  # POLAND -- mapped in detail
  'Grand Prix of Poland Pairs' => [
    'gp polski par',
    'gpp mpp open',
    'grand prix plolski par',
    'grand priix polski par',
    'grand prix pairs of poland',
    'gran prix pairs of poland',
    'grand prix polski par',
    'otp puchar grodu staszica gpp',
    'pair grand prix of poland'],
  'Grand Prix of Poland Teams' => [
    'gp of poland teams',
    'gpp teamow',
    'grand prix of poland zulawski teams',
    'grand prix polski teamow',
    'grand prix team of poland',
    'poznan open teams',
    'poznan teams tournament',
    'team grand prix of poland',
    'teams grand prix of poland'],
  'Polish BAM Teams' => ['bam team championship of poland'],
  'Polish Boys Championship' => ['polish championship boys'],
  'Polish Business League' => ['blb'],
  'Polish First League' => [
    'polish 1st division', 
    'polish first division', 
    'i liga'],
  'Polish Girls Championship' => ['polish championship girls'],
  'Polish IMP Pairs' => [
    'butler polish championship',
    'butler (imp) polish pairs championship'],
  'Polish Individual Championship' => [
    'forumbridge.pl top individual',
    'individual championship of poland',
    'polish top individual',
    'top indyvidual'],
  'Polish Mixed Pairs' => [
    'otwarte mistrzostwa poznania mixt',
    'mixed championship of poland',
    'polish mixed pairs championship',
    'polish mixed pairs championships',
    'polish mixt pairs championship'],
  'Polish Mixed Teams' => [
    'mistrzostwa polski teamów mikst',
    'polish mixt team championships'],
  'Polish Open Pairs' => [
    'forumbridge.pl top pairs',
    'inea cup',
    'open pairs championship of poland',
    'polish championship open pairs',
    'polish open pairs championship'],
  'Polish Open Teams' => [
    'mistrzostwa polski teamów',
    'polish open team championship',
    'polish open tems',
    'polish team championship',
    'polish teams championship',
    'team championship of poland',
    'teams championship of poland'], 
  'Polish Open Trials' => [
    'polish bermuda bowl trials',
    'polish national trials',
    'polish team trials', 
    'polish trials',
    'polish trials open'], 
  'Polish Patton Teams' => [
    'poland championship patton',
    'polish championships team patton',
    'polish teams patton'],
  'Polish Premier League' => [
    'mecz o superlig©', 
    'mecz o superlige',
    'mecz o superligê',
    'polish premier leauge', 
    'polish premier legaue',
    'polish premier legue',
    'polish premier leuge', 
    'polish premier leuge', 
    'polish premier leaugue', 
    'polish premiere league'],
  'Polish School Championship' => [
    'polish schools champ',
    'polish schools championships'],
  'Polish Second League' => ['polish 2 league'],
  'Polish Third League' => ['polish league: division 3'],
  'Polish U16 Teams' => [
    'polish u-16 championships',
    'polish u16 championships'],
  'Polish U20 Trials' => ['u20 polish trials'],
  'Polish U25 Trials' => ['poish u25 trials'],
  'Polish Women Trials' => ['polish trials women',
    'polish trials ladies', 'woman trial poland',
    "polish bridge union women's trials"],
  'Pomerania Cup' => [
    'grand prix of greater poland voivodeship',
    'grand prix of wielkopolski',
    'rozgrywek pucharowych pwzbs'],


  # PORTUGAL
  'Portuguese Grand Prix' => [
    'estoril open teams',
    'portugal grand peix',
    'portugal grand prix', 
    'portuguese grad prix'],
  'Portuguese IMP Pairs' => [
    'nacional pares por imps',
    "nacional pares por imp's",
    'nacional pares imps portugal',
    "campeonato nacional pares por imp's"],
  'Portuguese Open Teams' => [
    'equipas open pt', 
    'open teams pt',
    'portugal open teams championship',
    'portuguese cneo', 
    'portuguese national teams',
    'portuguese teams'],
  'Portuguese Open Trials' => [
    'portuguese open trial', 
    'portuguese slection trials',
    'portuguese trials',
    'portuguese trial', 
    'portuguese selection trials'],
  'Portuguese Northern Regional Open Teams' => [
    'northern regional open teams',
    'northern regional teams open'],

  'PRBA State Level Open' => ['prba open state level',
    'prba state level', 'prba statelevel'],
  'PYC Hindu Gymkhana Royale' => ['pyc royale'],
  'PSN Sarma Centenary Memorial' => ['psn  sarma centenary memorial',
    'psn sarma memorial'],
  'PT Timah Invitational Teams' => [
    'invitasi pt timah',
    'invitasi pt_ timah',
    'invitasi pt_timah',
    'invitasi terbatas pt timah',
    'invitasi terbatas pt_timah',
    'invitasi terbatas pt_ timah',
    'pt timah limited invitational teams',
    'pt_ timah limited invitation teams',
    'pt_ timah limited invitational teams',
    'pt_ timah ltd invitational teams'],
  'PYC Hindu Gymkhana Pairs Royale' => ['pyc pairs royale'],
  'Prince Takamatsu Cup' => [
    'prince takamatsu memorial cup',
    'takamatsu cup'],

  'Queensland Women Trials' => ['qld womens trials'],
  'Queensland Senior Trials' => [
    'qld seniors trial',
    'qld seniors trials'],

  ### RRR

  'R N Bagla Memorial Pairs' => ['rn bagla menorial pairs'],
  'R R Gupta Memorial Championship' => [
    'r r gupta memorial bridge tournament'],
  'R Ratnam Memorial' => ['r ratnam memoral championship'],
  'Ragn-Sells International Grand Tournament' => [
    'ragn sells international',
    'ragn-sells intl grand tournament',
    'ragn-sells intl_ grand tournament',
    'ragn sells intl_ grand tournament'],
  'Rai Bahadur Modi Memorial All India Open' => [
    'rai bahadur modi memorial',
    'rai bahadur memorial'],
  'Rio de Janeiro Open Teams' => [
    'rio de janeiro championship',
    'rio de janeiro state final'],
  'Rio de Janeiro Christmas Individual' => [
    'rio de janeiro xmas individual'],

  # ROMANIA -- mapped in detail
  'Romanian League' => [
    'cn ecgipe',
    'cn echipe', 
    'c_n_ echipe', 
    'divizia a', 
    'national romanian teams',
    'romanian national teams div a', 
    'romanian national division', 
    'romanian national teams- div a', 
    'romanian team championship',
    'romanian teams-a division', 
    'romanian teams- a division'],
  'Romanian Open Teams' => [
    'romanian national champ_',
    'romanian national champs',
    'romanian national championship',
    'romanian national championships teams',
    'romanian national team championship',
    'romanian national team championships',
    'romanian national team champs',
    'romanian national teams', 
    'romanian national teams championships',
    'romanian teams'],
  'Romanian Open Trials' => [
    'romanian national team selection',
    'romanian national trials',
    'romanian open teams trial',
    'romanian open teams trials',
    'romanian open trials',
    'romanian selection'], 
  'Romanian Second League' => [
    'cn echipe div b',
    'cn echipe div b seria a',
    'cn ecgipe div b seria a'],

  'Rome Challenger Trophy' => ['trofeo challenger città di roma',
    'challenge trofeo città di roma'],
  'Rondane Pairs Cup' => ['rondanecupen swiss pairs'],
  'Rondane Teams Cup' => ['rondane cup teams', 'rondanecupen teams',
    'rondanecupen swiss teams'],
  'Rosfjord Swiss Teams' => ['rosfjord monrad team',
    'rosfjord monrad teams'],
  'Rui Pinto Cup' => [
    'taça rui pinto'],
  'Ruia Gold Cup' => [
    'golden jubilee',
    'ruia gold', 
    'ruia gold trophy',
    'ruia gols', 
    'ruia trophy'],
  'Ruia Silver Cup' => ['ruia silver'],

  # RUSSIA
  'Russian IMSA Cup' => ['imsa cup'],
  'Russian Open Teams' => ['russian teams championship',
    'russian team championship'],
  'Russian Premier League' => ['russian premiere league'],

  'Ruter 7 Open' => ['ruter7 elitetournament'],

  ### SSS

  'Salo Midsummer Juniors' => ['midsummer juniors'],
  'Salvador Assael IMP Pairs' => [
    "salvador assael imp's across the field"],
  'Samadhan Summer League' => ['samadhan bridge league'],
  'Sao Paulo Cup' => [
    's o paulo cup', 
    'sao paulo state cup', 
    'são paulo cup'], 
  'Sao Paulo State Championship' => [
    'sao paulo champ',
    'sao paulo championship', 
    'sao paulo champ', 
    'sap paulo state championship',
    'são paulo state championship', 
    'sp champ', 
    'sao paulo state'],
  'Sarundajang Cup' => ['the sarundajang cup'],
  'Scottish Cup' => ['scot cup', 'scot cuo', 'scottish cup plate'],
  'Scottish National League' => ['scotland national league'],
  'Senior Camrose' => ['seniors camrose'],

  'Serbian Cup' => [
    'cup of serbia', 
    'cup srbije', 
    'kup srbije'],
  'Serbian Open Teams' => [
    'serbian bridge championship',
    'serbia teams championship',
    'serbian tam championship', 
    'serbian team championship',
    'serbian teams championship',
    'serbianteam championship', 
    'serbian closed team championship'],
  'Serbian Open Trials' => [
    'open serbian trials',
    'serbian open team trials',
    'serbian open trial', 
    'serbian teams trial'],
  'Serbian Premier League' => [
    'serbian league', 
    'serbian premier leaugue',
    'serbian premier leauge'],

  'Serdika Open Teams' => ['serdika cup'],
  'Shenhua Cup' => ['shen hua cup'],
  'Shree Keni Trophy' => ['keni memorial trophy',
    'keni memorial  trophy', 'mkeni  trophy', 'm keny trophy',
    'm keni  trophy', 'm keni trophy', 'mkeni trophy'],
  'Slava Cup' => ['cup slava', 'salava cup'],
  'Slovakian Open Teams' => ['slovakia open teams'],

  # SOUTH AFRICA
  'South African Championship' => ['south african nationals',
    'south african championships'],
  'South African Inter-Province Teams' => [
    'sa interprovincial',
    'sa interprovincials',
    'sa inter provincials'],
  'South African Teams' => [
    'sa team champs',
    'sa teams',
    'sa teams champs',
    'south african chaionships'],

  # SOUTH AMERICA
  'South American Junior Teams' => [
    'south american junior championship',
    'south american junior championships',
    'south american junioor championships',
    'youth sabc'],
  'South American Open Pairs' => [
    'sudamericano de parejas',
    'sudamericano de parejas libres'],
  'South American Open Teams' => [
    'libres sudamericano',
    'southamerican open championship',
    'sudamericano libre equipos',
    'sudamericano libres'],
  'South American Senior Teams' => [
    'clasificacion sudamericano seniors',
    'south american senior championship'],
  'South American Women Teams' => [
    'clasificatoria damas equipos',
    'clasificatoria equipos damas', 
    'sudamericano damas'],
  'South American Senior Trials' => [
    'seleccion sudamericano senior'],

  'Southeast Asian Games' => [
    'sea games', 
    'south east asian games'],

  # SPAIN
  'Spanish Central Zone Teams' => [
    'equipos zonal centro',
    'zonal centro equipos'],
  'Spanish Mixed Teams' => [
    'spanish mixed national teams'],
  'Spanish Open Teams' => [
    'camp esp',
    'campeonato de españa por equipos',
    'campeonato espan', 
    'campeonato espanaonda', 
    'spanish national championship',
    'spanish national teams',
    'spanish national teams championship',
    'spanish teams', 
    'spanish teams championship',
    "spanish teams ch'ship",
    'spain teams'],
  'Spanish Open Trials' => [
    'open seleccion mundial'],
  'Spanish Senior Trials' => [
    'prueba de seleccion equipos senior'],

  'SPBF Championship' => ['zone 7 championship', 'zone 7 championships'],
  'Spring Foursomes' => [
    'spring 4s', 
    'spring fours', 
    'schapirosfs'],
  'Spring Nationals' => ['spring nat', 'spring national', 'spring nats',
    'sping national', 'spring nat opens'],
  'SPS Trophy' => ['lojdy cup', 'sps construction trophy'],
  'Staszek Wybranowski Memorial' => ['memorial staszka wybranowskiego'],
  "Sternberg Women's BAM Teams" => ['marsha may sternberg bam'],
  'Stockholm Teams' => ['stockholm teams cs', 'stockholms teams'],
  'Summer Monsoon League' => ['summer monsoon', 'summer monsoon leahue'],

  # SWEDEN
  'Swedish District Teams' => [
    'swdish district',
    'sweden distric', 
    'sweden district',
    'swedis district', 
    'swedish championship cistrict', 
    'swedish championship district', 
    'swedish championships distrcit',
    'swedish championships district', 
    'swedish champsionship district', 
    'swesish champsionship district',
    'swedish district championship',
    'swedish district championships',
    'swedish district',
    'swedish districts', 
    'swedish disttrict',
    'swesish district'], 
  'Swedish Juniors Championship' => [
    'swedish junior championships',
    'swedish juniors cs'],
  'Swedish Juniors Pairs' => [
    'swedish junior pair championship',
    'swedish junior pairs championship',
    'swedish national junior pair championship',
    'swedish national junior pairs'],
  'Swedish Juniors Teams' => ['swedish juniors teams cs',
    'swedish juniors teams cs', 'swedish junior teams',
    'swedish junior team', 'swedish junior team championship'],
  'Swedish Open Pairs' => [
    'open swedish pairs championship', 
    'sweden national pairs',
    'swedish national pairs',
    'swedish open pair', 
    'swedish pair',
    'swedish pairs championships'],
  'Swedish Open Teams' => ['swedish teams'],
  'Swedish Open Team Trials' => [
    'swedish open trials',
    'swedish team trials',
    'swedish teams trials', 
    'swedish team trial'],
  'Swedish Premier League' => [
    'swedish club teams',
    'swedish elite series',
    'swedish elitserien', 
    'swedish premier leauge',
    'swedish premieer league'],
  'Swedish Senior Team Trials' => [
    'sweden senior trials',
    'swedish senior trials'],

  # SWITZERLAND
  'Swiss Club Championship' => [
    'interclub swiss team championship',
    'swiss interclubs',
    'swiss interclub championship', 
    'swisss interclubs', 
    'swiss interclub'],
  'Swiss Cup' => [
    'coupe suisse', 
    'swiss open cup', 
    'swiss cuo', 
    'switzerland open cup',

    'champion suisse', 
    'championnat suisse',
    'swiss championshi', 
    'swiss championshio',
    'swiss championship',
    'Swiss open championship',
    'swiss team champiomshio',
    'Swiss team championship'

    ],

  ### TTT

  'Taiwan University Cup' => ['taiwan university championship'],
  'Taiwan University Cup Teachers' => [
    "taiwan university cup teacher's section"],
  'Taiwanese Open Trials' => ['taiwanese trials',
    'taiwanese team trial'],
  'Taiwanese Senior Trials' => ['ctcba senior team trial'],
  'Taiwanese Teams' => ['taiwanese teal'],
  'TATA Open' => ['tata opren', 'tata sports', 'ttat open'],
  'Telkom Indonesia Open' => [
    'telkom cup',
    'telkom speedy',
    'telkom indonesian open'],
  'Teltscher Trophy' => [
    'senior camrose',
    'teltcher trophy'],
  'TGR Auction Pairs' => [
    'tgr auction',
    "tgr's auction pairs",
    'tgrs auction pair', 
    'tgrs auction pairs'],
  'TGR Auction Teams' => ['tgrs auction teams'],
  'TGR Super League' => ["tgr's super league", "tgr's super legue",
    'tgrs league', 'tgrs 2nd auction pairs', 'tgrs super league',
    "tgr's league", "trg's super league"],
  'Thane Champion of Champions Teams' => [
    'tdba champion of champions',
    'thane bridge annual'],
  'Thanos Capayiannides Memorial Simultaneous' => [
    'thanos capayiannides'],
  'The Hague Bridge Experience' => ['the hague bride experience',
    'teh hague bridge experience'],
  'Thrace Club Teams' => ['thrace region clubs team championship',
    'türk trakya bölge kulüpler þampýyonasi ekýbý', 'trachean club teams'],
  'Thrace Cup League' => ['trakya kulupler ligi'],
  'Tianjin Binhai Cup' => [
    'tianjin bin hai cup',
    'tianjin binhai cup world men elite tournament'],
  'Tolani Gold Trophy' => [
    'dr_tolanigoldcup',
    'dr_tolani gold cup summer national',
    'dr_tolani gold cup summer nationals',
    'dr_tolani gold summer nationals', 
    'dr_tolani gold troph',
    'dr_ tolani gold cup summer national',
    'dr_ tolani gold cup summer nationals',
    'dr tolani gold cup summer nationals',
    'tolani gold summar nationals',
    'tolani gold summer nationals',
    'tolani gold summer', 
    'tolani gold summer national', 
    'tolani gold summer nationals', 
    'tolani gold summer nationals',
    'tolani gols summer nationals',
    'tolani open summer national',
    'tolani open summer nationals',
    'tolani summer nationals gold', 
    'tolani summer nationald gold',
    ],
  'Tolani Grand Prix' => ['tolani gp', 'tolani grand pix'],
  'Tolani Silver Cup' => ['dr tolani summer nationals silver',
    'tolani silver trophy',
    'dr_tolani open summer nationals silver',
    'dr_tolani silver cup summer national',
    'dr_tolani sliver cup summer nationals'],
  'Top Circuit' => ['melchemie top circuit',
    'ing bank top circuit', 'witte huis topcircuit'],
  'Trondheim Pairs Cup' => ['trondheim cup swiss pairs'],
  'Trondheim Teams Cup' => ['trondheim cup swiss teams'],

  # TURKEY
  'Turkish Club Championship' => ['türkýye kulüplerarasi þampýyonasi',
    'turkey club teams championship',
    'türkýye klüpler arasi brýç þampýyonasi',
    'turkish club teams championship',
    'turkish club championships',
    'turkish club teams championship',
    'turkish clubs championship',
    'turkish clubs team championship',
    'turkish clubs teams championship',
    'turkish clubs team championship teams',
    'turkish club team championship',
    'turkish inter club championships',
    'turkish inter-clubs championship',
    'turkiye clubs championship', 'turkey clubs championship'],
  'Turkish East Mediterranean Teams' => [
    'turkish clubs championship east & south east el',
    'turkish east & south-east teams',
    'turkish east mediterranean',
    'turkish east mediterranean club teams',
    'turkish eastern mediterranean club', 
    'turkish eastern mediterranean club teams'],
  'Turkish Mixed Team Trials' => ['turkish mixed team trails'],
  'Turkish Mixed Teams' => [
    'turkey mix teams ch',
    'turkey mix teams championship',
    'turkey mixed team championship',
    'turkey mixed teams',
    'turkis mixed teams',
    'turkish mixed teams',
    'turkish mixed team championship',
    'turkish mixed team championships',
    'turkish mixed teams championship',
    'turkiye mixed teams championship',
    'turkýsh mixed teams'],
  'Turkish Open Teams' => [
    'turkey open team championship',
    'turkish national open national selection',
    'turkish open team championship',
    'turkish open teams',
    'turkish open teams championship',
    'turkish open teams championships',
    'turkiye acik takimlar sampiyonasi',
    'turkish national open teams'],
  'Turkish Swiss Mixed Teams' => ['turkey swiss mixed teams'],
  'Turkish Teams Championship' => ['turkiye bric takimlar sampiyonasi'],
  'Turkish U16 Pairs' => [
    'turkey u16 championship'],
  'Turkish University Teams' => [
    'turkish Universities championship',
    'turkish universities bridge championship'],
  'Turkish Winter Championship' => [
    'turkiye kis takimlar sampiyonasi',
    'turkish winter chanpionship'],
  'Turkish Winter Open Teams' => [
    'turkiye kis acik takimlar sampiyonasi'],
  'Turkish Winter Women Teams' => [
    'turkish winter woman team championship'],
  'Turkish Women Teams' => ['türkish ladies teams',
    'turkish ladies teams championships',
    'turkish ladies teams',
    'turkish women championships',
    'turkish womens teams championship'],

  ### UUU

  'Spingold Teams' => [
    'spingold knockout',
    'spingold knockout teams'],
  'US Girls Trials' => [
    'junior usbc rona',
    'jusbc rona'],
  'US Junior Trials' => [
    'us junior teams',
    'usbf junior trials'],
  'US Open Trials' => [
    'us itt', 
    'us itt trials', 
    'usa international team trials',
    'usa itt',
    'usa team trial'],
  'US Senior Teams' => [
    'nabc senior ko',
    'nabc senior knock-out teams',
    'united states seniors bridge championship',
    'us senior',
    'us seniors'],
  'US Senior Trials' => [
    'usa seniors team trials',
    'usa seniors trials', 
    'usbf senior team trials',
    'usbf senior trials', 
    'usbf seniors trials'],
  'US Women' => ['us womens championships'],
  'US Women Teams' => [
    'united states women bridge championship',
    "us women's bridge championship", 
    "us women's bridge championhip",
    "united states women's bridge championship"],
  'US Youngsters' => ['u-21 us'],
  'US Youngster Trials' => [
    'jusbc u21',
    'us u-21 trials',
    'u-21 us trials'],
  'USBF Challenge Match' => ['usbf jr/pro charity challenge match'],

  ### VVV

  'Vanderbilt Teams' => [
    'vanderbilt teams', 
    'vanderbilt ko teams'],
  'Varna Titan Open Teams' => [
    'varna titan teams',
    'teams titan'],
  'Venezuelan Swiss Pairs' => ['venezuela parejas suizas',
    'venezuela swiss pairs'],
  'Venice Cup' => ['<venive <cup'],
  'Vest-Agder Regional Team Championship' => [
    'regional chship vest-agder', 'regional champship vest-agder',
    'regional chship vest-agder', 'vest-agder km lag'],
  'Victorian Open Trials' => [
    'victoian open', 
    'victorian opean',
    'victorian opean teams', 
    'victorian open',
    "'victorian open", 
    'victorian open team', 
    'victorian open team selection',
    'victorian open team trials',
    'victorian open teams',
    'victorian open teams playoff',
    'victorian playoff',
    'victorian team'],
  'Victorian Pennant' => ['vic pennant'],
  'Victorian Senior Trials' => ['vic seniors trials'],
  'Victorian Women Trials' => ['vic women trials'],

  'Videocon WCG Open' => ['videcon wcg open'],

  ### WWW

  'Wagar Teams' => [
    'wagar teams', 
    "wagar women's", 
    "wagar women's ko",
    'wagar womens ko'],
  'Warsaw Online Teams' => ['enthusiast bridge zlot', 
    'warsaw bboers champ', 'warsaw bboers championship'],
  'Watermark Open Teams' => [
    'watermark bridge classic',
    'watermark teams',
    'willoughby bridge classic'],
  'WCG Open' => ['wcg annual'],
  'Wellingdon Swiss Pairs' => ['wsc open swiss pairs championship',
    'wsc open swisspairs championship', 'wsc swiss open pairs'],
  'Western Mediterranean Club Teams' => [
    'western mediterranean clubs team championship'],
  'White House International' => ['white house international teams',
    'white house tournament teams'],
  'White House Juniors' => [
    'qhite house juniors',
    'the white hous juniors',
    'white house junior',
    'white house junior internationals',
    'whiteouse juniors'], 
  'White House Top 12' => ['modalfa top 12', 'witte huis top 12'],
  'White House Top 16' => ['white house int. teams top 16',
    'white house int_ teams top 16',
    'white house international top 16 teams'],
  'Welsh Open Trials' => ['welsh open trial', 'welsh trials',
    'welsh trial'],
  'Willingdon Sports Club Swiss Pairs' => [
    'willingdon sports club open swiss pairs',
    'willingdon sports club open',
    'willingdon sports club  open',
    'willingdon sports club  open swiss pairs',
    'willingdon sports club  swiss pairs'],
  'Winter Open Teams' => ['winter teams', 'winter team'],

  # WORLD
  'Huayuan Cup' => [
    'hua yuan cup'],
  'Oly-Star Cup' => [
    "oly-star cup women's bridge elite tournament",
    "oly-star cup women's bridge grand prix"],
  'IMSA Elite Women Teams' => [
    'women elite tournament',
    "women's bridge elite tournament",
    "women's elite tournament",
    "women's bridge grand prix"],
  'World Juniors Championship' => ['world juniors championships'],
  'World Masters Individual' => ['masters individual',
    'world masters'],
  'World Open Pairs' => ['world pairs championship'],
  'World Seniors Championships' => ['world senior championship'],
  'World Transnational Open Teams' => [
    'world transnational teams'],
  'World University Teams' => [
    'world university bridge championship',
    'world university bridge championships',
    'world university championship',
    'univ_ world champs'],

  'Yeh Bros Cup' => ['yehbros cup', 'yer bros cup'],
  'Young Chelsea Knock-out' => ['yc ko', 'young chelsea ko',
    'young chelsea knockout'],
  'Youth Open Bridge Paris' => ['youth paris open bridge'],

  ### ZZZ

  'Zulawski Cup' => ['zulawski teams'],
  'Zurich Open Pairs' => ['zurich imp pairs']
);

my @SINGLE_WORDS = qw(
  Cavendish
  Vadsøturneringen 
);

my %SINGLE_TYPOS =
(
  'APBF Championships' => ['pabfc', 'pabf', 'pabfs'],
  'Argentinian Club Teams' => ['cnia'],
  'ASEAN Club Championship' => ['abcc'],
  'Australian Autumn National Open Teams' => ['anot'],
  'Australian National Open Teams' => ['not'],
  'Australian National Senior Teams' => ['nst'],
  'Australian National Women Teams' => ['nwt'],
  'Australian Spring Open Teams' => ['snot'],
  'Bermuda Bowl' => ['bb'],
  'Bobby Evans Seniors Teams' => ['best'],
  'Brazilian Open Teams' => ['brasilchamp'],
  "Buffett Cup" => ['buffett', 'buffet'],
  'Camrose Trophy' => ['camrose', 'camroae', 'ccmrose'],
  'Canadian National Teams Championship' => ['cntc'],
  'Canadian Seniors Teams Championship' => ['cstc', 'cnst'],
  'Canadian Women Teams Championship' => ['cwtc'],
  Cavendish => ['cavendiish', 'caavendish', 'cavemdish', 'cavendiosh',
    'cavendsh', 'cavvendish', 'avendish', 'cav'],
  'Challenge Match' => ['desafio', 'challengue', 'challenger',
    'challenge'],
  'Collegiate Bowl' => ['collegiate', 'collegiates'],
  'Commonwealth Nations Bridge Championships' => ['cnbc'],
  'Copenhagen Invitational Pairs' => ['cbi'],
  'Danish Championship' => ['dm'],
  'Division Nationale' => ['dn'],
  "d'Orsi" => ['sb', 'dosb'],
  'Dutch Meesterklasse' => ['meesterklasse'],
  'European Bridge Teams Championship' => ['ebtc'],
  "European Champions' Cup" => ['ecc'],
  'European Small Federation Games' => ['esfg', 'sfc'],
  'European University Bridge Championship' => ['eubc', 'eucb', 'euc'],
  'European Youth Bridge Championship' => ['eybc'],
  'European Youth Bridge Pairs Championship' => ['eybpc', 'eypc'],
  'European Youth Bridge Teams Championship' => ['eytc', 'jem'],
  'Exhibition Match' => ['exhibition'],
  'FOSS Grand Tournament' => ['foss'],
  'Friendly match' => ['friendly'],
  'German Team Championship' => ['teammeisterschaft'],
  'German Bundesliga' => ['bundesliga'],
  'Gianarrigo Rona Trophy' => ['rona'],
  'Grand National Open Teams' => ['gnot'],
  'Grand National Teams' => ['gnt'],
  # 'Grand Prix of Poland' => ['gpp'],
  'Grand Prix of Poland Pairs' => ['gppp'],
  "Gro's Supercup" => ['grocup'],
  'Icelandair Open' => ['icelandair'],
  'Junior Camrose' => ['juniorcamrose', 'juniorcmrose'],
  'Kalani Trophy' => ['kalani'],
  "Kepri Governor's Cup" => ['kepricup'],
  'Lederer Memorial Trophy' => ['lederer', 'ledered'],
  "Linda Stern Women's Teams" => ['lswt'],
  'Maccabi Games' => ['maccabiah'],
  'McConnell Cup' => ['mcconnell'],
  'NTU Cup' => ['ntucup'],
  'Paris Youth Open Teams' => ['ypob'],
  'Peggy Bayer' => ['peggybayer'],
  'Portuguese Open Teams' => ['cneo'],
  'Reisinger BAM Teams' => [
    'reisiger', 
    'reisinger', 
    'resisinger'],
  'Rosenblum Cup' => ['rosenblum'],
  'Ruia Gold Cup' => ['ruia'],
  'Scottish Cup' => ['scottishcupplate'],
  'Southeast Asian Games' => ['seagames'],
  'Spingold Teams' => ['spingold'],
  'Swedish Elite Series' => ['elitserien'],
  'Prince Takamatsu Cup' => ['takamatsu'],
  'Teltscher Trophy' => [ 
   'teltschertrophy', 
   'teltscher', 
   'telschertrophy'],
  'Tolani Grand Prix' => ['tolanigrandprix'],
  'Top Circuit' => ['topcircuit'],
  'Transnational Open Teams' => ['tnt', 'tnot'],
  'US Junior Trials' => ['usjbc', 'jusbc'],
  'US Juniors Training' => ['jtp'],
  'US Senior Teams' => ['ussbc'],
  'US Women Teams' => [
    'uswbc', 
    'uswbf', 
    'uswc',
    'us womens championships'],
  'Vanderbilt Teams' => [
    'vanderbilt', 
    'vanderbuilt', 
    'vanderebilt', 
    'vandebilt', 
    'vandy'],
  'Venice Cup' => ['vc', 'venice'],
  'Victorian Pennant' => ['pennant'],
  'Vilnius Club Pairs' => ['vbk'],
  'Wagar Teams' => ['wagar'],
  'White House Juniors' => ['whj'],
  'World Transnational Mixed Teams' => ['wtmt'],
  'World Transnational Open Teams' => ['wtot'],
  'World University Championship' => ['wuc'],
  'Young Chelsea Knock-out' => ['ycko'],
  'European Winter Teams' => ['zc']
);

sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
