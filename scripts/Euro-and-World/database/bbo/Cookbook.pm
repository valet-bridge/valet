#!perl

use strict;
use warnings;
use Exporter;

package Cookbook;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  %MERGE_ALIASES
  %SPELL_ALIASES
  %COUNTRY_ALIASES
  %CITY_ALIASES
  %MONTH_ALIASES
  %WEEKDAY_ALIASES
  %ORDINAL_ALIASES
  %NUMERAL_ALIASES
  %NAMED_TEAM_ALIASES
  %TOURNAMENT_ALIASES
  %STAGE_ALIASES
  %MODE_ALIASES
  %MONIKER_ALIASES
  %ORIGIN_ALIASES
  %SPONSOR_ALIASES
  %MEMORIAL_ALIASES
  %KILL_ALIASES
);

# Some words obviously belong together, and if their tokens
# are separated early on, it is harder to keep them together.
our %MERGE_ALIASES = (
  EBL => ["E_B_L_"],

  Eurochamp => ["eur champ"],
  Superleague => [ "super league", "sup league", "superleague"],
  Bermudabowl => [ "bermuda bowl", "bb"],
  Venicecup => ["venice cup", "vc", "venice"], # I hope
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

  Interclub => ["inter club", "inter-club", "inter-clubs"],
  Interprovince => ["inter province", "inter-province",
    "inter-provinces", "inter provinces"],
  Interregion => ["inter region", "inter-region", "inter-regional"],
  Intercity => ["inter-city", "inter city"],
  Roundrobin => ["round robin", "roun robin", "round bobin",
    "round-robin", "r_robin", "r robin", "round roubin"],

  Goancurry => ["goan curry"],
  Stonecutters => ["stone cutters"],
  Vestagder => ["vest-agder", "vest - agder"],
  Heimdal => ["heimdal bk"],
  Mohansicka => ["mohan sicka"],

  GetImmo => ["get immo", "get-immo"],

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
  Knockout => ["knock out", "knock-out", "knockouts"],
  Tiebreak => ["tiebreak", "tie", "extra boards", "extra time",
    "extra stanza", "semifinals extra", "ot"],

  "U20" => ["u 20"],
  "U21" => ["under 21"],
  "U25" => ["u 25"],
  "U28" => ["under 28"],

  BAM => ["b-a-m", "b-a-m-"],

  of => ["out of"]
);

