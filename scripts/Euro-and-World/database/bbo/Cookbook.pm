#!perl

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Exporter;

package Cookbook;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  %MERGE_HASH
  $MERGE_REGEX
  %MERGE_LOWER_TO_ORIG_CASE
  %FIX_HASH
  $FRONT_REGEX
  $BACK_REGEX
  $PRE_GROUP_REGEX
  $POST_GROUP_REGEX
);

# This merge gets executed first of all.
# Some words obviously belong together, and if their tokens
# are separated early on, it is harder to keep them together.
# Each substition is tried separately, so it is quite expensive,
# and the merge should really only contain multiple words.

my %MERGE_ALIASES = (

  # TNAME
  Bermudabowl => ["bermuda bowl"],
  Eurochamp => ["eur champ"],
  Fortunacup => ["fortuna cup"],
  FXcup => ["fx sec_ cup"],
  IsrGP => ["israel grand prix"],
  Hungariancup => ["hungarian cup"],
  Kepricup => ["kepri cup"],
  Grocup => ["gro's supercup"],
  Nationscup => ["nations cup"],
  Ruiagold => ["ruia gold", "ruia gols"],
  Ruiasilver => ["ruia silver"],
  Serdikacup => ["serdika cup"],
  Superleague => ["super league", "sup league", "sup l",
    "super leahue", "sup leg"],
  VAKM => ["vest-agder km", "vest - agder"],
  Vitoteams => ["vito teams"],

  # SPONSOR
  FXSec => [qw(fx securities)],
  Jetimmo => ["get immo", "get-immo", "jet immo"],
  LYLaw => [qw(L&Y)],
  "Bridgeclub" => ["briagclub"],

  # MEMORIAL
  Mohansicka => ["mohan sicka"],
  "muratkilercioglu" => ["murat kilercioglu"],

  # ORGANIZER
  EBL => ["e_b_l_"],
  "BridgeBaseOnline" => ["bridge base online"],
  "guangdongbridgeclub" => ["guangdong bridgeclub"],

  # TOURNAMENT: none

  # MOVEMENT
  Roundrobin => ["round robin", "roun robin", "round bobin",
    "round-robin", "r_robin", "r robin", "round roubin", "rrobin",
    "round ronin", "grup maçlari"],

  # ORIGIN
  Interclub => ["inter club", "inter-club", "inter-clubs"],
  Interprovince => ["inter province", "inter-province",
    "inter-provinces", "inter provinces"],
  Interregion => ["inter-region", "inter-regional"],
  Proam => ["pro am"],

  # STAGE
  Final => ["phase finale", "fin als"],
  Semifinal => ["meia final", "meias finais", 
    "semi final", "semi-final", "semi finals", "semi-finals",
    "demi-finale", "demi-finales", "1_2final", "semi <final",
    "yarý final", "simi final"],
  Quarterfinal => ["quarter final", "quarter finals",
    "quarter-final", "quet final", "quartal final",
    "quarti finale", "qtr finals",
    "round of 8"], # Error-prone: "1st Quarter Final" can be either
  PreQF => ["pre qf", "pr qf"],
  PO => ["play-off", "play_off", "play off"],
  Rof128 => ["round of 128"],
  Rof64 => ["round of 64"],
  Rof32 => ["round of 32"],
  Rof18 => ["phase a 18"],
  Rof16 => ["round of 16", "phase a 16"],
  Rof12 => ["phase a 12"],
  Knockout => ["knock out", "knock-out"],
  Tiebreak => ["extra boards", "extra time", "extra stanza", 
    "semifinals extra", "tie break", "tie reak", "tiebreak"],
  "Second half" => ["second ha"],
  Bronze => ["small final"],
  "Session 1" => ["única sesión"],

  # SCORING
  BAM => ["b-a-m"],
  MP => ["matchpoint"],

  # AGE
  U28 => ["under 28"],

  # GENDER

  # COUNTRY, CITY, MONTH, WEEKDAY, ORDINAL, NUMERAL, ROMAN: none
  fifth => ["5 eme"],
  "Open RR" => ["orr"],
  "Women RR" => ["wrr"],
  "First half" => ["1mt", "1emt", "andata"],
    "second half" => ["2mt", "2emt", "ritorno", "retur"],

  # PARTICLE
  "vs ni" => [qw(vni)],
  of => ["out of"],
  "12th" => ["12 th"],
  of5 => ["0f5"], # Typo
  "off" => ["0ff"],
  '()' => ['(\+2)'] # Uninteresting
);


