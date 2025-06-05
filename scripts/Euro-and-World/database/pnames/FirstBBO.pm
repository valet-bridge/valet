#!perl

# First names that appear in the BBO db file.

package FirstBBO;

use strict;
use warnings;
use v5.10;
use Exporter 'import';

our @EXPORT = qw(@FIRST_BBO);

use utf8;

our @FIRST_BBO =
qw(
  Abhishek Adana Addie Adeline Adem Adri Adrie Agah Agathe Ahron 
  Ahuva Aine Akman Alberta Ale Alina Alix Ally Anamaria Ance André 
  Angie Ania Ann-christin Ann-karin Ans Antalya Anto Arad Ariela Arka 
  Armelle Arnaldo Arto Arzie Asad Asia Asim Asuncion Ataturk AtatÜrk 
  Atul Avraham Aya Ayd Azafers 

  Babs Bahattin Balk Barrie Bartek Basia Batia Becky Bedrettin Bekir 
  Belen Beppe Bercu Bernice Bertie Bess Bets Bev Biagio Bilha Bili 
  Birte Björn Bjørn Blanche Boaz Bobbi Bobbie Bobi Bobo Boiko Bond 
  Boo Bosse Boyan Brak Brianna Brigid Brit Bruria Bunny Burhaniye 
  Bursa Bydgoszcz Börje Bülent 

  Caitlin Cam Camelia Candy Capulcu Cara Carlene Carlota Cat Cath 
  Ceco Cesar Cezar Chana Charo Chas Chelo Cherry Chiedere Chiedi 
  Chiedila Christel Christin Chujun Cihat Cilla Clementine Clo Clyde 
  Coco Cookie Cora Coral Cristi Cumali Cumhuriyet Cy Czapczyk 

  Danièle Danka Daphna Darcy Davey Dawn Debayan Deirdre Delores 
  Denmert Des Devrim Dewantoro Dian Didi Dierk Dim Dimitra Dimo Dinah 
  Diny Dion Dixie Dodo Dona Doni Dorrit Doruk Dost Dot Dottie Dotty 
  Douwe Dov Duane Duke Dusty Dvora 

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

  Laci Lana Laos Laurillau Lella Len Leni Lenie Lenny Leona Leonor 
  Leroux Lies Liesbeth Lilia Linn Lizzy Llewellyn Lolo Loraine Lorena 
  Lori Lorie Lorne Lory Lotta Louiz Loulou Lubo Luca Luci Lucila 
  Lucille Ludivine Lyly Lynette Lütfi 

  Macit Maddie Madeline Mado Magnar Mags Mail Maj-britt Mali Malka 
  Mam Mandy Manny Manon Marcie Marcy Marg Marga Marge Margret 
  Mariapia Mariarosa Mariateresa Maribel Mariela Marilou Marine 
  Marjie Marlis Marlon Marly Marmaris Martyn Marv Maryann Maryanne 
  Maryellen Marylou María Mat Mattei Mavis Mazal Meira Melinda Melka 
  Melle Merlino Mersin Mery Mic Michał Michèle Miki Milagros Milen 
  Millie Minas Misha Misho Missy Misty Mithat Mitzi Mm Mogens Moni 
  Monte Mort Muhittin Musa Myra Myrna Mónica 

  Nacho Nadir Nahit Nalini Nando Nano Nasko Naty Nazilli Nazmi Nebil 
  Necati Necdet Nechama Neco Neli Nelleke Nena Nessuna Nessuno Nicky 
  Nik Nikki Nili Ninguno Nini Ninni Nives Niyazi Noel Nomi Nona Norm 
  Nuala 

  Oddvar Ofra Olek Oli Oline Olsztyn Ondine Oreste Orna Ozel 

  Paco Pantelis Paweł Paz Peg Pepa Pepe Peppe Peppino Pernik Petrov 
  Piergiorgio Pinson Piotrek Pipo Pippo Pit Pnina Pola Poonam Pop 
  Poyraz Prashant Prithviraj Przemek Puck 

  Quincy 

  Rabin Radek Radus Rafa Rafi Ramona Ras Real Rebeca Rebel Reg Reggie 
  Reggio Reinhard Relu René Renée Ric Richard Rickard Rietje Riki 
  Rima Robert Rochelle Rocio Rodger Romen Romuald Romy Rosalie 
  Roseann Rosette Rosine Rosita Rosy Roxy Ruby Ruse Rusty Ruthie 
  Ruthy Ruti Ruty Rysiek Régis 

  Sadan Sadettin Sadie Saffet Sagar Sait Sal Salvo Samos Samsun Sana 
  Santosh Sas Saurabh Sayac Sebbo Sefer Selami Selo Selçuk Sermin 
  Seyfi Sezai Shanti Shari Shaul Sheld Shelly Shelo Sherief Sherri 
  Sherrie Sheryl Shimon Shine Shirl Shlomit Shosh Shoshi Shyam Simeon 
  Simon Sisi Sissi Siz Sky Soare Sofi Sourav Stanimir Steph Stew Stu 
  Sudip Sudipta Sundar Sunita Sunny Surabaya Suz Suzana Suzie 
  Svetoslav Svilen Sybille Syd Süleyman 

  Tamar Tami Tammy Tan Tarja Tatjana Taylan Tayyar Tea Tere Tess 
  Tessa Tex Texas Thouvenot Tikva Tilly Tiny Tita Titok Tomek Tomi 
  Tonny Torbjørn Torleif Trabzon Traisi Traudi Trish Trisha Troy 
  Tysha 

  Ula Uli Ulisse Uzi 

  Valérie Vania Varna Vasant Vasilis Vencislav Vic Vickie Viki Vilma 
  Vio Vlado 

  Walek Walt Wangbin Wangjun Wes Wiesiek Wilbur Willi Winifred 

  Ximena 

  Yaffa Yakup Yalova Yambol Yaron Yaya Yochi Yohanan Yolanda Yoli 
  Yona Yosy Yunnie 

  Zaza Zbyszek Zee Zeev Zehava Zeynel Zibi Zila Zipi Zvika 

  Åsa 

  Ömer Özel 

  Øyvind 

Amitava
Animesh
Anjan
Arghadip
Abdool
Abhinav
Abhirup
Abhisek
Abi
Abid
Abidin
Abin
Achintya
Adelheid
Adhikram
Adina
Adish
Adrianne
Aenne
Agenor
Aggie
Agniswar
Agniv
Agnus
Ahindra
Aidoru
Akash
Akiva
Alaa
Alastair
Albrecht
Aleen
Alef
Alek
Alexia
Alf-Ole
Alfhild
Alfian
Alissa
Alister
Alphonse
Alton
Alun
Alverna
Amariusz
Amin
Amitabha
Amitava
Amjad
Ammara
Amyn
Ananth
Ancho
Ando
Andreia
Ane
Angeline
Anika
Aniko
Anirban
Anish
Anisha
Anisur
Anitha
Anjali
Anjan
Anka
Anki
Ankit
Ankur
Ann-Britt
Annalena
Annan
Anne-Britt
Anne-Lise
Annethe
Annike
Annlies
Annmarie
Anoop
Antje
Anu
Anubhab
Anuj
Aravind
Archana
Archisman
Archit
Ardi
Arghadweep
Arghya
Aria
Arik
Arindam
Aristeidis
Ariz
Arkaprabha
Arleen
Armande
Arnar
Arnoldo
Arnt
Arpan
Arpana
Artemil
Arunabha
Arye
Ashe
Ashfaq
Asif
Asitabha
Asitranjan
Aslan
Asoke
Aspen
Asraful
Asrinjoy
Asta
Ataur
Atilla
Atli
Attie
Augusta
Austin
Avik
Avilash
Avirup
Avis
Avishek
Ayananshu
Aylwin
Aytac
Azim
Baljit
Baltasar
Balu
Banashree
Bane
Banna
Barak
Barth
Bartolome
Bartu
Becca
Beelu
Beggi
Bendt
Beniamin
Bennet
Bennett
Benson
Beny
Bergvin
Bern
Bernardette
Berndt
Berne
Bernt-Ivar
Bhaskara
Bhubanjit
Bikash
Billmar
Bjargey
Boban
Bobbe
Boby
Bocho
Bodhayan
Bodo
Bodvar
Bodzio
Boerje
Bojko
Bonifacio
Bonni
Britt-Anne
Britt-Inger
Britt-Mari
Brunon
Buck
Burt
Burton
Butch
Byron
Cal
Calla
Calvert
Calvi
Camion
Carena
Carie
Carli
Carlye
Carmella
Carminia
Carolee
Carter
Caryll
Caryn
Casey
Cassidy
Cayce
Cece
Ceci
Celsa
Cenan
Cetty
Chao-Chun
Chetan
Chia
Chick
Chilton
Chiradeep
Chittaranjan
Chiyoko
Chong
Chresten
Christie
Clarence
Clarene
Clarke
Clay
Climton
Clint
Clinton
Cloud
Cobia
Cody
Comey
Connee
Conxita
Corbin
Cord
Corentin
Cori
Cosette
Cox
Dagrun
Dalibor
Dalina
Dallan
Dallas
Damji
Danele
Danja
Danko
Danusia
Darlyn
Dawid
Day
DeAnn
Deb
Debaditya
Debanjan
Debjit
Decon
Deena
Deepanjan
Deepshubhra
Degsy
Denice
Denyse
Dessie
Dessy
Devera
Dial
Dibyendu
Didrik
Dimcho
Dimityr
Diniz
Dinos
Dipan
Dipankar
Dipti
DirkJan
Doina
Dom
Donka
Doraisamy
Dorcas
Dorita
Lane
Pauli
Sangho
Sanjib
Shailesh
Spiridione
Valio
Vikrant
Zhijiang
Ziba
);

1;
