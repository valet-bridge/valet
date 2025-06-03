#!perl

package Analysis;

use strict;
use warnings;
use v5.10;

use lib '.';

use constant
{
  INITIAL => 0,
  ALLCAPS => 1,
  CAPITALIZED => 2,
  PARTICLE => 3,
  GENERAL => 4
};

my %EXCEPTIONS =
(
  'Chien-I' => CAPITALIZED,
  "DALL'AGLIO" => ALLCAPS,
  "DELL'ARMI" => ALLCAPS,
  "GUINVARC'H" => ALLCAPS,
  'Jérôme' => CAPITALIZED,
  'Jan-e-Alam' => CAPITALIZED,
  JoAnna => CAPITALIZED,
  'I-Hung' => CAPITALIZED,
  'I-Ming' => CAPITALIZED,
  LaLa => CAPITALIZED,
  'María' => CAPITALIZED,
  "O'KEEFFE-BROWN" => ALLCAPS,
  "O'REILLY-POL" => ALLCAPS,
  "Ra'ad" => CAPITALIZED
);

my %SPECIALS =
(
  # The first part is the short/nickname/rename/variant.
  SHORT =>
  {
    Alya => {Alevtina => 1},
    Andy => {Andrew => 1, 'Andrew C.' => 1},
    Becky => {Rebecca => 1},
    Bobby => {Robert => 1},
    Chander => {Chandkaran => 1},
    Chris => {Krzysztof => 1},
    Conny => {Catharine => 1},
    Dave => {David => 1},
    Desi => {'Desislava Borissova' => 1},
    Det => {Bernadette => 1},
    Dick => {Richard => 1, 'Richard J.' => 1},
    Giampao => {Giampaolo => 1},
    Giancarlo => {'Giovanni Carlo' => 1},
    Hein => {Henricus => 1},
    Henk => {Hendrik => 1},
    Hovik => {Hovhannes => 1},
    'Jean-Jacque' => {'Jean-Jacques' => 1},
    Jerem => {Jeremi => 1},
    Jim => {James => 1, 'James E.' => 1},
    Katie => {Catherine => 1},
    Kit => {Christopher => 1},
    Lina => {Eleni => 1},
    Liz => {Elizabeth => 1},
    Loes => {'Marie Louise' => 1},
    Maggie => {Margaret => 1},
    Mandy => {Adamantia => 1},
    Manos => {Emmanuel => 1},
    Matt => {Matthew => 1},
    Mauri => {Maurizio => 1},
    Natasha => {Nataliya => 1},
    Nick => {Nicklas => 1, Niklas => 1},
    Pero => {Petar => 1},
    Phil => {Philip => 1},
    Sandro => {Alexandre => 1},
    Sascha => {Alexander => 1},
    Sasha => {Alexander => 1},
    Teddy => {Theodor => 1},
    Tony => {Anthony => 1, Anton => 1},
    Wil => {Willem => 1},
    Wim => {Willem => 1},
    Yossi => {Josef => 1, Yosef => 1},
    Zandy => {Alexander => 1}
  },

  NICKNAME =>
  {
    Ans => {'Anna Maria Wilhelmina' => 1},
    Akis => {Zafiris => 1},
    Charles => {'Ka Ning' => 1},
    Denis => {Darko => 1},
    Dimmie => {Irene => 1},
    Himmy => {'Pak Him' => 1},
    Joice => {'Julita Grace' => 1},
    Kojak => {'William J.' => 1},
    Mavi => {'Maria Vittoria' => 1},
    Memo => {Giampietro => 1},
    Mino => {Jacomo => 1},
    Moti => {Mordechay => 1},
    'Nancy Marie' => {'Pek See' => 1},
    Nina => {Planinka => 1},
    Nitsa => {Antonia => 1},
    Pinuccia => {Giuseppina => 1},
    Sheelu => {Saela => 1},
    Titta => {'Giovanni Battista' => 1}
  },

  RENAME =>
  {
    Adam => {'Tsz Nam' => 1},
    Aaron => {'Shiu Cheong' => 1},
    Abby => {'Wai-Lap' => 1},
    Bob => {Xinyu => 1},
    Brian => {'Ho Yin' => 1},
    Calvin => {'Ching Fung' => 1},
    Catherine => {Runmei => 1},
    Charmain => {'Hor Yung' => 1},
    Chris => {'Tze Him' => 1},
    Christopher => {'Hong Sing' => 1},
    Clair => {Shiuan => 1},
    'Costa-Foru' => {Constantin => 1},
    Cynthia => {'Hung Ching' => 1},
    Davied => {'Xiao' => 1},
    Dennis => {'Yu Kwong' => 1},
    Derek => {'Wei Peu' => 1},
    Desmond => {'Feng Gui' => 1},
    Dora => {'Lo Lai Yee' => 1},
    Gary => {'Po Tang' => 1},
    Gloria => {'Ching-Shan' => 1},
    Harry => {'Tsz Fung' => 1},
    Henry => {'Wai-Kit' => 1},
    Jack => {Jie => 1},
    Jerry => {'Li Min' => 1},
    Jimmy => {'Saleem Ud' => 1, Zhuo => 1},
    John => {'Hao Zhen' => 1},
    Joyce => {'Sau Yin' => 1},
    Kelvin => {Yisheng => 1},
    Kevin => {Yuxiang => 1},
    Marvin => {'Yong Chieng' => 1},
    Max => {Ziyu => 1},
    'Nancy Marie' => {'Pek See' => 1},
    Nicky => {Kulbir => 1},
    Oak => {Wattanai => 1},
    Pearlie => {'Pui Yi' => 1},
    'Pedro Leonel' => {Ioklon => 1},
    Romulus => {'Yuan Xing' => 1},
    Ronald => {'Cheuk Him' => 1},
    Ruby => {'Ka Yee' => 1},
    Timothy => {'Jian Zhong' => 1, Kaiti => 1},
    Vincent => {'Hoi Yuen' => 1},
    Vonny => {'Siti Chaerani' => 1},
    Wendy => {Guangli => 1},
    William => {'Shiu-Kwong' => 1},
  },
  
  VARIANT =>
  {
    Alexandre => {Alexandru => 1},
    Chengyi => {'Cheng Yi' => 1},
    Danielle => {Daniele => 1},
    Isabella => {Isabelle => 1},
    Jacob => {Yaacov => 1},
    Jeniffer => {Jennifer => 1},
    Jiaxiang => {'Jia Xiang' => 1},
    Jingsheng => {Jinsheng => 1},
    Kamales => {Kamles => 1},
    Mansur => {Mansoor => 1},
    Marco => {Marcos => 1},
    Michael => {Mikhail => 1},
    Michele => {Michelle => 1},
    Monya => {Monia => 1},
    Myriam => {Miryam => 1},
    Nabeel => {Nabil => 1},
    Norman => {Normann => 1},
    Paolo => {Paulo => 1},
    Rigmore => {Rigmor => 1},
    Simin => {Simun => 1},
    Sophie => {Safeya => 1},
    Stephan => {Stefan => 1},
    Teodoras => {Teodoros => 1},
    Zbyszek => {Zbigniew => 1},
    Zdenek => {Zdenko => 1},
    Zijian => {'Zi Jian' => 1},
    Wojciech => {Wojtek => 1},
    Woyciech => {Wojtek => 1},
  }
);

