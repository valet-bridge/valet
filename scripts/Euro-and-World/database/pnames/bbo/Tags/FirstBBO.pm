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
