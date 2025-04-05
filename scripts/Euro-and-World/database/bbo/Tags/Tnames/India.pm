#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::India;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'All India Bangur Cement Hindusthan Club',
  'All India Corporate Invitational Pairs',
  'All India HCL Pairs',
  'All India HCL Teams',
  'All India Open Pairs',
  'All India Shree Cement',
  'All India UTI Bank Masters Championship',
  "Ahmedabad President's Cup",
  'Amla Ruia Women Pairs',
  'Anoop Dhawan Invitational Pairs',
  'Ashok Kapur Memorial Swiss Pairs',
  'B L Rao Memorial Open',
  'Bhabha Atomic Research Centre Open',
  'Dainik Navjyoti All India Inter-State',
  'Delhi Gymkhana Club Dhampur Trophy',
  'Delhi Gymkhana Club Open Pairs',
  'Delhi Gymkhana Club Open Teams',
  'Fenesta Open Pairs',
  'Fenesta Women Pairs',
  'Ganesha Open Teams',
  'Godfrey Phillips All India Open',
  'HCL Pro-Am Pairs',
  'Hindusthan Club Teams',
  'Indian Gold Open Pairs',
  'Indian Gold Open Teams',
  'Indian Gold Women Pairs',
  'Indian Inter-State Teams',
  'Indian Masters Invitational Pairs',
  'Indian Masters Open Teams',
  'Indian Men Trials',
  'Indian Mixed Pairs',
  'Indian Mixed Trials',
  'Indian Open Trials',
  'Indian Senior Pair Trials',
  'Indian Senior Trials',
  'Indian Silver Open Teams',
  'Indian State Championship',
  'Indian Western Zone Championship',
  'Indian Women Trials',
  'Jaya Jain Memorial',
  'JHIC Silver Jubilee Open Teams',
  'Justice J M Lal All India Open Pairs',
  'Justice J M Lal All India Open Teams',
  'Kabra Open IMP Pairs',
  'Kabra Women IMP Pairs',
  'Kalani Trophy',
  'Karnataka State Teams',
  'Karnik-Vaidya Open',
  'Kr. Murli Manohar National Masters',
  'Krishnapatnam Port National Masters',
  'L C Sunil Rajendra Memorial',
  'Lalit Mohanka Memorial',
  'Lokmanya Jubilee',
  'Madras Gymkhana Club Open',
  'Maharaja Yeshwantrao Holkar National Pairs',
  'Maharaja Yeshwantrao Holkar National Teams',
  'Maharashtra State Pairs',
  'Maharashtra State Teams',
  'Mall of the Millenium Pairs Cup',
  'Mavericks Premier League',
  'Mohan Sicka BAM Teams',
  'Mohan Sicka Pairs',
  'Mohanlal Bhartia Memorial Grand Prix',
  'Mohanlal Bhartia Memorial Pairs',
  'Nandu Oke Memorial IAF Swiss Pairs',
  'Narain Bhojwani Memorial',
  'Otters Inter-Club Teams',
  'P Singhania All India Open Pairs',
  'PSN Sarma Centenary Memorial Pairs',
  'PSN Sarma Centenary Memorial Teams',
  'PYC Hindu Gymkhana Royale',
  'Phoenix Mixed Pairs',
  'Poddar National Masters',
  'Prashant Desai Memorial',
  'Pune State Level Open Teams',
  'R N Bagla Memorial Pairs',
  'R R Gupta Memorial Championship',
  'R Ratnam Memorial',
  'Rai Bahadur Modi Memorial All India Open',
  'Rajasthan Invitational Pairs',
  'Rajasthan Invitational Teams',
  'Ruia Gold Cup',
  'Ruia Silver Cup',
  'Shree Keni Trophy',
  'Shree Cement Corporate Invitational Teams',
  'Smt. Vijya Jajoo Mixed Pairs',
  'Summer Monsoon League',
  'TATA Open',
  'Thane Champion of Champions Teams',
  'Tolani Gold Trophy',
  'Tolani Grand Prix',
  'Tolani Silver Cup',
  'Uttar Pradesh State Pairs',
  'Uttar Pradesh State Teams',
  'West Bengal Open Team Trials',
  'West Bengal Open Teams',
  'Willingdon Sports Club Swiss Pairs',
  'WCG Open'
);

