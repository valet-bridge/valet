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
  Superleague => ["super league", "sup league", "sup l",
    "super leahue"],
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
  Final => ["phase finale", "fin als"],
  Semifinal => ["meia final", "meias finais", 
    "semi final", "semi-final", "semi finals", "semi-finals",
    "demi-finale", "demi-finales", "1_2final", "semi <final",
    "yarý final", "simi final"],
  Quarterfinal => ["quarter final", "quarter finals",
    "quarter-final", "quet final", "quartal final", "1_4final",
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
    "semifinals extra", "tie break", "tie reak"],

  # SCORING
  BAM => ["b-a-m", "b-a-m-"],

  # NAMED_TEAM
  Goancurry => ["goan curry"],
  Stonecutters => ["stone cutters"],
  Vestagder => ["vest-agder", "vest - agder"],

  # AGE
  "U20" => ["u 20"],
  "U21" => ["under 21"],
  "U25" => ["u 25"],
  "U28" => ["under 28"],

  # GENDER

  # COUNTRY, CITY, MONTH, WEEKDAY, ORDINAL, NUMERAL, ROMAN: none
  "fifth" => ["5 eme"],

  # PARTICLE
  of => ["out of"]
);


# ----------------------------------------------------------------


# This spell checker is run on the tokens.

our %FIX_ALIASES = 
(
  MONIKER => 
  {
    "Australian National Open Teams" => [qw(not)],
    "Australian National Senior Teams" => [qw(nst)],
    "Australian National Women Teams" => [qw(nwt)],
    "Bermuda Bowl" => [qw(bermudabowl bermuda bb)],
    "Canadian National Teams" => [qw(cntc)],
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
    "Nordic Championship" => [qw(nm)],
    "Ruia Gold" => [qw(ruiagold)],
    "Ruia Silver" => [qw(ruiasilver)],
    "Serdica Cup" => [qw(serdicacup)],
    "Super League" => [qw(superleague)],
    "USBC" => [],
    "Vanderbilt" => [qw(vandy)],
    "Venice Cup" => [qw(venicecup vc venice)], # I hope
    "VITO Teams" => [qw(vitoteams)],
    "World Mind Sports Games" => [qw(wmsg mind)],
    "World Transnational Open Teams" => [qw(wtot)],
    "World Transnational Mixed Teams" => [qw(wtmt)]
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
    Cup => [],
    League => [qw(leahue)],
    Olympiad => [qw(olympiads)],
    Open => [qw(open o libres opain oper ope op)], # Ambiguous
    Tournament => [qw(tournoi tounoi)],
    Trials => [qw(trial selectio selection prueba)]
  },

  MOVEMENT =>
  {
    Barometer => [],
    Danish => [],
    Monrad => [],
    Patton => [],
    "Round robin" => [qw(roundrobin)],
    Swiss => [qw(sw swis suisse)],
    Triangle => []
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
    Knockout => [qw(knock knockouts)],
    Tiebreak => [qw(tie ot)]
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
      finals finall finas fnal fnals fina f sinal fýnal)],
    "Semi-final" => [qw(semifinal semif semifinals semifinale semifinali
      seminfinal semifinales semis semfin sfinal sfinals sf
      semifianls semýfýnal sefi yf)],
    Semi => [qw(meia meias)],
    "Quarter-final" => [qw(quarterfinal quafin quarterf quarterfinals 
      qfinal qfinals quaterfinal qf ottavi quarti)],
    "Round-robin" => [qw(rrobin roundrobin rr)],
    Playoff => [qw(po playoff playoffs)],
    "Knock-out" => [qw(ko elimination kostage knockout knockouts)],
    PreQF => [qw(pqf)],

    Round => [qw(rounds rouns rueda ruond rd riund rnd rds ound
      tound tour runde runder rn r rond ronda ronud roudn roun turno)],
    Stanza => [qw(stanza stsnza stan stanzas stanzaq stranza)],
    Session => [qw(serssion sesion sesión sesj sesjon sess
      sessió sessión ses sesje sessie sesson sesssion sessions
      sessão devre segssion séance séan seans seansi)],
    Stage => [],
    Section => [qw(ssegssion seksjon sektion)],
    Match => [qw(mathc m kamp incontro matxh macth meci matches mecz)],
    Segment => [qw(seg segm segement segemt segmant segmen segemnt
      segmento segments segmetn segmnet segnment sgment segt sengemt)],
    Set => [qw(sets)],
    Half => [qw(hallf halvleg halv hlf mt)],
    Part => [qw(parte)],
    Quarter => [qw(quaerter quater qtr)],
    Place => [qw(puesto)],

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
    Seniors => [qw(senior seniors seniors')],
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
    Men => [qw(mens men's men`s)],
    Women => [qw(woman wemen womans women's womens ladies ladies's
      damas)],
    Mixed => [qw(mix mixte)],
  },

  GROUP =>
  {
    Group => [qw(grup grp gr groups pool)],
  },

  TABLE =>
  {
    Table => [],
    Room => [qw(rm)]
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
    France => [qw(fra)],
    Hungary => [qw(hungarian)],
    Ireland => [qw(iire roi)],
    Israel => [],
    Italy => [],
    Latvia => [],
    Malta => [],
    Monaco => [],
    Netherlands => [qw(netherland)],
    Norway => [qw(nor)],
    "Northern Ireland" => [qw(ni)],
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
    Wroclaw => [],
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

  WEEKEND =>
  {
  },

  ORDINAL =>
  {
    first => [qw(1rst 1er primera)],
    second => [qw(segundo segunda 2e)],
    third => [qw(tercer 3e)],
    fourth => [qw(4rth 4e)],
    fifth => [],
    eighth => [qw(8e)]
  },

  NUMERAL =>
  {
    '1' => [qw(one !)],
    '2' => [qw(two ")],
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
    And => [qw(&)],
    Of => [qw(af off 0f 0ff av de olf pf fo from)]
  },

  KILL =>
  {
    Kill => [qw(untitled
      bbo bbo1 bbo2 bbo3 bbo4
      bbo1o bbo2o bbo3o 
      bbvg bbovg 
      man mandarin 
      fluff reloaded missed this
      game series npc rank
      afternoon night barriere best delayed dup combined only int
      12b è no n° vs =), '#']
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
