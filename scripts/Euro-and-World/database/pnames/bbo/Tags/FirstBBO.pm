#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::FirstBBO;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Abdool Abhinav Abhirup Abhisek Abhishek Abi Abid Abidin Abin 
  Achintya Adana Addie Adelheid Adeline Adem Adhikram Adina Adish 
  Adri Adrianne Adrie Aenne Agah Agathe Agenor Aggie Agniswar Agniv 
  Agnus Ahindra Ahron Ahuva Aidoru Aine Akash Akiva Akman Alaa 
  Alastair Alberta Albrecht Ale Aleen Alef Alek Alexia Alf-Ole 
  Alfhild Alfian Alina Alissa Alister Alix Ally Alphonse Alton Alun 
  Alverna Amariusz Amin Amitabha Amitava Amjad Ammara Amyn Anamaria 
  Ananth Ance Ancho Ando Andreia André Ane Angeline Angie Ania Anika 
  Aniko Animesh Anirban Anish Anisha Anisur Anitha Anjali Anjan Anka 
  Anki Ankit Ankur Ann-Britt Ann-christin Ann-karin Annalena Annan 
  Anne-Britt Anne-Lise Annethe Annike Annlies Annmarie Anoop Ans 
  Antalya Antje Anto Anu Anubhab Anuj Arad Aravind Archana Archisman 
  Archit Ardi Arghadip Arghadweep Arghya Aria Ariela Arik Arindam 
  Aristeidis Ariz Arka Arkaprabha Arleen Armande Armelle Arnaldo 
  Arnar Arnoldo Arnt Arpan Arpana Artemil Arto Arunabha Arye Arzie 
  Asad Ashe Ashfaq Asia Asif Asim Asitabha Asitranjan Aslan Asoke 
  Aspen Asraful Asrinjoy Asta Asuncion Ataturk AtatÜrk Ataur Atilla 
  Atli Attie Atul Augusta Austin Avik Avilash Avirup Avis Avishek 
  Avraham Aya Ayananshu Ayd Aylwin Aytac Azafers Azim 

  Babs Bahattin Baljit Balk Baltasar Balu Banashree Bane Banna Barak 
  Barrie Bartek Barth Bartolome Bartu Basia Batia Becca Becky 
  Bedrettin Beelu Beggi Bekir Belen Bendt Beniamin Bennet Bennett 
  Benson Beny Beppe Bercu Bergvin Bern Bernardette Berndt Berne 
  Bernice Bernt-Ivar Bertie Bess Bets Bev Bhaskara Bhubanjit Biagio 
  Bikash Bilha Bili Billmar Birte Bjargey Björn Bjørn Blanche Boaz 
  Boban Bobbe Bobbi Bobbie Bobi Bobo Boby Bocho Bodhayan Bodo Bodvar 
  Bodzio Boerje Boiko Bojko Bond Bonifacio Bonni Boo Bosse Boyan Brak 
  Brianna Brigid Brit Britt-Anne Britt-Inger Britt-Mari Brunon Bruria 
  Buck Bunny Burhaniye Bursa Burt Burton Butch Bydgoszcz Byron Börje 
  Bülent 

  Caitlin Cal Calla Calvert Calvi Cam Camelia Camion Candy Capulcu 
  Cara Carena Carie Carlene Carli Carlota Carlye Carmella Carminia 
  Carolee Carter Caryll Caryn Casey Cassidy Cat Cath Cayce Cece Ceci 
  Ceco Celsa Cenan Cesar Cetty Cezar Chana Chao-Chun Charo Chas Chelo 
  Cherry Chetan Chia Chick Chiedere Chiedi Chiedila Chilton Chiradeep 
  Chittaranjan Chiyoko Chong Chresten Christel Christie Christin 
  Chujun Cihat Cilla Clarence Clarene Clarke Clay Clementine Climton 
  Clint Clinton Clo Cloud Clyde Cobia Coco Cody Comey Connee Conxita 
  Cookie Cora Coral Corbin Cord Corentin Cori Cosette Cox Cristi 
  Cumali Cumhuriyet Cy Czapczyk 

  Dagrun Dalibor Dalina Dallan Dallas Damji Danele Danièle Danja 
  Danka Danko Danusia Daphna Darcy Darlyn Davey Dawid Dawn Day DeAnn 
  Deb Debaditya Debanjan Debayan Debjit Decon Deena Deepanjan 
  Deepshubhra Degsy Deirdre Delores Denice Denmert Denyse Des Dessie 
  Dessy Devera Devrim Dewantoro Dial Dian Dibyendu Didi Didrik Dierk 
  Dim Dimcho Dimitra Dimityr Dimo Dinah Diniz Dinos Diny Dion Dipan 
  Dipankar Dipti DirkJan Dixie Dodo Doina Dom Dona Doni Donka 
  Doraisamy Dorcas Dorita Dorrit Doruk Dost Dot Dottie Dotty Douwe 
  Dov Duane Duke Dusty Dvora 

  Earl Earle Ecol Edi Edie Edip Edirne Edy Eirini Eko Elayne Eliana 
  Elif Elinor Elle Ellin Eloise Elsebeth Ema Emel Emi Eray Ergul 
  Erkut Esperto Estela Etta Etti Etty Evelin Eveline Evie Evy 

  Fede Fehmi Felice Fern Fiorella Florin Floyd Fons Forse Framboise 
  Frances Franek Frankie Franziska François Françoise Freda Frieda 

  Gab Gabe Gabon Gabri Gale Galia Galip Gar Gaurav Geneviève Genia 
  Geoffroy Georgie Gerlinde Gerrie Geula Giannis Gidi Gin Gina Ginger 
  Gita Giusi Glenda Glo Gogos Gord Gordy Gosia Grisha Gry Grzesiek 
  Gunnel Gérard Gökhan Göran Gürsel 

  Hal Hamdi Hannie Hansje Hava Haydar Haydee Hayri Hedva Hedwige 
  Heimir Helma Herb Herm Hervé Hido Hildegard Hille Honey Hélène 
  Hüseyin 

  Ignazio Ija Ikram Ila Ilene Ilian Ilias Inconnu Ingemar Ioana 
  Iordan Irek Irv Iskenderun Itzik Ivailo Iza Izia Izik Izmir Izmit 

  Jacki Janek Janette Janey Janna Jasmin Jasmina Jau Jeanie Jeannette 
  Jennie Jepp Jeri Jewel Jhon Jivko Jo-ann Joanie Joaquim Johny Jojo 
  Joni Joro Josep Josie Josy José Judie Jutta Jörgen Jørgen 

  Kai Kali Kapalu Karakartal Kars Kasia Katy Kayhan Kayseri Keith 
  Keke Keren Kerry Kiko Kiri Kobi Koi Koko Koksal Kole Korhan Kosta 
  Kostadin Krasi Krille Kristi Krysia Krzysiek Kuki Kumar Kusum Kuzey 

  Laci Lana Lane Laos Laurillau Lella Len Leni Lenie Lenny Leona 
  Leonor Leroux Lies Liesbeth Lilia Linn Lizzy Llewellyn Lolo Loraine 
  Lorena Lori Lorie Lorne Lory Lotta Louiz Loulou Lubo Luca Luci 
  Lucila Lucille Ludivine Lyly Lynette Lütfi 

  Macit Maddie Madeline Mado Magnar Mags Mail Maj-britt Mali Malka 
  Mam Mandy Manny Manon Marcie Marcy Marg Marga Marge Margret 
  Mariapia Mariarosa Mariateresa Maribel Mariela Marilou Marine 
  Marjie Marlis Marlon Marly Marmaris Martyn Marv Maryann Maryanne 
  Maryellen Marylou María Mat Mattei Mavis Mazal Meira Melinda Melka 
  Melle Merlino Mersin Mery Mic MichÃ¨le Miki Milagros Milen 
  Millie Minas Misha Misho Missy Misty Mithat Mitzi Mm Mogens Moni 
  Monte Mort Muhittin Musa Myra Myrna Mónica 

  Nacho Nadir Nahit Nalini Nando Nano Nasko Naty Nazilli Nazmi Nebil 
  Necati Necdet Nechama Neco Neli Nelleke Nena Nessuna Nessuno Nicky 
  Nik Nikki Nili Ninguno Nini Ninni Nives Niyazi Noel Nomi Nona Norm 
  Nuala 

  Oddvar Ofra Olek Oli Oline Olsztyn Ondine Oreste Orna Ozel 

  Paco Pantelis Pauli Paz Peg Pepa Pepe Peppe Peppino Pernik 
  Petrov Piergiorgio Pinson Piotrek Pipo Pippo Pit Pnina Pola Poonam 
  Pop Poyraz Prashant Prithviraj Przemek Puck 

  Quincy 

  Rabin Radek Radus Rafa Rafi Ramona Ras Real Rebeca Rebel Reg Reggie 
  Reggio Reinhard Relu René Renée Ric Richard Rickard Rietje Riki 
  Rima Robert Rochelle Rocio Rodger Romen Romuald Romy Rosalie 
  Roseann Rosette Rosine Rosita Rosy Roxy Ruby Ruse Rusty Ruthie 
  Ruthy Ruti Ruty Rysiek Régis 

  Sadan Sadettin Sadie Saffet Sagar Sait Sal Salvo Samos Samsun Sana 
  Sangho Sanjib Santosh Sas Saurabh Sayac Sebbo Sefer Selami Selo 
  Selçuk Sermin Seyfi Sezai Shailesh Shanti Shari Shaul Sheld Shelly 
  Shelo Sherief Sherri Sherrie Sheryl Shimon Shine Shirl Shlomit 
  Shosh Shoshi Shyam Simeon Simon Sisi Sissi Siz Sky Soare Sofi 
  Sourav Spiridione Stanimir Steph Stew Stu Sudip Sudipta Sundar 
  Sunita Sunny Surabaya Suz Suzana Suzie Svetoslav Svilen Sybille Syd 
  Süleyman 

  Tamar Tami Tammy Tan Tarja Tatjana Taylan Tayyar Tea Tere Tess 
  Tessa Tex Texas Thouvenot Tikva Tilly Tiny Tita Titok Tomek Tomi 
  Tonny Torbjørn Torleif Trabzon Traisi Traudi Trish Trisha Troy 
  Tysha 

  Ula Uli Ulisse Uzi 

  Valio Valérie Vania Varna Vasant Vasilis Vencislav Vic Vickie Viki 
  Vikrant Vilma Vio Vlado 

  Walek Walt Wangbin Wangjun Wes Wiesiek Wilbur Willi Winifred 

  Ximena 

  Yaffa Yakup Yalova Yambol Yaron Yaya Yochi Yohanan Yolanda Yoli 
  Yona Yosy Yunnie 

  Zaza Zbyszek Zee Zeev Zehava Zeynel Zhijiang Ziba Zibi Zila Zipi 
  Zvika 

  Åsa 

  Ömer Özel 

  Øyvind 

  Aadil Aamer Abeer Ahava Aiman Akill Akira Akoit Alisha Amara
  Amelka Amila Anina Apana Asena Atara Aulus Aytac

  Bandi Bando Banjer Barend Batie Bayan Belisa Beren Berkan Berkut
  Berra Bertel Bertus Betta Bikram Biman Blaine Blara Boran Boslo

  Dedel Dermane Dhani Dhuni Dilla Dilly Dinan Diran Diren Dotti
  Duysal Dwill

  Edita Efira Eirek Elies Emili Eros Esperanza Evita Ezibi

  Feray Ferhan Flippi Flore Florie Fosen Franda Friedel

  Gabin Galen Gandon Ganni Gilla Gilmar Gioni Glorie Golla Goral
  Gradus Grong Gulli Gulus Gunder Gusta

  Hashim Haman Hanni Hattie Heide Helli Hemin Henda Hilario Hilko
  Hilla Hilly Himawan Hrafn Hrelu Hriva

  Irini Ishan Icaro Iliga Inaki Iuras

  Jesson Jadie Jadil Janber Janick Jarad Jarda Jarie Jasia Jeker
  Jelle Jetty Jhale Joline Jolle Joran Joren Juras

  Kirit Kabou Kalia Karia Karie Karon Karya Kayla Kelli Kenza Khayer
  Khuman Kirit Kisio Kjoro Kolla Kora Krasim

  Landon LaVon Lanny Lissa Lluis Lolina Lolla Loras Lotten Lyaya

  Melia Meline Minna Manick Manis Manish Mantas Marinel Maune
  Mendel Milla Minna Molla Murli

  Nisim Nance Narda Neasa Nissa Nolly

  Oberon Odetta

  Pancho Peris

  Rares Radda Rapin Rolla

  Sante Scilla Selam Senga Seren Sevan Stani Solla

  Tuner Toddy

  Uchen

  Vroni

  Willa

  Zilla

  Ahadin Aima Aina Ainaya Alaeddin Albane Aleth Alzuri Ananzi Andrée
  Apolonia Arzaz Azu
  Bayram Bektas Beyhan Birdie Bregtje Buby
  Caty Cezmi Chania Cybèle
  Daffi Dalila Davut Dhen Diao
  Efthimios Eid Elie Erdin Erol Eyyüp
  Ferdy Ferit Filiz Fränzi Fulya
  Gatot Gerti Giampi Graziamaria Gudveig Guena Günni
  Haci Hallgeir Harshad Hisam Honeylee
  Idman Iliya Ireta
  Jakop Jeff Jehane Jeun Jogindra Jongky Juju Jushi Jørn
  Karelle
  Kasif Kasim Kayan Korine Kosyo Kyriakos
  Lakjio Laudine Laurette Lauriane Lezinka Lilo Liselil Liujun
  Liza Locky Lorella Luise Luma
  Malbina Malissa Marizul Mariapaola Marlena Marnie Marsel Marzenna
  Mayol Mevlüt Michala Mici Mido Miko Muhammet Mumu Müfit
  Nacher Nadhin Nayak Nedko Nedo Nezihi Nige Nilesh N'Oga
  Ozzie Önder Ören Özdener Özer
  Paulie Pavinee Pepo Perisa Pik Pleun Puchi
  Ramazan Raylene Richi Roni Rosalila Ruç Ruja Rüstem
  Sabyasachi Safa Sakke Samiksha Sasho Schoumicha Sefik Senol Sevinç
  Shaban Shary Shukoufeh Sigbjørn Soad Songa Sowmitra Stevan Sudarshan
  Sudirman Sülo Sveinngun Sy
  Taara Tadjib Theodoros Tshepiso Txomin Tyroon
  Üzeyir
  Vahit Vehbi Viktoria Viliam
  Waled Winson Woen
  Xenia
  Yaren Yehudit Yeni Yoya Youyou Yueyin Yunyue
  Zare Zekai Zekeriya Zdzicho Zhivko Zhixiu

  Arnaut Cevdet Frédérique Gerasimos Göro Günay Ivonna Krzys
  Sebahettin Öksel Özden Özgür Pål Rémy Samo Sergi Seyit Torvald
  Ümit Yüksel

  Aghita Ainy Akinom Annki Anyelik Apryanta Ayca Aygün Aymar
  Bimla Birkan Blagi Brune Budi Byju
  Caglar Cakircali Celile Cholai Craquotte
  Divaraka Donita
  Fahrettin Fenita Ferry Fuat
  Gapil Gilly Gökay
  Guangbin
  Haohao Hazar Hery Huysuz
  Inmaculada Irson
  Jieren Jyaubin
  Kamaljit Kata Kikou Kizola Konrat
  Lindy Lukman
  Macca Majvor Marj Melek Morena Murph Musty Mårten
  Nadri Necmi Nial Normand
  Okcan Öner Öktem
  Paradima Prasanta Priti
  Raymon Reki Ridvan Ronger
  Sacit Sada Sadra Sankul Saya Semsettin Shansy Shterion
  Surender Susu Sysser
  Tiena Touran Till Tiny Trinitee Tuzar
  Udatta Ulric
  Valli Volkan
  Xieluo Xuefeier
  Yocheved Yolcu Yongfu
  Zdzislaw Zoli
  Øivind

  Amaranta Aramesh Armony
  Bjørnar
  Cissi Curly Cüneyt
  Dimitar Elod Ferdi Feyzullah Gaétan Guglielmo Gündüz
  Izzy Jieren Juana Karina Kerim Lysette Maité Mayur Miep Mildi
  Nail Ocson Odd Oyil Öge Öztekin
  Reine Sjef Slamet Todd Turan Vinayak Ximena Zoé

  Ade Aenul Afifah Africa Amatore Annigret Anonyo Arvat Aycha Ays
  Berni Bicio Biji Boutaud Büsra Canip Cemo Chengquan Ciana Cumi
  Dalin Danail Dante Dawet Decky Deli Demitrius Derya Dinar Dobo
  Doel Dustin
  Edit Eminella Encho Ermanno Erwan Eya Flavius
  Gani Giorgetto Gitan Gogi Govind Grenfell Güven
  Hafiz Hazell Heloise Hüseyn Idro Imam Ippokratis Izzio
  Jef Josyane
  Kani Katinka Keisho Kostis Kranthirao Kryzsztof Kuljit Kürsat Kåre
  Lalou Laurance Lilka Ljubisa Lucetta Lusitana Lyng
  Majd Mancy Margarete Margeritha Mariasun Martinha Merve
  Mieczysław Mijntje Mikis Musti Müje
  Nadina Naranja Natali Nati Natuk Nea Nesimi Neuquina Nevenka
  Nibali Nietta Niraj Nurbay Nurullah
  Oceane Ordac Oszkar Önce Rhianna
  Rogeir Roki Ronni Röne Rumelili
  Sabu Sakis Sasko Seza Siggen Simcha Sirri Skarbimir
  Sooki Suayip Sueli Süreyya Sibylle Syham
  Tagi Tassios Tauno Theodori Tiberiu Tico Ünal
  Veny Vesya Virendra Virgul
  Xuechun Yasen Yenchi Yendi Zarko Zhangjie Åse

  Aquiles Araf Dougall Gülden Gürol Ibo Jadzia Muneca Nawaz
  Pumulo Rajon Rychu Sem Valmar Xuyou

  Abir Adha Akhteruzzaman Arief Aristea Atahualpa Aura
  Bjørke Bogac Bong Cengiz Chenhui Cudi
  Dennica Didina Dulce Ersah Ertürk Eylül Feyza Frymeta
  Gahis Gimgim Ginevra Gokay Gulten Güler Gültekin Güzide
  Iole Jemy Kavi Kesanli Khairuddin Lokman Lussy Merche Moch
  Nisa Pallina Pupa Rizgar Sedick Seiki Sevilay Shalom Sido Standa
  Taiji Ülgen Wadud Wardeen Wided Yura Zbych Zbychu

  Anang Anaz Asil Bayhan Blondu Burcan Cantürk Gulce Heniek Heru
  Izzettin Inas Kasey Kwanyoung Lis Mendo Novi Sahabettin Samdi
  Shalom Sipalui Suheyla Sukil Tavare Temur Tona Yuklong

);

my %SINGLE_TYPOS =
(
);


sub set_hashes
{
  my ($method, $key) = @_;

  $method->(\@MULTI_WORDS, \%MULTI_TYPOS,
    \@SINGLE_WORDS, \%SINGLE_TYPOS, $key);
}

1;