my %MULTI_TYPOS =
(
  'All India Bangur Cement Hindusthan Club' => [
    'bangur cement hindusthan club'],
  'All India Corporate Invitational Pairs' => [
    'all india corporate invitational',
    'all india invitational corporate',
    'corporate pairs',
    'corporate invitational pairs'],
  'All India Shree Cement' => [
    'all india shri cement',
    'shree cement all india bridge championship',
    'shree cement championships'],
  'All India UTI Bank Masters Championship' => [
    'ull aindia uti bank masters championship',
    'all india uti national masters championship',
    'all india utibank masters championship'],
  'Amla Ruia Women Pairs' => [
    'amla ladies pairs'],
  'Ashok Kapur Memorial Swiss Pairs' => [
    'ashok kapoor memorial swiss pairs',
    'ashok kapoor memorial  swiss pairs',
    'ashok kapur memorial',
    'ashok kapur memorial sw2iss pairs',
    'ashok kapur memorial swiis pairs',
    'ashok kapur memorial swiss imp pairs',
    'ashok kapur memorial  annual all india pairs',
    'ashok kapur memrial swiss pairs',
    'ashok kapur memrial  swiss pairs'],
  'B L Rao Memorial Open' => [
    'b_l_rao memorial open',
    'open b_l_rao memorial',
    'open b_r_rao  memorial'], 
  'Bhabha Atomic Research Centre Open' => ['barc open'],
  'Dainik Navjyoti All India Inter-State' => [
    'Dainik Navjyoti All India Interstate',
    'Dainik Navjyoti All India Inter -State'],
  'Delhi Gymkhana Club Dhampur Trophy' => [
    'dgc india open dhampur trophy'],
  'Delhi Gymkhana Club Open Pairs' => [
    'delhi gymkhana open pairs'],
  'Delhi Gymkhana Club Open Teams' => [
    'delhi gymkhana centenary celebrations',
    'delhi gymkhana championship',
    'delhi gymkhana club centenary',
    'delhi gymkhana club centenary celebrations',
    'delhi gymkhana club championship',
    'delhi gymkhana club open',
    'delhi gymkhana club open championship',
    'delhi gymkhana club india open bridge tournament',
    'delhi gymkhana open',
    'delhi gymkhana open championship',
    'delhi gymkhana open chmpionship',
    'delhi gymkhana open tournament',
    'dgc annual open championship',
    'dgc centenary celebrations',
    'dgc centenary tournament',
    'dgc open annual championship',
    'dgc open championship'],
  'Fenesta Women Pairs' => [
    'fenesta ladies pair'],
  'Ganesha Open Teams' => [
    'ganesha bridge open tournament'],
  'HCL Pro-Am Pairs' => [
    'hcl pro am pairs'],
  'Indian Men Trials' => [
    'indian men national camp',
    'indian men qualification camp'],
  'Indian Mixed Trials' => [
    'indian mixed national camp',
    'indian mixed national qualification camp'],
  'Indian Open Trials' => [
    'india open selection trials',
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
    'indian senior team selection trial',
    'indian senior team selection triaals',
    'indian senior team selection trials',
    'indian senior teams selection',
    'indian senior teams selection trial',
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
  'Indian Women Trials' => [
    'indian women national camp'],
  'Jaya Jain Memorial' => ['mrs_ jaya jain memorial'],
  'JHIC Silver Jubilee Open Teams' => [
    'jhic silver jub',
    'jhic silver jubilee',
    'jhic silver jubilee tourney'],
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
  'Kabra Open IMP Pairs' => [
    'kabra national pairs'],
  'Kabra Women IMP Pairs' => [
    "kabra women' imp pairs"],
  'Kalani Trophy' => ['kalani bridge championship', 'kalani trohy',
    'kalani bridge champioship'],
  'Karnataka State Teams' => [
    'ksba golden jubily'],
  'Karnik-Vaidya Open' => [
    'karnik vaidya open',
    'karnik-vaidya annual'],
  'Kr. Murli Manohar National Masters' => [
    'kr murli manohar national masters',
    'kr_ murli manohar national master',
    'kr_ murli manohar national masters'],
  'L C Sunil Rajendra Memorial' => ['l_c_sunil rajendra memorial'],
  'Lalit Mohanka Memorial' => [
    'lalit mohanka memorials'],
  'Lokmanya Jubilee' => [
    'lokmanya ss silver jubilee',
    'lokmanya ss siver jubliee', 
    'lokmanya golden jubilee'],
  'Madras Gymkhana Club Open' => [
    'madras gymkhana open',
    'mgc open',
    'iob madras gymkhana club championship',
    'iob madras gymkhana open',
    'iob maras gymkhana open'],
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
  'Mall of the Millenium Pairs Cup' => [
    'mall of the millenium cup'],
  'Mohan Sicka BAM Teams' => [
    'mohan sicka',
    'mohan sicka bam',
    'mohan sicka trophy'],
  'Mohan Sicka Pairs' => [
    'sickka pairs'],
  'Mohanlal Bhartia Memorial Grand Prix' => [
    'bhartia memorial gran prix',
    'bhartia memorial grand prix',
    'mohanlal bharatia grand prix',
    'mohanlal bharatia memorial grand prix',
    'mohanlal bharatiya memorial gran prix',
    'mohanlal bharia memorial',
    'mohanlal bharia memorial grand prix',
    'mohanlal bhartia grand prix',
    'mohanlal bhartia memorial bridge tournament',
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
  'Nandu Oke Memorial IAF Swiss Pairs' => [
    'nandu oke memorial',
    'nandu oke memorial swiss pairs',
    'nandu oke memorial swiis pairs'],
  'Narain Bhojwani Memorial' => [
    "otter's cup open",
    "otter's club open",
    'Narayan bhojwani cup',
    'narayan bhojwani cup teams',
    'n_ bhojwani cup'],
  'Otters Inter-Club Teams' => [
    'otters club open',
    'otters interclub championship'],
  'P Singhania All India Open Pairs' => [
    'all india sir p singhania memorial',
    'all india sir padmapat singhania memorial bridge',
    'all india sps memorial bridge tournament',
    'dr singhania swiss pairs'],
  'PYC Hindu Gymkhana Royale' => ['pyc royale'],
  'Phoenix Mixed Pairs' => [
    'phonix mixed pairs'],
  'Poddar National Masters' => [
    'poddar national master',
    'poddar nationals masters', 
    'podder national masters',
    'podder nationals masters'],
  'Pune State Level Open Teams' => [
    'prba open state level',
    'prba statelevel',
    'prba state level open',
    'prba state level'],
  'R N Bagla Memorial Pairs' => [
    'bagla pairs royale',
    'r_n_bagla memorial pairs royale',
    'r_n_bagla pairs royale',
    'r_nbagla pairs royale',
    'rn bagla menorial pairs'],
  'R R Gupta Memorial Championship' => [
    'r r gupta memorial bridge tournament'],
  'R Ratnam Memorial' => ['r ratnam memoral championship'],
  'Rai Bahadur Modi Memorial All India Open' => [
    'rai bahadur modi memorial',
    'rai bahadur memorial'],
  'Ruia Gold Cup' => [
    'golden jubilee',
    'ruia gold',
    'ruia gold trophy',
    'ruia gols',
    'ruia trophy'],
  'Ruia Silver Cup' => ['ruia silver'],
  'Shree Cement Corporate Invitational Teams' => [
    'shree cement corporate invitation tournament'],
  'Shree Keni Trophy' => [
    'keni memorial trophy',
    'keni memorial  trophy', 
    'mkeni trophy',
    'mkeni  trophy', 
    'm keni trophy', 
    'm keni  trophy', 
    'm keny trophy'],
  'Smt. Vijya Jajoo Mixed Pairs' => [
    'smt_ vijya jajoo mixed pairs'],
  'Summer Monsoon League' => [
    'samadhan summer league',
    'samadhan bridge league',
    'summer monsoon',
    'summer monsoon leahue'],
  'TATA Open' => [
    'tata opren', 
    'tata sports', 
    'tcs teams championship',
    'ttat open'],
  'Thane Champion of Champions Teams' => [
    'tdba champion of champions',
    'thane bridge annual'],
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
  'WCG Open' => [
    'videocon wcg Open',
    'videcon wcg open',
    'wcg annual'],
  'West Bengal Open Team Trials' => [
    'west bengal interstate selection trial'],
  'Willingdon Sports Club Swiss Pairs' => [
    'wellingdon swiss pairs',
    'willingdon all india open swiss imp pairs',
    'willingdon club swiss imp pairs',
    'willingdon club swiss pairs',
    'willingdon sports club annual swiss pairs',
    'willingdon sports club mumbai swiss imp pairs',
    'willingdon sports club open swiss pairs',
    'willingdon sports club open',
    'willingdon sports club  open',
    'willingdon sports club  open swiss pairs',
    'willingdon sports club  swiss pairs',
    'willingdon swiss pairs',
    'wsc open swiss pairs championship',
    'wsc open swisspairs championship',
    'wsc swiss open pairs'],
);

my %SINGLE_TYPOS =
(
  'Kalani Trophy' => ['kalani'],
  'Ruia Gold Cup' => ['ruia'],
  'Tolani Grand Prix' => ['tolanigrandprix']
);

sub set_hash
{
  my ($gmulti_words, $gmulti_typos, $gsingle_typos) = @_;

  push @$gmulti_words, @MULTI_WORDS;

  while (my ($key, $value) = each %MULTI_TYPOS)
  {
    @{$gmulti_typos->{$key}} = @$value;
  }

  while (my ($key, $value) = each %SINGLE_TYPOS)
  {
    @{$gsingle_typos->{$key}} = @$value;
  }
}

1;
