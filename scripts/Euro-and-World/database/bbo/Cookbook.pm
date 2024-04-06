#!perl

use strict;
use warnings;
use utf8;
use open ':std', ':encoding(UTF-8)';
use Exporter;

package Cookbook;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  %SINGLETONS
  %ITERATORS
  %AMBIGUITIES

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
  MONTH
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
    'Guangdong Bridge Club' => [qw(guangdongbridgeclub)]
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

    'Round-robin' => [qw(rrobin roundrobin rr)],

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
    Kids => []
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
    'Czech Republic' => [],
    England => [qw(eng)],
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
    vs => []
  },

  ITERATOR =>
  {
    Rof => [],

    "Quarter-final" => [qw(quarterfinal quafin quarterf quarterfinals 
      qfinal qfinals quaterfinal qf ottavi quarti)],
    "Semi-final" => [qw(semifinal semif semifinals semifinale semifinali
      seminfinal semifinales semis semfin sfinal sfinals sf
      semifianls semýfýnal sefi yf)],
    Semi => [],
    Berth => [],
    Place => [qw(puesto lugar)],
    Top => [],

    Round => [qw(rounds rouns rueda ruond rd riund rnd rds ound ro
      tound tour runde runder rn rond ronda ronud roudn
      turno turul sr)],
    Stanza => [qw(stanza stanzas stranza stsnza stan)],
    Session => [qw(serssion sesion sesión sesj sesjon sess
      sessió sessión ses sesje sessie sesson sesssion sessions
      sessão devre segssion séance séan seans seansi)],
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
    Table => [qw(t)],
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
      untitled bbo bbvg bbovg vg vmg bridge dup man mandarin pabfc
      daskalakis robinso stern hol
      fluff reloaded missed this train tren ch mac ore oam le friendly
      game series npc rank tpatkawan patkawan phase tadkov friendship
      am afternoon night soir barriere best delayed us
      combined for only alle int titan silver gold vp sm
      è no n° =), 
      '#', '?', 'one!', 'ab', 'a&b', ']']
  }
);

my %AMBIGUITIES =
(
  '1_2' => [ 
    ['ITERATOR', 'BASE', 'NUMERAL', 1, 'OF', 'NUMERAL', 2],
    ['ITERATOR', 'FIELD', 'Semi'] ],
  '1_4' => [ 
    ['ITERATOR', 'BASE', 'NUMERAL', 1, 'OF', 'NUMERAL', 4],
    ['ITERATOR', 'FIELD', 'Quarter'] ],
  'f' => [
    ['SINGLETON', 'LETTER', 'F'],
    ['ITERATOR', 'FIELD', 'Final'] ],
  'g' => [
    ['SINGLETON', 'LETTER', 'G'],
    ['SINGLETON', 'GENDER', 'Girls', 'SINGLETON', 'AGE', 'U26'],
    ['ITERATOR', 'FIELD', 'Group'] ],
  'j' => [
    ['SINGLETON', 'LETTER', 'J'],
    ['SINGLETON', 'AGE', 'U26'] ],
  'm' => [
    ['SINGLETON', 'LETTER', 'M'],
    ['SINGLETON', 'GENDER', 'Men'],
    ['ITERATOR', 'FIELD', 'Match'] ],
  'o' => [
    ['SINGLETON', 'LETTER', 'O'],
    ['SINGLETON', 'GENDER', 'Open'],
    ['SINGLETON', 'AGE', 'Open'],
    ['SINGLETON', 'GENDER', 'Open', 'SINGLETON', 'AGE', 'Open'] ],
  's' => [
    ['SINGLETON', 'LETTER', 'S'],
    ['SINGLETON', 'AGE', 'Seniors'],
    ['ITERATOR', 'FIELD', 'Segment'],
    ['ITERATOR', 'FIELD', 'Semi'] ],
  't' => [
    ['SINGLETON', 'LETTER', 'T'],
    ['ITERATOR', 'FIELD', 'Table'] ],
  'q' => [
    ['SINGLETON', 'LETTER', 'Q'],
    ['ITERATOR', 'FIELD', 'Quarter'],
    ['ITERATOR', 'FIELD', 'Qualifying'] ],
  'v' => [
    ['SINGLETON', 'ROMAN', 5],
    ['SINGLETON', 'LETTER', 'V'],
    ['SINGLETON', 'PARTICLE', 'vs'] ],
  'w' => [
    ['SINGLETON', 'LETTER', 'W'],
    ['SINGLETON', 'GENDER', 'Women'] ],
  'open' => [
    ['SINGLETON', 'GENDER', 'Open'],
    ['SINGLETON', 'AGE', 'Open'],
    ['SINGLETON', 'GENDER', 'Open', 'SINGLETON', 'AGE', 'Open'] ],
  'swiss' => [
    ['SINGLETON', 'MOVEMENT', 'Swiss'],
    ['SINGLETON', 'COUNTRY', 'Switzerland'] ],
  'danish' => [
    ['SINGLETON', 'MOVEMENT', 'Danish'],
    ['SINGLETON', 'COUNTRY', 'Denmark'] ]
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
our $PRE_GROUP_REGEX = qr/^($PRE_GROUP_PATTERN)([AB])$/i;

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