# The first one is used to verify that middle names are like first names.
# This last one used to verify that middle names are like last names.

my @FIRST_NAMES =
qw(
  Aaron Aas Abbas Abdel Abdimulia Abdul Abdullah Abel Abulrahman 
  Adele Adie Adji Adnane Adrian Ae Agha Agnieszka Agus Ahasan Ahmad 
  Ahmed Ahmer Ake Akhtar Akter Alain Alan Albert Alberto Alejandra 
  Alejandro Alex Alexander Alexandra Alexandre Alexandru Alfredo Ali 
  Almeida Alp Alper Alta Altan Ameer Amenhoteps Aminur Amita 
  An Anand Anant Anders Andre Andrea Andreas Andreea Andrei Andres 
  Andrias Andrzej Anfinn Angel Angela Angelica Angelo Angelova 
  Anikovich Anil Anis Anita Anker Ann Anne Annette Anthonius Anthony 
  Anton Antonia Antonieta Antonio Anwen Ara Ardiansyah Are Ariel Aril 
  Arild Arne Arni Aron Arslan Arthur Arturo Arve Arvind Arya Arzum 
  Asbjorn Asfandiyar Asghar Aslam Aslihan Assis Atle Aulia Aulid 
  Avsar Awuy Ayeska Aysen Ayu Ayyampalayam Azat Azizul 

  Babu Bae Bagus Baliram Bambang Barbosa Barki Barkin Baron Bas 
  Battista Beate Beatrice Belle Benedict Beniamino Berka Berkay 
  Berkim Bertram Besour Bey Bhan Bharadhan Bindi Birgitte Birol 
  Bjoerk Bjoernar Bjorn Bogdan Borgar Borissova Brarne Breves Brian 
  Brita Britt Bruce Bruna Bruno Buke Bye 

  Cagan Cagdas Cai Can Carla Carlo Carlos Carmen Carol Carolina Cata 
  Catalin Cato Cecilia Celal Celia Celina Cem Cemal Ceren Cesare 
  Chairudin Chakravarthy Chand Chander Chandra Chang Charles Charlie 
  Charlline Charlotte Charya Chen Cheng Chhotelal Chi Chih Chin Chiu 
  Choi Choo Chou Choudary Choukri Chow Christa Christer Christian 
  Christina Christine Christopher Chuan Chul Chun Chung Cici Cing 
  Claude Claudiu Coomer Cosmo Costanza Craig Cristian Cristina Cruz 
  Cyprian 

  Daldoul Dan Dana Daniel Daniela Dario Darma David Delfina Deng 
  Deniz Devchand Devshi Dey Di Diana Dicle Didem Didier Dimitar Dirk 
  Doga Dolores Domenico Dong Dumitru 

  Ebrahim Edmund Edoardo Eduardo Edward Efe Egemen Egil Eidur Einar 
  Eirik Eivind Eka Elena Elia Elida Eline Elisa Elise Elizabeth 
  Elvansyah Elvin Elvira Emil Emilie Emin Emine Emir Emmanuel Emre En 
  Endras Endre Enoch Enok Enrica Enrique Enver Ercolian Erdem Erik 
  Eriks Erling Erol Ersan Esra Esther Ethem Eufke Eugenia Eugenio 
  Ezequiel Ezz 

  Fa Fai Falah Falk Fang Fanly Faruk Fawzy Fay Federico Fei Felicia 
  Felipe Felix Feng Fernando Ferruh Fethi Fikret Filippo Florencia 
  Florin Fold Frances Francesco Francis Francisco Francois Francoise 
  Franke Fraser Frederic Frederik Fredrik Freyr Frimaco Frode Fu Fuad 
  Funda Furkan Fusun 

  Gabizo Gabriel Gabriela Gabryjela Gail Gama Gamze Gan Gautama Gaute 
  Gautur Ge Georg Georges Gerard Ghaffar Gheorghe Ghias Gigello 
  Giovanni Gisella Gisli Giulio Giuseppe Glen Gokhan Gopal 
  Gopalakrishna Gorkem Gracio Grazia Graziela Gro Gu Guang Gudlaug 
  Guimar Guirguis Gul Guldamla Gulen Gundega Guney Gunnar Guo Gurcan 
  Gursel Gurunath Gustaaf 

  Haakon Habibul Hacer Hae Hai Hakan Hakim Hakki Halidun Hallvard 
  Haluk Hamadeh Hameed Hamit Han Hang Hao Harald Harianto Hariram 
  Harris Hasan Hassan Haugan Haugen Hazel Hazem He Hee Hefny Hein 
  Helen Helena Helene Helgard Helge Helvijs Hendrik Heng Henrik Henry 
  Hermon Hersir Hieu Him Hin Hjalmar Ho Hock Holmar Hong Hongxuan 
  Hoong Hove Hronn Hsien Hsin Hsuan Hua Huai Hugo Hui Hun Hung 
  Huseyin Hussain Hussein Hyder Hyoung 

  Ian Ibrahim Idland Ignacio Ijaz Ik Ilan Ilari Ildeniz Imran In 
  Indra Inge Inger Ingi Ingvald Ionis Ioulios Iqbal Irene Iriantha 
  Irvin Isabel Isin Iskandar Iskander Isyana Ivan Ivar Ivonne Izzet 

  Ja Jack Jacob Jacques Jake Jakob Jakup James Jan Jane Janneth Jason 
  Javier Jean Jeffry Jen Jeng Jeremiah Jerry Jia Jiang Jie Jin Jing 
  Joan Joana Joao Joaquin Joergen Johan Johannes John Jona Jonny Joo 
  Jorge Jorgen Jose Joseph Juan Jubilate Judith Juhan Jul Jun Jung 
  Justus 

  Oaitse Ong Tshepo Yusuf Chaerani Wa Nam Surendra Cheung Hoi Fung
  Ning Wilson Asifur Kei Shiu Howard Flora Roman Ram Zhazha Kaligis
  Mai-Brit Don Lai Ghalib Pok Yee Lazarus Uz Putu Monteiro
  Roberto Dharma Tarikul Mehedi Dev Lorand Kemal Ramana Amirul
  Hossain Arman Desi Mijanul Moshiur Anisul Zahid Aleixo Khanh
  Ul-Ain Manasseh Rica Mangapul Noel Hayk Mirna Zafar Akten Joffani
  Faroque Teiji Kurnia Basuki Ramzi Madeira Ramadan Suci Kirti
  Devi Moazzem Hean Guadalupe Audiary Gangadhara Yunief Mariano
  Denis Haerul Md Grace El-Salam Del Rosario Helal Cheong Sing
  Rama

  Kaare Kahraman Kai Kang Kant Kanti Kapulu Kare Kareem Karim Karin 
  Karl Karna Kashinath Kate Kaur Kay Kayzen Kee Keith Kelly Kenneth 
  Kenyon Kenzo Kerem Keung Khan Khimji Khurrum Ki Kieren Kimar Kin 
  King Kinman Kirankumar Kishore Kit Kjellaug Kong Konstantinos 
  Korkut Krishna Krishnan Kristen Kristian Kristine Kristjan Kubilay 
  Kui Kumar Kumari Kun Kursad Kyoung Kyung 

  Lal Lam Lan Lao Lata Lau Laurentiu Lavinia Lee Lei Lena Lene Leon 
  Leonardo Leonel Leslie Li Lia Liang Lija Lilian Lily Lin Lionel 
  Lisa Lise Lliker Lok Long Lou Louis Louisa Louise Lu Luca Lucasz 
  Lucette Lucia Lucian Luie Luigi Luis Luisa Luiza Lujon Lun Lung Luz 
  Lygre Lynn 

  Machado Maciej Mae Magnus Mahbubul Mahmood Malcom Man Manaf Mani 
  Manuel Mao Mar Marc Marcelin Marcelo Marek Margaret Margarita 
  Margrethe Mari Maria Marian Marie Marina Marinh Marino Mario Marit 
  Marius Mark Marques Marta Marthen Martin Martins Massimo Matias 
  Mauricio May Mayo Mecbure Mei Melih Melissa Meng Merete Meta Mette 
  Micael Michael Michailov Michel Miguel Mihaela Mihai Mihail 
  Mihaylova Mikael Min Ming Mirabelle Miranda Mirta Mitra Mo Moazzem 
  Mobinul Moen Mohamed Mohammad Mohan Mohon Mohsen Moin Monica 
  Monirul Mora Moran Morten Mou Mounir Mozez Muammer Mubashir Muhamm 
  Muhammad Muhsin Mui Mumtaz Murat Murthy Mushtaq Mustafa Muthu 
  Muzharul 

  Nabi Naci Nafiz Naidu Najee Namineni Nan Narayan Narayana Narayanan 
  Nasir Nath Naz Nazan Nazar Nazif Nazli Nazmul Nedim Neil Ngin Nian 
  Nicholas Nick Nicoletta Nicolle Nigar Nihat Nika Niklas Nina No 
  Nobre Noeline Noelle Noervita Npeng Nualsri Nur Nurdan Nurhan 

  Octavian Odile Odin Oi Oktem Olafs Olai Oland Olav Olcay Ole Olha 
  Olivier Olof Omar Omer Onder Onggani Onur Orhan Orn Oruc Osman 
  Osnes Otto Ove Ovidiu Owen Ozer Ozgur Ozkan 

  Pablo Pada Pall Palmelia Pan Paola Paoli Parakrama Parningotan 
  Patrick Paul Paula Pauli Paulo Pawel Paz Ped Pedro Pei-en Pelin 
  Peng Pennaf Perry Perwez Peter Pethraj Petronia Petter Pham Pheng 
  Philip Philippe Pia Pierre Pin Ping Pino Pong Ponniah Prabakar 
  Prakash Prasad Premsagar Pretty Priscilla Purushottam 

  Qamar Qasim Qian Qiang Qing 

  Rabie Rachel Rafael Ragnar Rahman Raiko Raman Ramanathan Ramon Ran 
  Ranjan Ransani Rao Raphaela Rashebul Rashedul Rashid Rashmikant 
  Rasiklal Raveen Ray Razzak Recep Reddi Reese Rehman Remzi Rengasamy 
  Resit Reynir Reza Ri Rianto Riaz Ricardo Richard Ricky Ricquier 
  Rifat Rimnong Ristu Riswan Rita Roar Robert Roberto Rock Rodolfo 
  Roger Rom Romano Ronald Ronaldo Rong Rosa Rosanna Rosaria Roxana 
  Roy Ru Ruhi Rui Ruiz Runar Ruth Ruzgar Ryan Ryk Ryung 

  Saad Saadat Sabine Saeed Safak Safari Sai Said Sajid Saktia Sales 
  Salih Salman Samuel Samy San Sangwon Santoso Sarathi Sartika Sartje 
  Sastry Sattar Sau Saverio Saz Sebastian Seda Sekhar Selim Sencer 
  Sener Seng Seniha Senol Septimiu Serap Sergio Sergiu Serhat Serif 
  Setyo Sevgi Seyhan Shahbana Shahidul Shaihan Shaker Shakil Shamin 
  Shan Shankar Shanker Shantilal Shauq Shen Sheng Sherif Shi Shing 
  Shirazi Shohdy Si Sigurd Sila Silvio Sim Sima Simoes Simon Simona 
  Singh Siok Siri Sirin Sivert Skarhol Smari Sobhagchand Soerlie 
  Sofia Sofie Somchand Sonya Soon Sophia Sophie Sorin Spike 
  Sreedharan Sreekanth Srinivasa Stephen Steven Stewart Stirling 
  Sture Su Suba Subari Subbarao Subramanian Sue Suheda Sujauddin Sule 
  Suleiman Sultana Sum Sunra Sup Supeno Surya Suryakant Susana Svarup 
  Swaray Sydney Syed Sze-Ching Sze-Wing 

  Ta Tan Tao Tat Taymour Teck Teixeira Teng Terence Teresa Terje Theo 
  Theodore Theoman Thiruvenkata Thomas Thora Tie Tin Tinas Ting Titus 
  Toar Tobing Tolga Tomas Tong Tor Tora Tore Torgeir Torio Tove Tri 
  Trine Triumf Tua Tugce Tugrul Tumo Tunc Tuncay Tung Tybring Tyr 

  Uffe Ufuk Ugur Ulrik Ulvi Umair Umit Ursin Usman Utku Uttamchand 

  Vadumangudi Vala Valentin Valerie Vaman Vegard Venkata Venkatraman 
  Venugopal Verona Veronica Vicenzo Victor Victoria Vidar Vijayanand 
  Vince Vincent Virgil Virginia Vishwanath Vittoria Vittorio Vogg 
  Vural 

  Wahyu Wai Walter Wardhani Watrap Wei Wen Werner Wilhemina Willem 
  William Willy Winarno Wisolus Wojciech Wook 

  Xavier Xi Xian Xiang Xin Xing Xinying Xiong Xu Xuan 

  Yan Yang Yao Yasin Yau Yb Ye Yehia Yen Yeung Yi Yigit Yin Ying 
  Yoland Yong Young Yp Yu Yuan Yue Yun Yung Yves Yvonne 

  Zafer Zahir Zahra Zaman Zaverchand Zeki Zen Zeynep Zhen Zhi Zhong 
  Zhou Zhu Zia-ul Ziaullah Zoe Zorana Zou Zsolt 
);

