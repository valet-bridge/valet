#!perl

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Exporter;

package Event::Cookbook;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  %SINGLETONS
  %ITERATORS

  %FIX_HASH

  $FRONT_REGEX
  $BACK_REGEX
  $PRE_GROUP_REGEX
  $POST_GROUP_REGEX
);

# Singletons are words imply a field and that don't have parameters.
# For example, "EBL" is an ORGANIZER.
#
# Iterators are words/concepts that take parameters.
# For example, "Round" can be "Round 4-5 of 8".

# TODO Unify
my @SINGLETON_LIST = qw(
  TNAME
  SPONSOR
  MEMORIAL
  ORGANIZER
  TOURNAMENT
  MOVEMENT
  STAGE
  ORIGIN
  FORM
  SCORING
  AGE
  GENDER
  COUNTRY
  CITY
  YEAR
  YEAR_MONTH
  MONTH
  MONTH_DAY
  DATE
  WEEKDAY
  TEMPORAL
  COLOR
  ORDINAL
  NUMERAL
  ROMAN
  LETTER
  PARTICLE
  KILL

  MAJOR_MINOR
  N_OF_N
  N_TO_N
  N_TO_N_OF_N
  NL
  NL_OF_N
  NL_TO_N

  EXPANSION
  NATIONALITY

  TNAME
  TITLE_DESTROY
  TWORD
  MEET
  CLUB
  REGION

  ORGANIZATION
  ZONE
  TITLE_SPONSOR
  TITLE_COUNTRY
  TITLE_NATIONALITY
  TITLE_REGION
  TITLE_CITY
  QUARTER
  UNIVERSITY
  TITLE_FORM
  CAPTAIN
  TITLE_GENDER
  TITLE_AGE
  TITLE_SCORING
  PERSON
  ITERATOR
  TITLE_STAGE
  TIME
  TITLE_YEAR
  TITLE_PARTICLE
  AMBIGUOUS
  TITLE_DATE
  TITLE_ROMAN

  TEAM1_AGE TEAM2_AGE
  TEAM1_CAPTAIN TEAM2_CAPTAIN
  TEAM1_COUNTRY TEAM2_COUNTRY
  TEAM1_REGION TEAM2_REGION
  TEAM1_CITY TEAM2_CITY
  TEAM1_GENDER TEAM2_GENDER
  TEAM1_SPONSOR TEAM2_SPONSOR
  TEAM1_ORDINAL TEAM2_ORDINAL
  TEAM1_QUARTER TEAM2_QUARTER
  TEAM1_TWORD TEAM2_TWORD
  Berth BERTH
  Day DAY
  DATE_START DATE_END
  Group GROUP
  Flight FLIGHT
  Half HALF
  Match MATCH
  Quarter
  Phase PHASE
  Round
  Semifinal
  Segment SEGMENT
  Series SERIES
  Session SESSION
  Set SET
  Stage
  Stanza STANZA
  Table TABLE
  TEMPO

  Boards BOARDS
  F G
  J
  O
  Part PART
  Place PLACE
  Q
  Rof ROF
  Room ROOM
  ROUND
  S
  Section SECTION
  TEAM_FORM
  Tempo
  Top
  W
  Week WEEK
  Weekend WEEKEND
  Y
);

our %SINGLETONS = map { $_ => 1 } @SINGLETON_LIST;

