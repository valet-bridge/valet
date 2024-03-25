#!perl

use strict;
use warnings;
use Exporter;

package Cookbook;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  %MERGE_HASH
  %FIX_HASH
);

# This merge gets executed first of all.
# Some words obviously belong together, and if their tokens
# are separated early on, it is harder to keep them together.
# Each substition is tried separately, so it is quite expensive,
# and the merge should really only contain multiple words.

my %MERGE_ALIASES = (

  # MONIKER
  Eurochamp => ["eur champ"],
  Superleague => ["super league", "sup league"],
  Bermudabowl => ["bermuda bowl"],
  Venicecup => ["venice cup"],
  Nationscup => ["nations cup"],
  Hungariancup => ["hungarian cup"],
  Fortunacup => ["fortuna cup"],
  Kepricup => ["kepri cup"],
  FXcup => ["fx sec_ cup"],
  Serdicacup => ["serdika cup"],
  Grocup => ["gro's supercup"],
  Ruiagold => ["ruia gold", "ruia gols"],
  Ruiasilver => ["ruia silver"],
  Muratkilercioglu => ["murat kilercioglu"],
  Grandprix => ["grand prix"],
  Kalanitrophy => ["kalani trophy"],
  Vitoteams => ["vito teams"],

  # SPONSOR
  GetImmo => ["get immo", "get-immo"],

  # MEMORIAL
  Mohansicka => ["mohan sicka"],

  # ORGANIZER
  EBL => ["E_B_L_"],

  # TOURNAMENT: none

  # MOVEMENT
  Roundrobin => ["round robin", "roun robin", "round bobin",
    "round-robin", "r_robin", "r robin", "round roubin"],

  # ORIGIN
  Interclub => ["inter club", "inter-club", "inter-clubs"],
  Interprovince => ["inter province", "inter-province",
    "inter-provinces", "inter provinces"],
  Interregion => ["inter region", "inter-region", "inter-regional"],
  Intercity => ["inter-city", "inter city"],

  # STAGE
  Final => ["phase finale"],
  Semifinal => ["meia final", "meias finais", 
    "semi final", "semi-final", "semi finals", "semi-finals",
    "demi-finale", "demi-finales", "1_2final", "semi <final"],
  Quarterfinal => ["quarter final", "quarter finals",
    "quarter-final", "quet final", "quartal final", "1_4final",
    "round of 8"], # Error-prone: "1st Quarter Final" can be either
  PO => ["play-off", "play off"],
  Rof128 => ["round of 128"],
  Rof64 => ["round of 64"],
  Rof32 => ["round of 32"],
  Rof18 => ["phase a 18"],
  Rof16 => ["round of 16", "phase a 16"],
  Rof12 => ["phase a 12"],
  Knockout => ["knock out", "knock-out"],
  Tiebreak => ["extra boards", "extra time", "extra stanza", 
    "semifinals extra"],

  # SCORING
  BAM => ["b-a-m", "b-a-m-"],

  # NAMED_TEAM
  Goancurry => ["goan curry"],
  Stonecutters => ["stone cutters"],
  Vestagder => ["vest-agder", "vest - agder"],
  Heimdal => ["heimdal bk"],

  # AGE
  "U20" => ["u 20"],
  "U21" => ["under 21"],
  "U25" => ["u 25"],
  "U28" => ["under 28"],

  # GENDER

  # COUNTRY, CITY, MONTH, WEEKDAY, ORDINAL, NUMERAL, ROMAN: none

  # PARTICLE
  of => ["out of"]
);


# ----------------------------------------------------------------


# This spell checker is run on the tokens.