my @LAST_NAMES =
qw(
  AASAND ABATE ABI ABOU ABREU AGUADO AIT AJI ALBERTI ALTMANN ALVARADO 
  AMMENDOLIA ANAVI ANCHISI ANDERSON ANG ARAUJO ARGAYNE ARMIJO ARREAGE 
  ASHAK ASPLUND ATTARD AZZALI 

  BACCHI BAJOS BALLERINO BALLI BANG BAPTISTA BARCOS BARDEN BARONE 
  BARRERA BASELGA BATALLA BATZIA BAUCK BAYRAK BEIRAO BELLERIO BELLOCQ 
  BELLUSSI BELRHITI BENATAR BENDER BENSBY BETTENCOURT BETTI BILDE 
  BJOERBEKK BO BONADIES BONANOMI BORDALLO BORSARELLI BOSCARO BOU 
  BREDIUS BRENDERFORD BRENNA BRITO BRIX BROEKSTEEG BRORHOLT BRUGNONI 
  BRUN BRYDE BUELENS BUI BULLARD BUUS 

  CABANNE CADI CALVO CAMARGO CANALI CANDUCCI CANER CANESSA CAPBERN 
  CAPELLI CAPION CARINI CASALE CASTELLO CASTRO CATASTINI CATTANEO 
  CESARI CESATI CHACON CHAMACHERIL CHAMORRO CHAN CHAVES CHIN CHINDEMI 
  CILLEBORG CIVIDIN CLASSEN COLOMBO COLONNA COOK CORREA CORSICO 
  COSIGNANI COSSU COSTA COUTINHO CREDAZZI CRIADO CRISAFULLI CROCI 
  CUBILLO CUERVO CUEVA

  D'ANDREA D'OREY DAL DALDOUL DALEMARK DAM DARNISA DELLADIO DELPIANO 
  DENEGRI DIAZ DIEZ DIMITROV DOBREVA DONG DOUER DRINOVEC DUQUE DWYER 
  DYBVIK 

  ECK EDWARDS ERICH ERTBJERG ESCOBAR 

  SHAMS VYDT PHAM LAM STRAND SAINZ ARREAGA LUO BONNY PERSIVALE
  SEVERIN LAMA TIRTA BASHEER BRITO MEW BRUM POMARES FUNG KEE
  MOUSTAFA ROCHA ALVARES ALVAREZ TROELS SAAID LA'O ANDRADE ROGVU
  HELAL

  FABBRI FAHMY FANTONI FARHANI FARINA FERLAZZO FERNANDES FERNANDEZ 
  FINCHELTUB FLORIN FOLLIERO FOO FRANCES FRANCISCI 

  GAMIO GANDINI GARCIA GARRIGOU GARRONE GATT GERMANETTI GIACCHINI 
  GLAZER GOETZ GOLDFARB GOLFARELLI GOMES GOMEZ GONCALVES GONZALES 
  GONZALEZ GRASHOLT GRAYSON GUANG GULDBRAND GUPPU 

  HALD HAMADEH HANSEN HARALDSDOTTIR HARLAND HAYMAN HELDAL HERNANDEZ 
  HERRERA HINZ HJORTH HOEL HOLM HOLMEN HOLTZ HUC HVIDBERG 

  INDHU ISRAEL ISRAELI IVANES 

  JANSE JARAMILLO JEITZ JIMENEZ JONES JUCHIMOWICZ JUHL JUL JUST JUUL 

  KLIBI FUN MELLADO D'AVE FERGUSON ELDON ROSELL CUBILLO MENDOZA

  KAELIN KAI KEITH KERLERO KIRK KIRKEGAARD KOCH KOFOED KONDAKCI KORRE 
  KRAFT KRAGH KROGH KRUSE KUREK 

  LANZOTTI LAUGE LECIS LEMAITRE LEVY LI LIAQUAT LINDAAS LINTRUP 
  LOENBERG LOPES LOPEZ LORENTE LOSCHI LOVEJI LUCA LUND LUZ LYBECH 
  LYNGE 

  MARANI MARITI MARSH MARTHEN MARTINEZ MATEO MATHE MAURY MAZE MAZZADI 
  MEJIA MENDES MICALI MIER MILESI MIQUELEZ MOELLER MOLLER MONTEIRO 
  MONTES MORCK MOREIRA MUSCAT 

  NAAS NAYER NEGRIN NIELSEN NIKOLOV NOEL NOERHAVE NORMAN NYHEIM 
  NYVANG 

  OLIVEIRA 

  PABIS PALANCA PALMA PAOLI PARASIAN PAZ PELAEZ PENNINO PEREIRA PEREZ 
  PINTO POLIMENI POMARES PONCE PORTANTI PORTO POWELL PRASETYO PRATO 
  PUIG 

  QUERAN 

  RAHTJEN RAIKO RAMIREZ RANDLE RASK RASMUSSEN RAULUND REDDY REIMER 
  REY REYES RIBEYRO RICCI ROBERT ROCABERT ROSEN ROUANET ROZPIDE RUMOR 
  RUZ 

  SALAZAR SANCHEZ SANCHO SANTOS SATHYAMANGALAM SCHMIDT SCHNETZER 
  SEGURA SELLAN SEQUI SERCY SERRANO SGOLOMBIS SHAUQ SHLESINGER 
  SIANIPAR SILVA SILVERMAN SIMON SKAK SKAUG SKOGLY SMADILO SOLLI 
  SOUSA SPINOLA STAMATOV STAUGAARD STEEN STEIGER STEWART STRANDE 
  SUAREZ SUNGUR 

  T'KINT TANEV TEKTURK THEISS THITTAI THRANE THUNBO TJON TOCCO 
  TORKELSEN TORNBERG TRAN TRONCHETTI TURLETTI TUTTOBENE TVEDEN 

  URIBE USBER 

  VADUMANGUDI VAGN VAISBICH VALENTI VALENZUELA VARGAS VEEL VELANDO 
  VERDI VERMEHREN VIGORELLI VILA VILBORG VINBERG VIVARELLI 

  WAN WANG WEI WEISS WHEATLEY WICKBE WILLE WINGAARD WONG 

  XIAO 

  YEH 

  ZACK ZAIDENBERG ZAMMIT ZAMORA ZEDDA ZUNIGA ZUR-CAMPANILE 
);

