#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Both;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Aad Aas Abbas Abdallah Abdullah Abe Abel Abi Abid Abraham Abram 
  Acar Adam Adamo Adel Adly Adnan Afzal Agha Agus Ahasan Ahmad Ahmed 
  Ahmet Ahn Akbar Ake Akhtar Akin Akter Alaa Alan Albert Alegre 
  Alejandro Alessandro Alev Alexander Alexandr Alexandre Alexia 
  Alexis Ali Alkan Allan Allen Allison Alp Alper Altan Aly Amal Aman 
  Amar Ambrose Amedeo Amin Amir Amit Amos Ana Anal Anand Ananda 
  Anders Andras Andre Andrea Andree Andrei Andres Andrew Anette Ange 
  Angel Angelova Anghel Angus Anikovich Anil Anisa Ansori Anton 
  Antoni Antonio Ao Aran Ardi Ari Arianto Arie Arif Arifin Arman 
  Arnaud Arnold Arnon Aron Arora Arslan Arthur Arwin Asaf Ashe Ashley 
  Ashraf Asla Aslam Aslan Assaf Assis Astrand Ata Atakan Atila Atilla 
  Augusta Austin Avery Aviram Avis Avni Avon Avril Awwad Ay Aydin 
  Ayhan Aykan Aykut Ayman Ayu Azim Aziz Azzam 

  Babu Bacon Bader Bagus Bahadir Baki Balasundaram Balazs Balint 
  Baltazar Bang Banna Bao Bar Barak Baran Barb Barbosa Baris Barna 
  Barnet Baron Barrett Barrie Barry Bart Barth Bas Basak Basar 
  Basheer Battista Baxter Bayram Bektas Bell Bella Ben Benedek 
  Benedict Beni Benjamin Bennet Bennett Benno Benoit Bensaid Benson 
  Berend Berge Berk Berlin Bern Berna Bernard Bernhard Berry Berthold 
  Bertram Bertrand Beyhan Bilal Bilge Bina Bindi Bing Birol Bjoern 
  Bjork Bjorn Blair Blake Bo Bob Bobby Bojko Bonifacio Bonny Bora 
  Borre Bose Boyce Boyd Boye Bradley Brady Brandon Brett Bruce Bruna 
  Bruno Bryan Buck Bud Budd Budihardjo Buket Burghard Burke Burt 
  Burton Buse 

  Cai Cal Calvi Cameron Can Caner Capri Carel Carlos Carlton Carmo 
  Carter Casey Caspar Cassidy Cata Ceci Cengiz Cesare Cetin Cezmi 
  Chacar Chan Chandra Chandrasekhar Chang Chao Charles Che Chelly 
  Chen Cheng Cheong Cheung Chi Chiara Chien Ching Ching-Chieh Chiu 
  Choi Chong Choo Chou Choukri Chow Christian Christie Chuck Chun 
  Chung Cita Claes Clair Clare Clark Clarke Claudiu Clay Clement 
  Clifford Clifton Clint Clinton Cody Cole Colin Colleen Conrad 
  Constantin Cooper Cornelis Cornelius Corrado Cory Coskun Costa Cox 
  Craig Cristina Cruz Curtis 

  Dag Dale Damiano Dan Dana Danan Dani Daniel Dario Dave David Davide 
  Davis Day Dean Deb Deen Delia Demir Deng Denis Dennis Deny Dewi Dey 
  Dharanishvar Dias Didier Diklic Dima Ding Ding-Ming Djoudi Dogan 
  Don Donald Donato Dongen Donovan Doran Dorisa Doruk Douglas Dragan 
  Drew Dubravko Duc Dumitru Duncan Duran Dursun Dvora 

  Easley Ebrahim Ece Edgar Edmond Edouard Eduard Edwin Edy Efraim 
  Efrat Ege Eggert Eid Elias Elie Elliot Elliott Ellis Elmer Else 
  Elvansyah Elwindra Engin Enoch Er Eran Ercan Erdal Erdem Erden 
  Erdinc Erdogan Eren Erez Ergun Erich Erkan Ernest Ernst Erol Ertel 
  Erwin Esin Etienne Eva Eve Evelyn Everett Ewald Ewart 

  Fabio Fabrizio Fady Falk Fan Fang Fani Farah Fares Faruk Fay 
  Federico Fei Fella Feng Ferdinand Ferdinando Ferenc Fernando Fiamma 
  Filip Finlay Finn Fletcher Fleur Floris Floyd Fong Fonseca France 
  Francesco Francis Francisca Francisco Franck Franco Francois Frank 
  Franklin Frantz Franz Fraser Frazer Freddy Frej Fried Fritz Fu 

  Gabor Gabriel Gabriele Gabriella Gad Gaetano Gal Gala Gama Gan 
  Ganapathy Gang Garcia Garland Garrett Garth Gary Gauthier Gayle Ge 
  Gennaro Gentile George Georges Gerard Gerardo Germaine German 
  Ghalib Gheorghe Ghias Ghose Giampaolo Giampietro Gil Gilbert Gilda 
  Giles Gill Giordano Giovanna Giovanni Giuliano Go Godefroy Goksel 
  Gonca Gopal Gordon Gordy Graca Grace Gracia Gracio Graf Graham 
  Grant Granville Gray Grazia Greer Gregory Griffith Grigore Gu 
  Gudrun Gui Guido Gul Gulden Guler Gultekin Gunawan Guner Gunes 
  Guney Gunilla Gunn Gunter Gunther Guo Gupta Gur Guray Gursel Guy 
  Guzman 

  Habib Hagen Hai Haider Haim Hakim Hakki Hala Hale Hallberg Hameed 
  Hamid Hamilton Han Hani Hank Hanna Hannah Hans Hansen Hao Haque 
  Harald Hari Harley Harmon Harris Harrison Hartono Harvey Hasan 
  Hasmet Hassan Hassine Haugen Hayden Hayet Hazel He Hee Hein 
  Heinrich Heinz Helge Helin Helle Helm Henderson Heng Henri Henry 
  Herbert Herman Hermann Hernando Herve Hiroya Hirsh Hisham Ho Hoi 
  Hon Hong Honghai Hope Horst Hossain Hossam Hou Hove Howard Hsi Hsia 
  Hsiao Hua Huang Hubert Hugo Hugues Hui Humphrey Hung Hussain 
  Hussein Hyder 

  Iancu Ibrahim Idil Ignazio Ilan Ilari Ilhan Ilie Imran Inna Iqbal 
  Iren Irwin Isabelle Iskandar Islam Ismail Isman Israel Istvan Ivy 

  Jack Jackson Jacob Jacques Jamal James Jan Jana Jansa Javed Jay 
  Jayakumar Jean Jeffrey Jen Jeng Jesse Jesus Jett Jhon Ji Jia 
  Jiahong Jiang Jin Jing Jinlong Jiong Joao Joel John Jonas Jones 
  Jordan Jorna Jorunn Joseph Jost Jourdain Joy Joyce Juan Julien 
  Julius Jung Jurek Just 

  Kaare Kahraman Kaligis Kalpana Kalyanasundaram Kam Kamal Kamel 
  Kamil Kamto Kang Kannan Kant Karel Karim Karol Kartal Kat Kate 
  Kaushik Kay Kaya Kazim Ke Keith Kelley Kelly Kelsey Kemal Kendrick 
  Kenny Kent Kenyon Kerem Khaled Khalid Khalil Khan Kieran Kim King 
  Kiran Kit Klint Ko Kohen Kong Konrad Koren Korkut Kostas Kotomi 
  Krishna Krishnakumar Krishnan Krishnaswamy Kuang Kumar Kuo Kurnia 
  Kurt Kutlu Kwok Kyle Kyoko Kyriakos 

  Lai Lajos Lakshman Lakshmanan Lal Lale Lan Landry Lane Lara Lau 
  Lauge Laurence Lauri Laurie Lavi Lawrence Lazar Lazarus Lee Leeuw 
  Lei Leigh Lena Lenka Leo Leon Leonard Leone Leonid Leopold Leroy 
  Leslie Lester Letizia Lev Levan Levy Lew Lewis Liang Liem Lila 
  Lilli Lilly Lin Lindsay Line Ling Linn Lionel Lis Lise Liss Liu 
  Liviu Lloyd Lo Long Lorentz Lorenzo Loretta Lotte Lou Louis Louise 
  Louk Lourdes Lu Lubis Lucas Luis Luisa Luiz Luke Lulu Lung Luo 
  Lutfi Lutz Lynn 

  Ma Mac MacCORMAC Machado MacHALE Maci Madeira Madhav Mae Magda 
  Magdalena Magni Magnus Maher Mahmood Maia Maj Majeed Major Malcolm 
  Malik Mallory Man Manasa Manasseh Mani Manoj Manson Mansoor Manuel 
  Mao Marcello Marcin Marco Marcus Marek Margit Margot Mari Maria 
  Mariano Marie Marin Marina Marini Marino Maris Mark Markus Marques 
  Marshall Marta Marti Martin Martins Marty Martyna Marvin Mas Masood 
  Mate Mateo Mather Mathew Mathieu Matko Matthias Mauri Maurice 
  Maurits Mauro Maury May Maya Mayo Mazhar Mee Meer Mehedi Mehta Mei 
  Meiling Meir Meka Mel Melka Menachem Meng Meral Meredith Mersin 
  Meta Mete Metin Meyer Miao Michael Michailov Michalek Michaux 
  Michel Michele Miguel Mihai Mik Mika Milo Milos Milton Min Mina 
  Ming-Hsuan Minh Miran Miranda Miro Miroslaw Mirza Misra Mitchell 
  Mitko Mitra Mo Modi Moen Mohamed Mohammad Mohammed Mohan Mohd 
  Mohiuddin Mohsen Moon Mora Moran Morgan Morgen Morris Morten Morton 
  Mou Mounir Moussa Moustafa Moza Muhammad Mulyadi Mumtaz Munir Murat 
  Murphy Murray Murthy Mustafa Mutlu Myles 

  Nabil Nadar Nader Nagy Naidu Nail Naki Nan Naran Narayan Narayanan 
  Narendra Natarajan Nathan Nazar Neil Neill Nell Nelson Neville Ni 
  Nicholas Nick Nico Nicolai Nicolas Nicole Nihal Nika Ning Nino 
  Niranjan Nishat Nishino Nita No Noble Nobre Noel Nolan Noldy Norman 

  Octavian Oguz Okay Oksana Oktaviandita Oktay Oktem Oland Olcay 
  Olech Oliver Olivier Omar Omer Omran Onder Ong Oren Orhan Orlando 
  Osman Otto Ove Owen Ozan Ozcan Ozer Ozge Ozgur Ozkan 

  Pal Palma Palmi Pan Panos Paolo Par Pari Pascal Pasi Patrick Patty 
  Paul Paula Paulo Pavel Pawel Paz Peer Pei Pelle Penev Peng Penny 
  Percy Pere Perepelitsya Periasamy Perry Peter Petrov Philip Pi 
  Piero Pierre Pietra Pina Ping Pinhas Pino Pinpin Pinto Piret 
  Piskanto Po-Yi Pol Polat Pong Prabhu Prakash Priatna Prince Prodan 
  Promila Purba Purushottam 

  Qasim Qi Qian Qiao Qin Qiu Quentin 

  Rabin Rachel Rafa Rafal Raghavan Ragnar Rahim Rahman Rainer Rajeev 
  Rajkumar Raju Ralph Ram Ramadan Ramakrishnan Ramamurthy Raman 
  Ramanathan Ramaratnam Ramesh Rami Ran Rana Randall Randy 
  Ranganathan Rao Rashid Raul Ravi Ravichandran Ray Raymond Razi 
  Razvan Reese Rehman Reiner Reinhold Remy Ren Renard Renaud Rens 
  Renu Reshwadithya Reti Rex Reyes Reza Ria Riad Rian Ricard Rich 
  Richard Riggs Rita Riva Riza Roald Roar Robb Roberts Rock Roger 
  Roisin Roland Rolland Rom Romaine Roman Romano Romeo Ron Rong Ronke 
  Rony Roos Rosa Rosalba Rosales Rosario Rose Rosetta Rosi Ross Roy 
  Ruben Rudolph Ruggiero Ruiz Rune Russ Russell Ryan 

  Sa Saad Sabine Sabri Sadashiv Sadek Sadi Saeed Safak Safari Sai 
  Said Saket Sakthivel Salah Saleem Saleh Salem Salih Salim Salman 
  Salvador Salvatore Sameer Samir Samuel Samy San Sandro Sankaran 
  Sanna Santanu Santoso Sapan Sari Sarp Sastry Satish Sato Satya Sau 
  Saul Savas Scott Sedef See Sekhar Selcuk Sen Sencer Serban Serdar 
  Serenella Serif Seth Severin Sevin Seyhan Shacham Shah Shahaf 
  Shaker Shalom Shan Shane Shani Shannon Shaolin Shaomin Sharif 
  Sharon Shaya Sheik Shekhar Sheldon Shelley Shelly Shen Sheng Sherif 
  Shi Shih Shmuel Shriram Shu Si Siew Sigmund Silva Silvio Sim Simeon 
  Simon Simone Singh Slim Solomon Solvi Sompotan Sonawala Song Soo 
  Soon Spencer Spyros Sridar Sridhar Srinivas Srinivasa Srinivasan 
  Sriram Stanley Stanton Steen Stefan Stefano Stein Stephen Stojan 
  Stuart Su Suba Subari Subramanian Sugiharto Sultan Sultana Sumaiya 
  Sun Sundaram Sung Suri Swaminathan Syarifah Syed Sylvester Sze 

  Tai Tal Tan Taner Tang Tanguy Tao Tarek Tarikul Tarp Taylan Taylor 
  Teixeira Temel Teng Teo Teresa Terry Tevfik Theodore Thibault 
  Thomas Thor Tian Tianshu Tilak Ting Tipton To Tobias Tobing Todd 
  Tohme Tola Tom Tong Toon Toprak Tor Tore Torsten Toshiko Tracey 
  Troels Tsang Tudor Tugrul Tulin Tuncer Tung Tunga Turan Turhan 
  Turker Tyler 

  Ugur Ulgen Ulvi Umair Umar Unal Uner Uras Urban Usman Uta Uz 

  Vahidy Vaidotas Vaidya Valdes Vanni Varda Vasanth Vasile 
  Venkatachari Venkatesh Venkatraman Vera Vered Vernon Vicente Vikram 
  Vila Vinay Vincent Vincenzo Vinod Viola Viorel Viswanath 
  Viswanathan Vit Vitali Vlad Volker Vural 

  Wa Wadia Wael Wahid Wahyu Wai Walle Walter Wan Wang Ward Warner 
  Warren Wayne Weimin Wen Werner Wied Wilhelm Willard Wilson Winarno 
  Wing Winston Wit Wolf Wolfe Wolter Wong Woo Woodward Wu 

  Xavier Xi Xia Xiang Xiao Xiaoping Xin Xing Xiong Xu Xuan Xue Xuehai 
  Xun 

  Ya Yahya Yalcin Yan Yang Yannan Yao Yasar Yasin Yasuko Yau Ye Yeh 
  Yehuda Yen Yener Yeung Yi Yildirim Yilmaz Yin Ying Yiu Yohanes Yong 
  Yoon You Young Youssef Yu Yuan Yue Yuen Yuksel Yulin Yun Yunief 
  Yunus Yusuf 

  Zach Zachary Zafar Zafer Zahir Zain Zakar Zaman Zara Zeljko Zen 
  Zenko Zhan Zhang Zhao Zhen Zheng Zhi Zhili Zhong Zhou Zhu Zhuo 
  Zigmond Ziv Zohar Zoli Zou Zvi Zygmunt 

  Öktem 
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
