#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::FirstComb;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hashes);

my @MULTI_WORDS =
(
);

my %MULTI_TYPOS =
(
);

my @SINGLE_WORDS = qw(
  Aadil Aage Aake Aamer Aamir Aapo Aarne Aarnout Aaron Aart Aase 
  Aasmund Aavo Aayilyan Ab Abbelaziz Abbes Abbey Abby Abd Abdel 
  Abdelhamid Abdeljelil Abdelkamal Abdellah Abdellatif Abdelrahim 
  Abdelrahman Abderrahim Abderrahman Abdimulia Abdo Abdool Abdul 
  Abdulaziz Abdulbaki Abdulkadir Abdurrahman Abdurrizak Abeer Abhay 
  Abhaya Abhijit Abhinav Abhirup Abhisek Abhishek Abida Abidin 
  Abigail Abin Abir Abulrahman Acacio Achille Achintya Achyan Ad Ada 
  Adalberto Adalgisa Adalsteinn Adamantia Adana Adang Addie 
  Addolorata Ade Adela Adele Adelheid Adelin Adeline Adelle Adelstano 
  Adem Aden Adha Adhikram Adhiyaman Adi Adie Adil Adina Adinarayana 
  Adish Adisorn Aditi Aditya Adji Adnane Adolf Adolfo Adri Adriaan 
  Adrian Adriana Adrianna Adrianne Adriano Adrians Adriansyah Adrie 
  Adrien Adrienne Ady Ae Aegir Aenne Aenul Aernout Afifah Afife 
  Afonso Africa Afshar Agah Agamemnon Agape Agata Agatha Agathe 
  Agatino Agenor Aggeliki Aggelos Aggie Aghita Agnar Agne Agnes 
  Agnese Agneta Agnethe Agnieszka Agniswar Agniv Agnus Agota Agris 
  Agron Agu Agusta Agustin Agustina Ah Ahadin Aharon Ahava Ahindra 
  Ahmer Ahouva Ahron Ahsan Ahto Ahu Ahuva Ai-Tai Aia Aicha Aida Aidan 
  Aideen Aiden Aidoru Aigars Aiguo Aijia Aileen Aima Aiman Aimee 
  Aimery Aimilianos Ain Aina Ainaya Aine Ainy Aioulia Aiping Aire 
  Aisling Aivar Aivo Aiyue Aj Ajay Ajit Ajitkumar Ajoy Akaki Akash 
  Akeil Akhilesh Akhteruzzaman Aki Akif Akihiko Akiko Akill Akinom 
  Akinori Akio Akira Akito Akiva Akman Akoit Akos Akram Aksan Aksel 
  Akten Al Ala Alaaddin Alaattin Alaeddin Alagappan Alain Alaittin 
  Alamiro Alamsyah Alana Aland Alastair Alauddin Alba Albane Albena 
  Albena-Maria Alberta Albertas Albertica Albertina Alberto Albrecht 
  Alcio Alda Aldo Aldona Ale Alec Aled Aleen Alef Aleh Aleixo 
  Alejandra Alek Aleka Alekos Aleks Aleksa Aleksandar Aleksander 
  Aleksandr Aleksandra Aleksandrs Aleksei Aleksi Aleksis Aleksy Alen 
  Alena Alene Ales Alesandar Alesandra Alesandro Alessandra Alessia 
  Alessio Aleth Alevtina Alex Alexan Alexandar Alexandra 
  Alexandra-Ioana Alexandros Alexandru Alexei Alexej Alexey Alexi 
  Alexio Alexios Alf Alf-Ole Alfa Alfhild Alfian Alfons Alfonso 
  Alfonz Alfred Alfred-Cristian Alfredo Alfreds Alia Aliaksandr 
  Aliaksei Alice Alicia Alicja Alida Aliette Aliff Alim Alin Alina 
  Aline Alipio Alisa Alischa Alisdair Alisha Alison Alissa Alistair 
  Alister Alix Aliye Aliza Alja Aljosa Alka Allie Alltil Ally Allyson 
  Alma Almar Almudena Alojz Alok Aloke Alon Alona Alpay Alphan 
  Alphonse Alphonsine Alpo Alta Altankhuyag Alton Altug Alun Alvar 
  Alvaro Alverna Alvils Alvin Alvine Alvise Alvur Alvydas Alyette 
  Alzuri Amaan Amadeo Amai Amalia Amalie Amalya Amamchrla Amanda 
  Amara Amaranta Amaresh Amariusz Amarjit Amato Amatore Amaury Amber 
  Ambra Ambrish Ameer Ameeta Amelia Amelie Amelka Amenhoteps Ami 
  Amila Amilcar Amilcare Amina Aminur Amira Amiram Amiran Amiruddin 
  Amirul Amita Amitabha Amitava Amiya Amjad Ammara Amnon Amod 
  Amornpong Amparo Amr Amran Amro Amy Amyn An An-Chi Anabela Anahit 
  Anais Analia Anam Anamaria Anamarija Anan Anang Anant Ananta Ananth 
  Anantvikram Ananzi Anas Anastasia Anastasia-Ioanna Anastasiia 
  Anastassia Anatol Anatoli Anatolv Anatoly Anaz Anbazhagan Anber 
  Anca Ance Ancho Anda Andam Andelko Andi Andika Andis Ando Andor 
  Andreas Andreea Andreea-Magdalena Andreia Andreina Andrej Andrejs 
  Andreu Andrey Andrez Andriano Andrias Andrii Andrija Andris Andrius 
  Andronicos Andrse Andrsej Andrzei Andrzej André Andrée Andy Ane 
  Aneta Aneurin Anfinn Angela Angelica Angelika Angeliki 
  Angelina Angeline Angelo Angie Angioletta Angiolisa Anhar Ani Ania 
  Anibal Anick Aniela Anika Aniket Aniko Anila Animesh Anina Anindara 
  Anindra Anirban Aniruddha Anirudh Anis Anish Anisha Anisia Anisul 
  Anisur Anit Anita Anitha Anja Anjali Anjan Anju Anka Anke Anker 
  Anki Ankit Ankur Ankush Ann Ann-Britt Ann-Charlotte Ann-christin 
  Ann-Elin Ann-Elisabeth Ann-karin Ann-Katrin Ann-Mari Ann-Marie 
  Ann-Sophie Anna Anna-Britta Anna-Lena Anna-Lisa Anna-Maria 
  Anna-Marie Annabelle Annachiara Annaig Annalena Annalisa Annamalai 
  Annamaria Annamiek Annan Annarita Anne Anne-Britt Anne-Frederique 
  Anne-Laure Anne-Lies Anne-Lill Anne-Lise Anne-Margret Anne-Marie 
  Anne-Mette Anne-Sofie Anneke Annelie Annelies Anneliese Annelise 
  Anneloes Annemarie Annemie Annemiek Annet Annethe Annette Anni 
  Annibale Annica Annick Annie Annigret Annik Annika Annike Anniken 
  Annikki Anning Annita Annki Annlies Annmarie Annouck Annunziata 
  Anny Anonyo Anoop Anouk Anrui Ans Ansel Anselmo Ansgar Anshu Anshul 
  Anssi Antal Antalya Ante Anthea Anthonius Anthony Antina Antje Anto 
  Antoanetta Antoine Antoinetta Antoinette Antoinina Antoncarlo 
  Antone Antonella Antonello Antonia Antonie Antonieta Antonietta 
  Antonina Antonino Antonis Antony Antra Ants Antti Anu Anubhab Anuj 
  Anukul Anup Anupam Anurag Anushalakshmi Anushree Anutida Anvar 
  Anwaid Anwar Anwen Any Anya Anyelik Aoibheann Aoife Apana Aparna 
  Apin Apisai Apisak Apolinary Apolonia Appaji April Apryanta Apurba 
  Aquiles Ara Arad Araf Aram Aramesh Arant Aravind Arbha Archana 
  Archie Archil Archisman Archit Arda Ardiansyah Ardianto Ardic Ardy 
  Are Arek Arendina Argenta Arghadip Arghadweep Arghya Argun Argyro 
  Aria Arialds Arian Ariane Ariani Arianna Arief Ariel Ariela Arielle 
  Arijana Arijit Arik Aril Arild Arindam Aris Aristea Aristeidis 
  Aristide Aritra Ariz Arjen Arjun Arjuna Arka Arkadiusz Arkadiy 
  Arkaprabha Arkie Arleen Arlene Arlette Arline Armagan Armand 
  Armande Armando Armans Armelle Armen Armi Armin Armine Armnona 
  Armony Arnab Arnaldo Arnar Arnauld Arnaut Arnbjorn Arne Arne-Aivo 
  Arnfinn Arngunnur Arni Arnie Arnis Arnleyg Arno Arnoldo Arnoud 
  Arnstein Arnt Arpad Arpan Arpana Arpine Arran Arrigo Arsenio Arseny 
  Art Artan Artem Artemil Artis Arto Arttu Artur Arturas Arturo 
  Arturs Arun Aruna Arunabha Arunas Arunkumar Arup Arvat Arve Arvid 
  Arvin Arvind Arvo Arya Aryan Arye Arzaz Arzie Arzu Arzum Asa Asad 
  Asawanee Asbjoern Asbjorn Asbjrrn Asdang Ase Aseem Asem Asena Asep 
  Asfandiyar Asgeir Asger Asghar Asgrimur Asha Ashantha Asher Ashfaq 
  Ashim Ashish Ashit Ashok Ashot Ashutosh Ashvin Ashwani Ashwin Asia 
  Asif Asifur Asil Asim Asitabha Asitranjan Asle Asli Aslihan 
  Asmundur Asok Asoka Asoke Aspen Asqeri Asraful Asrar Asrinjoy 
  Assaad Assad Assem Asser Assunta Asta Astra Astri Astrid Asuka 
  Asuman Asuncion Asya Atahualpa Atam Ataman Atanas Atanu Ataov Atara 
  Ataturk AtatÜrk Ataur Atef Atephen Athanase Athanasia Athanasios 
  Athanassios Athena Athina Atie Atif Atiqa Atis Atle Atli Atsushi 
  Attie Attila Attilio Attiya Atul Aty Aubrey Aud Aude Audhild 
  Audiary Audrey Audun Audy Aue Augusto Aujon Auke Aukje Aulia Aulid 
  Aulus Aura Auramani Auraya Aurea Aurel Aurele Aurelia Aureliano 
  Aurelie Aurora Ava Avi Avigdor Avijit Avik Avilash Avinash 
  Avirup Avishek Aviv Aviva Avner Avraham Avram Avrick Avsar Aweel 
  Awuy Axel Aya Ayako Ayala Ayan Ayananshu Ayberg Ayca Aycha Ayd 
  Ayelet Ayeska Ayfer Aygün Ayla Aylin Aylwin Aymar Aymen Aymeric 
  Ayper Ayperi Ays Ayse Aysegul Aysel Aysen Aysun Aytac Aytug 
  Ayyachamy Ayyampalayam Ayyavoo Azad Azafers Azaleea Azat Azem 
  Azevedo Azhar Azize Azizul Azu Azuolas Azwerul Azza 

  Baard Babhrubahan Babs Babur Bachar Bachiraju Badal Badri Bae Baha 
  Baharuddin Bahattin Baher Bahjat Baisong Balakrishna Balaraman 
  Baliram Baljit Balk Balkaran Balkrishn Balkrishna Baltasar Balu 
  Bambang Bana Banashree Bandi Bando Bane Baneet Banghong Bangxiang 
  Bani Banjer Banu Baohua Baozhuo Bapsie Baptiste Barack Barbara 
  Barbora Barbro Barend Barkan Barki Barkin Barnabas Barney Barri 
  Bartek Barthelemy Bartlomiej Bartold Bartolome Bartolomiej Bartosz 
  Bartu Baruh Basant Basia Basil Basilis Bassem Bastiaan Bastian 
  Basudeb Basuki Batia Batie Batsho Battulga Battur Batuhan Baturalp 
  Baudouin Bauke Bayan Bayhan Be Bea Beat Beata Beate Beatrice 
  Beatrise Beatrix Beatriz Becca Bechir Becky Beda Bedia Bedii 
  Bedrettin Bee Beelu Beerti Beggi Bego Begona Behsat Beilin Bekir 
  Bela Belen Belinda Belis Belisa Belle Belly Belma Bence Bendt 
  Benedetta Benedicte Benedikt Bengt Bengt-Erik Beniamin Beniamino 
  Benito Benjie Benjun Benni Bennur Benny Bent Bent-Goran Bente Bento 
  Beny Bep Beppe Beppino Berangere Berardino Bercu Beren Berenika 
  Bergvin Berit Berka Berkan Berkay Berkim Berkut Bernace Bernadett 
  Bernadette Bernando Bernardette Bernardino Bernardo Bernd Berndt 
  Berne Berni Bernice Bernie Bernodus Bernt Bernt-Ake Bernt-Ivar 
  Beroze Berra Berrak Berri Berrin Bert Berta Bertel Bertha Bertie 
  Bertil Bertus Beryl Besir Besour Bess Beta Beth Bethany Bets Betsey 
  Betsy Betta Bette Bettie Bettina Betty Betul Beuce Bev Beverley 
  Beverly Bey Bhabatosh Bhabesh Bhagat Bhalchandra Bhan Bhanumati 
  Bharadhan Bharat Bharati Bhaskar Bhaskara Bhaskararao Bhoga 
  Bholanath Bhubanjit Bhuuaneswari Biagio Bianca Biancastella Biao 
  Biba Bibbi Bibi Bibiana Bibor Bicio Bidesh Biharilall Bijal Biji 
  Bijit Bijon Bikash Biki Bikram Bilgehan Bilha Bili Biljana Bill 
  Billie Billmar Billur Billy Bilquis Bim Bimal Biman Bimla Bin 
  Binbin Bindiya Binsar Binxiang Bipinchandra Birat Bircan Birdal 
  Birdie Biren Birger Birgit Birgitta Birgitte Birkan Birkir Birmal 
  Birna Birte Birthe Biruta Biserka Bishwajit Bistra Biswajit Biteng 
  Bizhi Bjargey Bjarke Bjarn Bjarne Bjarni Bjoerg Bjoerk Bjoernar 
  Bjorg Bjorgvin Bjorn-Harald Bjornar Bjrrn Bjrrnar Björn Bjørke 
  Bjørn Bjørnar Bladimor Blagi Blaine Blanca Blanche Blandine Blanka 
  Blara Blasius Blathnaid Blazej Blondu Bo-Henry Bo-Lennart Bo-Yin 
  Boatametse Boaz Boban Bobbe Bobbi Bobbie Bobbye Bobi Bobo Boby 
  Bocho Bodhayan Bodil Bodo Bodvar Bodzio Boelie Boerje Boerre Bofeng 
  Bogac Bogdan Bogdan-Iljuta Bogi Boguslav Boguslaw Bohdan Bohumil 
  Bohumir Bohuslav Boian Boiko Bojan Bojana Boje Bojidar Bojing Bok 
  Boleslaw Bolin Bolo Bomsi Bond Bong Bonni Bonnie Boo Boonchai 
  Boonita Boonserm Boran Borce Borgar Borge Boriana Boril Boris 
  Borislav Borissova Borje Borna Borui Borut Borys Boslo Bosse Boting 
  Botond Boutaud Boutch Boxin Boyan Boyuan Bozena Bracha Brad Bragi 
  Brahmajyoti Brak Bram Branca Branimir Branislav Branka Branko 
  Brarne Breda Bregtje Brenda Brendan Brendon Brent Breves Brian 
  Brianna Brid Bridget Bridie Brieuc Brig-Gen Brigid Brigita Brigitt 
  Brigitta Brigitte Briony Brit Brit-Helen Brita Britt Britt-Anne 
  Britt-Inger Britt-Mari Britt-Marie Britta Broma Brona Bronagh 
  Bronia Bronislav Bronius Bronwen Bror Brune Brunello Brunon Bruria 
  Bryndis Brynjar Bryony Buby Buddy Budi Bujor Buke Bulent Bunny 
  Bunyawee Burak Burcak Burcan Burcu Burhan Burhanettin Burhaniye 
  Burkhard Burrell Bursa Busra Butch Buwen Buyung Bydgoszcz Bye Byju 
  Byron Börje Bülent Büsra 

  Cadir Cagan Cagatay Cagdas Cagla Caglar Cagri Cahit Cait Caitlin 
  Cakircali Caleb Calin Calla Callin Callum Calvert Calvin Cam 
  Camelia Camila Camilla Camille Camillo Camion Canan Candace Candas 
  Candela Candelaria Candeloro Candice Candy Canip Cansel Cantürk 
  Canyun Capulcu Cara Careen Caren Carena Carie Carin Carina Carine 
  Carl Carl-Otto Carla Carlene Carleton Carli Carlo Carlota Carlotta 
  Carlye Carlyn Carmel Carmela Carmelina Carmella Carmelo Carmen 
  Carmencita Carminia Carol Carol-Ann Carola Carole Carolee Carolien 
  Carolina Caroline Carolyn Carrie Carsten Caryll Caryn Cas Casmir 
  Cass Castor Cat Catalin Catalin-Lucian Catalina Catarina 
  Cate Caterina Cath Catharina Catharine Catheline Catherine Cathrine 
  Cathryn Cathy Catja Cato Catrin Caty Cavit Cayce Ceara Cebrail Cece 
  Cecil Cecile Cecilia Cecilie Cecille Cecily Ceco Cedric Cees 
  Ceferino Cela Celal Celestino Celia Celile Celina Celine Celsa 
  Celso Cem Cemal Cemil Cemo Cenan Cenek Ceni Cenk Cera Cerag Ceren 
  Ceri Cesar Cettina Cetty Cevat Cevdet Ceyda Ceyhun Cezar Cezary Ch 
  Chad Chaerani Chafika Chahed Chahir Chaim Chairoj Chairudin Chaitad 
  Chak Chakib Chakravarthi Chakravarthy Chalermpol Chamnong Chana 
  Chanchal Chand Chandan Chander Chandkaran Chandrakant Chandramohan 
  Chandran Chandrasekaran Chandrashekhar Chandrashenkar Chandreshwar 
  Chang-Dar Chang-Kae Changcheng Changhe Changu Changyu Changzhan 
  Chania Chantal Chao-Chun Chaochuan Chaohao Charlene Charley Charlie 
  Charliene Charlline Charlotte Charlton Charly Charmaine Charna 
  Charnchai Charo Charya Chas Chau Chavali Chayes Che-Hsing Che-Hung 
  Che-Min Chee Chelo Chen-Chang Chen-Chin Chen-Han Chen-Syuan 
  Chenesani Cheng-Chieh Cheng-Jui Cheng-Kuo Chengke Chengpin Chengqi 
  Chengquan Chengtang Chengxi Chengyen Chengzhong Chenhui Chentian 
  Chentong Chenyu Chenyun Cheri Cherish Cherrie Cherry Cheryl Chetan 
  Cheuk Cheuk-Hin Chhaya Chhotelal Chi-Cheung Chi-Hsuan Chi-Rong 
  Chi-Wei Chia Chia-Fan Chia-Feng Chia-Ling Chia-Sheng Chia-Shin 
  Chia-Yu Chiachi Chianglin Chiaramaria Chicco Chick Chiedere Chiedi 
  Chiedila Chieh-Hsing Chieko Chien-Chen Chien-Hsuan Chien-Hsun 
  Chien-I Chien-Te Chien-Ya Chien-Yao Chieng Chih Chih-Chung 
  Chih-Hong Chih-Hung Chih-Kuo Chih-Ling Chih-Tsung Chih-Wei Chii-Mou 
  Chilton Chin-Hsien Chin-Yu Ching-Chiang Ching-Chun Ching-Hsiang 
  Ching-Hung Ching-Shan Ching-Wen Ching-Yu Ching-Yueh Chinnathee Chip 
  Chiradeep Chirawut Chittaranjan Chiu-Hsia Chiung-Yueh Chiwanon 
  Chiyo Chiyoko Chiyu Chloe Cholai Chongchana Choon Choonhee Chord 
  Choudary Chresten Chris Chriselle Chrissi Christa Christal Christel 
  Christer Christiaan Christiana Christiane Christianne Christiano 
  Christin Christina Christine Christo Christodoulos Christoffer 
  Christoforos Christoph Christophe Christopher Christos Christy 
  Chrysoula Chu-Di Chu-Tang Chuan Chuan-Cheng Chuanbing Chuancheng 
  Chuanming Chuanpit Chuanru Chuanxin Chuanyao Chuanzhen Chuei-Min 
  Chujun Chukri Chul Chullery Chun-Fan Chun-Hui Chun-Ping Chun-Po 
  Chun-Yao Chung-Cheng Chung-Man Chung-Wen Chung-Yang Chunhua Chunhui 
  Chunilal Chunlan Chunlin Chunqing Chunru Chunshan Chunyen Chushi 
  Chutcharee Chuwen Chyah Cia Cian Cian-Han Ciana Ciao Ciara Ciaran 
  Cicci Cici Cid Cihan Cihat Ciler Cilla Cindy Cing Cinzia Ciprian 
  Cipriano Ciro Ciska Cissi Citalaksana Ck Cl Claartje Claire Clara 
  Clarence Clarene Clarice Clarisa Clas Claude Claude-Herve Claudette 
  Claudia Claudie Claudine Claudio Claudius Claus Clelia Clemence 
  Clemens Clementine Cleo Clerette Clif Cliff Climton Clive Clo 
  Clodomiro Clotilde Cloud Clover Clovis Clyde Cobia Coby Coco Codrin 
  Coen Colby Colette Comey Con Conceicao Concepcion Concetta Concha 
  Conchita Congcong Connee Connie Connor Conny Conor Constance 
  Constant Constantine Constanza Consuelo Conxita Cookie Coomer Cor 
  Cora Coral Coralie Corbin Cord Corentin Corey Cori Corina Corinne 
  Coriolan Cormac Corneille Cornel Cornelia Corneliu Coroliano Corrie 
  Cosetta Cosette Cosmin Cosmo Costache Costantino Costanza Costas Cr 
  Craquotte Cris Cristal Cristi Cristian Cristiana Cristiano 
  Cristinel Cristobal Cristoforo Cristy Csaba Csenge Cudi Cumali 
  Cumhur Cumhuriyet Cumi Cuneyt Curey Curly Curt Cvetanka Cy Cybèle 
  Cynthia Cyprian Cyril Cyrile Cyrus Czapczyk Czeslaw Cüneyt 

  Da Da-Yung Daad Daan Dace Dadan Dade Daehong Daffi Dafydd 
  Dag-Jorgen Dagbjort Dagfinn Dagmar Dagrun Daher Daicong Daiga 
  Dainis Dainius Daisuke Daisy Dakai Daleep Dalia Dalibor Dalila 
  Dalin Dalina Dallan Dallas Damian Damiao Damien Damir Damjan Damji 
  Damon Danail Danele Danev Danhong Danhua Dania Daniela Daniele 
  Daniella Danielle Danil Danilo Danièle Danja Danjal Danka Danko 
  Danlei Danning Danny Dano Danping Dante Danusia Danut Danuta Dany 
  Daphna Daphne Daqian Daquan Dara Darcy Dare Darek Daria Darian 
  Darien Darina Darinka Darius Dariusz Darko Darlene Darlyn Darma 
  Darrell Darren Darrian Darshan Darwin Daryl Dasha Dasong Davey 
  Davor Davut Dawei Dawet Dawid Dawn Dawood Daya Dayanand Dayanidhi 
  De Dea DeAnn Deanna Debabrata Debaditya Debanjan Debashish Debasish 
  Debayan Debbie Debby Debjit Debora Deborah Debra Deci Decio Decky 
  Declan Decon Dede Dedel Dee Deena Deepa Deepak Deepanjan 
  Deepshubhra Defeng Degsy Deha Deirdre Dejan Dejana Delfina Deli 
  Della Delores Demetri Demetrio Demian Demie Demitrius Demly 
  Demosthenis Dendra Denes Dengzhou Denice Denisa Denise Denisse 
  Deniz Denmert Dennica Denny Denys Denyse Deone Deping Derek Dermane 
  Dermot Derrick Derun Derya Desheng Desi Desiderio Desire 
  Desiree Desislava Desmond Despina Dessie Dessy Desy Det Detlef 
  Detlev Detta Dev Devchand Deven Devendra Devendranath Devera Devi 
  Devid Devidas Devrim Devshi Dewan Dewantoro Dewita Dezideriu Dhani 
  Dharma Dharmabandu Dhen Dhiraj Dhishan Dhuni Di Dial Dian Diana 
  Diane Dianna Dianne Dianying Diao Diarmuid Dibyendu Diccen Dick 
  Dicke Dicky Dicle Didem Didi Didina Dido Didrik Diego Dieke Dierdre 
  Dierk Diertrich Dieter Diethild Dietlind Difei Dilek Dilip Dilla 
  Dilly Dilyanka Dim Dimah Dimas Dimcho Dimitar Dimitra Dimitraki 
  Dimitri Dimitrie Dimitrij Dimitrije Dimitrios Dimitris Dimityr Dimo 
  Dimosthenis Dimpho Dina Dinah Dinan Dinar Dinaz Dinesh Ding-Hwa 
  Ding-Ting Dingjie Dingwei Dingyi Dingyuan Diniar Diniz Dinkar Dinko 
  Dino Dinos Diny Dion Dionissios Dionissis Dionysios Dipak Dipan 
  Dipankar Dipti Diran Diren Dirik Dirk DirkJan Disa Dita Divakar 
  Divakarendra Divaraka Dixie Diyan Djems Djordje Dmitri Dmitrii 
  Dmitrij Dmitriy Dmitry Dmytro Dobo Dobromir Dodo Doel Doga Doina 
  Dolly Dolores Dom Domenico Domingos Dominic Dominik Dominika 
  Dominique Domonkos Dona Donal Donas Donata Donatella Donghua Dongke 
  Donglin Dongping Dongqing Doni Donita Donka Donna Donnie Donny 
  Dontcho Dora Doraisamy Dorcas Dore Doreen Dorel Dori Dorian Doriana 
  Doriano Dorin Dorina Doris Dorit Dorita Dorli Dorn Doron Dorota 
  Dorothea Dorothy Dorottya Dorrit Dorte Dorthe Dorthy Doru Dosia 
  Dost Dosti Dot Dotti Dottie Dotty Doug Dougall Douwe Dov Dovah 
  Draga Drago Dragos Dragoslav Dragutin Drazen Driek Dries Drofn Dror 
  Drora Duane Duarte Dubravka Duccio Dudley Duke Dulce Dundar Dunja 
  Durgadas Durriyah Duru Dusan Dustin Dusty Duygu Duysal Dvir Dwayne 
  Dwill Dyah Dyane Dylan Dympna Dzenete 

  Eapen Earl Earle Easa Ebbe Ebru Eby Ecem Eckhard Ecol Ed Eda 
  Edahabi Edd Eddie Eddo Eddy Edel Edem Edgaras Edgars Edi Edie Edina 
  Edip Edirne Edison Edit Edita Edite Edith Edith-Louise Edme Edmund 
  Edna Edo Edoardo Eduardas Eduardo Edvard Edward Edwardo Edyta Ee 
  Eero Eeva Efe Efecan Effi Efi Efira Efrahim Efthimios Egbert Egemen 
  Egidijus Egidio Egija Egil Egill Egisto Egita Egmont Egon Egons 
  Egor Eha Ehsan Ehud Eidur Eigil Eija Eiji Eileen Eilish Einar Eirek 
  Eirik Eirikur Eirin Eirini Eishi Eisuke Eitan Eivind Eka Ekambaram 
  Ekaterina Ekaterini Ekawahju Ekin Eko Ekrem El-Salam Ela Elaine 
  Elayne Elby Elda Eldad Eleana Eleanor Eleliis Elena Eleni Eleonora 
  Eleonore Elfreda Eli Elia Eliahu Eliakim Eliana Eliane Elianna 
  Elida Elies Eliezer Elif Eligio Elin Elina Eline Elinor Elio Elios 
  Eliran Elisa Elisabet Elisabeth Elisabetta Elise Elita Eliza 
  Elizabeth Elizaveta Eljana Elke Ella Elle Ellen Ellena Ellert Elli 
  Ellie Ellin Elling Elly Elma Elmar Elna Elod Eloene Eloise Els Elsa 
  Elsbeth Elsebeth Elsje Elsya Elva Elvan Elvera Elvin Elvina Elvio 
  Elvira Elvis Elvita Ely Elymelech Elzbieta Ema Emad Eman Emanuel 
  Emanuela Emanuele Emanule Emar Emel Emeline Emer Emeric Emi Emiel 
  Emil Emile Emili Emilia Emiliana Emiliano Emilie Emilio Emils Emily 
  Emin Emine Eminella Emir Emira Emma Emmaline Emmanno Emmanuel 
  Emmanuele Emmanuelle Emmett Emmy Emory Emrah Emre Ena Encho Enda 
  Endel Ender Endras Endre Enea Enes Engbert Enid Enis Enkh-Erdene 
  Enma Enn Ennio Enno Enok Enri Enrica Enrichetta Enrico Enrique 
  Entee Entscho Enver Enwen Enza Enzo Eoin Epko Eralda Eraldo Eram 
  Eranga Erasmo Eray Erazm Ercole Ercolian Ercument Erdin Erek Ergul 
  Erhan Eri Eria Eric Erica Erick Ericos Erik Erik-Jan Erika Erikas 
  Eriks Erin Erio Erke Erki Erkki Erkmen Erkut Erla Erlend Erlendur 
  Erleta Erli Erling Erlingur Ermanno Ermelinda Erminio Erna Ernesta 
  Ernesto Ernests Ernie Ernis Ernst-Otto Eros Erotokritos Errikos 
  Errol Ersah Ersan Ersen Ertan Ertin Ertugrul Ertürk Ervin Erwan 
  Eryck Erzsebet Esa Esad Esat Esen Eser Eshan Eskil Esme Esmerian 
  Esmond Espen Esperanza Esperto Esra Esref Esteban Estefano Estela 
  Estelle Ester Estera Estere Esteve Esther Eszter Etel Etelvina 
  Ethan Ethel Ethem Eti Etiennette Etkin Etleva Etsuko Etta Etti 
  Ettore Etty Eufke Eugen Eugene Eugenia Eugenie Eugenio Eugeniusz 
  Eulalie Eun Eunice Eunsun Euriell Eurydice Eva-Liss Evaggelos Evald 
  Evan Evangelia Evangelos Evelien Evelin Eveline Evelio Evelyne Even 
  Evert Everton Evette Evgeni Evgenia Evgenii Evgenios Evgeniy 
  Evgeniya Evgeny Evgueni Evie Evita Evrim Evy Ewa Eward Eya Eyal 
  Eydun Eylem Eylül Eyyüp Ezequiel Ezgi Ezibi Ezio Ezz Ezzedine 

  Fa Faan Fabian Fabiana Fabiano Fabien Fabienne Fabiola Fabrice 
  Fabrizia Faby Facundo Fadela Fadhil Fadi Fadia Fadma Fahir Fahmida 
  Fahrettin Fahri Fai Faik Fairouz Fairy Faith Faiz Fajar Fakhreddine 
  Fakiha Fakir Falah Falak Fanfei Fang-Wen Fangchen Fangming Fangqing 
  Fania Fanly Fanny Faramarz Faraz Farid Farida Farideh Faried Farly 
  Farooque Faroque Farouq Farrukh Faruq Faten Fatih Fatiha Fatim 
  Fatma Fatos Fattouma Fausta Fausto Fauzan Fawad Fawzy Faycal 
  Faye Fayes Fayez Faysal Fayza Fazle Fearghal Fede Federica Federigo 
  Fedor Fehmi Fehmina Fei-Yeung Feijo Feilan Feiwei Felice Felicia 
  Felicien Felicija Felicitas Felicity Felipe Felix Femke Femmy 
  Fengming Fengrui Fenita Fenna Fera Ferai Feray Ferda Ferdaous Ferdi 
  Ferdy Fergus Ferhan Ferhat Ferial Feridun Ferihan Ferit Fern 
  Fernand Fernanda Fernard Fernardo Feroza Feroze Ferrante Ferruccio 
  Ferruh Ferry Ferudun Feryal Fethi Fethiye Fevzi Feyza Feyzullah 
  Fiammetta Fida Fidelia Fien Fiera Figen Fikret Fikri Fil Filaretos 
  Filipe Filippo Filippos Filiz Filomena Filretos Filyra Fin Fina 
  Finnbjorn Finnley Fiona Fionnuala Fiorella Fiorenza Fiorenzo 
  Firinde Fitri Fivo Fizza Flaminia Flavia Flavio Flavius Flemming 
  Flip Flippi Flor Flora Flore Florence Florencia Florent Florentin 
  Florian Floriana Florie Florimont Florin Florine Fo Fobio Fofo 
  Foland Fold Fon Fons Forse Fortina Fortunat Fortuny Fosen Fotini 
  Fotis Foula Framboise Fran Franc Franca Frances Francesca Francien 
  Francine Franciszek Francoise Franda Franek Franiciszek Franke 
  Frankie Franko Franky Frano Frans Fransisca Fransiscus Fransiskus 
  Frantisek Franz-Jurgen Franziska François Françoise Frauke Fred 
  Freda Fredd Freddi Freddie Frederic Frederick Frederico Frederik 
  Frederikke Frederique Frediano Fredric Fredrik Fredy Freerk Freja 
  Frenc Frenk Freyja Freyr Frida Fridjon Frieda Friedel Frimaco 
  Frimann Friso Frithjof Frits Fritzi Frode Frosso Fryderyk Frymeta 
  Fränzi Frédérique Fuad Fuat Fuensanta Fugen Fujun Fulvia Fulvio 
  Fulya Fumiharu Fuming Fumito Funda Furio Furkan Fushou Fusun Fuxia 
  Fuxiang 

  Gab Gabby Gabe Gabi Gabin Gabino Gabizo Gabon Gabri Gabriel-Marius 
  Gabriela Gabrielle Gabrio Gabryjela Gaby Gadi Gaelle Gaetan Gahis 
  Gai Gail Gaiyu Gajendra Gale Galen Galia Galileo Galina Galip Gamal 
  Gamze Gandon Ganesan Gangadhara Ganghua Gangoif Gani Gankhuyag 
  Ganna Ganni Gansukh Gaoyun Gapil Gar Gareth Garey Gargeshwari Garry 
  Garton Gaspare Gaston Gastone Gatis Gatot Gaurav Gautam Gautama 
  Gaute Gautur Gavin Gavriel Gay Gaye Gaylor Gaétan Gea Gearge Gebran 
  Gediminas Geert Geeske Geeta Geffrey Geir Geir-Olav Gejza Geke 
  Gelengul Geming Gemma Gen Genc Gencho Gene Genev Genevieve 
  Geneviève Geng-Daw Gengliang Genia Genie Gennadii Geoff Geoffrey 
  Geoffroy Geoge Geon Georg Georget Georgette Georgi Georgia 
  Georgiana Georgie Georgii Georgina Georgios Georgios-Angelos Georgy 
  Geraint Gerald Geraldas Geraldine Gerasimos Gerben Gerbrand Gerd 
  Gerda Gerdje Gergana Gergely Gerhard Gerhart Gerhilt Geri Gerlinde 
  Germana Germano Germen Gernot Gerrie Gerrit Gerrit-Jan Gerry 
  Gerryanne Gert Gert-Jan Gerti Gertjan Gertrud Gertrude Gerty 
  Gesualdo Geta Geula Gevorg Geza Gezim Ghada Ghaffar Ghaith Ghaleb 
  Ghandi Ghassan Ghiath Ghislaine Ghita Ghulam Giacinto Giacomo 
  Giambattista Giampao Giampi Giampiero Gian Gianandrea Gianantonio 
  Gianarrigo Giancarlo Gianfranco Gianluca Gianluigi Gianmarco 
  Gianmatteo Gianna 
  Gianni Giannis Gianpaolo Gideon Gidi Giedre Giedrius Gigello Gigi 
  Gijsbert Gila Gilad Gilberto Gildana Gili Gilla Gilles Gillian 
  Gilly Gilmar Gilpin Gimgim Gin Gina Ginette Ginevra Ginger Ginny 
  Gino Ginta Gintaras Gintare Gintas Gints Gio Gioacchino Gioia Gioni 
  Giora Giorgetto Giorgi Giorgia Giorgio Giorgos Giovan 
  Giovanbattista Giovanella Giradhar Girard Girdharlal Giri Girish 
  Girts Gisa Gisela Gisele Gisella Giselle Gisli Gita Gitan Githa 
  Gitta Gitte Giuditta Giulia Giuliana Giulio Giuseppe Giuseppina 
  Giusi Giustino Giusy Givi Gizem Gjermund Gladys Glauco Gleb Glen 
  Glenda Glenis Glenn Glenna Glo Glod Gloria Glorie Glyn Glynis 
  Gobinda Gocha Goeran Gofaone Gogi Gogos Gojko Gokay Gokhan 
  Gokulasvar Golla Gombo Goncalo Gonenc Gongjun Gongqi Gonneke 
  Gonzalo Gopalakrishna Gopalkrishna Gopinath Goral Goran Gorana 
  Gorazd Gord Gordan Gordana Gorkem Gosia Gourab Gouverneur Govardhan 
  Govert Govind Gowri Graciela Gradus Graeme Grahame Grainne Grama 
  Grattan Graziamaria Graziela Graziella Grazyna Greet Greg Grega 
  Greger Gregers Gregg Gregoire Gregor Gregorio Gregorz Grenfell 
  Greta Gretchen Grete Grethe Gretl Grigol Grigori Grigorij Grigory 
  Grimur Grisha Gro Grong Grozdan Grozio Gry Grzegorz Grzesiek 
  Guadalupe Guang Guangbin Guangen Guangfu Guanghong Guanghua 
  Guanghui Guangjian Guangli Guangming Guangrui Guangyang Guanyu 
  Gudjon Gudlaug Gudlaugur Gudmundur Gudni Gudny Gudveig Guelfo Guena 
  Guenter Guenther Gueorguii Guergui Guglielmo Guihua Guilherme 
  Guillaume Guillermo Guilliam Guimar Guirguis Guiseppe Gulab Gulce 
  Guldamla Guldem Gulen Gulgun Guliana Gulle Gulli Gullvi Gulnur 
  Gulten Gulum Gulus Gulzar Gun Gunars Gunborg Gundega Gunder Gunna 
  Gunnar Gunnel Gunnlaug Gunnlaugur Gunthart Gunver Gunvor Guocheng 
  Guofang Guohua Guoming Guoping Guoqiang Guoquan Guorong Guoshun 
  Guowu Guoxing Guoxiong Guoxu Guoyan Gurcan Gurli Gurmit Gurprit 
  Gurpur Gurunath Gus Gusta Gustaaf Gustav Gustavo Gustavs Gusztav 
  Guttormur Guus Guy-Alain Guzide Gwen Gwendoline Gwynn Gyles Gylfi 
  Gyorgy Gytis Gyula Gérard Gökay Gökhan Göran Göro Gülden Güler 
  Gültekin Günay Gündüz Günni Gürol Gürsel Güven Güzide 

  Haakon Haavard Habibe Habibul Hacer Haci Hadasa Hadm Hady Hae 
  Haerul Haeryung Hafez Hafiz Hafizah Hagbart Hagop Haibo Haifa 
  Haifeng Haig Haihong Hailey Hailin Hailong Haiqing Haixiang Haixin 
  Haixiong Haiyan Hajar Hakan Hakob Hakon Hal Haldor Haldun Halidun 
  Halil Halima Halina Halit Halla Halldor Hallgeir Hallvard Haluk 
  Halvor Hamadi Haman Hamdi Hamed Hamide Hamish Hamit Hamza Hana 
  Hanan Hanbin Hanchang Handan Handojo Hanfei Hang Hang-Jung Hanif 
  Hanita Hanitriniana Hanjie Hanka Hanlan Hanne Hanneke Hannelore 
  Hannes Hanni Hannie Hanny Hanoi Hans-Herman Hans-Juergen Hans-Olof 
  Hans-Ove Hans-Richard Hansa Hansang Hanshun Hansje Hanspeter Hanxi 
  Hanxiao Hanyang Hanyu Hanz Hao-Wei Haochen Haohao Haojiang Haojun 
  Haolin Haomin Haoqing Haoran Haotian Haowen Haoxiao Haoxin Haoxuan 
  Harendra Harianto Harihara Hariharan Harikrishna Hariom Hariram 
  Haris Harish Hariyadi Harke Harm Harold Harpa Harri Harriet 
  Harriette Harry Harshad Hartmut Harue Haruki Harumi Harun Hasab 
  Hashim Hasinur Haskell Hasnat Hassibul Hassouna Hastings Hasyim 
  Hatice Hatsuko Hattie Haugan Hauke Haukur Hava Haven Haya Hayat Haydar 
  Haydee Hayk Haykanush Hayomo Hayri Hazar Hazell Hazem Hazur Hean 
  Heather Heber Hebin Hector Heddy Hedi Hedia Hedin Hedva Hedwig 
  Hedwige Hedy Hee-Jung Hefny Hege Hegumi Hei Heidar Heidemari 
  Heidi Heidrun Heidy Heike Heikki Heimir Heimo Heitie Heitor Helber 
  Helder Heldur Hele Helen Helena Helene Heleno Helga Helgard Helgi 
  Helina Helioui Hella Helli Helly Helma Helmar Helmer Helmi Helmut 
  Helmuth Heloisa Heloise Helvijs Hema Hemant Hemendra Hemin Hemkanti 
  Hen Henadzi Henda Hendra Hendriatta Hendrik Heniek Henk Henky Henni 
  Hennie Henning Henny Henricus Henriette Henrik Henrique Henryk 
  Herald Herb Herculano Herm Hermanni Hermine Hermon Herna Herry 
  Hershel Hersir Herstein Herta Heru Hervé Hery Hesham Hester Hetty 
  Hideki Hideko Hidenobu Hidenori Hider Hideyuki Hido Hien Hiesh Hieu 
  Hikmet Hikoe Hila Hilario Hilary Hilbert Hilda Hilde Hildegaard 
  Hildegard Hilit Hilko Hilla Hillar Hille Hilly Hilmi Him Himani 
  Himawan Hin Hin-Cheung Hinda Hing Hipolito Hiranmoy Hiroaki 
  Hirokana Hiroki Hiroko Hiroshi Hiroyuki Hisam Hisami Hisaya Hiske 
  Hitoshi Hjalmar Hjalti Hjordis Hlkan Hlvard Hlynur Ho-Chuan Ho-Yee 
  Hock Hoda Hogni Hoi-Kei Holly Holmar Homer Honey Honeylee Hong-Ren 
  Hongbin Hongbing Hongfeng Honggao Hongguang Hongji Hongjie Hongjuan 
  Hongjun Hongkai Hongkang Hongli Hongmei Hongqin Hongquan Hongshui 
  Hongwei Hongwen Hongxia Hongxiang Hongxin Hongxuan Hongyan Hongzhi 
  Honjar Honwell Honzik Hoong Hor Horacio Horatiu Horia Horst-Dieter 
  Hortense Hortensia Hosni Hougad Houria Hovhannes Hrafn Hrafnhildur 
  Hrannar Hrefna Hrelu Hrgni Hristo Hriva Hrolfur Hronn Hsi-Li 
  Hsi-Tao Hsiang Hsiang-Wen Hsiang-Yi Hsiang-Yu Hsiao-Lan Hsiao-Tien 
  Hsien Hsien-Yin Hsin Hsin-Jung Hsin-Lung Hsin-Wei Hsin-Yen 
  Hsiu-Chin Hsiu-Ping Hsuan Huagai Huai Huaiyu Huamin Huan Huan-Kwei 
  Huaqun Huda Huei Hugh Hugihalle Huguette Huib Huibert-Jan Huibo 
  Huifang Huihui Huijun Huilian Huilin Huiwen Huixia Huiyuan Huiyun 
  Hulda Hulisi Hulusi Hulya Humayun Humberto Hun Hung-Sheng Hung-Shih 
  Huopeng Hurdogan Huriye Husam Huseyin Husnu Hussam Huub Huup Huysuz 
  Hye Hymie Hyoung Hyun Hélène Hüseyin Hüseyn 

  I-Hung I-Ming Ia Iain Iakov Iakovos Ian Iasonas-Iraklis Ib Ibo 
  Ibolya Ica Icaro Icilio Ida Idan Idar Ides Idland Idman Ido Idro 
  Ifighenia Iftikhar Ig Ignacio Ignacy Igor Ihsan Ihsaner Ija Ijaz Ik 
  Ikka Ikram Ila Ilai Ilana Ilaria Ilbey Ildeniz Ildiko Ildrid Ildze 
  Ileana Ilene Ilgaz Ilham Ilia Ilian Ilias Iliga Ilir Iliya Ilkay 
  Ilker Ilkka Ilko Illy Ilmar Ilona Ilpo Ilse Ilse-Betina Ilsub Ilya 
  Ilyas Ilze Imad Imam Iman Imants Imelda Imma Imogen Imre Imtiaz Ina 
  Inaki Inas Inci Inconnu Inda Indah Inderjit Indika Indira 
  Indra Indranath Indre Indrek Ine Ineke Ines Inez Inga Ingar Inge 
  Inge-Margrethe Ingeborg Ingebrigt Ingela Ingemar Inger Ingi Ingjerd 
  Ingmar Ingmund Ingo Ingrid Ingu Ingunn Ingvald Ingvar Ingvild 
  Inmaculada Inneke Inocencio Inon Insan Ioan Ioana Ioanna 
  Ioanna-Aikaterini Ioannis Ioklon Iolanda Iole Ion Ioni Ionis Ionut 
  Ionut-Constantin Iordan Iordanis Ioseb Ioulios Ipek Ippokratis Ira 
  Irakli Irek Irem Irena Irene Ireneusz Ireta Irfan Iriantha Irimbert 
  Irina Irini Iris Irit Irita Irma Irmeli Irmgard Irne Iro Irson 
  Irsyal Irv Irvin Irving Irwan Iryna Isa Isaac Isabel Isabela 
  Isabella Isak Isha Ishan Ishmael Isidro Isik Isil Isin Isis 
  Iskander Iskenderun Islam-Rasem Ismat Ismet Ismo Isobel Issu Isyana 
  Itai Italia Italo Itamar Itay Itzhak Itzik Iulian Iuras Iva Ivailo 
  Ivan Ivana Ivanie Ivannia Ivano Ivar Ivars Ivaylo Ives Ivica Ivo 
  Ivonna Ivonne Iwan Iwo Iwona Iyn Iza Izabela Izabella Izat Izia 
  Izik Izim Izmir Izmit Iztok Izvorka Izzet Izzettin Izzio Izzy 

  Ja Jaafar Jaak Jaakko Jaan Jaanus Jaap Jac Jacco Jacek Jacint Jacki 
  Jackie Jacky Jacobo Jacomo Jacopo Jacov Jacqueline Jacqui Jacquie 
  Jacub Jad Jade Jadie Jadil Jadwig Jadwiga Jadzia Jae Jaedon Jafet 
  Jaganmohanreddy Jagannath Jagdish Jaggy Jahangir Jahirul Jai Jaia 
  Jaime Jaimes Jaishankar Jaishree Jak Jaka Jake Jakob Jakop Jakub 
  Jakup Jale Jalila Jamie Jamilla Jamilur Jan-Christer Jan-e-Alam 
  Jan-Egil Jan-Erik Jan-Hendrik Jan-Marius Jan-Olov Jan-Owe 
  Jan-Willem Janak Janardhan Janber Jancel Jane Janek Janet Janette 
  Janey Janez Jani Janice Janick Janie Janine Janis Janka Janko Janna 
  Janne Janneke Jannes Janneth Jannie Jannik Janny Janos Jantien 
  Janusz Jany Janyne Jappy Jaqueline Jarad Jarda Jared Jarek Jari 
  Jarie Jarl Jarlath Jarle Jarmila Jarmo Jarno Jaroslav Jaroslaw 
  Jasia Jasin Jasmin Jasmina Jasmine Jasminka Jason Jaspal Jasper 
  Jaturong Jau Jau-Jiunn Javaid Javier Jawan Jayabrata Jayakrishnan 
  Jayamani Jayant Jayanta Jayanth Jayashree Jaycee Jaymalhar Jayne 
  Jayshreeben Jazlene Jean-Andre Jean-Arnold Jean-Baptiste 
  Jean-Bernard Jean-Charles Jean-Christophe Jean-Claude Jean-Daniel 
  Jean-Dominique Jean-Francois Jean-Gilles Jean-Guy Jean-Jacque 
  Jean-Jacques Jean-Louis Jean-Luc Jean-Marc Jean-Marcel Jean-Marie 
  Jean-Max Jean-Michel Jean-Paul Jean-Philippe Jean-Pierre Jean-Roger 
  Jean-Yves Jeanette Jeanie Jeanine Jeanna Jeanne Jeannette Jeannie 
  Jeannine Jechiel Jed Jeevanada Jef Jeff Jeffry Jefri Jehane Jehran 
  Jeker Jelena Jelle Jelmer Jemina Jemmy Jemy Jen-Chien Jen-Lee 
  Jeneiv Jenel Jenifer Jeniffer Jenish Jenn Jenna Jenni Jennie 
  Jennifer Jenny Jenri Jens Jensine Jeovani Jepp Jeppe Jer Jerem 
  Jeremi Jeremiah Jeremiasz Jeremie Jeremy Jerene Jeri Jerko Jeroen 
  Jerom Jerome Jeroo Jerrod Jerry Jerzy Jes Jesal Jesper Jess Jessel 
  Jessica Jessie Jesson Jet Jetske Jette Jetty Jeun Jewel Jeyakumar 
  Jeyathilaka Jezzica Jhale Jia-Dong Jiacheng Jiahao Jiahe Jiaheng 
  Jiajing Jiajun Jiakang Jialin Jialu Jiaming Jian Jian-Jian Jianbing 
  Jianbo Jiancheng Jianfeng Jiangang Jiangchuan Jianghong Jiangliang 
  Jiangnan Jiangping Jiangsheng Jiangtao Jiangwen Jiangyun Jianhai 
  Jianhua Jianjun Jianke Jianlei Jianming Jianping Jianqiang Jianqiu 
  Jianquang Jianrong Jiansheng Jianwei Jianxin Jianyong Jianyu 
  Jianzheng Jianzhong Jiaping Jiaqi Jiarui Jiateng Jiaxin Jiaxing 
  Jiayi Jiayu Jichao Jicheng Jidong Jie Jie-Ren Jiean Jien Jiening 
  Jieping Jieren Jiezhen Jifeng Jignesh Jihad Jihong Jihua Jijun 
  Jildy Jill Jilles Jillian Jim Jimmie Jimmy Jin-Shuen Jinbo Jincheng 
  Jingcheng Jingdong Jingfan Jingfeng Jingheng Jinghong Jinghui 
  Jingjing Jingsheng Jinguo Jingwen Jingxiang Jingxing Jingxuan 
  Jingyan Jingyi Jingyu Jingyuan Jingyue Jinhao Jinko Jinliang Jinmin 
  Jinnian Jinru Jinsheng Jinsong Jintian Jinyan Jinyao Jinyi Jinyue 
  Jionger Jiping Jiri Jitendra Jiteng Jitka Jittakan Jiuliang 
  Jiun-Ming Jivan Jivko Jixiong Jiyao Jiyuan Jjerzy Jo Jo-ann Jo-Anne 
  Jo-Arne Jo-Chieh Joachim Joakim Joan Joana Joanie Joanmarie Joann 
  Joanna Joanne Joannes Joao-Paulo Joaquim Joaquin Joar Jobina 
  Jocelyn Jocelyne Jochen Jodi Jody Joe Joelle Joerg Joergen Joern 
  Joey Joffani Joginder Jogindra Johan Johanan Johann Johanna Johanne 
  Johannes John-Eldar John-Erik John-Henry Johnathan Johni Johnny 
  Johny Jojo Joke Jola Jolanda Jolanta Joline Jolle Jomar Jomo Jon 
  Jon-Egil Jona Jonas-Rimantas Jonatan Jonathan Jong-Chuan Jongki 
  Jongky Joni Jonida Jonill Jonny Jons Joo Joon Joop Joost Jopie 
  Joram Joran Jordanis Jordi Joren Jorg Jorge Jorgen Joris Jorma Jorn 
  Joro Jorrit Jorun Jorund Jorundur Jos Jose Josee Josef Josefina 
  Joseline Josep Josephin Josephine Josette Josh Joshua Josiane 
  Josianne Josias Josie Josko Jostein Josy Josyane José Jothimani Jou 
  Jouko Jouni Jouri Jovan Jovana Jovanka Joyjit Joyrup Joze Jozef 
  Jozsef Juana Juancho Juanita Jubilate Jucoslav Jude Judi Judie 
  Judit Judita Judith Judy Juei-Yu Jugoslav Juha Juhan Juhani Juheni 
  Juho Jui Jui-Feng Jui-Yi Juju Jukka Jules Julette Julia Julian 
  Juliana Julianna Julianne Juliano Julide Julie Juliet Juliette 
  Julija Julio Julita July Jun Junaid Juncan Junda June Junfeng 
  Jungyoon Juniarto Junjie Junko Junnan Junqiang Junren Junru Junshan 
  Junxi Junxiang Junyang Junyi Junyu Junyuan Junyue Juraj Juras Jure 
  Jurg Jurgen Jurgita Juri Jurica Jurii Jurijs Juril Juris Jushi 
  Jussi Justas Juste Justin Justine Justus Justyna Jut Jutta Juuso 
  Juyu Jvhani Jy Jyaubin Jyme Jyotindra Jyri Jyrki Jytte Jérôme 
  Jörgen Jørgen Jørn 

  Ka Ka-Cheung Kaan Kaarel Kaarle Kabelo Kabou Kacper Kadayam Kadir 
  Kagan Kah Kai Kai-Cheuk Kai-Ching Kai-En Kaijian Kailash Kaisa 
  Kaiti Kaiwen Kaj Kaja Kajal Kajetan Kal Kalamazad Kalervo Kalevi 
  Kali Kalia Kalifa Kalin Kalle Kalpa Kalthoum Kalvi Kalyan 
  Kalyanaraman Kam-Wing Kamala Kamalakara Kamales Kamaleshwar 
  Kamaljit Kamelia Kamen Kamiel Kamila Kamile Kamla Kamles Kamran 
  Kamrul Kamryn Kamuran Kanagarajulu Kanakamuthu Kanako Kandahar 
  Kanellos Kang-Wei Kani Kanokporn Kanti Kaori Kaorora Kaoru Kapalu 
  Kapulu Karakartal Karan Karapet Kare Kareem Kareen Karelle Karen 
  Kari Kari-Anne Karia Kariana Kariawaya Karic Karie Karin Karina 
  Karine Karka Karl Karl-Heinz Karl-Johan Karl-Markus Karla Karlijn 
  Karlina Karlis Karlo Karmani Karmen Karna Karnchit Karolina Karoly 
  Karon Karri Kars Karsten Karthik Kartlos Kartney Karunakara 
  Karuppiah Karya Kasamon Kasemsuk Kasey Kashif Kashinath Kasia Kasif 
  Kasim Kasira Kaspar Kasper Kata Katalin Katarina Katarzyna Katerina 
  Kath Katharina Katharine Katherine Kathie Kathirgamu Kathleen 
  Kathrin Kathrine Kathryn Kathy Kati Katia Katialena Katie Katinka 
  Katja Katrien Katrin Katrina Katrine Kattuputhur Katy Katya Kauko 
  Kaupo Kaur Kaustabh Kaustubh Kavi Kavinthan Kavita Kawaljit Kayan 
  Kayden Kayhan Kayla Kayseri Kayzen Kazimierz Kazuhiko Kazuhisa 
  Kazuko Kazunori Kazuo Kazuto Kazuyuki Kc Keaboka Kealeboga 
  Keamogetswe Kees Kees-Jan Kefu Kei Keijo Keiko Keisho Keisuke Keke 
  Kelan Kelli Kelvin Ken Kenan Kende Keneilwe Kenichi Kenji Kennet 
  Kenneth Kenta Kentaro Kento Kenza Kenzo Keoagile Keping Keqiang 
  Keren Kerim Kerri Kerry Kerstin Kesanli Kesha Keshav Kestutis Ketki 
  Ketty Keung Kevin Kexin Keyzad Kgomotso Khadija Khaik Khairuddin 
  Khaldoun Khandakar Khanh Khawar Khayer Kheng Khimji Khrystyna 
  Khuman Khurrum Khurshid Ki Kien Kieren Kiki Kikik Kiko Kikou Kimar 
  Kimberley Kimberly Kimiko Kimitoshi Kin Kinga Kinman Kinoka 
  Kinzaburo Kira Kirankumar Kirawat Kiri Kiril Kirill Kirit Kirollos 
  Kirsi Kirsten Kirstin Kirstine Kirstyn Kirti Kishore Kisio Kismet 
  Kitora Kittichai Kittinan Kitty Kity Kivanc Kizola Kjartan Kjeld 
  Kjell Kjell-Arne Kjellaug Kjetil Kjoro Klaas Klaids Klara Klaus 
  Klaus-Peter Klavs Klement Kleomenis Klimentin Knud Knud-Aage Knut 
  Ko-Wei Koba Kobe Kobi Koen Koeno Koert Kohava Koi Koichiro Koit 
  Kok-Leong Koka Kokan Koki Koko Koksal Kole Kolla Kolyo Komarudin 
  Kong-Te Konrat Konstantin Konstantina Konstantinos Konstantins 
  Konstanty Konstantyn Koos Kora Korapin Koray Korhan Korina Korine 
  Kornel Kornelija Kory Koshi Kosta Kostadin Kostandin Kostis Kosuke 
  Kosyo Kotaro Koteeswaran Koteswar Koteswara Kouichi Koushik Kovit 
  Kranthirao Krasi Krasim Krasimir Krassimir Krastyu Kresimir Kresten 
  Kridsada Kridsadayut Krille Kripa Kris Krishen Krishnakant 
  Krishnama Krishnamoorthi Krishnaveni Krista Kristanto Kristaps 
  Kristen Krister Kristi Kristian Kristie Kristijan Kristin Kristina 
  Kristine Kristinn Kristjan Kristjana Kristof Kristoffer Kristyna 
  Krisztian Krisztina Kritsakron Krojgaard Krysia Kryspin Krystian 
  Krystof Krystyna Krysztof Kryzsztof Krzys Krzysiek Krzysztof Ksenia 
  Ksenija Kuan Kuan-Chu Kuan-Hsuan Kuang-En Kubilay Kudret Kuei-Peng 
  Kui Kuki Kukuh Kulbir Kuldip Kuljit Kumara Kumari Kumiko Kumkum 
  Kumpati Kun Kun-Chieh Kun-Hung Kunal Kuniaki Kuniko Kunj Kunning 
  Kunti Kunwar Kuo-Hsuan Kuo-Jay Kuo-Paw Kuo-Yong Kuowen Kuppusamy 
  Kurniadi Kursad Kursat Kurt-Erik Kurt-Ove Kurtul Kush Kushal Kusum 
  Kutluhan Kutlwano Kuzey Kw Kwai Kwan Kwanyoung Kwok-Fai Kwong Kyeom 
  Kylie Kyllikki Kyoung Kyra Kyros Kyung Kåre Kürsat 

  Laci Ladiscan Ladislao Ladislaus Ladislav Laetitia Laila Lailatul 
  Laith Lakdar Lakjio Lakshmi LaLa Lalit Lalita Lalla Lalou Lamberto 
  Lamro Lamya Lana Lance Landon Lanfranco Lanny Lanpikul Lanxi Lany 
  Lao Laos Larbi Lariss Larissa Larry Lars Lars-Erik Lars-Goran 
  Lars-Ingvar Larus Larysa Lasha Lassad Lasse Laszlo Lata Latchmin 
  Latifah Laudine Laura Lauralee Laurance Laure Laureen Lauren 
  Laurens Laurent Laurentino Laurentiu Laurette Lauriane Laurie-Anne 
  Laurillau Lauris Lauritz Lavinia LaVon Lazzaro Lea Leah Leandro 
  Leao Lech Leda Leela Leen Leena Leenart Leendert Leentje Leevi 
  Lefteris Lehua Leia Leida Leif Leif-Erik Leif-Lke Leila Leise 
  Leixuan Lelia Lelio Lella Leman Lembit Lemet Lemiao Len Lene Leng 
  Leni Lenie Lenin Lennart Lennie Lenny Leny Leona Leonardo Leonas 
  Leonel Leonhard Leonids Leonie Leonilde Leonor Leonore Leopoldo 
  Leora Leqing Leroux Les Leslaw Lesley Leszek Leticia Letsogile 
  Letty Leuben Levana Levent Levente Leviah Levon Lex Leyan Leyla 
  Leylak Lezinka Li-Chung Li-Hsiang Li-Jen Lia Liam Liana Liane 
  Liang-Cheng Liang-Ching Liangkai Liangshui Liangxiao Lianjiang 
  Lianqing Lianwei Libby Libero Liborio Licia Licong Lida Lidang 
  Lidia Lies Liesbeth Lieve Lieven Liga Ligang Lihua Lihui Liidia 
  Liisa Lija Lijun Lik Likui Lilani Lileta Lili Lilia Lilian Liliana 
  Liliane Liliek Lilja Lilka Lill Lilla Lillemor Lillian Lilliana 
  Lillienne Lilo Lily Lin-Huan Lin-Shou Lina Linas Linchun Linda 
  Lindy Linetta Ling-Fang Lingjian Lingke Lingwen Lingyi 
  Lingyun Linhua Linlin Linnea Lino Linus Linzhen Linzhong Lion Lior 
  Liora Liping Liqiang Liqun Liraz Liri Lisa Lisanne Lisbeth Liselil 
  Liselotte Lisette Lisha Lisi Lissa Lite Liu-Mou Liujun Liulin 
  Liuqing Liv Liva Livia Liviana Livio Liviu-Fred Liwei Liwen Liwu 
  Lixin Lixiong Liya Liyong Liz Liza Lizzie Lizzy Ljiljana Ljosbra 
  Ljubisa Ljubisav Ljubomir Ljubov Ljudmila Lke Ll Llewellyn Lliker 
  Llorenc Lluis Lo-Mei Locky Lode Lodovica Loek Loekie Loes Logi Loic 
  Lois Lok Lokman Lola Loli Lolina Lolla Lolo Loly Lon Lone Longgen 
  Longhua Longin Loni Lora Loraine Lorand Loras Lore Loredana Lorella 
  Loren Lorena Lorenza Loreto Lori Lorie Lorinc Loris Lorna Lorne 
  Lorraine Lory Lotan Lotfy Lotta Lotten Lotty Louia Louis-Amaury 
  Louis-Carl Louisa Louiz Louize Loukas Loukia Loula Loulou 
  Lourdinhas Louw Lovro Luai Lubna Lubo Lubomir Lubos Luc Luca Lucasz 
  Lucero Lucetta Lucette Luci Lucia Lucian Luciana Luciano Lucie 
  Lucien Lucienna Lucienne Lucila Lucile Lucilia Lucilla Lucille 
  Lucio Lucja Lucky Lucrecia Lucy Ludger Ludivine Ludmil Ludmila Ludo 
  Ludovic Ludovica Ludovico Ludvig Ludwika Luella Luie Luigi Luigina 
  Luigino Luisana Luise Luisel Luiza Lujon Luk Luka Lukas Lukasz 
  Lukman Luma Luminita Lun Lung-Shian Luofei Luoluo Lusitana Lusje 
  Lussy Lutfiye Lutfu Luuk Luz Lya Lyaya Lychezar Lydia Lydie Lygre 
  Lykourgos Lyle Lyly Lyn Lynda Lynette Lyng Lynne Lynton Lysette 
  Lyudmila Lütfi 

  Maaciej Maaijke Maaike Maan Maarja Maarten Maartje Maaruf Mabel 
  Macarena Macca Machev Macie Maciej Maciek Macit MacKENZIE MacMAHON 
  MacNAIR Madalina Maddalena Maddhav Maddie Madeleine Madelena 
  Madeline Madelon Madelyn Madelynn Madhu Madhukar Mado Mads Maduo 
  Mady Maeve Magali Magdi Magdolna Magdy Maged Maggie Maggy Magnar 
  Magne Mags Magy Maha Mahalinhay Mahbubul Mahdi Mahendra Mahesh 
  Mahfuz Mahir Mahjoub Mahkota Mahmoud Mahmud Mahmudah Mahmudul 
  Mahmut Mai-Brit Maichel Maida Maija Mail Maipraewa Maire Mais 
  Maissa Maisy Mait Maite Maitreyi Maité Maj-britt Maja Majd Majda 
  Majka Majken Majorie Majvor Makarand Makiko Makoto Maks Maksim 
  Maksimilians Maksymilian Mal Malak Malbina Malcom Malene Malgorzata 
  Mali Malin Malissa Malka Mallappa Mallika Malou Malvine Malwina Mam 
  Mamie Mamta Manaf Manal Manana Manas Mancy Mandy Mane Maneck 
  Maneesh Manel Manette Manfred Mang Mangala Mangapul Manglus Manick 
  Manis Manish Manisha Manjit Manju Manjula Manlin Manlio Manny 
  Manoel Manol Manola Manolis Manolo Manon Manoo Manou Mans Mantas 
  Manthanee Manuela Manzoor Maoliang Maoxiang Mapita Mar Mara Marc 
  Marc-Andre Marcel Marcela Marcelin Marcell Marcella Marcelle 
  Marcelo Marcia Marcie Marcos Marcy Mare Mareille Marell Marella 
  Maren Marg Marga Margara Margaret Margareta Margarete Margaretha 
  Margarida Margarita Margaryta Margaux Marge Margeritha Margherita 
  Margi Margie Margo Margreet Margret Margrethe Margriet Marguerite 
  Maria-Aparecida Maria-Cristina Mariabruna Marialuisa Marian Mariana 
  Mariangela Mariann Marianna Marianne Marianske Marianthi Mariapaola 
  Mariapia Mariarita Mariarosa Mariasun Mariateresa Maribel Marica 
  Marice Marie-Annick Marie-Cecile Marie-Christine Marie-Claire 
  Marie-Claude Marie-Dominique Marie-Elisabeth Marie-France 
  Marie-Francoise Marie-Helene Marie-Jeanne Marie-Jose Marie-Josephe 
  Marie-Laure Marie-Luce Marie-Marthe Marie-Noelle Marie-Paule 
  Marie-Pierre Marie-Rose Marie-Therese Marie-Valentine Marie-Yvonne 
  Mariejke Marieke Mariela Mariella Marielle Mariemme Marienza 
  Marieta Marietta Mariette Marija Marijan Marijana Marijke Marijn 
  Marika Mariko Marilena Marilina Marilou Marilyn Marine Marinel 
  Marinella Marinesa Marinette Marinh Marinus Mario Marion Marios 
  Marious Mariquita Marisa Marisol Marit Marita Maritha Maritza 
  Marius Mariusz Mariya Marizul Marj Marja Marjan Marjana Marjie 
  Marjo Marjola Marjolein Marjorie Marjukka Marjun Marketa Markku 
  Markland Marko Markuss Marla Marle Marleen Marlen Marlena Marlene 
  Marlies Marlis Marlon Marlous Marly Marmaris Marner Marnie Maro 
  Marong Maroulla Marousia Marsel Marsha Mart Marte Marten Martha 
  Marthe Martial Martijn Martina Martine Martinha Martinos Marton 
  Martti Martyn Martynas Martín Maru Marulla Marusa Marv Marvellous 
  Marwan Mary Mary-Ellen Maryadi Maryann Maryanne Maryellen Marylene 
  Marylin Marylise Marylou Maryna Maryse Maryvonne Marzenna Marzia 
  Marziliano Marzio María Masaaki Masakatsu Masako Masaru Masayuki 
  Massenzio Massimiliano Massimo Masud Mat Matan Matea Matej Mateusz 
  Matevz Mathias Mathilde Mati Matias Matija Matilda Matilde Matjaz 
  Matous Mats Matt Mattei Matteo Matthaus Matthew Matthieu Matti 
  Mattia Mattias Matus Matyas Maud Maude Maula Maune Maura Maureen 
  Mauricette Mauricio Maurizi Maurizia Maurizio Mavi Mavis Max 
  Maxence Maxim Maxime Maximilian Maximiliano Maximo Maxine Mayalo 
  Mayda Mayol Mayur Mazal Mbakisi Md Mecbure Mechthild Mecislovas 
  Medardo Medhat Mediha Medina Meelis Meena Meenal Meera Meg Megan 
  Meghji Megumi Mehboob Mehdi Meherangiz Mehka Mehmat Mehmet Mehrishi 
  Mehves Meike Meikui Meilun Meira Meisheng Meixue Melania Melanie 
  Melek Melia Melic Melih Melike Melina-Marie Melinda Meline Melissa 
  Melle Meltem Melvin Memed Memet Memo Men Mendel Menderes Mendo 
  Meng-Fei Meng-Hsuan Mengqi Merche Merdan Merel Merete Meri 
  Meriem Merih Merijn Merima Merja Merle Merlin Merlino Merrell 
  Merril Merrilee Merryn Mert Merter Merve Mervin Mervyn Mery Meryem 
  Mesbahur Meshack Messiha Mesut Metecan Metod Mette Mevlüt Mey Mi 
  Mia Mian Mic Micael Micaela Micha Michaela Michail Michal Michala 
  Michalis Micheal Michela Michelangelo Micheline Michelle Michiel 
  Michiko Michnea Michèle Mici Mick Mickael Mickarter Micke Mickey 
  Mickie Micky Mido Midori Mieczyslaw Mieczysław Mieke Mieko Miel 
  Mieneke Miep Mieto Mietta Migry Mihael Mihaela Mihail Mihailo 
  Mihajlo Mihaly Mihaylova Mihkel Miho Mii Miin Mijanul Mijntje 
  Mikael Mike Mikhail Miki Mikis Mikk Mikkel Mikko Miklos Miko 
  Mikolaj Mikotaj Mikulas Mikus Mila Milagros Milan Milash Mildi 
  Mildred Milen Milena Mileva Mili Milica Milind Milivoj Miljenko 
  Milka Milko Milla Millicent Millie Milly Milojka Milorad Miloslav 
  Milosz Milovan Miltiadis Miltos Milva Milvi Mima Mimi Mimma Mimmo 
  Mimy Min-Fang Minar Minas Minda Mindaugas Mindy Mine Mineke Minesh 
  Ming Ming-Chien Ming-Ching Ming-Kit Mingfang Minggui Minghao 
  Minghui Mingkun Minglei Mingliang Mingming Mingqing Mingquan 
  Mingrong Mingshu Mingtai Mingyu Mingzhong Mini Minjie Minna Minnie 
  Minoru Minqi Minyeo Miodrag Miquel Mir Mira Mirabelle Mircea 
  Mireille Mirek Mirela Mirella Mirena Miriam Miriana Mirja Mirjam 
  Mirjan Mirjana Mirko Mirna Miroliub Miroljub Miron Miros Miroslav 
  Miroslava Miroslawa Mirta Mirto Miryam Mis Misako Misha Misho Miso 
  Missy Misty Misue Misuzu Mitch Mithat Mithun Mitja Mitresh Mitsue 
  Mitsuru Mitsuyo Mitul Mitzi Mizuho Mizuko Mladen Mm Moa Moataz Moaz 
  Moazzem Mobinul Moch Mochamad Modisaotsile Mogens Mohamad 
  Mohanakumar Mohindra Mohini Mohit Mohon Mohsin Moin Moine Moira 
  Moise Moises Mokgabo Mokhtar Mokone Molla Mollie Molly Momchil 
  Momcilo Momo Mona Moncef Monette Moni Monia Monica Moniek Monika 
  Monique Monirul Monowarul Monte Montse Montserrat Monty Morag 
  Mordechai Mordechay Morella Morena Morrie Mort Mortan Moselle Moshe 
  Moshiur Mosimanegape Mostafa Motaz Moti Motoaki Mouaffak Moulay 
  Mousec Moussia Moxi Moye Moyna Mozez Mrinal Muammer Mubashir 
  Muberra Mucella Mucteba Mudessar Mufazzel Mufit Muge Muguette 
  Muhamm Muhammed Muhammet Muharrem Muhittin Muhsin Mui Mujahed 
  Mujdat Mukarram Mukhiban Mukul Mukund Mulgan Mumu Munawar Muneca 
  Mungo Muqun Muralidhararao Murhy Muriel Murli Murph Murry Musa 
  Mushfiqur Mushir Mushtaq Mustafizur Mustapha Mustaqim Musti Mustika 
  Musty Muthu Muvakkar Muyun Muzaffer Muzeyyen Muzharul Mya 
  Mychaylets Mykhailo Mylene Myoung Myra Myriam Myrna Myron Myrsini 
  Myryam Myung Mårten Mónica Müfit Müje 

  N'Oga Nabeel Nabi Nacher Nachiketa Nacho Naci Nada Nadamuni Nadav 
  Nadejda Naderah Nadhin Nadi Nadia Nadide Nadiia Nadina Nadine Nadir 
  Nadira Nadri Nadrih Nafis Nafiz Nagasubramanian Nageswara Nagib 
  Nagisa Nahid Nahil Nahit Nahla Nahwa Nai Naimul Naina Najee Najeh 
  Najet Najib Najim Najla Najwa Nalin Nalini Nalita Nam Name Namik 
  Namineni Namit Nana Nanan Nance Nancy Nandansing Nando Nanette 
  Nanning Nano Nantia Nao Naoko Naomi Naoto Naoya Naozumi Napoleon 
  Naranja Narayana Narda Naren Nares Naresh Narguis Nasir Nasko Nat 
  Natali Natalia Natalie Natalija Nataliya Natallia Nataly Natanael 
  Natasa Natasha Natassa Nate Nath Nathalie Nathaniel Nati Natividad 
  Natsuko Nattapong Natuk Naty Nauman Nauris Naveed Navneet Nawab 
  Nawal Nawar Nawaz Nayak Naz Nazan Nazarena Nazif Nazife Nazik 
  Nazilli Nazli Nazmi Nazmul Nazzaro Nea Neal Neasa Nebil Nebojsa 
  Necati Necdet Nechama Necla Necmettin Necmi Neco Nedeltcho Nedi 
  Nedim Nedime Nedju Nedko Nedo Neelofar Neena Neeta Neftali Negra 
  Nehida Neide Neila Neils Nejat Neklan Nel Nele Neli Nella Nelleke 
  Nellie Nelly Nelonia Nels Nemanja Nena Nenad Neng Neong Nerio 
  Neriyosang Nermeen Nermin Nesat Nese Neset Nesim Nesimi Neslihan 
  Nesserine Nessima Nessrine Nessuna Nessuno Nestor Nesya Neta Netai 
  Netsy Nettin Netty Neuquina Neven Nevena Nevenka Nevin Nevra Nevzat 
  Neza Nezer Nezih Nezihi Ngai Ngin Nial Niall Niamh Nian Nianyan 
  Nianzhong Nibali Nic Nicasio Niccolo Nichele Nicklas Nicky Nicla 
  Niclas Nicola Nicolae Nicolae-Colea Nicolay Nicoleta Nicoletta 
  Nicolle Nicos Nida Nidia Niek Nieke Niels Niene Nietta Nieves Nigar 
  Nige Nigel Nihan Nihat Nik Nikhil Niki Nikica Nikita Nikki Niklas 
  Niko Nikol Nikola Nikolai Nikolaj Nikolajs Nikolaos Nikolas 
  Nikolaus Nikolay Nikoleta Nikos Nil Nilesh Nilgun Nili Nils 
  Nils-Olof Nils-Otto Nilufer Nimet Nimo Nina Ninette Ninguno Ningyu 
  Nini Ninni Ninon Nir Nira Niraj Nirel Nirmal Nirosha Nis Nisa Nisar 
  Nishant Nisim Niso Nissa Nissan Niti Nitin Nitjaree Nitsa Nitya 
  Niva Nives Niyati Niyazi Nizami Nji Noa Noah Noam Nobuko Nobuyuki 
  Nocolas Noeline Noelle Noemi Noemia Noervita Noga Noheir Nok Nolly 
  Nomi Nona Nongyu Nonlaphan Nono Noomi Noor Noordin Noorul Noppadol 
  Nora Norah Norayr Norb Norbert Norberto Noreen Norella Noriaki 
  Noriko Norm Norma Normand Normann Nouber Noufissa Noura Noureddine 
  Nouri Nourredine Novi Novry Noyla Npeng Ntina Nuala Nualsri Nuccia 
  Nuccio Nugzar Nuha Nuket Nukhet Numan Nuno Nunung Nunzia Nunzio 
  Nuoyi Nur Nuran Nuray Nurbay Nurdan Nurdin Nurettin Nurhan Nuri 
  Nuria Nurit Nursel Nurten Nurul Nurullah Nusa Nuttakul Nutwarun 
  Nyok-Kien 

  Oaitse Oana Obaidullah Oberon Occo Oceane Ocson Octav Octavio 
  Octavius Odd Odd-Erik Oddbjoern Oddbjorn Oddmar Oddrun Oddur Oddvar 
  Oded Odeta Odetta Odette Odile Odin Odon Oezen Ofek Ofer Ofra Ognen 
  Ognjen Ognyan Oguzhan Oi Okan Okcan Oktar Oktav Oktavianus Ola Olaf 
  Olafs Olafur Olai Olav Olavi Ole Olebile Oleg Olek Oleksander 
  Oleksandr Olena Olesya Olga Olgierd Olgu Olgun Olha Oli Olina 
  Olindrilla Oline Olivers Olivia Olle Olli Olly Olof Olsztyn Olve 
  Olympio Omero Omid Omphemetse Omprakash Omur Ona Onalenna Ondine 
  Ondrej Oner Onggani Onko-Jan Onno Ontlametse Onur Oosman Ophir Or 
  Ora Oran Oratile Orazio Ordac Oreste Oriana Orietta Origene Orit 
  Orjan Orkun Orkunt Orla Orn Orna Ornella Orsan Orsolya Ortwin Oruc 
  Orvar Ory Oryah Osama Osami Oscar Oshri Oskar Oskari Oskars Oslo 
  Osmo Osnes Ossur Ostap Osvaldas Osvaldo Oswald Oszkar Otakar Oth 
  Ottar Otti Ottorino Ovidiu Ovunc Owe Oxana Oya Oyil Oystein Oyvind 
  Ozden Ozel Ozlem Oznur Ozren Ozzie 

  Paal Paata Paavan Paavo Pablo Pachari Paco Pada Paddy Padma 
  Padmakar Padmanabhan Padmani Padmavathy Padmini Padraig Pak Pall 
  Pallikaranai Pallina Palmelia Palmira Paloma Pam Pamela Panagiotis 
  Panayiotis Panayotis Pancho Pandian Pandurang Panjaroon Pankaj 
  Pantelis Pao-Chi Paola Paradima Parakrama Param Paramjit Paras 
  Paresh Parfula Parich Parimal Parit Parlindungan Parningotan Parpar 
  Partho Parvez Parvin Pascale Pascaline Pascual Pasquale Pastoriza 
  Pat Patnarin Patrice Patricia Patricio Patrik Patrizia Patrycja 
  Patryk Patsy Patti Paule Paulette Pauli Paulie Paulina Pauline 
  Paulis Pauls Paulus Pavinee Pavla Pavle Pavlina Pavlos Pavo Pc 
  Pearl Ped Peder Pedro Peep Peeracha Peeter Peg Peggy Pei-En 
  Pei-Hsuan Pei-Hua Pei-Ting Peicai Peicheng Peifeng Peijie Peilin 
  Peixian Peiyan Pek Pekka Pele Pelin Penelope Penghao Pengqiao 
  Penguin Penko Pennaf Penpiccha Pentti Pepa Pepe Pepo Peppe Peppino 
  Per Per-Ake Per-Arne Per-Erik Per-Goran Per-Gunnar Per-Inge Per-Ola 
  Per-Olof Per-Olov Per-Ove Percival Pericle Peris Perisa Perizat 
  Perla Perluigi Pernik Pernilla Pernille Perran Perrine Pers Pertti 
  Perumpulipakam Perwez Peta Petar Pete Peter-Paul Peteris Pethraj 
  Petko Petr Petra Petri Petro Petronia Petros Petter Petur Peu Pey 
  Peycho Phadhyf Phailin Phakhanan Phanuwit Phattharin Phebe Phedias 
  Phedra Pheng Phia Phicheth Phil Philipa Philipp Philippe Philippos 
  Phillip Phillipe Phina Phoebe Phone Phongthep Phonlakrit Phornchai 
  Phouk Phuong Phyllis Pia Pichai Pier Piera Pierandrea Pierangelo 
  Piercarlo Pierfrancesco Piergiorgio Piergiovanni Pierino Pierluigi 
  Piermassimo Pierre-Alain Pierre-Andre Pierre-Edouart Pierre-Jean 
  Pierre-Yves Pierrette Piet Pieter Pietro Pihel Pik Pik-Ching 
  Pik-Kin Pilar Pilhae Pim Pimpraphai Pin Pin-Tsen Pinaki Pinar 
  Pinchas Pinella Ping-Lin Pinghsuan Pinit Pinson Pinuccia Pio Piotr 
  Piotrek Pipo Pippo Pirjo Pirkko Pit Pitchapruek Pittawat Pius Piya 
  Piyush Placido Plamen Planinka Pleun Plinio Pll Pnina Po Po-Han 
  Po-Hsiang Po-Lin Po-Ya Pobsit Pok Pol-Henri Pola Polina Ponniah 
  Pontus Pony Poohdid Pooja Poonam Poornachandra Pop Pornthep Poul 
  Povilas Povl Pow Powhatan Poyraz Prabakar Prabha Prabhakar Prabhala 
  Prabhat Prabir Pradeep Pradip Prafula Prahalad Prajwal Prakasam 
  Pramod Pramoul Pran Pranab Praneet Pranta Prapongse Prasad 
  Prasannakumar Prasanta Prasenjit Prasert Prashant Prashanth Prasun 
  Pratap Pratapan Prateep Pravati Praveen Pravin Prdrag Preben 
  Predrag Preechaya Preeti Prem Premila Premkumar Premsagar Premysl 
  Pretty Priidu Priit Prillya Primo Prinya Prinz Priscilla Pritam 
  Prith Prithviraj Priti Pritish Priya Proctor Prol Przemek 
  Przemyslaw Puchi Puck Pui Puja Pum Pumulo Punam Puneet Punya Pupa 
  Puqing Puriya Purshottam Pushpa Putri Putu Pyttsi Pål 

  Qamar Qazi Qiang Qianwen Qihao Qijiao Qiming Qing Qingbin Qingfeng 
  Qinghong Qinghua Qingliang Qingqing Qingshen Qingyuan Qinqin Qinyi 
  Qinyong Qipeng Qirjako Qiubo Qiufeng Qiuyang Qiwei Qixiang Qiying 
  Qiyun Quan Quanlong Qucheng Qudsia Quin Quincy Quirino Qumars Qurat 

  Ra'ad Rabie Rachael Rachen Rachid Rachma Rachman Rachna Radda Rade 
  Radek Radhakrishna Radhakrishnan Radi Radka Radmila Rado Radoslav 
  Radoslaw Radosslav Radu Radus Raduz Raed Raf Rafael Rafaele Rafail 
  Rafat Raffael Raffaele Raffaella Raffy Rafi Rafiq Rafiqul Rafn 
  Rafsan Raghava Raghavendra Raghbir Raghnild Raghunath Raghuraman 
  Ragip Ragna Ragnheidur Ragnhild Rahat Rahel Rahmi Rahn Rahul 
  Raianne Raigo Raija Raiko Raili Raimo Rain Raina Rainers Raivo Raj 
  Raja Rajagopal Rajagopalarao Rajaiah Rajani Rajaram Rajeeva Rajen 
  Rajendra Rajesh Rajeshwar Rajgopal Rajiv Rajnesh Rajon Rajul Rakel 
  Rakem Rakesh Raksha Ralf Ralfs Ralitsa Ralpf Raluca Rama 
  Ramachandra Ramana Ramanatha Ramaswamaiah Ramawatar Ramazan Rambabu 
  Rameen Ramiro Ramkumar Ramnik Ramniwas Ramon Ramona Ramprakash 
  Ramprasad Ramula Ramunas Ramzi Ranald Ranan Randa Randal Randi 
  Rangadhamarao Rangan Ranik Ranja Ranjan Ranjit Ranko Ranner Ransani 
  Raouf Raoul Raphael Raphaela Rapin Raquel Rares Ras Rashebul 
  Rashedul Rashi Rashidul Rashmikant Rasik Rasika Rasiklal Rasim 
  Rasmus Ratan Ratanlal Rati Ratna Rauf Raveen Ravikumar Ravindra 
  Ravishankar Rawad Rawit Rawya Raylene Raymon Raymonde 
  Razvan-Constantin Razzak Real Realba Reanette Rebeca Rebecca Rebel 
  Recai Recep Reda Reddi Refik Refiz Reg Regena Reggie Reggina Reggio 
  Regina Reginald Regine Regis Reha Rehana Reidar Reidun Reiko Rein 
  Reinaldo Reinder Reine Reinert Reinhard Reinier Rejan Rejin Rekha 
  Reki Reky Relu Remco Remi Remigiusz Remko Remo Remzi Ren-Jun Rena 
  Renal Renaldas Renata Renate Renato Renda Rene Renee Renfei Renfu 
  Rengasamy Renhong Reniel Renjie Rentaro Renxia Renyu Renzhou Renzo 
  René Renée Resego Resit Restu Resul Reuben Reuven Revaz Revika 
  Revnak Reyhan Reymond Reynaldo Reynir Rezaul Rezzan Rhianna Rhoda 
  Rhona Rhonda Rhys Ri Rianto Riaz Ric Rica Ricardo Riccardo 
  Ricciardo Ricco Richa Richi Richie Richo Rick Rickard Ricki Ricky 
  Rico Ricquier Ridha Ridi Ridvan Rie Rieks Rien Rienk Rietje 
  Rifat Rigga Rigmor Rigmore Riitta-Liisa Rik Rikard Rikarour 
  Rikhardur Riki Rikke Riko Riku Rima Rimantas Rimnong Rina Ringo 
  Rini Rinku Rino Rinus Riona Risk Risteard Ristu Riswan Ritambhar 
  Rituparna Ritva Rivi Rivka Rixi Rizcallah Rizgar Rizky Rizwan Rkia 
  Rob Robbie Robby Robert Roberta Robertino Roberto Robi Robin Robins 
  Roby Robyn Rocco Rochelle Rocio Rocky Rod Rodger Rodica Rodion 
  Rodolfo Rodolphe Rodric Rodrigo Roefi Roel Roeland Roelof Rogeir 
  Rogerio Rogier Roglyn Rohit Roi Rokas Roki Rokia Rokos Rolandas 
  Rolande Rolando Rolf Rolf-Eric Rolla Rollon Rolph Romain Romana 
  Romaric Romarie Romen Romesh Romolo Romuald Romualdas Romulo Romy 
  Ronald Ronaldo Ronan Rong-Jenn Ronger Rongjie Rongliang Rongqiang 
  Rongzhong Roni Ronnaug Ronni Ronnie Ronny Roro Rory Rosacarla 
  Rosalia Rosalie Rosalila Rosalind Rosaline Rosani Rosanna Rosaria 
  Rosarie Rose-Marie Roseann Roseline Rosella Roselyn Roselyne 
  Rosemarie Rosemary Rosette Roshan Rosie Rosine Rosita Rossana 
  Rossella Rossen Roswitha Rosy Roula Roulla Rouzanna Rowan Rowena 
  Roxana Roxane Roxy Roy-Hugo Roz Rozanne Rozet Rozi Rozita Ru 
  Ruaridh Rubina Rubinder Rubiwar Ruby Ruchan Ruchira Rudeng Rudi 
  Rudiger Rudolf Rudolfs Rudy Rufus Rugang Ruggero Ruhan Ruhi Rui 
  Ruibing Ruicheng Ruifu Ruihong Ruihua Ruiji Ruijun Ruike Ruiqi 
  Ruiting Ruizhe Ruja Rujipong Rukma Rukson Rumelili Rumen Rumman 
  Runa Runar Runi Runmei Runnan Runolfur Runyue Ruo Ruochen Ruoshui 
  Ruoyang Ruoyu Rupa Rupal Rupinder Ruri Rury Ruse Ruskin Rustam 
  Rusty Rut Rutger Ruth Ruth-Margrete Ruthanne Ruthie Ruthy Ruti Ruty 
  Ruud Ruyang Ruzgar Ruç Rychu Ryk Ryks Ryo Ryoga Ryoichi Ryoko 
  Rysiek Rystein Ryszard Rytis Ryung Ryusuke Ryvind Régis Rémy Röne 
  Rüstem 

  Saadat Sabahattin Saban Sabiha Sabin-Horia Sabina Sabrina Sabu 
  Sabyasachi Sacchariawan Sacha Sachiko Sachin Sacit Sada Sadako 
  Sadan Sadettin Sadhana Sadie Sadik Sadra Sadun Saela Saevar Safa 
  Safdar Safeya Saffet Safinur Sagar Sagari Sagie Sagnik Sagrario 
  Sahabettin Sahar Sahika Sahipal Sahmettin Saiful Saikritick 
  Sailaranjan Saim Sait Sajid Sajjad Sakari Saketh Sakharam Sakhawat 
  Sakher Sakiko Sakir Sakis Sakke Sakorn Saktia Sakuntala Sal Sales 
  Saliva Sally Salma Salvo Sam Samantha Sambasiva Sambuddha Samdi 
  Sameh Samer Samet Sami Samia Samih Samika Samiksha Samim Samina 
  Samira Sammy Samo Samonwan Samos Sampath Samsun Samuele Samuil 
  Samvel Sana Sandeep Sander Sandhya Sandi Sandie Sandip Sandor 
  Sandra Sandrine Sandris Sandy Sanekata Sanem Saner Sang Sangarapil 
  Sangho Sangwon Sanja Sanjay Sanjeev Sanjib Sanjoy Sankaranarayanan 
  Sankul Sannie Sante Santhalakshmi Santi Santiago Santino Santje 
  Santo Santosh Sanyogita Saonan Saowalak Sara Sarah Sarangapani 
  Sarasij Sarathi Sarfaraz Sarik Saroj Sarosh Sarper Sartaj Sarthak 
  Sartika Sartje Saruul Sarvothama Sas Sasa Sascha Sasha Sashko Sasho 
  Sasima Saskia Sasko Saso Saswata Sathyavathi Satilmis Satoshi 
  Sattar Satyabrata Satyakumar Satyanarayan Saulius Saumitra Saurabh 
  Sava Saverio Savina Sawar Sawaria Sawon Sawsan Say Saya Sayac Sayan 
  Sayantan Sayed Sayeed Sayoko Saz Saziye Schelte Schenz Schoumicha 
  Scilla Se Seamus Sean Seb Sebahattin Sebahettin Sebas Sebastian 
  Sebastiano Sebastien Sebbo Sebnem Secondo Seda Sedat Seden Sedick 
  Seemab Sefa Sefer Sefik Sehmus Seiki Seiya Sejal Sejr Sekkilar 
  Selahaddin Selahattin Selale Selam Selami Selen Selena Selene Selim 
  Selin Selma Selmin Selo Selva Selwyn Selçuk Sem Sema Semahat Semih 
  Semra Semsettin Sena Senada Senel Sener Seng Senga Seniha Senlin 
  Senol Senthur Sentot Seongseok Seppo Septimiu Serafettin Serap 
  Serdal Seref Seren Serena Serenina Serge Sergei Sergej Sergey Sergi 
  Sergici Sergii Sergije Sergio Sergiu Sergiy Serhan Serhat Serhei 
  Serhii Serkan Serl Sermed Sermin Servet Sesa Sesha Seszek Setiatin 
  Setsuko Setyo Seung Seungjin Sevan Sevda Severine Severo Sevgi 
  Sevil Sevilay Sevim Sevinc Sevinç Sevket Seyda Seyfi Seyit Seymon 
  Seza Sezai Shaban Shafique Shaham Shahar Shahbana Shahid Shahin 
  Shahla Shahnaz Shahrazad Shahzaad Shahzeb Shai Shaihan Shailaja 
  Shailendra Shailesh Shaju Shakeel Shakil Shamaila Shambhu Shamim 
  Shamin Shamshad Shamsuzzaman Shanfeng Shang-Hsuan Shangjie 
  Shangqing Shankar Shanker Shanshan Shansy Shanti Shantilal 
  Shao-Ting Shao-Tse Shao-Yu Shaohong Shaotao Shaowu Shapour Sharad 
  Sharat Shari Sharleen Sharmin Shary Sharyn Shashank Shashi 
  Shashikala Shashikant Shathi Shaul Shaun Shauq Shavit Shawn 
  Sheau-Fong Sheena Shehla Sheila Shelagh Sheld Shelo Shenghao 
  Shengle Shengli Shengmiao Shengxiang Shengya Shengyu Shengyue Sheri 
  Sherie Sherief Sherien Sherri Sherrie Sherry Sheryl Sheung Shezereh 
  Shi-Jie Shi-Tzun Shibnath Shichun Shiela Shien-Chu Shifra Shigang 
  Shih-Fen Shih-Yao Shih-Yi Shih-Yung Shijia Shijie Shikan Shikang 
  Shilan Shilin Shiling Shimin Shimon Shimshon Shine Shing Shing-Kwan 
  Shira Shirazi Shireen Shiri Shirin Shirl Shirlev Shirley Shirlie 
  Shitong Shiu Shiu-Ching Shiu-Kwong Shiuan Shivam Shiwen Shixiang 
  Shiyi Shiyong Shiyu Shiyuan Shiyun Shizhen Shlomit Shlomo Sho 
  Shoalb Shobhana Shohdy Shoji Shoko Shona Shosh Shoshana Shoshi 
  Shoua Shounan Shoushui Shouvik Shoval Shpetim Shpiner Shrikant 
  Shrinidhi Shrivallabh Shruti Shterion Shu-Chen Shu-Ping Shu-Yi 
  Shuaitong Shuang Shuangle Shuangrong Shubham Shubi Shue Shugo 
  Shuguang Shui Shui-Liang Shuichi Shuijing Shuk Shuki Shukoufeh 
  Shukri Shula Shulan Shuluo Shun Shun-Hin Shun-Ho Shunsuke Shuo 
  Shuoming Shuoyan Shuping Shuqing Shurong Shyam Siang-Chen Siarhei 
  Sibel Sibrand Sibylle Sicco Sicheng Sid Siddhartha Sidharth Sidney 
  Sido Sidsel Sie Siegfried Siem Sigbjørn Siger Sigfus Siggen Sigi 
  Signe Signy Sigrid Sigridur Sigrun Sigrunn Sigtryggur Sigudur 
  Sigurbjorn Sigurd Sigurdur Sigurjon Sigyn Sihan Sihao Siiri Sijia 
  Sikun Sila Sili Silje Silvana Silvano Silvere Silvestre Silvia 
  Silvija Silvina Silviu Sima Simcha Simen Simiko Simin Simoes Simona 
  Simonetta Simten Simun Sinan Sinasi Sindhu Sinead Sinem Sinesio 
  Sing Singles Singsan Sini Sinikka Sinisa Sinniah Sintija Siobhan 
  Siok Siong-Kong Sipalui Siqing Siraphob Sireen Siri Sirin 
  Siripatsorn Siriram Sirje Sirma Sirri Sirui Sisi Sissel Sissi Siti 
  Siu-Kau Siv Sivaramakrishna Sivert Sivezat Sixi Siyi Siyu Siyuan 
  Siz Size Sjarel Sjef Sjietsen Sjoerd Sjoert Sjur Sk Skafti Skander 
  Skarbimir Skarhol Skerdi Skirmantas Skjalg Skuli Sky Sladana 
  Sladjana Slaheddine Slamet Slava Slavi Slavica Slavko Slawek 
  Slawomir Slihas Slobodan Smaranda Smari Smaro Smita Sneh Snehasish 
  Snezana Sniedze Snir Snorre Snorri Soad Soare Sobhagchand Sock 
  Soegianto Soelvi Soemarsono Soeren Soerlie Soffia Sofi Sofia Sofie 
  Soha Sohair Soham Sohban Sol Solange Solbritt Soledad Solene 
  Solfrid Soli Solita Solla Solvei Solveig Soma Somaya Somboon 
  Somchai Somchand Somnath Somsak Sona Sonal Sonata Sondra Sondre 
  Sondro Soner Songa Songhe Songhua Songtao Sonia Sonja Sonny Sonya 
  Soo-Rong Sooki Sophia Sophie Sophocles Sora Sorada Soren Sorin 
  Sorin-Radu Sorina Sornprom Sosso Sotirios Sotiris Sotos Soudi 
  Soumadeep Soumalya Soumitra Soumya Sounak Soundararajan Sourav 
  Sourendra Souvik Souzy Sovan Sovert Sowmitra Spela Spike Spiridione 
  Spiros Spyridoula Srecko Sree Sreedharan Sreeemathi Sreekanth 
  Sreekrishnan Sreekumar Sri Srihari Srikanta Staale Stacy 
  Staf Staffan Stan Stancho Standa Stane Stani Stanimir Stanislaus 
  Stanislav Stanislaw Stanko Stasa Stasha Stathis Stav Stavros 
  Stavroula Steban Steef Stef Stefania Stefanie Stefanos Stefanus 
  Steffen Stefka Steinar Steingrim Steingrimur Steinunn Steliana 
  Stelio Stelios Stella Sten Sten-Sture Stense Stepan Steph Stephan 
  Stephane Stephanie Stephannie Stephy Sterling Stevan Steve Steven 
  Stevica Stevy Stew Steward Stian Stig Stine Stirling Stjepan Stoian 
  Stojcho Stoyan Stoycho Stoyo Strato Stratos Stu Sture Sturla 
  Stylianos Su-Beng Suat Suayip Subadra Subba Subbarao Subhas Subhash 
  Subhashree Subhransu Subir Subodh Subrata Suchithra Suci Sudarmadi 
  Sudarshan Sudesh Sudha Sudhakar Sudhakara Sudhir Sudip Sudipta 
  Sudirman Sue Sueli Suely Suena Suet Sugita Sugun Suh-Ling Suha 
  Suhaili Suhair Suhan Suhang Suhas Suheda Suheil Suheyla Suhua Sui 
  Sujata Sujauddin Sujiit Sujit Sukai Sukalyan Sukamal Sukanta Sukh 
  Sukha Sukil Sukiyah Sukrit Sukriye Sukru Sule Suleiman Suleman 
  Suleyman Sulina Sulun Sum Suman Sumit Sumitra Sumusu Suna Sunai 
  Sunanda Sundar Sundarram Sundermurthy Sune Sunil Sunisa Sunit 
  Sunita Sunny Sunra Suominen Suoth Sup Supang Supeno Suphi Supote 
  Surabaya Surajit Surat Surekhakumari Surender Surendra Suresh 
  Suriwipha Surya Suryakant Susan Susana Susann Susanna Susanne 
  Susetta Sushil Susi Susie Susu Susy Sutanu Suthep Suvi Suwat Suz 
  Suzan Suzana Suzanna Suzanne Suzet Suzi Suzie Suzy Svala Svante 
  Svarup Svatopluk Svavar Svein Svein-Olav Sveinn Sveinngun Sven 
  Sven-Ake Sven-Erik Sven-Olov Svend Svenn Sverre Sverrir Svetla 
  Svetlana Svetlin Svetolik Svetomir Svetoslav Svetozar Sviatlana 
  Svilen Svjetlana Swa Swapan Swaray Swarnashish Swarnendu Swarup Sy 
  Syahrial Syam Syarif Sybil Sybill Sybille Syd Syham Sylva Sylvain 
  Sylvia Sylvian Sylviane Sylvie Sylwester Sylwia Syra Sysser Sytze 
  Szabolcs Szczepan Sze-Ching Sze-Guan Sze-Wing Szilvia Szymon 
  Süleyman Sülo Süreyya Søren Søs

  Ta Taara Taavet Taavi Tabita Tad Tadahiro Tadashi Tadayoshi Tadej 
  Tadek Tadeshi Tadeusz Tadjib Tae Taeko Taf Tage Tagi Tahar Tahir 
  Tahira Tahseen Tahsin Tai-Che Taia Taiana Taiji Tais Taivo Tak 
  Takahiko Takahiro Takahito Takako Takanori Takao Takashi Takayuki 
  Takehiko Takeshi Takis Takumi Takuto Talat Taliana Tamar Tamara 
  Tamas Tamer Tami Tammo Tammy Tamo Tamsin Tana Tananchai Tanaporn 
  Tanel Tania Tanja Tanman Tanmoy Tanudjan Tanya Tapan Tapas Tapio 
  Taptep Tara Tarak Taral Tarik Tariq Taristchollatorn Tarja Tarjei 
  Tarjej Taru Tasmin Tassamon Tassios Tassos Tat Tatiana Tatjana 
  Tatsiana Tatsunosuke Tatu Tatyana Taufik Tauno Tavare Tawatchai 
  Taweesith Tayfun Taymour Tayyar Tazeen Tea Tebogo Teck Ted Teddy 
  Tedi Teerachart Teguh Tehseen Teiji Temide Temistocle Temur Ten 
  Tengbo Tengis Teno Tenyu Teodor Teodora Teodoras Teodoros Teofilo 
  Teong-Wah Terasak Tere Terence Teresinha Tereza Teri Terje Tero 
  Terpsi Terrence Terri Terrol Teruko Terushi Tess Tessa Tessi 
  Tetsuji Tetsutaro Tetty Tetyana Tex Texas Tezcan Thabo Thalia 
  Thanaporn Thanassis Thanos Thapanee Tharuniah Thawee Thea 
  Theeraphat Thelma Themis Theo Theodor Theodori Theodoros Theofanis 
  Theoman Theresa Therese Thiago Thibaud Thibaut Thibo Thierry Thijs 
  Thindivanam Thirumala Thirunavukkarasu Thiruvadanthai Thiruvenkata 
  Thodoros Thom Thon Thondiculam Thongchai Thora Thoranna Thorarinn 
  Thordur Thorgeir Thorgerdur Thoriq Thorir Thorlakur Thorleif 
  Thorstein Thorsteinn Thorsten Thorvald Thouvenot Throstur Ti Tia 
  Tiago Tiancheng Tianfa Tianjun Tianle Tianling Tianlu Tianping 
  Tianqi Tianxiang Tianyao Tianyi Tiberiu Tibor Tico Tie Tielman 
  Tien-Chun Tien-Hsuan Tien-Hsun Tien-Liang Tiena Tiffany Tiger 
  Tigran Tihana Tihomir Tiina Tiit Tijen Tikva Til Tilakraj Till 
  Tilly Tilmann Tim Timo Timothee Timothy Timotius Timucin Timur Tin 
  Tina Tinas Tine Tineke Ting-Chun Ting-You Tinghao Tingqiang Tino 
  Tiny Tirso Tirtharaj Tita Titan Titi Tito Titok Titti Titus Tiziana 
  Tiziano Tjali Tjeerd Tjerk Tlhabiso Toar Tobi Tobina Toby Toddy 
  Todor Toine Toivo Toke Tolga Tolja Tolle Tomas Tomasz Tomaz Tomek 
  Tomer Tomi Tomislav Tommaso Tommy Tomoaki Tomoe Tomohiro Tomoya 
  Tomoyuki Toms Ton Tona Tonci Tone Toni Tonia Tonio Tonis Tonje 
  Tonno Tonny Tonu Tony Toomas Toos Tor-Eivind Tora Toralv Torben 
  Torbjorn Torbjrrn Torbjørn Torgeir Torgild Torild Torio Torjborn 
  Torkel Torkom Torleif Tormod Toros Torstein Torunn Torvald Tos 
  Toshihiro Toto Toufic Touran Toussaint Tova Tove Toygan Toygar 
  Toyohiko Toyoko Tp Trabzon Tracy Traian Trairat Traisi Trajan 
  Traudi Treephop Trevor Tri Tribhovandas Tribhuvan Tribhuwan Tricia 
  Triinu Trille Trine Trinitee Triona Trish Trisha Tristan Triumf 
  Trond Troy Trude Trudi Trudy Truls Truus Tryfonas Tryggvi Trygve Ts 
  Tshephiso Tshepiso Tshepo Tsolo Tsukasa Tsuneo Tsuyoshi Tsz Tua 
  Tuana Tuba Tubby Tufail Tufan Tugba Tugbars Tugce Tulay Tulij Tulla 
  Tullia Tumo Tuna Tunc Tuncay Tuner Tungga Tunky Ture Turgay Turgut 
  Turid Turkatasever Turlough Tushar Tutku Tuul Tuula Tuuve Tuzar 
  Tvrtko Txomin Tybring Tymen Tymoteusz Tyr Tyroon Tysha Tytus Tze 
  Tzu Tzu-Hao Tzu-Liang Tzu-Lin Tzung-Fang Tzuoh-Miin 

  Uba Ubaldo Uchen Uchenna Udatta Uday Uddin Udo Uffe Ufuk Ugis Ugo 
  Ugurcan Ugurhan Ujjwal Uki Ul-Ain Ula Uladzimir Uldis Ulf Uli 
  Ulises Ulisse Ulker Ulla Ulla-Britt Ullabritt Ulli Ulric Ulrich 
  Ulrik Ulrika Ulrike Ulyana Uma Umberto Umesh Umit Umran Umut Una 
  Unni Unnikrishnan Uno Uraiwan Uri Uriah Uriel Urmas Urmila Uros Urs 
  Ursin Ursula Urszula Urzula Uschi Usha Ute Utku Utta Uttam 
  Uttamchand Uwe Uygar Uzi 

  Vaardal Vaclav Vaclovas Vadim Vadivelu Vagelis Vaggelis Vahit Vahur 
  Vaikunth Vaino Val Vala Valarie Valdo Valentin Valentina Valentino 
  Valeri Valeria Valerie Valerio Valeriu Valeriy Valery Valev Valgard 
  Valgerdur Valio Vallapa Valli Vallo Valmar Valter Valur Valya 
  Valérie Vaman Vambola Van Vanaja Vanda Vandana Vanessa Vangelis 
  Vania Vanja Vanna Vannino Varalakshmi Varis Varna Varol Vasant 
  Vasanthan Vasanthi Vasanti Vasco Vasil Vasileios Vasilij Vasiliki 
  Vasilis Vasiliy Vasko Vassil Vassili Vassiliki Vassilis Vasssilios 
  Vasudeo Vasudevan Vedat Vedran Vedy Veerabhadra Veerubhotla Vegard 
  Vehbi Veikko Veli Velia Velibor Velichka Velimir Velina Velitchko 
  Veljko Vellislav Vello Velupillai Vemund Vencislav Venetia Venkata 
  Venkataramani Venkatasubramanian Venkateswarlu Venkatram Venkatrao 
  Ventseslav Ventsislav Venu Venugopal Veny Verena Veri Verina Verino 
  Vern Verner Verona Veronel Veronica Veronika Veronique Very Vesa 
  Veselin Vesna Vesya Veterano Vetle Veysel Veysi Vi Viacheslav 
  Vibeke Vibhas Vibul Vic Vicenzo Vicki Vickie Vicky Victor 
  Victor-Bernard Victoria Victoriano Vidami Vidar Vidhya Viekko Vieri 
  Vigdis Viggo Vignir Vijay Vijaya Vijayan Vijayanand Vijayraghavan 
  Vikas Vikentij Viki Vikrant Viktor Viktoria Viktors Vildan 
  Vilhjalmur Viliam Viljem Villiam Villo Villy Vilma Vilmar Vimal 
  Vimla Vinayak Vince Vineet Vinesh Vinita Vinko Vino Vinoth Vintila 
  Vio Violaine Violet Violeta Viorica Virat Virendra Virgil 
  Virgilijus Virgilio Virginia Virginie Virginijus Virgul Viriya Visa 
  Visalakshi Vishnu Vishwa Vishwanath Vishwas Visweswar Visweswara 
  Vita Vitagliano Vital Vitaly Vithaya Vito Vitold Vitor Vittal 
  Vittek Vittoria Vittorio Viv Vivek Vivi Vivian Viviana Viviane 
  Vivianne Vivien Vivienne Vjekoslav Vjollca Vlad-Ionut Vladan 
  Vladimi Vladimir Vladimiros Vladislav Vladmir Vlado Vladyslav 
  Vlamir Vlastimil Vlatko Vogg Vojislav Vojko Vojtek Volha Volkan 
  Volodymyr Voyteck Vrat Vreni Vroni Vsevolod Vuc Vuk Vyacheslav 
  Vygandas Vygintas Vytautas 

  Wacek Waclaw Waded Wadud Wafa Wafik Wai-Kit Wai-Lap Wai-Sing Wajid 
  Waldemar Waldemiro Waled Waleed Walek Walery Waliul Wally Walt 
  Walte Walther Waltraud Wan-Hew Wan-Ting Wanchai Wanda Wanfeng 
  Wangbin Wanghua Wangjing Wangjun Wangying Wanida Wanna Waqar 
  Wardeen Wardhani Wardiman Waseem Washiragon Wasim Watini Watrap 
  Wattana Wattanai Wei-Bung Wei-Chun Wei-Hsiang Wei-Ming Wei-Shou 
  Wei-Wei Weichang Weichen Weidong Weiguo Weihong Weihua Weijia Weili 
  Weiluan Weiming Weiping Weiqiang Weirong Weishu Weishun Weisong 
  Weitong Weiwei Weixin Weiyi Weiyu Weiyuan Weize Welly Wen-Chuan 
  Wen-Chun Wen-Hua Wen-Ling Wen-Yen Wen-Yo Wenbin Wenbo Wenchan 
  Wenche Wendell Wendi Wendy Wenfei Wenhong Wenhui Wenhung Wenji 
  Wenjia Wenjie Wenjiong Wenjun Wenke Wenling Wenmin Weno Wenqin 
  Wensheng Wenshu Wenxia Wenxuan Wenyi Wenying Wenyu Wenzhuo Wes 
  Wesley Wibeke Widad Wided Widi Wiebe Wiebke Wiel Wiesiek Wiesla 
  Wieslaw Wieslawa Wietske Wijnand Wiktor Wil Wilbur Wilfried Wilga 
  Wilhelmina Wilhelmine Wilhem Will Willa Willem Willi William Willie 
  Willy Wilma Wiltrud Wim Wimpy Win Winda Winifred Winnie Winsom 
  Winson Wismoyo Wisolus Wisse Wissem Witak Witold Wittawin Wiveca 
  Wladek Wladyslaw Wlliam Wlodek Wlodzimierz Woen Wojcie Wojciech 
  Wojcieck Wojtek Woldemar Wolfang Wolfgang Wolfram Wongsapol Wonjoo 
  Wook Woranittha Wosziech Wout Wouter Woyciech Wrik Wto Wubbo Wuping 
  Wuyuan 

  Xenia Xian Xianan Xianbin Xiangbin Xiangchen Xiangdong Xiangfeng 
  Xiangping Xiangshun Xiangwu Xiangyang Xiangying Xiangyun Xiangzhu 
  Xianliang Xianpei Xiaobao Xiaobing Xiaobo Xiaochen Xiaodong 
  Xiaofang Xiaofeng Xiaoguang Xiaohan Xiaojin Xiaojing Xiaojun 
  Xiaolei Xiaoling Xiaolun Xiaomin Xiaoming Xiaonong Xiaoqiong 
  Xiaoqun Xiaoran Xiaorun Xiaotong Xiaowu Xiaoxia Xiaoxue Xiaoyan 
  Xiaoyang Xiaoyi Xiaoyin Xiaoyu Xichen Xieen Xieluo Xieyang Xifeng 
  Xihao Xihong Ximena Xinchen Xingguo Xinghe Xingjian Xingke Xingsi 
  Xingxing Xingyu Xingzeng Xinli Xinlun Xinmei Xinmin Xinwu Xinyang 
  Xinyao Xinyi Xinying Xinyu Xinyue Xioajuan Xiongbai Xiongying 
  Xiufen Xiuting Xiwang Xiyuan Xuan-Da Xuanci Xubo Xuchen Xudong 
  Xuechun Xuefang Xuefei Xuefeier Xuefeng Xuejun Xueliang Xueming 
  Xuenan Xuezhu Xufa Xufeng Xukai Xunchang Xuyang Xuyou 

  Ya-Bin Yaacob Yaacov Yadwiga Yael Yaffa Yair Yajie Yakov Yakub 
  Yakup Yalan Yalova Yambol Yamin Yaming Yan-Xiu Yane Yanfeng Yang-Ru 
  Yangquan Yangyang Yanhong Yanhua Yanhui Yaniv Yanjiao Yanka Yankan 
  Yankos Yankun Yanmei Yann Yannick Yannis Yanong Yanpei Yanqing 
  Yanrong Yanru Yanting Yanwen Yanxu Yanyan Yanze Yanzhuo Yao-Ming 
  Yaojia Yaomin Yaoxing Yaoyuan Yapin Yaqi Yaren Yariv Yaroker Yaron 
  Yaroslav Yasemin Yasen Yasmin Yasmine Yassen Yasser Yassin Yasuaki 
  Yasuhiro Yasuo Yasushi Yati Yatish Yauhen Yauheni Yawamon Yaxin 
  Yaya Yazeed Yazhou Yb Yee Yefen Yehia Yehoshua Yehudit Yelda 
  Yen-Chen Yen-Hsiang Yen-Hsuan Yen-Jung Yena Yenchi Yendi Yeng Yeni 
  Yeshayahu Yesim Yessi Yeti Yetkin Yeuk Yevgeniya Yi-An Yi-Hsien 
  Yi-Li Yi-Nan Yi-Pin Yi-Ting Yi-Wen Yi-Zu Yibing Yicai Yichao Yichen 
  Yicheng Yichi Yici Yidan Yide Yidi Yifan Yifei Yifu Yigal Yigit 
  Yihan Yihao Yihong Yiji Yijia Yijing Yijun Yili Yilin Yiling Yimei 
  Yimin Yiming Yin-Shou Yin-Yu Ying-Cheng Ying-Hsuan Ying-Tsun 
  Yinghao Yinghui Yinglei Yingqi Yingxiang Yingying Yingzhe Yino Yinpei 
  Yinuo Yipeng Yiping Yiqi Yiqin Yiran Yisheng Yiting Yitong Yitzhak Yiwei 
  Yiwen Yixiang Yixin Yixiong Yixuan Yiyang Yiyi Yiyun Yizhou Yizhuo 
  Yke Yl Ylva Yngve Yoav Yochai Yocheved Yochi Yoel Yogesh Yohan 
  Yohanan Yohsin Yoichi Yoke Yoko Yoland Yolanda Yolande Yolanta 
  Yolcu Yoli Yona Yonatan Yonca Yong-Rui Yongchang Yongcheng 
  Yongchuan Yongcun Yongfu Yonggang Yongge Yonghong Yonghui Yongji 
  Yongjie Yongkang Yongling Yongqiang Yongqun Yongsheng Yongxue 
  Yongzhong Yongzhu Yonko Yono Yoonbo Yoram Yordan Yordi York 
  Yorukakar Yosef Yoshiko Yoshiro Yoshitake Yoshiyuki Yosi Yossi Yosy 
  Yotam Youbao Youbert Youku Youmna Young-Hong Youngmee Youp Youri 
  Yousef Yousheng Youyou Yoya Yp Yu-Chen Yu-Cheung Yu-Han Yu-Jen 
  Yu-Jhau Yu-Jui Yu-Lun Yu-Sheng Yu-Shiang Yu-Tung Yuanbong Yuanchun 
  Yuandong Yuanfeng Yuanluo Yuanwei Yuanzhe Yuashan Yubao Yuce 
  Yucelen Yuchen Yucheng Yudai Yudian Yuding Yuedong Yuegang Yuehua 
  Yuehui Yuekai Yueling Yuenan Yuet Yuewu Yuexin Yueyin Yufan Yufei 
  Yufeng Yugo Yuhan Yuhao Yuheng Yuhui Yuichi Yuji Yujie Yuk-Kin Yuka 
  Yuki Yukiko Yukinao Yuklong Yuko Yukun Yul Yulan Yulia Yulian 
  Yuliana Yulianty Yuliy Yumiko Yuming Yun-Ching Yun-Ju Yunan Yunfei 
  Yung Yung-Nan Yung-Song Yung-Yi Yung-Yun Yungkuang Yunhai Yunhui 
  Yunita Yunjian Yunlong Yunn Yunnie Yunpeng Yunqing Yunyan Yunyi 
  Yunyue Yunzhong Yupeng Yuqi Yuqian Yuqiao Yura Yuri Yurina Yurong 
  Yury Yusaku Yusef Yushun Yusuke Yutaka Yuthasak Yutong Yuval Yuwei 
  Yuxiang Yuxin Yuyang Yuzhang Yvan Yves Yvette Yvon Yvonne

  Zacharias Zachariasz Zafiris Zaha Zahari Zahia Zahid Zahoor Zahra 
  Zaid Zaira Zakaria Zakir Zana Zanchao Zandra Zane Zaneta Zare Zarko 
  Zart Zaverchand Zavis Zaza Zbigniev Zbigniew Zbych Zbychu Zbynek 
  Zbyszek Zdena Zdenek Zdenko Zdizislaw Zdravko Zdzi Zdzicho 
  Zdzilslaw Zdzislaw Ze Zee Zeen Zeenat Zeev Zehava Zehra Zejun Zekai 
  Zeke Zekeriya Zeki Zelan Zelie Zelin Zemin Zena Zend Zengke Zengqun 
  Zenon Zergun Zerna Zerrin Zew Zeynel Zeynep Zeyni Zezhu Zhangjie 
  Zhanxue Zhaobin Zhaochen Zhaofeng Zhaohong Zhaohui Zhaokun Zhaolun 
  Zhaorong Zhaoyi Zhazha Zhe Zhecheng Zheheng Zhejun Zhenbo Zhengdong 
  Zhenghai Zhenghua Zhenghui Zhengjiang Zhengjun Zhengrong Zhenguo 
  Zhengwei Zhengyang Zhenhai Zhenhao Zhenhe Zhenhuan Zhenlin Zhenpeng 
  Zhenquan Zhenxin Zhenyi Zhenyue Zhenzhong Zheqi Zhigang Zhiguo 
  Zhihao Zhihua Zhihui Zhijiang Zhijie Zhijun Zhiming Zhiqiang 
  Zhiqing Zhisheng Zhivko Zhiwei Zhiwen Zhixian Zhixiu Zhiyi Zhiying 
  Zhiyong Zhiyu Zhiyun Zhizheng Zhizhou Zhonghua Zhonghuan Zhongkai 
  Zhongquan Zhongsheng Zhongtian Zhongwei Zhongwen Zhongzhao 
  Zhuangyan Zhuodi Zhuoqiang Zhuxiongjie Zi Zi-Ming Zia Zia-Ul Ziao 
  Ziaullah Ziba Zibi Zichao Zichen Zicheng Zie Zifang Ziga Zigfrid 
  Zihan Zihao Zijie Zijun Zila Ziliang Zilla Zilvinas Ziming Zimo Zip 
  Zipi Zipora Zippi Ziqi Ziqian Ziqiao Ziqiu Zirui Zishu Zisu Zita 
  Zitong Ziva Ziwen Zixi Zixuan Ziya Ziyu Zizhuo Zizi Zlata Zlatko 
  Zmagoslav Zoe Zofia Zois Zoltan Zongze Zoraida Zoran Zorana Zorka 
  Zoya Zoé Zsofi Zsofia Zsolt Zsuzsa Zsuzsanna Zuanpei Zubeida 
  Zuhal Zuhra Zumbulka Zuofa Zuqiang Zurab Zuyi Zuzana Zuzanna Zvia 
  Zvika Zvonimir Zvonko Zymantas 

  Åsa Åse 

  Öge Öksel Ömer Önce Önder Öner Ören Özden Özdener Özer Özgür 
  Öztekin 

  Øivind Øyvind 

  Ülgen Ümit Ünal Üzeyir 

  Annoyla Lanzo Laverne Leemor Uxue Yanjun Zviah
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
