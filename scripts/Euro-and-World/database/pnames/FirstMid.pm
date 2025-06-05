#!perl

# First names that appear between the first and last words in
# the EBL file.  It is assumed that the first and last words are
# capitalized correctly to cut down on the length of the list.

package FirstMid;

use strict;
use warnings;
use v5.10;
use Exporter 'import';

our @EXPORT = qw(@FIRST_MID_NAMES);

use utf8;

our @FIRST_MID_NAMES =
qw(
  Aaron Aas Abbas Abdel Abdimulia Abdul Abdullah Abel Abulrahman Adam 
  Adele Adie Adji Adnane Adrian Ae Agha Agnieszka Agus Ahasan Ahmad 
  Ahmed Ahmer Ake Akhtar Akten Akter Alain Alamsyah Alan Albert 
  Alberto Aleixo Alejandra Alejandro Alex Alexander Alexandra 
  Alexandre Alexandru Alfredo Ali Alp Alper Alta Altan Ameer 
  Amenhoteps Aminur Amirul Amita An Anand Anant Anders Andre Andrea 
  Andreas Andreea Andrei Andres Andrias Andrzej Anfinn Angel Angela 
  Angelica Angelo Angelova Anikovich Anil Anis Anisul Anita Anker Ann 
  Anne Annette Anthonius Anthony Anton Antonia Antonieta Antonio 
  Anwen Ara Ardiansyah Are Ariel Aril Arild Arman Arne Arni Aron 
  Arslan Arthur Arturo Arve Arvind Arya Arzum Asbjorn Asfandiyar 
  Asghar Asifur Aslam Aslihan Assis Atle Audiary Aulia Aulid Avsar 
  Awuy Ayeska Aysen Ayu Ayyampalayam Azat Azizul 

  Babu Bae Bagus Baliram Bambang Barbosa Barki Barkin Baron Bas 
  Basuki Battista Beate Beatrice Belle Benedict Beniamino Berka 
  Berkay Berkim Bernardo Bertram Besour Bey Bhan Bharadhan Bibiana 
  Bindi Birgitte Birol Bjoerk Bjoernar Bjorn Bogdan Borgar Borissova 
  Brarne Breves Brian Brita Britt Bruce Bruna Bruno Buke Bye 

  Cagan Cagdas Cai Can Candelaria Carla Carlo Carlos Carmen Carol 
  Carolina Cata Catalin Cato Cecilia Celal Celia Celina Cem Cemal 
  Ceren Cesare Chaerani Chairudin Chakravarthy Chand Chander Chandra 
  Chang Charles Charlie Charlline Charlotte Charya Chen Cheng Cheong 
  Cheung Chhotelal Chi Chieng Chih Ching Chiu Choi Choo Chou Choudary 
  Choukri Chow Chris Christa Christer Christian Christina Christine 
  Christopher Chuan Chul Chun Chung Cici Cing Claude Claudiu Coomer 
  Cosmo Costanza Craig Cristian Cristina Cristy Cruz Cyprian 

  Dan Dana Daniel Daniela Dario Darma David Del Delfina Deng Denis 
  Deniz Desi Dev Devchand Devi Devshi Dey Dharma Dhishan Di Diana 
  Dicle Didem Didier Dimitar Dirk Doga Dolores Domenico Don Donas 
  Dora Douglas Dumitru 

  Ebrahim Edmund Edoardo Eduardo Edward Efe Egemen Egil Eidur Einar 
  Eirik Eivind Eka Elena Elia Elida Eline Elisa Elise Elizabeth 
  Elvansyah Elvin Elvira Emil Emilie Emin Emine Emir Emmanuel Emre En 
  Endras Endre Enoch Enok Enrica Enrique Enver Ercolian Erdem Erik 
  Eriks Erling Erol Ersan Esra Esther Ethem Eufke Eugenia Eugenio 
  Ezequiel Ezz 

  Fa Fai Falah Falk Fang Fanly Faroque Faruk Fawzy Fay Federico Fei 
  Felicia Felipe Felix Feng Fernando Ferruh Fethi Fikret Filippo 
  Flora Florencia Fold Fong Francesco Francis Francisco Francois 
  Francoise Franke Franz Fraser Frederic Frederik Fredrik Freyr 
  Frimaco Frode Fu Fuad Funda Furkan Fusun 

  Gabizo Gabriel Gabriela Gabryjela Gail Gama Gamze Gan Gangadhara 
  Gautama Gaute Gautur Ge Georg Georges Gerard Ghaffar Ghalib 
  Gheorghe Ghias Ghulam Gigello Giovanna Giovanni Gisella Gisli 
  Giulio Giuseppe Glen Gokhan Gopal Gopalakrishna Gorkem Grace Gracio 
  Grazia Graziela Gro Gu Guadalupe Guang Gudlaug Gui Guimar Guirguis 
  Gul Guldamla Gulen Gundega Guney Gunnar Guo Gurcan Gursel Gurunath 
  Gustaaf 

  Haakon Habibul Hacer Hae Haerul Hai Hakan Hakim Hakki Halidun 
  Hallvard Haluk Hameed Hamit Han Hang Hao Harald Harianto Hariram 
  Harris Hasan Hassan Haugan Haugen Hayk Hazel Hazem He Hean Hee 
  Hefny Hein Helen Helena Helene Helgard Helge Helvijs Hendrik Heng 
  Henrik Henry Hermon Hersir Hieu Him Hin Hjalmar Ho Hock Hoi Holmar 
  Hong Hongxuan Hoong Hossain Hove Howard Hronn Hsien Hsin Hsuan Hua 
  Huai Hugo Hui Hun Hung Huseyin Hussain Hussein Hyder Hyoung 

  Ian Ibrahim Idland Ignacio Ijaz Ik Ilan Ilari Ildeniz Imran Indah 
  Indra Inge Inger Ingi Ingvald Ionis Ioulios Iqbal Irene Iriantha 
  Irvin Isabel Isin Iskandar Iskander Islam Isyana Ivan Ivar Ivonne 
  Izzet 

  Ja Jack Jacob Jacques Jade Jake Jakob Jakup James Jan Jane Janneth 
  Jason Javier Jean Jeffry Jen Jeng Jeremiah Jerry Jia Jian Jiang Jie 
  Jimmy Jin Jing Joan Joana Joao Joaquin Joergen Joffani Johan 
  Johannes John Jona Jonny Joo Jorge Jorgen Jose Joseph Juan Jubilate 
  Judith Juhan Jun Jung Justus 

  Kaare Kahraman Kaligis Kamal Kang Kant Kanti Kapulu Kare Kareem 
  Karim Karin Karl Karna Kashinath Kate Kaur Kay Kayzen Kei Kelly 
  Kemal Kenneth Kenyon Kenzo Kerem Keshav Keung Khan Khanh Khimji 
  Khurrum Ki Kieren Kimar Kin King Kinman Kirankumar Kirti Kishore 
  Kit Kjellaug Kong Konstantinos Korkut Krishna Krishnan Kristen 
  Kristian Kristine Kristjan Kubilay Kui Kumari Kun Kurnia Kursad 
  Kwong Kyoung Kyung 

  Lai Lal Lan Lao Lata Lau Laurentiu Lavinia Lazarus Lee Lei Lena 
  Lene Leon Leonardo Leonel Leslie Lia Liang Lija Lilian Lily Lin 
  Lionel Lisa Lise Liz Lliker Lok Long Lorand Lou Louis Louisa Louise 
  Lu Lucasz Lucette Lucia Lucian Luie Luigi Luis Luisa Luiza Lujon 
  Lun Lung Luz Lygre Lynn 

  Machado Maciej Madeira Mae Magnus Mahbubul Mahmood Malcom Man Manaf 
  Manasseh Mangapul Mani Manuel Mao Mar Marc Marcelin Marcelo Marek 
  Margaret Margarita Margrethe Mari Maria Marian Mariano Marie Marina 
  Marinh Marino Mario Marit Marius Mark Marques Marta Martin Martins 
  Massimo Matias Maula Mauricio May Mayo Md Mecbure Medina Mehedi Mei 
  Melih Melissa Meng Merete Meta Mette Micael Michael Michailov 
  Michel Miguel Mihaela Mihai Mihail Mihaylova Mijanul Mikael Min 
  Ming Mirabelle Miranda Mirna Mirta Mitra Mo Moazzem Mobinul Moen 
  Mohamed Mohammad Mohan Mohon Mohsen Moin Monica Monirul Mora Moran 
  Morten Moshiur Mou Mounir Mozez Muammer Mubashir Muhamm Muhammad 
  Muhsin Mui Mumtaz Murat Murthy Mushtaq Mustafa Muthu Muzharul 

  Nabi Naci Nafiz Naidu Najee Nam Namineni Nan Narayan Narayana 
  Narayanan Nasir Nath Naz Nazan Nazar Nazif Nazli Nazmul Nedim Neil 
  Ngin Nian Nicholas Nick Nicoletta Nicolle Nigar Nihat Nika Niklas 
  Nina Ning Nishino No Nobre Noeline Noelle Noervita Npeng Nualsri 
  Nur Nurdan Nurhan 

  Oaitse Octavian Odile Odin Oi Oktem Olafs Olai Oland Olav Olcay Ole 
  Olha Olivier Olof Omar Omer Onder Ong Onggani Onur Orhan Orn Oruc 
  Osman Osnes Otto Ove Ovidiu Owen Ozer Ozgur Ozkan 

  Pablo Pada Pall Palmelia Pan Paola Parakrama Parningotan Patrick 
  Paul Paula Paulo Pawel Ped Pedro Pelin Peng Pennaf Percival Perry 
  Perwez Peter Pethraj Petronia Petter Peu Pheng Philip Philippe Pia 
  Pierre Pin Ping Pino Plinio Pok Pong Ponniah Prabakar Prakash 
  Prasad Premsagar Pretty Priscilla Purushottam Putri Putu 

  Qamar Qasim Qi Qian Qiang Qing Quirino 

  Rabie Rachel Rafael Ragnar Rahman Raiko Ram Rama Ramadan Raman 
  Ramana Ramanathan Ramon Ramzi Ran Rangan Ranjan Ransani Rao 
  Raphaela Rashebul Rashedul Rashid Rashmikant Rasiklal Raveen Ray 
  Razzak Recep Reddi Reese Rehman Remzi Rengasamy Resit Reynir Reza 
  Ri Rianto Riaz Rica Ricardo Ricky Ricquier Rifat Rimnong Ristu 
  Riswan Rita Roar Roberto Rock Rodolfo Roger Rom Roman Romano Ronald 
  Ronaldo Rong Rosa Rosanna Rosaria Rosario Roxana Roy Ru Ruhi Rui 
  Ruiz Runar Ruth Ruzgar Ryan Ryk Ryung 

  Saad Saadat Sabine Saeed Safak Safari Sai Said Sajid Sakharam 
  Saktia Sales Salih Salman Samuel Samy San Sangwon Santoso Sarathi 
  Sartika Sartje Sastry Sattar Sau Saverio Saz Sebastian Seda See 
  Sekhar Selim Sencer Sener Seng Seniha Senol Septimiu Serap Sergio 
  Sergiu Serhat Serif Setyo Sevgi Seyhan Shahbana Shaihan Shaker 
  Shakil Shamin Shan Shankar Shanker Shantilal Shauq Shen Sheng 
  Sherif Shi Shing Shirazi Shiu Shohdy Si Sigurd Sila Silvio Sim Sima 
  Simoes Simona Sing Singh Siok Siri Sirin Sivert Skarhol Smari 
  Sobhagchand Soerlie Sofia Sofie Somchand Sonya Soon Sophia Sophie 
  Sorin Spike Sreedharan Sreekanth Sridar Srinivasa Stephen Steven 
  Stirling Sture Su Suba Subari Subbarao Subramanian Suci Sue Suheda 
  Sujauddin Sule Suleiman Sultana Sum Sunra Sup Supeno Surendra Surya 
  Suryakant Susana Svarup Swaray Syed 

  Ta Tang Tao Tarikul Tat Taymour Teck Teiji Teixeira Teng Terence 
  Teresa Terje Theo Theodore Theoman Thiruvenkata Thomas Thora Tie 
  Tilak Tin Tinas Ting Titus Toar Tobing Tolga Tomas Tong Tor Tora 
  Tore Torgeir Torio Tove Tri Trine Triumf Tshepo Tua Tugce Tugrul 
  Tumo Tunc Tuncay Tung Tungga Tybring Tyr 

  Uffe Ufuk Ugur Ulrik Ulvi Umair Umit Ursin Usman Utku Uttamchand Uz 

  Vala Valentin Valerie Vaman Vegard Venkata Venkatraman Venugopal 
  Verona Veronica Vicenzo Victor Victoria Vidar Vijayanand Vince 
  Vincent Virgil Virginia Vishwanath Vitor Vittoria Vittorio Vogg 
  Vrat Vural 

  Wa Wahyu Wai Walter Wardhani Watrap Wen Werner Wilhelmina Willem 
  William Willy Wilson Winarno Wisolus Wojciech Wook 

  Xavier Xi Xian Xiang Xin Xing Xinying Xiong Xu Xuan 

  Yan Yang Yao Yasin Yau Yb Ye Yee Yehia Yen Yeung Yi Yigit Yin Ying 
  Yoland Yong Young Yp Yu Yuan Yue Yuen Yun Yung Yunief Yusuf Yves 
  Yvonne 

  Zafar Zafer Zahid Zahir Zahra Zaman Zaverchand Zeki Zen Zeynep 
  Zhang Zhazha Zhen Zhi Zhong Zhou Zhu Ziaullah Zoe Zorana Zou Zsolt 
);

1;