our %SPELL_ALIASES = (
  Final => [qw(final fianl filnal fin finais finale finales finali 
    finals finall finas fnal fnals fina f sinal)],
  SF => [qw(semifinal semif semifinals semifinale semifinali
    seminfinal semifinales semis semfin sfinal sfinals sf 
    semifianls semýfýnal sefi)],
  Semi => [qw(semi meia meias)],
  QF => [qw(qf quarterfinal quafin quarterf quarterfinals 
    qfinal qfinals quaterfinal ottavi)],
  RR => [qw(rr rrobin roundrobin)],
  PO => [qw(po playoff playoffs)],
  KO => [qw(ko elimination kostage knockout knockouts)],

  Round => [qw(round rounds rouns rueda ruond rd riund rnd rds
    tound tour runde runder rn r rond ronda ronud roudn roun
    stanza stsnza stan stanzas stanzaq stranza)],
  Session => [qw(session serssion sesion sesión sesj sesjon sess
    sessió Sessión ses seksjon sesje sessie sesson sesssion sessions
    sessão stage)],
  Section => [qw(section segssion seksjon sektion)],
  Match => [qw(match mathc m kamp incontro matxh macth)],
  Segment => [qw(segment seg segm segement segemt segmant segmen 
    segmento segments segmetn segmnet segnment sgment segt sengemt
    set part)],
  Quarter => [qw(quarter quaerter quater)],

  Teams => [qw(teams team equipos team's lag teamd terms)],
  Pairs => [qw(pairs pair paýrs psirs parejas)],
  Individual => [qw(individual ind indiv indivual)],

  Men => [qw(men mens)],
  Women => [qw(women woman wemen womans women's womens ladies ladies's
    damas)],
  Mixed => [qw(mixed mix mixte)],
  Girls => [qw(girls gir)],
  Kids => [qw(kids)],

  Seniors => [qw(seniors senior seniors)],
  Juniors => [qw(juniors junior yunior)],
  U28 => [qw(u28)],
  U21 => [qw(u21)],
  Youngsters => [qw(youngsters yougerters youth youngster)],
  Schools => [qw(schools school)],

  Open => [qw(open o libres opain oper ope op)],

  Table => [qw(table)],
  Boards => [qw(boards board brds donnes spil)],
  Group => [qw(group grup grp groups pool)],

  MP => [qw(matchpoints matchpoint machpoints macthpoints mpoints mp)],
  IMP => [qw(imp ýmp)],
  BAM => [qw(BAM)],
  Patton => [qw(patton)],

  Qualifying => [qw(quailfy qual qualf qualfication quali qualif
    qualification qualifier qualify qualifying quallification qualy
    qr qulification prelim preliminary pre pelim
    clasificacion clasificatoria)],
  Swiss => [qw(swiss sw swis suisse)],
  Trials => [qw(trials trial selectio selection)],

  Of => [qw(of af off 0f av de olf pf from)]
);

our %COUNTRY_ALIASES = (
  Bulgaria => [qw(bulgaria)],
  'Czech Republic' => [qw(czech)],
  Denmark => [qw(denmark)],
  England => [qw(england eng)],
  Estonia => [qw(estonia)],
  Finland => [qw(finland)],
  France => [qw(france)],
  Hungary => [qw(hungary hungarian)],
  Ireland => [qw(ireland ire)],
  Israel => [qw(israel)],
  Italy => [qw(italy)],
  Latvia => [qw(latvia)],
  Malta => [qw(malta)],
  Monaco => [qw(monaco)],
  Netherlands => [qw(netherlands netherland)],
  Norway => [qw(norway nor)],
  Pakistan => [qw(pakistan)],
  Scotland => [qw(scotland sco)],
  Turkey => [qw(turkey tur)],
  USA => [qw(usa)],
);

our %CITY_ALIASES = (
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
);

our %MONTH_ALIASES = (
  January => [qw(january jan)],
  February => [qw(february feb)],
  March => [qw(march mar)],
  April => [qw(april apr)],
  May => [qw(may)],
  June => [qw(june jun juin)],
  July => [qw(july jul)],
  August => [qw(august aug)],
  September => [qw(september sept sep)],
  October => [qw(october oct)],
  November => [qw(november nov)],
  December => [qw(december dec)]
);

our %WEEKDAY_ALIASES = (
  Monday => [qw(monday mon)],
  Tuesday => [qw(tuesday tue)],
  Wednesday => [qw(wednesday wed)],
  Thursday => [qw(thursday thu)],
  Friday => [qw(friday fri freitag)],
  Saturday => [qw(Saturday sat samstag)],
  Sunday => [qw(sunday sun sonntag)]
);

our %ORDINAL_ALIASES = (
  first => [qw(first 1rst 1er)],
  second => [qw(second segundo segunda 2e)],
  third => [qw(third tercer 3e)],
  fourth => [qw(fourth 4rth 4e)],
  eighth => [qw(eighth 8e)]
);

our %NUMERAL_ALIASES = (
  '1' => [qw(one)],
  '2' => [qw(two)],
  '3' => [qw(three)],
  '4' => [qw(four)],
  '5' => [qw(five)],
  '6' => [qw(six)],
  '7' => [qw(seven)],
  '8' => [qw(eight)]
);

our %ROMAN_ALIASES = (
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
);

our %NAMED_TEAM_ALIASES = (
  Ao => [qw(ao)],
  Baker => [qw(baker)],
  Bramley => [qw(bramley)],
  Daskalakis => [qw(daskalakis)],
  Cayne => [qw(cayne)],
  Delfour => [qw(delfour)],
  Doussot => [qw(doussot)],
  DKI => [qw(dki)],
  Ekeblad => [qw(ekeblad)],
  Fireman => [qw(fireman)],
  Goldman => [qw(goldman)],
  Grabel => [qw(grabel)],
  Gromov => [qw(gromov)],
  Gursel => [qw(gursel)],
  Heimdal => [qw(heimdal)],
  Hollman => [qw(hollman)],
  Jacobs => [qw(jacobs)],
  Kasday => [qw(kasday)],
  Kasle => [qw(kasle)],
  Kolata => [qw(kolata)],
  Lall => [qw(lall)],
  Lavazza => [qw(lavazza)],
  Lynch => [qw(lynch)],
  Mahaffey => [qw(mahaffey)],
  Milner => [qw(milner)],
  Moss => [qw(moss)],
  Narasimhan => [qw(narasimhan)],
  Nickell => [qw(nickell)],
  Robinson => [qw(robinson robinso)],
  Schwartz => [qw(schwartz)],
  Strul => [qw(strul)],
  Sulsel => [qw(sulsel)],
  Weed => [qw(weed)],
  Zimmermann => [qw(zimmermann)]
);

our %TOURNAMENT_ALIASES = (
  League => [qw(league leahue)],
  Tournament => [qw(tournament tournoi tounoi)],
  Olympiad => [qw(olympiad olympiads)],
);

our %STAGE_ALIASES = (
  Final => [qw(final)],
  Semifinal => [qw(semifinal)],
  Quarterfinal => [qw(quarterfinal)],
  Rof12 => [qw(rof12)],
  Rof16 => [qw(rof16)],
  Rof18 => [qw(rof18)],
  Rof32 => [qw(rof32)],
  Rof64 => [qw(rof64)],
  Rof128 => [qw(rof128)]
);

our %MODE_ALIASES = (
  Danish => [qw(danish)],
  Monrad => [qw(monrad)],
  Swiss => [qw(swiss)],
  Barometer => [qw(barometer)]
);

our %MONIKER_ALIASES = (
  "Bermuda Bowl" => [qw(bermudabowl bermuda)],
  "Venice Cup" => [qw(venicecup)],
  "D'Orsi Cup" => [qw(dosb)],
  "Ruia Gold" => [qw(ruiagold)],
  "Ruia Silver" => [qw(ruiasilver)],
  "Nations Cup" => [qw(nationscup)],
  "Hungarian Cup" => [qw(hungariancup)],
  "Fortuna Cup" => [qw(fortunacup)],
  "Kepri Cup" => [qw(kepricup)],
  "FX Securities Cup" => [qw(fxcup)],
  "Serdica Cup" => [qw(serdicacup)],
  "Gro's Supercup" => [qw(grocup)],
  "National Open Teams" => [qw(not)],
  "Murat Kilercioglu" => [qw(muratkilercioglu)]
);

our %ORIGIN_ALIASES = (
  Province => [qw(interprovince)],
  Region => [qw(interregion)],
  City => [qw(intercity)],
  Club => [qw(interclub)],
  University => [qw(university univ)],
  Transnational => [qw(transnational transnation trans 
    transnatio transnat)]
);

our %SPONSOR_ALIASES = (
  SportAccord => [qw(sportaccord)],
  MULTICOMS => [qw(multicoms)]
);

our %MEMORIAL_ALIASES = (
  "Mohan Sicka" => [qw(mohansicka)]
);

our %KILL_ALIASES = (
  Kill => [qw(Untitled
    BBO1o BBO2o BBO3o BBVG BBOVG 
    BBO BBO1 BBO2 BBO3 BBO4
    fluff reloaded 12b
    champion championship champions champion's championship's
    man mandarin =)]
);

1;