my %ITERATORS =
(
  Rof => 'ROUND_OF',
  'Quarter-final' => 'QF',
  'Semi-final' => 'SF',
  Semi => 'PREVENT_THIS',
  Berth => 'PREVENT_THIS',
  Place => 'PREVENT_THIS',
  Top => 'PREVENT_THIS',

  Round => 'ROUND',
  Stanza => 'PREVENT_THIS',
  Session => 'SESSION',
  Segment => 'SEGMENT',
  Section => 'SECTION',
  Set => 'PREVENT_THIS',
  Stage => 'PREVENT_THIS',
  Match => 'PREVENT_THIS',
  Tempo => 'PREVENT_THIS',
  Half => 'PREVENT_THIS',
  Part => 'PREVENT_THIS',
  Quarter => 'PREVENT_THIS',
  Day => 'PREVENT_THIS',

  Group => 'GROUP',
  Table => 'TABLE',
  Room => 'ROOM',
  Boards => 'BOARDS',
  Weekend => 'WEEKEND',
  Week => 'WEEK'
);



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
  },

  ORGANIZER =>
  {
    "Bridge Club Saint Etoile" => [qw(bcsh)],
    "Bridge Base Online" => ["bridgebaseonline"],
    CBAI => [], # Don't map directly to Ireland; could be "Ireland 2"
    EBL => [qw(ebl)]
  },
    
  TOURNAMENT =>
  {
    Championship => [qw(championship's champion champions champion's)],
    Cup => [],
    Trophy => [],
    League => [],
    Olympiad => [qw(olympiads)],
    Open => [qw(libres opain oper op terbuka terbukaerbuka)], # Ambiguous
    Tournament => [qw(tounoi)],
    Trials => [qw(trial selectio selection prueba)],
    'Super League' => [qw(superleague sl)],
    Super => [qw(super sup)],

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

  STAGE =>
  {
    Qualifying => [qw(quailfy qual qualf qualfication quali qualif
      qualification qualifier qualify quallification qualy
      qr qulification prelim preliminary pre pelim
      clasificacion clasificatoria)],

    'Round-robin' => [qw(rrobin roundrobin rr rrr)],

    PreQF => [qw(pqf)],

    'Knock-out' => [qw(ko elimination kostage knockout knockouts
      knock knockouts)],

    Rof12 => [],
    Rof16 => [],
    Rof18 => [],
    Rof32 => [],
    Rof64 => [],
    Rof128 => [],

    Final => [qw(fianl filnal fin finale finales finali ff
      ofinals finals finall finas fnal fnals fina f sinal 
      fýnal final!)],
    "Semi-final" => [qw(semifinal semif semifinals semifinale semifinali
      seminfinal semifinales semis semfin sfinal sfinals sf
      semifianls semýfýnal sefi yf)],
    Semi => [],
    "Quarter-final" => [qw(quarterfinal quafin quarterf quarterfinals 
      qfinal qfinals quaterfinal qf ottavi quarti)],
    Tiebreak => [qw(ot tie)],
    Playoff => [qw(po playoff playoffs)],
    Consolation => [qw(conso)],
    Bronze => [],

    Play => []
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
    MP => [qw(machpoints macthpoints mpoints matchpoint)],
    IMP => [qw(ýmp)],
    BAM => [],
    Patton => []
  },

  AGE =>
  {
    Seniors => [qw(senior seniors seniors seniors' senior*)],
    Juniors => [qw(junior yunior)],
    Youngsters => [qw(yougerters youth young youngster)],
    Schools => [qw(school)],
    Girls => [qw(gir)],
    Kids => [],
    U28 => [],
    U26 => [],
    U25 => [],
    U21 => [],
    U20 => [],
    U16 => []
  },

  GENDER =>
  {
    Men => [qw(mens men's men`s pa)],
    Women => [qw(woman wemen womans women's womens ladies ladies's
      damas pi wo)],
    Mixed => [qw(mix mixte)],
  },

  COUNTRY =>
  {
    Bulgaria => [],
    'Czech Republic' => ['czech'],
    Denmark => [],
    England => [qw(eng)],
    Estonia => [],
    Finland => [],
    France => [qw(fra)],
    Hungary => [],
    Ireland => [qw(ire roi), 'rep of ireland'],
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
    Spring => []
  },

  COLOR =>
  {
    Red => [],
    White => []
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
    '0' => [qw(zero)],
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
    '1' => ['i'],
    '2' => ['ii'],
    '3' => ['iii'],
    '4' => ['iv'],
    '5' => ['v'],
    '6' => ['vi'],
    '7' => ['vii'],
    '8' => ['viii'],
    '9' => ['ix'],
    '10' => ['x'],
    '11' => ['xi', 'xith'],
    '12' => ['xii'],
    '13' => ['xiii'],
    '14' => ['xiv'],
    '15' => ['xv'],
    '16' => ['xvi'],
    '17' => ['xvii'],
    '18' => ['xviii'],
    '19' => ['xix', 'xixth'],
    '20' => ['xx'],
    '21' => ['xxi'],
    '22' => ['xxii'],
    '23' => ['xxiii'],
    '24' => ['xxiv', 'xxivth'],
    '25' => ['xxv', 'xxvth'],
    '26' => ['xxvi'],
    '27' => ['xxvii'],
    '28' => ['xxviii'],
    '29' => ['xxix', 'xxixth'],
    '30' => ['xxx'],
    '31' => ['xxxi'],
    '32' => ['xxxii'],
    '33' => ['xxxiii'],
    '34' => ['xxxiv', 'xxxivth'],
    '35' => ['xxxv', 'xxxvth'],
    '36' => ['xxxvi'],
    '37' => ['xxxvii'],
    '38' => ['xxxviii'],
    '39' => ['xxxix', 'xxxixth'],
    '40' => ['xl', 'xlth'],
    '53' => ['liii']
  },

  PARTICLE =>
  {
    And => [qw(& +)],
    Of => [qw(af off av de olf pf fo from)],
    To => [],
    vs => []
  },

  ITERATOR =>
  {
    Rof => [],

    Berth => [],
    Place => [qw(puesto lugar)],
    Top => [],

    Round => [qw(rounds rouns rueda ruond rd riund rnd rds ound ro
      tound tour runde runder rn rond ronda ronud roudn
      turno turul sr devre)],
    Stanza => [qw(stanza stanzas stranza stsnza stan stanzaq)],
    Session => [qw(serssion sesion sesión sesj sesjon sess
      sessió sessión ses sesje sessie sesson sesssion sessions
      sessão segssion séance séan seans seansi)],
    Segment => [qw(seg segm segement segemt segmant segmen segemnt
      segmento segments segmetn segmnet segnment sgment segt sengemt 
      se eg), 'seg#'],
    Section => [qw(seksjon sektion)],
    Set => [qw(sets)],
    Stage => [],
    Match => [qw(mathc m kamp incontro matxh macth meci matches mo
      maych mecz)],
    Tempo => [],
    Half => [qw(hallf halvleg halv hlf mt ha)],
    Part => [qw(parte)],
    Quarter => [qw(quaerter quater qtr)],
    Day => [],

    Group => [qw(gr grp groups pool)],
    Table => [qw(t ta tb)],
    Room => [qw(rm)],
    Boards => [qw(board brds donnes spil)],
    Weekend => [],
    Week => []
  },

  # These are substitions that are text-only and do not imply a field.
  EXPANSION =>
  {
    'Final Round' => [qw(fr)],
    'Final Segment' => [qw(fs)],
    'Qualifying Segment' => [qw(qs)],
    'Q A' => [qw(qa)],
    'Q B' => [qw(qb)]
  },

  KILL =>
  {
    Kill => [qw(
      vg vmg 
      man pabfc
      daskalakis robinso stern hol
      fluff train tren ch mac ore friendly mandarin
      game rank tpatkawan patkawan tadkov friendship
      am afternoon night soir barriere delayed us
      for int titan silver gold vp sm
      è no n° =), 
      '?', 'one!', 'ab', 'a&b', ']', 'mandarin table']
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
my @PRE_GROUP = (qw(f group qf sf semi t open), @ROMAN);

my $PRE_GROUP_PATTERN = join('|', map { quotemeta } @PRE_GROUP);
our $PRE_GROUP_REGEX = qr/\b($PRE_GROUP_PATTERN)([AB])\b/i;

my @POST_GROUP = qw(rr);

my $POST_GROUP_PATTERN = join('|', map { quotemeta } @POST_GROUP);
our $POST_GROUP_REGEX = qr/^([OW])($POST_GROUP_PATTERN)$/i;

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