my %FIRST_NAMES_HASH;
$FIRST_NAMES_HASH{$_} = 1 for @FIRST_NAMES;

my %LAST_NAMES_HASH;
$LAST_NAMES_HASH{$_} = 1 for @LAST_NAMES;


my %PARTICLES =
(
  ABU => 1,
  AL => 1,
  BEN => 1,
  DA => 1,
  DALLA => 1,
  DALLE => 1,
  DEGLI => 1,
  DELLA => 1,
  DELLE => 1,
  DE => 1,
  DEL => 1,
  DEN => 1,
  DER => 1,
  DI => 1,
  DO => 1,
  DOS => 1,
  DU => 1,
  E => 1,
  ECH => 1,
  EL => 1,
  IBN => 1,
  LA => 1,
  LE => 1,
  LO => 1,
  MAC => 1,
  SAINT => 1,
  SANTA => 1,
  ST => 1,
  TEN => 1,
  TER => 1,
  VAN => 1,
  "'T" => 1,
  VON => 1,
  Y => 1,
  ZU => 1
);


sub new
{
  my $class = shift;
  my $self = bless {}, $class;
  return $self;
}


sub reprint_list
{
  my ($list, $name) = @_;
  my @unique_sorted = sort { lc($a) cmp lc($b) } do 
  {
    my %seen;
    grep { !$seen{lc $_}++ } @$list;
  };

  # Reprint in formatted style
  print "my \@$name =\nqw(\n";

  my $indent = "  ";
  my $line = $indent;
  my $prev_initial = '';

  foreach my $name (@unique_sorted) 
  {
    my $initial = uc substr($name, 0, 1);

    # Add blank line when initial changes
    if ($prev_initial ne '' && $initial ne $prev_initial) 
    {
      print "$line\n" if $line =~ /\S/;
      print "\n";
      $line = $indent;
    }

  # Check if adding the name exceeds 70 columns
  if (length($line) + length($name) + 1 > 70) 
  {
    print "$line\n";
    $line = $indent;
  }

  $line .= "$name ";
  $prev_initial = $initial;
}

  # Print any remaining names in the buffer
  print "$line\n" if $line =~ /\S/;
  print ");\n";
}


