#!perl

package City;

use strict;
use warnings;
use Exporter;
use v5.10;

my @CITY_LIST =
  ( "Aachen", "Ajaccio", "Albena", "Albuquerque, NM", "Amman", 
    "Amsterdam", "Ann Arbor, MI", "Antalya", "Arhus", "Arona", 
    "Athens",  "Atlanta, GA",
    "Bali", "Bad Honnef", "Baden-Baden", "Bangkok", "Barcelona", 
    "Beijing", "Beirut", "Bellaria", "Bermuda", "Biarritz", 
    "Bielefeld", "Birmingham", "Bordeaux", "Brasov", "Brighton", 
    "Brussels", "Bucharest", "Budapest", "Buenos Aires", "Burghausen", 
    "Cannes", "Cardiff", "Chennai", "Como", "Copenhagen",
    "Deauville", "Delft", "Dublin", "Dubrovnik", "Dun Laoghaire",
    "Eilat", "Elsinore", "Estoril", "Fiesch", "Fort Lauderdale, FL",
    "Geneva", "Ghent", "Guaruja",
    "Hague", "Hamilton, ON", "Hammamet", "Hasselt", "Helsinki", "Herzliya",
    "Istanbul", "Izmir", "Jesolo", "Jurmala",
    "Karachi", "Kfar Hamaccabiah", "Killarney", "Kosice",
    "Larnaca", "Las Palmas", "Lausanne", "Liepaja", 
    "Lille", "Lisbon", "Lund", "Lyon",
    "Maastricht", "Madeira", "Malmo", "Mangaratiba", "Manila", 
    "Marrakech", "Menton", "Miami, FL", "Miami Beach, FL", 
    "Milan", "Milton Keynes", "Monaco", "Monte Carlo", 
    "Montecatini", "Montreal", "Montreaux",
    "Naples", "Neumunster", "New Orleans, LA", 
    "New York City, NY", "Nottingham", "Novi Sad", "Nymburk",
    "Oberreifenberg", "Ocho Rios", "Online", "Opatija", 
    "Orlando, FL", "Oslo", "Ostend",
    "Palermo", "Papendal", "Paris", "Pau", "Perth", "Pezinok",
    "Philadelphia, PA", "Piestany", "Plovdiv", 
    "Poznan", "Prague", "Protaras", "Ptuj",
    "Rhodes", "Riccione", "Riga", "Rio de Janeiro", "Rome",
    "Saint-Vincent", "Salsomaggiore", "Salt Lake City, UT", 
    "Samorin", "San Marino", "Sanremo", "Santa Sofia (Forli)",
    "Santiago", "Sanya", 
    "Sao Paulo", "Seattle, OR", "Shanghai", "Sorrento", "Southampton", 
    "Stargard", "Stirling", "Stockholm", "Strasbourg", "Sydney", 
    "Taicang", "Taipei", "Tallinn", "Tata", "Tenerife", "Tianjin",
    "Tignes", "Torquay", "Tromso", "Turin", "Turku",
    "Valkenburg", "Valletta", "Veldhoven", "Venice", "Vejle", "Verona", 
    "Vienna", "Vilamoura", "Vilnius",
    "Warsaw", "Wiesbaden", "Wroclaw", "Wuhan", "Wujang",
    "Yokohama", "Zagreb");

my %CITIES = map { $_ => 1 } @CITY_LIST;


sub new
{
  my $class = shift;
  return bless {}, $class;
}


sub valid
{
  my ($self, $text) = @_;
  return exists $CITIES{$text} ? 1 : 0;
}


1;