our %FIX_ALIASES = 
(
  MONIKER => 
  {
    "Bermuda Bowl" => [qw(bermudabowl bermuda bb)],
    "D'Orsi Cup" => [qw(dosb)],
    "European" => [qw(eurochamp)],
    "Fortuna Cup" => [qw(fortunacup)],
    "FX Securities Cup" => [qw(fxcup)],
    "Grand Prix" => [qw[(grandprix)]],
    "Gro's Supercup" => [qw(grocup)],
    "Hungarian Cup" => [qw(hungariancup)],
    "Kalani Trophy" => [qw(kalanitrophy)],
    "Kepri Cup" => [qw(kepricup)],
    "Murat Kilercioglu" => [qw(muratkilercioglu)],
    "Nations Cup" => [qw(nationscup)],
    "National Open Teams" => [qw(not)],
    "Ruia Gold" => [qw(ruiagold)],
    "Ruia Silver" => [qw(ruiasilver)],
    "Serdica Cup" => [qw(serdicacup)],
    "Super League" => [qw(superleague)],
    "Venice Cup" => [qw(venicecup vc venice)], # I hope
    "VITO Teams" => [qw(vitoteams)]
  },

  SPONSOR =>
  {
    "Get Immo" => [qw(getimmo)],
    MULTICOMS => [qw(multicoms)],
    SportAccord => [qw(sportaccord)]
  },

  MEMORIAL =>
  {
    "Mohan Sicka" => [qw(mohansicka)]
  },

  ORGANIZER =>
  {
  },
    
  TOURNAMENT =>
  {
    Champion => [qw(champions champion's)],
    Championship => [qw(championship's)],
    League => [qw(leahue)],
    Olympiad => [qw(olympiads)],
    Open => [qw(open o libres opain oper ope op)], # Ambiguous
    Tournament => [qw(tournoi tounoi)],
    Trials => [qw(trial selectio selection)]
  },

  MOVEMENT =>
  {
    Barometer => [],
    Danish => [],
    Monrad => [],
    Patton => [],
    "Round robin" => [qw(roundrobin)],
    Swiss => [qw(sw swis suisse)]
  },

  ORIGIN =>
  {
    Province => [qw(interprovince)],
    Region => [qw(interregion)],
    City => [qw(intercity)],
    Club => [qw(interclub)],
    University => [qw(university univ)],
    Transnational => [qw(transnational transnation trans 
      transnatio transnat)]
  },

  STAGE =>
  {
    Qualifying => [qw(quailfy qual qualf qualfication quali qualif
      qualification qualifier qualify quallification qualy
      qr qulification prelim preliminary pre pelim
      clasificacion clasificatoria)],
    Knockout => ["knockouts"],
    Tiebreak => ["tie", "ot"]
  },

  FORM =>
  {
    Teams => [qw(team equipos team's lag teamd terms)],
    Pairs => [qw(pair paýrs psirs parejas)],
    Individual => [qw(ind indiv indivual)]
  },

  ITERATOR =>
  {
    Final => [qw(fianl filnal fin finais finale finales finali 
      finals finall finas fnal fnals fina f sinal)],
    "Semi-final" => [qw(semifinal semif semifinals semifinale semifinali
      seminfinal semifinales semis semfin sfinal sfinals sd
      semifianls semýfýnal sefi)],
    Semi => [qw(meia meias)],
    "Quarter-final" => [qw(quarterfinal quafin quarterf quarterfinals 
      qfinal qfinals quaterfinal sf ottavi)],
    "Round-robin" => [qw(rrobin roundrobin rr)],
    Playoff => [qw(po playoff playoffs)],
    "Knock-out" => [qw(ko elimination kostage knockout knockouts)],

    Round => [qw(rounds rouns rueda ruond rd riund rnd rds
      tound tour runde runder rn r rond ronda ronud roudn roun)],
    Stanza => [qw(stanza stsnza stan stanzas stanzaq stranza)],
    Session => [qw(serssion sesion sesión sesj sesjon sess
      sessió Sessión ses sesje sessie sesson sesssion sessions
      sessão)],
    Stage => [],
    Section => [qw(ssegssion seksjon sektion)],
    Match => [qw(mathc m kamp incontro matxh macth)],
    Segment => [qw(seg segm segement segemt segmant segmen 
      segmento segments segmetn segmnet segnment sgment segt sengemt)],
    Set => [],
    Part => [],
    Quarter => [qw(quaerter quater)],

    Rof12 => [],
    Rof16 => [],
    Rof18 => [],
    Rof32 => [],
    Rof64 => [],
    Rof128 => []
  },

  SCORING =>
  {
    MP => [qw(matchpoints matchpoint machpoints macthpoints mpoints)],
    IMP => [qw(ýmp)],
    BAM => [],
  },

  NAMED_TEAM =>
  {
    Ao => [],
    Baker => [],
    Bramley => [],
    Daskalakis => [],
    Cayne => [],
    Delfour => [],
    Doussot => [],
    DKI => [],
    Ekeblad => [],
    Fireman => [],
    Goldman => [],
    Grabel => [],
    Gromov => [],
    Gursel => [],
    Heimdal => [],
    Hollman => [],
    Jacobs => [],
    Kasday => [],
    Kasle => [],
    Kolata => [],
    Lall => [],
    Lavazza => [],
    Lynch => [],
    Mahaffey => [],
    Milner => [],
    Moss => [],
    Narasimhan => [],
    Nickell => [],
    Robinson => [qw(robinso)],
    Schwartz => [],
    Strul => [],
    Sulsel => [],
    Weed => [],
    Zimmermann => []
  },

  AGE =>
  {
    Seniors => [qw(senior seniors)],
    Juniors => [qw(junior yunior)],
    U28 => [qw(u28)],
    U21 => [qw(u21)],
    Youngsters => [qw(yougerters youth youngster)],
    Schools => [qw(school)],
    Girls => [qw(gir)],
    Kids => []
  },

  GENDER =>
  {
    Men => [qw(mens)],
    Women => [qw(woman wemen womans women's womens ladies ladies's
      damas)],
    Mixed => [qw(mix mixte)],
  },

  GROUP =>
  {
    Group => [qw(grup grp groups pool)],
  },

  TABLE =>
  {
    Table => []
  },

  BOARDS =>
  {
    Boards => [qw(board brds donnes spil)],
  },

  COUNTRY =>
  {
    Bulgaria => [],
    'Czech Republic' => [qw(czech)],
    Denmark => [],
    England => [qw(eng)],
    Estonia => [],
    Finland => [],
    France => [],
    Hungary => [qw(hungarian)],
    Ireland => [qw(iire)],
    Israel => [],
    Italy => [],
    Latvia => [],
    Malta => [],
    Monaco => [],
    Netherlands => [qw(netherland)],
    Norway => [qw(nor)],
    Pakistan => [],
    Scotland => [qw(sco)],
    Turkey => [qw(tur)],
    USA => [],
  },

  CITY =>
  {
    Ballymena => [qw(ballymena)],
    Beijing => [qw(beijing)],
    Deauville => [qw(deauville)],
    Izmir => [qw(izmir izmýr ýzmir)],
    Kepri => [qw(kepri)],
    Kolkata => [qw(kolkata)],
    Pau => [qw(pau)],
    Radkov => [qw(radkov)],
    Vancouver => [qw(vancouver)],
    Venice => [qw(venice)],
    Wroclaw => [qw(wroclaw)],
    Zurich => [qw(zurich)]
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

  WEEKEND =>
  {
  },

  ORDINAL =>
  {
    first => [qw(1rst 1er)],
    second => [qw(segundo segunda 2e)],
    third => [qw(tercer 3e)],
    fourth => [qw(4rth 4e)],
    eighth => [qw(8e)]
  },

  NUMERAL =>
  {
    '1' => [qw(one)],
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
    Of => [qw(af off 0f av de olf pf from)]
  },

  KILL =>
  {
    Kill => [qw(Untitled
      BBO BBO1 BBO2 BBO3 BBO4
      BBO1o BBO2o BBO3o 
      BBVG BBOVG 
      man mandarin 
      fluff reloaded 12b =)]
  }
);

our %MERGE_HASH;
for my $key (keys %MERGE_ALIASES)
{
  for my $alias (@{$MERGE_ALIASES{$key}})
  {
    $MERGE_HASH{lc($alias)} = $key;
  }
}

our %FIX_HASH;
for my $category (keys %FIX_ALIASES)
{
  for my $value (keys %{$FIX_ALIASES{$category}})
  {
    $FIX_HASH{lc($value)} = { CATEGORY => $category, VALUE => $value };
    for my $fix (@{$FIX_ALIASES{$category}{$value}})
    {
      $FIX_HASH{$fix} = { CATEGORY => $category, VALUE => $value };
    }
  }
}

1;