sub remove_various
{
  my ($self, $words) = @_;

  my $i = 0;
  while ($i < @$words)
  {
    my $w = $words->[$i];
    if ($w =~ /^Jr\.*$/)
    {
      $self->{JUNIOR} = 1;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Sr\.*$/)
    {
      $self->{SENIOR} = 1;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Dr\.*$/)
    {
      $self->{TITLE} = 'Dr.';
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Capt\.*$/)
    {
      $self->{TITLE} = 'Captain';
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^Maj\.+$/)
    {
      $self->{TITLE} = 'Major';
      splice @$words, $i, 1;
      next;
    }
    if ($w eq 'Prinzessin')
    {
      $self->{TITLE} = 'Princess';
      splice @$words, $i, 1;
      next;
    }
    if ($w eq 'Marquess')
    {
      $self->{TITLE} = 'Marquess';
      splice @$words, $i, 1;
      next;
    }
    if ($w eq 'Brig-Gen')
    {
      $self->{TITLE} = 'Brigadier General';
      splice @$words, $i, 1;
      next;
    }
    if ($w eq 'LADY')
    {
      $self->{TITLE} = 'Lady';
      splice @$words, $i, 1;
      next;
    }
    if ($w eq 'II' || $w eq 'III')
    {
      $self->{DYNAST} = $w;
      splice @$words, $i, 1;
      next;
    }
    if ($i == 0 && ($w eq 'Baron' || $w eq 'Count'))
    {
      $self->{TITLE} = $w;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^\((\d)\)$/)
    {
      $self->{COUNTER} = $1;
      splice @$words, $i, 1;
      next;
    }
    if ($w =~ /^[A-Z]\.$/)
    {
      # A single initial with a point.
      $i++;
      next;
    }
    if ($w =~ /^[A-Z]$/)
    {
      # Add point to a single letter.
      $words->[$i] .= '.';
      $i++;
      next;
    }
    if ($w =~ /^\(([A-Z][a-z]+)\)$/)
    {
      my $inner = $1;
      if (exists $SPECIALS{SHORT}{$inner})
      {
        $self->{SHORT} = $inner;
        splice @$words, $i, 1;
        next;
      }
      if (exists $SPECIALS{NICKNAME}{$inner})
      {
        $self->{NICKNAME} = $inner;
        splice @$words, $i, 1;
        next;
      }
      if (exists $SPECIALS{RENAME}{$inner})
      {
        $self->{RENAME} = $inner;
        splice @$words, $i, 1;
        next;
      }
    }

    if ($w =~ /\./ && $w !~ / / && $w !~ /[a-z]/)
    {
      # Probably a list of initials.  Space them out properly and
      # include consistent dots.
      my @e = split /\./, $w;
      my $elen = $#e;
      die "Empty list: $w" unless $elen > 0;

      for my $j (0 .. $elen)
      {
        my $ee = $e[$j];
        die "Expected initial: $ee" unless length($ee) == 1;
        $e[$j] .= '.';
      }

      splice @$words, $i, 1, @e;
      $i += $elen + 1;
      next;
    }


    $i++;
  }
}


