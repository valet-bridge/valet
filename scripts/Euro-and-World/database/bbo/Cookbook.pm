#!perl

use strict;
use warnings;
use Exporter;

package Cookbook;

our @ISA = qw(Exporter);
our @EXPORT = qw(
  %MERGE_ALIASES
  %FIELD_ALIASES 
  %SPELL_ALIASES
  %COUNTRY_ALIASES
  %CITY_ALIASES
  %MONTH_ALIASES
  %WEEKDAY_ALIASES
  %ORDINAL_ALIASES
  %NAMED_TEAM_ALIASES
  %TOURNAMENT_ALIASES
  %MONIKER_ALIASES
  %ORIGIN_ALIASES
  %KILL_ALIASES
);

# Some words obviously belong together, and if their tokens
# are separated early on, it is harder to keep them together.
our %MERGE_ALIASES = (
  Superleague => [ "super league", "sup league"],
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

  Quarterfinal => ["quarter final", "quet final", "quartal final" ],
  Knockout => ["knock out", "knock-out"],

  Interclub => ["inter club", "inter-club", "inter-clubs"],
  Interprovince => ["inter province", "inter-province",
    "inter-provinces", "inter provinces"],
  Interregion => ["inter region", "inter-region", "inter-regional"],
  Intercity => ["inter-city", "inter city"],
  Roundrobin => ["round robin", "roun robin", "round bobin",
    "round-robin", "r_robin", "r robin", "round roubin"],

  "U20" => ["u 20"],
  "U21" => ["under 21"],
  "U25" => ["u 25"],
  "U28" => ["under 28"],

  EBL => ["E_B_L_"],
  Eurochamp => ["eur champ"],

  BAM => ["b-a-m", "b-a-m-"],

  of => ["out of"],
);

our %FIELD_ALIASES = (
  ROUND => [qw(round rounds rouns rueda ruond rd riund rnd rds
    tound tour runde runder rn r rond ronda ronud roudn roun
    stanza stan stanzas stanzaq stranza)],
  SEGMENT => [qw(segment seg segm segement segemt segmant segmen 
    segmento segments segmetn segmnet segnment sgment segt sengemt
    set)]
);

our %SPELL_ALIASES = (
  Final => [qw(final fianl filnal fin finais finale finales finali 
    finals finall finas fnal fnals f)],
  SF => [qw(semifinal semif semifinals semifinale semifinali
    seminfinal semifinales semis semfin sfinal sfinals sf 
    semifianls semýfýnal)],
  Semi => [qw(semi meia meias)],
  QF => [qw(qf quarterfinal quafin quarterf quarterfinals 
    qfinal qfinals quaterfinal)],
  RR => [qw(rr rrobin roundrobin)],
  PO => [qw(po playoff playoffs)],
  KO => [qw(ko elimination kostage knockout knockouts)],
  Session => [qw(session serssion sesion sesión sesj sesjon sess
    sessió Sessión ses seksjon sesje sessie sesson sesssion sessions
    sessão)],
  Section => [qw(section segssion seksjon sektion)],
  Match => [qw(match mathc m kamp incontro matxh)],
  Quarter => [qw(quarter quaerter quater)],

  Teams => [qw(teams team equipos team's lag teamd)],
  Pairs => [qw(pairs pair paýrs psirs parejas)],
  Individual => [qw(individual ind indiv indivual)],

  Men => [qw(men mens)],
  Women => [qw(women woman wemen womans women's womens ladies ladies's
    damas)],
  Mixed => [qw(mixed mix mixte)],
  Girls => [qw(girls)],
  Seniors => [qw(seniors senior seniors)],
  Juniors => [qw(juniors junior yunior)],
  Schools => [qw(schools school)],
  Youngsters => [qw(youngsters yougerters youth youngster)],

  Open => [qw(open o libres opain oper)],

  Table => [qw(table)],
  Boards => [qw(boards brds donnes)],
  Group => [qw(group grup grp groups)],

  MP => [qw(matchpoints matchpoint machpoints macthpoints mpoints mp)],
  IMP => [qw(imp ýmp)],
  BAM => [qw(BAM)],

  Qualifying => [qw(quailfy qual qualf qualfication quali qualif
    qualification qualifier qualify qualifying quallification qualy
    qr qulification prelim preliminary pre pelim)],
  Swiss => [qw(swiss sw swis)],
  Trials => [qw(trials trial selectio)],

  Of => [qw(of af off 0f av de)]
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
  first => [qw(first)],
  second => [qw(second segundo segunda)],
  third => [qw(third)],
  fourth => [qw(fourth)],
  eighth => [qw(eighth)]
);

our %NAMED_TEAM_ALIASES = (
  Baker => [qw(baker)],
  Bramley => [qw(bramley)],
  Daskalakis => [qw(daskalakis)],
  Cayne => [qw(cayne)],
  Delfour => [qw(delfour)],
  Doussot => [qw(doussot)],
  Ekeblad => [qw(ekeblad)],
  Fireman => [qw(fireman)],
  Goldman => [qw(goldman)],
  Gromov => [qw(gromov)],
  Gursel => [qw(gursel)],
  Jacobs => [qw(jacobs)],
  Kasle => [qw(kasle)],
  Kolata => [qw(kolata)],
  Lavazza => [qw(lavazza)],
  Lynch => [qw(lynch)],
  Mahaffey => [qw(mahaffey)],
  Milner => [qw(milner)],
  Murat => [qw(murat)],
  Mohan => [qw(mohan)],
  Moss => [qw(moss)],
  Narasimhan => [qw(narasimhan)],
  Nickell => [qw(nickell)],
  Robinson => [qw(robinson robinso)],
  Schwartz => [qw(schwartz)],
  Strul => [qw(strul)],
  Zimmermann => [qw(zimmermann)]
);

our %TOURNAMENT_ALIASES = (
  League => [qw(league leahue)],
  Tournament => [qw(tournament tournoi tounoi)],
  Olympiad => [qw(olympiad olympiads)],
);

our %MONIKER_ALIASES = (
  "Bermuda Bowl" => [qw(bermudabowl bermuda)],
  "Venice Cup" => [qw(venicecup)],
  "Ruia Gold" => [qw(ruiagold)],
  "Ruia Silver" => [qw(ruiasilver)],
  "Nations Cup" => [qw(nationscup)],
  "Hungarian Cup" => [qw(hungariancup)],
  "Fortuna Cup" => [qw(fortunacup)],
  "Kepri Cup" => [qw(kepricup)],
  "FX Securities Cup" => [qw(fxcup)],
  "Serdica Cup" => [qw(serdicacup)],
  "Gro's Supercup" => [qw(grocup)],
  "National Open Teams" => [qw(not)]
);

our %ORIGIN_ALIASES = (
  Province => [qw(interprovince)],
  Region => [qw(interregion)],
  City => [qw(intercity)],
  Club => [qw(interclub)],
  University => [qw(university)]
);

our %KILL_ALIASES = (
  Kill => [qw(Untitled
    BBO1o BBO2o BBO3o BBVG BBOVG 
    BBO1 BBO2 BBO3 BBO4)]
);

1;