# ----------------------------------------------------------------


# This spell checker is run on the tokens.

our %FIX_ALIASES = 
(
  TNAME => 
  {
    "Australian National Open Teams" => [qw(not)],
    "Australian National Senior Teams" => [qw(nst)],
    "Australian National Women Teams" => [qw(nwt)],
    "Bermuda Bowl" => [qw(bermudabowl bermuda bb)],
    "Canadian National Teams" => [qw(cntc)],
    "D'Orsi Senior Cup" => [qw(dosb sb sc)],
    "European Championship" => [qw(eurochamp)],
    "Fortuna Cup" => [qw(fortunacup)],
    "Geologi Cup" => [qw(geologi)],
    "Israel Grand Prix" => [qw(isrgp)],
    "Gro's Supercup" => [qw(grocup)],
    "Hungarian Cup" => [qw(hungariancup)],
    "Kepri Cup" => [qw(kepricup)],
    "Nations Cup" => [qw(nationscup)],
    "Nordic Championship" => [qw(nm)],
    "Ruia Gold" => [qw(ruiagold)],
    "Ruia Silver" => [qw(ruiasilver)],
    "Ruia Cup" => [qw(ruia)],
    "Serdika Cup" => [qw(serdikacup)],
    "United States Bridge Championship" => ["usbc"],
    "Vanderbilt" => [qw(vandy)],
    "Venice Cup" => [qw(vc venice)], # I hope
    "Vest-Agder Club Championship" => [qw(vakm)],
    "VITO Teams" => [qw(vitoteams)],
    "World Mind Sports Games" => [qw(wmsg mind)],
    "World Transnational Open Teams" => [qw(wtot)],
    "World Transnational Mixed Teams" => [qw(wtmt)]
  },

  SPONSOR =>
  {
    "FX Securities" => [qw(fxsec)],
    "Jet Immo" => [qw(jetimmo)],
    KWS => [],
    Lavazza => [],
    "L&Y Law" => [qw(lylaw)],
    MULTICOMS => [qw(multicoms)],
    Solakoglu => [],
    SportAccord => [qw(sportaccord)],
    Vito => [],
  },

  MEMORIAL =>
  {
    "Maharaja Holkar" => [qw(holkar)],
    "Mohan Sicka" => [qw(mohansicka)],
    "Murat Kilercioglu" => [qw(muratkilercioglu)],
    "P.C. Kalani" => [qw(kalani)]
  },

  ORGANIZER =>
  {
    "Bridge Club Saint Etoile" => [qw(bcsh)],
    "Bridge Base Online" => ["bridgebaseonline"],
    CBAI => [], # Don't map directly to Ireland; could be "Ireland 2"
    EBL => [qw(ebl)],
    "Guangdong Bridge Club" => [qw(guangdongbridgeclub)]
  },
    
  TOURNAMENT =>
  {
    Champion => [qw(champions champion's)],
    Championship => [qw(championship's)],
    Cup => [],
    Trophy => [],
    League => [],
    Olympiad => [qw(olympiads)],
    Open => [qw(open o libres opain oper op
      terbuka terbukaerbuka)], # Ambiguous
    Tournament => [qw(tounoi)],
    Trials => [qw(trial selectio selection prueba)],
    Super => [qw(sup)],
    Welcome => []
  },

  MOVEMENT =>
  {
    Barometer => [],
    Danish => [],
    Goulash => [],
    Monrad => [],
    Swiss => [qw(sw swis suisse)],
    Triangle => []
  },

  ORIGIN =>
  {
    World => [qw(mondial)],
    Province => [qw(interprovince)],
    Region => [qw(interregion)],
    City => [qw(intercity)],
    Club => [qw(interclub)],
    University => [qw(university univ)],
    Transnational => [qw(transnation trans transnatio transnat tn)],
    Invitational => [],
    Proam => [],
  },

  FORM =>
  {
    Teams => [qw(team equipos team's lag teamd terms tm)],
    Pairs => [qw(pair paýrs psirs parejas)],
    Individual => [qw(ind indiv indivual)]
  },

  SCORING =>
  {
    MP => [qw(machpoints macthpoints mpoints)],
    IMP => [qw(ýmp)],
    BAM => [],
    Patton => []
  },

  ITERATOR =>
  {
    Final => [qw(fianl filnal fin finale finales finali ff
      ofinals finals finall finas fnal fnals fina f sinal 
      fýnal final!)],
    "Semi-final" => [qw(semifinal semif semifinals semifinale semifinali
      seminfinal semifinales semis semfin sfinal sfinals sf
      semifianls semýfýnal sefi yf)],
    Semi => [],
    "Quarter-final" => [qw(quarterfinal quafin quarterf quarterfinals 
      qfinal qfinals quaterfinal qf ottavi quarti)],
    Playoff => [qw(po playoff playoffs)],
    "Knock-out" => [qw(ko elimination kostage knockout knockouts)],
    Tiebreak => [qw(ot)],
    Consolation => [qw(conso)],
    Bronze => [],
    Berth => [],
    "Final Round" => [qw(fr)],
    "Final Segment" => [qw(fs)],
    "Qualifying Segment" => [qw(qs)],
    "Round-robin" => [qw(rrobin roundrobin rr)],
    "Super League" => [qw(superleague sl)],

    Qualifying => [qw(quailfy qual qualf qualfication quali qualif
      qualification qualifier qualify quallification qualy
      qr qulification prelim preliminary pre pelim
      clasificacion clasificatoria)],
    Knockout => [qw(knock knockouts)],
    Qletter => [qw(q)],

    PreQF => [qw(pqf)],

    Round => [qw(rounds rouns rueda ruond rd riund rnd rds ound ro
      tound tour runde runder rn r rond ronda ronud roudn
      turno turul sr)],
    Stanza => [qw(stanza stanzas stranza)],
    Session => [qw(serssion sesion sesión sesj sesjon sess
      sessió sessión ses sesje sessie sesson sesssion sessions
      sessão devre segssion séance séan seans seansi)],
    Stage => [],
    Section => [qw(seksjon sektion)],
    Match => [qw(mathc m kamp incontro matxh macth meci matches mo
      maych mecz)],
    Segment => [qw(seg segm segement segemt segmant segmen segemnt
      segmento segments segmetn segmnet segnment sgment segt sengemt 
      se eg),
      'seg#'],
    Set => [qw(sets)],
    Tempo => [],
    Half => [qw(hallf halvleg halv hlf mt)],
    Part => [qw(parte)],
    Quarter => [qw(quaerter quater qtr)],
    Place => [qw(puesto lugar)],
    Top => [],
    Play => [],
    Day => [],

    Rof => [],
    Rof12 => [],
    Rof16 => [],
    Rof18 => [],
    Rof32 => [],
    Rof64 => [],
    Rof128 => []
  },

  AGE =>
  {
    Seniors => [qw(senior seniors seniors seniors' senior*)],
    Juniors => [qw(junior yunior)],
    Youngsters => [qw(yougerters youth young youngster)],
    Schools => [qw(school)],
    Girls => [qw(gir)],
    Kids => []
  },

  GENDER =>
  {
    Men => [qw(mens men's men`s pa)],
    Women => [qw(woman wemen womans women's womens ladies ladies's
      damas pi wo)],
    Mixed => [qw(mix mixte)],
  },

  GROUP =>
  {
    Group => [qw(gr groups pool)],
  },

  COLOR =>
  {
    Red => [],
    White => []
  },

  TABLE =>
  {
    Table => [qw(t)],
    Room => [qw(rm)]
  },

  BOARDS =>
  {
    Boards => [qw(board brds donnes spil)],
  },

  COUNTRY =>
  {
    Bulgaria => [],
    'Czech Republic' => [],
    England => [qw(eng)],
    Finland => [],
    France => [qw(fra)],
    Hungary => [],
    Ireland => [qw(roi), 'rep of ireland'],
    Israel => [],
    Italy => [],
    Latvia => [],
    Malta => [],
    Monaco => [],
    Netherlands => [qw(netherland)],
    Norway => [qw(nor)],
    "Northern Ireland" => [qw(ni), 'n ireland'],
    Pakistan => [],
    Scotland => [qw(sco)],
    Turkey => [qw(tur)],
    USA => [],
    Wales => [qw(wal)]
  },

  CITY =>
  {
    Ballymena => [],
    Beijing => [],
    Deauville => [],
    Izmir => [qw(izmýr ýzmir)],
    Kepri => [],
    Kolkata => [qw(kol)],
    Pau => [],
    Radkov => [],
    Vancouver => [],
    Zurich => []
  },

  YEAR =>
  {
  },

  MONTH =>
  {
    January => [qw(jan)],
    February => [qw(feb)],
    March => [qw(mar)],
    April => [qw(apr)],
    May => [],
    June => [qw(jun juin)],
    July => [qw(jul)],
    August => [qw(aug)],
    September => [qw(sept sep)],
    October => [qw(oct)],
    November => [qw(nov)],
    December => [qw(dec)]
  },

  DATE =>
  {
  },

  WEEKDAY =>
  {
    Monday => [qw(mon)],
    Tuesday => [qw(tue)],
    Wednesday => [qw(wed)],
    Thursday => [qw(thu)],
    Friday => [qw(fri freitag)],
    Saturday => [qw(sat samstag)],
    Sunday => [qw(sun sonntag)]
  },

  TEMPORAL =>
  {
    Spring => [],
    Weekend => [],
    Week => []
  },

  ORDINAL =>
  {
    first => [qw(1rst 1er primera fir)],
    second => [qw(segundo segunda sec)],
    third => [qw(tercer)],
    fourth => [qw(4rth)],
    fifth => [],
    sixth => [],
    seventh => [],
    eighth => [],
    last => [qw(lats ultimo)]
  },

  NUMERAL =>
  {
    '1' => [qw(one !)],
    '2' => [qw(two)],
    '3' => [qw(three)],
    '4' => [qw(four)],
    '5' => [qw(five)],
    '6' => [qw(six)],
    '7' => [qw(seven)],
    '8' => [qw(eight)]
  },

  ROMAN =>
  {
    '1' => [qw(i)],
    '2' => [qw(ii)],
    '3' => [qw(iii)],
    '4' => [qw(iv)],
    '5' => [qw(v)],
    '6' => [qw(vi)],
    '7' => [qw(vii)],
    '8' => [qw(viii)],
    '9' => [qw(ix)],
    '10' => [qw(x)],
    '11' => [qw(xi)],
    '12' => [qw(xii)]
  },

  PARTICLE =>
  {
    And => [qw(& +)],
    Of => [qw(af off av de olf pf fo from)],
    To => [],
  },

  KILL =>
  {
    Kill => [qw(untitled
      bbo bbvg bbovg vg vmg bridge
      man mandarin pabfc
      daskalakis robinso stern hol
      fluff reloaded missed this train tren ch mac ore oam le friendly
      game series npc rank tpatkawan patkawan phase tadkov friendship
      am afternoon night soir barriere best delayed us
      combined for only alle int titan silver gold vp sm
      è no n° vs =), 
      '#', '?', 'one!', 'ab', 'a&b', ']']
  }
);

my @PEEL_FRONT = qw(teams match maych rr segment
  semifinal stanza swiss vs juniors);

my @PEEL_BACK = qw(pairs team teams match round rounds rnd rr 
  segment session sessão stanza tempo final semi);

my $FRONT_PATTERN = join('|', map { quotemeta } @PEEL_FRONT);
our $FRONT_REGEX = qr/^($FRONT_PATTERN)(.+)$/i;

my $BACK_PATTERN = join('|', map { quotemeta } @PEEL_BACK);
our $BACK_REGEX = qr/^(.+)($BACK_PATTERN)$/i;

my @ROMAN = qw(i ii iii iv v vi vii viii ix x xi xii);
my @PRE_GROUP = (qw(f group q qf sf semi t), @ROMAN);

my $PRE_GROUP_PATTERN = join('|', map { quotemeta } @PRE_GROUP);
our $PRE_GROUP_REGEX = qr/^($PRE_GROUP_PATTERN)([AB])$/i;

my @POST_GROUP = qw(rr);

my $POST_GROUP_PATTERN = join('|', map { quotemeta } @POST_GROUP);
our $POST_GROUP_REGEX = qr/^([OW])($POST_GROUP_PATTERN)$/i;

our %MERGE_HASH;
for my $key (keys %MERGE_ALIASES)
{
  for my $alias (@{$MERGE_ALIASES{$key}})
  {
    $MERGE_HASH{lc($alias)} = $key;
  }
}

my $MERGE_PATTERN = join('|', map { quotemeta } keys %MERGE_HASH);
our $MERGE_REGEX = qr/\b($MERGE_PATTERN)\b/i;

our %FIX_HASH;
for my $category (keys %FIX_ALIASES)
{
  for my $value (keys %{$FIX_ALIASES{$category}})
  {
    $FIX_HASH{lc($value)} = { CATEGORY => $category, VALUE => $value }
      unless $category eq 'ROMAN';

    for my $fix (@{$FIX_ALIASES{$category}{$value}})
    {
      $FIX_HASH{$fix} = { CATEGORY => $category, VALUE => $value };
    }
  }
}

1;