sub get_capitalization
{
  # Not a class method
  my ($text) = @_;

  return INITIAL if $text =~ /^[A-Z]\.{0,1}$/;
  return ALLCAPS if $text =~ /^[A-Z]+$/;
  return CAPITALIZED if $text =~ /^[A-Z][a-z]+$/;
  return ALLCAPS if $text =~ /^[DOL]'[A-Z]+$/; # D'ANIELLO
  return ALLCAPS if $text =~ /^Ma{0,1}c[A-Z]+$/; # MacMAHON, McDONALD

  if (exists $EXCEPTIONS{$text})
  {
    return $EXCEPTIONS{$text};
  }

  if ($text =~ /^([A-Za-z]{2,})-([A-Za-z]{2,})$/)
  {
    # Something like Marie-Claire or ABU-GHAZALEH
    my ($a, $b) = ($1, $2);
    my $c1 = get_capitalization($a);
    my $c2 = get_capitalization($b);
    return $c1 if $c1 == $c2;
  }

  return GENERAL;
}


sub get_particle
{
  # Not a class method
  my ($text) = @_;

  return PARTICLE if exists $PARTICLES{uc($text)};

  return GENERAL;
}


sub add
{
  my ($self, $key, $text, $country) = @_;

  # reprint_list(\@FIRST_NAMES, 'FIRST_NAMES');
  # reprint_list(\@LAST_NAMES, 'LAST_NAMES');
  # die;

  # if ($text =~ /Marquess/)
  # {
    # print "HERE\n";
  # }

  my @words = split /\s+/, $text;

  $self->remove_various(\@words);

  my @caps;
  for my $v (@words)
  {
    push @caps, get_capitalization($v);
  }

  if ($#caps == 1)
  {
    if ($caps[0] == CAPITALIZED && $caps[1] == ALLCAPS)
    {
      $self->add_first($key, $words[0]);
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($caps[0] == ALLCAPS && $caps[1] == CAPITALIZED)
    {
      $self->add_first($key, $words[1]);
      $self->add_last($key, $words[0]);
      return;
    }
    elsif ($caps[0] == INITIAL && $caps[1] == ALLCAPS)
    {
      $self->add_first_initial($key, $words[0]);
      $self->add_last($key, $words[1]);
      return;
    }
    elsif ($caps[0] == ALLCAPS && $caps[1] == INITIAL)
    {
      $self->add_first_initial($key, $words[1]);
      $self->add_last($key, $words[0]);
      return;
    }
    elsif ($words[0] eq '-' || $words[1] eq '-')
    {
      print "$text WWW\n";
      return;
    }
    else
    {
      print "$text ZZZ\n";
      return;
    }
  }

  if ($#caps > 1)
  {
    # Look for last names containing particles.
    my @particles;
    for my $v (@words)
    {
      push @particles, get_particle($v);
    }

    return if $self->add_with_particle($key, \@words, \@caps, \@particles);
    return if $self->add_with_initials($key, \@words, \@caps, \@particles);
    return if $self->add_with_split($key, \@words, \@caps, \@particles);
  }

  if ($#caps == 2 && $caps[0] == CAPITALIZED && $caps[2] == ALLCAPS)
  {
    if (exists $FIRST_NAMES_HASH{$words[1]})
    {
      $self->add_first($key, "$words[0] $words[1]");
      $self->add_last($key, $words[2]);
      return;
    }
    if (exists $LAST_NAMES_HASH{$words[1]})
    {
      $self->add_first($key, $words[0]);
      $self->add_last($key, "$words[1] $words[2]");
      return;
    }
    if ($caps[1] == INITIAL)
    {
      $self->add_first($key, $words[0]);
      $self->add_middle_initial($key, $words[1]);
      $self->add_last($key, $words[2]);
      return;
    }

    print "$text YYY($#caps)\n";
    return;
  }
    

  print "$text XXX\n";
}


sub add_first
{
  my ($self, $key, $text) = @_;

  if (! exists $self->{FIRST_FULL} &&
      ! exists $self->{VARIANT} &&
      ! exists $self->{NICKNAME} &&
      ! exists $self->{RENAME} &&
      ! exists $self->{SHORT})
  {
    # Assume it's a full-form name, even if we know that it could
    # be a variant.
    $self->{FIRST_FULL} = $text;
    return;
  }

  for my $key (qw(FIRST_FULL VARIANT NICKNAME RENAME SHORT))
  {
    return if exists $self->{$key} && $self->{$key} eq $text;
  }

  for my $tag (qw(VARIANT NICKNAME RENAME SHORT))
  {
    if (exists $SPECIALS{$tag}{$text})
    {
      if (exists $self->{FIRST_FULL})
      {
        if (exists $SPECIALS{$tag}{$text}{$self->{FIRST_FULL}})
        {
          die "$tag: $self->{$tag} vs $text" if exists $self->{$tag};

          # It's a special form of FIRST_FULL.
          $self->{$tag} = $text;
          return;
        }
      }
      elsif (exists $self->{$tag})
      {
        die "$tag $self->{$tag} vs $text" if ($self->{$tag} ne $text);
      
        # We already have the special form.
        return;
      }
      else
      {
        # It's a new special form.
        $self->{$tag} = $text;
        return;
      }
    }
    elsif (exists $self->{FIRST_FULL} &&
      exists $SPECIALS{$tag}{$self->{FIRST_FULL}} &&
      exists $SPECIALS{$tag}{$self->{FIRST_FULL}}{$text})
    {
      # We got the special form first, but we stored it in FIRST__FULL,
      # and now we got the full first name.
      $self->{$tag} = $self->{FIRST_FULL};
      $self->{FIRST_FULL} = $text;
      return;
    }
    elsif (exists $self->{$tag} &&
      exists $SPECIALS{$tag}{$self->{$tag}}{$text})
    {
      # We got the special form directly into the right place.
      $self->{FIRST_FULL} = $text;
      return;
    }
  }

  # Can use $key
  print "$text: Haven't learned multiple first names yet.\n";
}


sub add_first_initial
{
  my ($self, $key, $text) = @_;

  # This is a stand-alone initial (or initials).
  if (exists $self->{FIRST_INITIAL})
  {
    die "Already have an initial when adding $text";
  }

  if (exists $self->{FIRST_FULL} &&
      exists $self->{VARIANT} &&
      exists $self->{NICKNAME} &&
      exists $self->{RENAME} &&
      exists $self->{SHORT})
  {
    die "Already have a first name when adding initial $text";
  }

  $self->{FIRST_INITIAL} = $text;
}


sub add_middle_initial
{
  my ($self, $key, $text) = @_;

  # This is a middle initial (or initials).
  if (exists $self->{MIDDLE_INITIAL})
  {
    die "Already have a middle initial when adding $text";
  }

  $self->{MIDDLE_INITIAL} = $text;
}


sub add_last
{
  my ($self, $key, $text) = @_;

  if (! exists $self->{LAST_FULL} &&
      ! exists $self->{LAST_VARIANT} &&
      ! exists $self->{LAST_EARLIER1} &&
      ! exists $self->{LAST_EARLIER2})
  {
    # Assume it's a full-form name.
    $self->{LAST_FULL} = $text;
    return;
  }

  for my $key (qw(LAST_FULL LAST_VARIANT LAST_EARLIER1 LAST_EARLIER2))
  {
    return if exists $self->{$key} && $self->{$key} eq $text;
  }

  if ($key eq 'NAME_DEPRECATED')
  {
    if (! exists $self->{LAST_EARLIER1})
    {
      $self->{LAST_EARLIER1} = $text;
      return;
    }
    if (! exists $self->{LAST_EARLIER2})
    {
      $self->{LAST_EARLIER2} = $text;
      return;
    }
  }


  print "$text: Haven't learned multiple last names yet.\n";
}


sub add_with_particle
{
  my ($self, $key, $words, $caps, $particles) = @_;

  my $len = $#$words;
  my $p_first = 99;
  for my $i (0 .. $len)
  {
    if ($particles->[$i] eq PARTICLE)
    {
      $p_first = $i;
      last;
    }
  }

  my $p_last = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($particles->[$i] eq PARTICLE)
    {
      $p_last = $i;
      last;
    }
  }

  return 0 unless $p_first <= $p_last;
  return 0 unless $p_first > 0 && $p_last < $len;

  for my $i (0 .. $p_first-1)
  {
    return 0 unless $caps->[$i] eq CAPITALIZED;
  }

  for my $i ($p_last+1 .. $len)
  {
    return 0 unless $caps->[$i] eq ALLCAPS;
  }

  my $first = join(' ', @{$words}[0 .. $p_first-1]);
  my $last = join(' ', @{$words}[$p_first .. $len]);

  $self->add_first($key, $first);
  $self->add_last($key, $last);
  return 1;
}


sub add_with_initials
{
  my ($self, $key, $words, $caps) = @_;

  my $len = $#$words;
  my $p_first = 99;
  for my $i (0 .. $len)
  {
    if ($caps->[$i] eq INITIAL)
    {
      $p_first = $i;
      last;
    }
  }

  my $p_last = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($caps->[$i] eq INITIAL)
    {
      $p_last = $i;
      last;
    }
  }

  return 0 unless $p_first <= $p_last;
  return 0 unless $p_first >= 0 && $p_last < $len;

  for my $i (0 .. $p_first-1)
  {
    return 0 unless $caps->[$i] eq CAPITALIZED;
  }

  for my $i ($p_last+1 .. $len)
  {
    return 0 unless $caps->[$i] eq ALLCAPS;
  }

  my $first = '';
  if ($p_first > 0)
  {
    my $first = join(' ', @{$words}[0 .. $p_first-1]);
    $self->add_first($key, $first);
  }

  my $initials = join(' ', @{$words}[$p_first .. $p_last]);
  my $last = join(' ', @{$words}[$p_last+1 .. $len]);
  $self->add_middle_initial($key, $initials);
  $self->add_last($key, $last);

  return 1;
}


sub add_with_split
{
  # Potentially this is a more powerful version of add_with_particle.
  # TODO Try without add_with_particle and also without the
  # special 3-element version further up

  # There should be a first name in front and a last name at the end.
  # Can we split somewhere along the way such that particles and
  # known last names go in the last name, and the rest in the first
  # name?

  my ($self, $key, $words, $caps, $particles) = @_;

  my $len = $#$words;
  return unless $len > 1;

  my $p_last = 99;
  for my $i (0 .. $len)
  {
    if ($caps->[$i] ne CAPITALIZED)
    {
      $p_last = $i;
      last;
    }
  }

  my $p_first = -1;
  for my $i (reverse 0 .. $len)
  {
    if ($caps->[$i] ne ALLCAPS)
    {
      $p_first = $i;
      last;
    }
  }

  return 0 unless $p_first + 1 == $p_last;

  for my $i (1 .. $p_first)
  {
if (! exists $FIRST_NAMES_HASH{$words->[$i]})
{
  print "MISS $words->[$i]\n";
}
    return 0 unless exists $FIRST_NAMES_HASH{$words->[$i]};
  }

  for my $i ($p_last .. $len-1)
  {
if (! exists $LAST_NAMES_HASH{$words->[$i]} &&
   $particles->[$i] ne PARTICLE)
{
  print "MISS $words->[$i]\n";
}
    return 0 unless 
      exists $LAST_NAMES_HASH{$words->[$i]} || 
      $particles->[$i] == PARTICLE;
  }

  my $first = join(' ', @{$words}[0 .. $p_first]);
  $self->add_first($key, $first);

  my $last = join(' ', @{$words}[$p_last .. $len]);
  $self->add_last($key, $last);

  return 1;
}


sub str_full
{
  my ($self) = @_;

  my $s = '';
  # TODO
  return $s;
}


1;
