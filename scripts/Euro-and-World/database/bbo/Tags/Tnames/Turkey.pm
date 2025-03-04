#!perl

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

package Tags::Tnames::Turkey;

our @ISA = qw(Exporter);
our @EXPORT = qw(set_hash);


my @MULTI_WORDS =
(
  'Aegean Open Teams',
  'Anatolian Club Teams',
  'Anatolian Fall Teams',
  'Anatolian Spring Teams',
  'Ankara Summer Teams',
  'Ankara Winter Teams',
  'Balikcioglu Open Teams',
  'Bodrum Patton Teams',
  'Bornova Arena Autumn Teams',
  'Bornova Arena Spring League',
  'Bornova Arena Invitational Pairs',
  'Cappadocia Open Pairs',
  'Deniz Unlu Open Teams',
  'Fatih Kiral Pairs',
  'Gelibolu Peace Teams',
  'Goksu-Yalikavak Pairs',
  'Hakan Peksen Open Teams',
  'Istanbul Club Teams',
  'Istanbul Summer Teams',
  'Istanbul Winter Open Teams',
  'Istanbul Winter Women Teams',
  'Istanbul Women Teams',
  'Izmir Teams Cup',
  'Izmir Winter Teams Cup',
  'Lüleburgaz Liberation Cup',
  'Marmara Inter-Club Championship',
  'Mersin Open Pairs',
  'Mersin Open Patton Teams',
  'Mersin Winter Open Teams',
  'Murat Kilercioglu Turkish Spring Teams',
  'Necmettin Sunget Teams Cup',
  'Okay Gur Winter Teams',
  'Sadun Su U26 Teams',
  'Salvador Assael IMP Pairs',
  'Salvador Assael Pro-Am Pairs',
  'Sivrioglu BAM Teams',
  'Solakoglu IMP Pairs',
  'Thrace Cup League',
  'Turkish-Greek Open Pairs',
  'Turkish-Greek Open Teams',
  'Turkish Club Championship',
  'Turkish East Mediterranean Teams',
  'Turkish Junior Pairs',
  'Turkish Mixed Team Trials',
  'Turkish Mixed Teams',
  'Turkish Open Pair Trials',
  'Turkish Open Team Trials',
  'Turkish Open Teams',
  'Turkish Senior Team Trials',
  'Turkish Swiss Mixed Teams',
  'Turkish Swiss Open Teams',
  'Turkish Super Cup',
  'Turkish U16 Pairs',
  'Turkish U21 Pair Trials',
  'Turkish U21 Team Trials',
  'Turkish U26 Teams',
  'Turkish U26 Team Trials',
  'Turkish U26 Women Team Trials',
  'Turkish U31 Team Trials',
  'Turkish University Teams',
  'Turkish Winter Open Teams',
  'Turkish Winter Women Teams',
  'Turkish Women Pair Trials',
  'Turkish Women Team Trials',
  'Turkish Women Teams',
  'Western Mediterranean Club Teams',
  'Yalcin Atabey Open Teams',
);

my %MULTI_TYPOS =
(
  'Aegean Open Teams' => [
    'aegean championships',
    'aegean clubs championship',
    'ege bilimsel bric sk spring teams',
    'ege kulupler arasi',
    'ege klupler arasi bolge elemeleri',
    'spring team ege bilimsel bsk',
    'turkish clubs championship aegean playoffs'],
  'Anatolian Club Teams' => [
    'anadolu bolge elemesi',
    'anatolian club qualifying',
    'eastern anatolian qualification',
    'eastern anatolýa qualýfýcatýon',
    'ic anadolu bolge elemesi',
    'ic anadolu bolge elemeleri',
    'ic anadolu elemeleri',
    'ic anadolu kulupler bolge elemeleri',
    'ic anadolu kulupler bolge elemesi',
    'ic anadolu kulupler elemesi',
    'turkish interclubs champ_ anatolia elections',
    'turkiye kuluplerarasi ic anadolu elemeleri',
    'turkiye kulupler arasi ic anadolu elemeleri'],
  'Anatolian Fall Teams' => ['anatolian side fall teams'],
  'Anatolian Spring Teams' => ['anatolia spring teams'],
  'Ankara Summer Teams' => [
    'ankara summer team championship',
    'ankara yaz dortlu',
    'ankara yaz dörtlü'],
  'Ankara Winter Teams' => [
    'ankara kis',
    'ankara kis dortlu',
    'ankara kis ligi',
    'ankara kýs',
    'ankara kýþ takýmlar',
    'turkiye kis dortlu ankara'],
  'Balikcioglu Open Teams' => [
    'balikcioglu teams championship'],
  'Bornova Arena Autumn Teams' => [
    'autumn championship bornova bridge arena'],
  'Bornova Arena Spring League' => [
    'bornova bric kulubu spring league',
    'spring league bornova bridge arena'],
  'Deniz Unlu Open Teams' => [
    'deniz unlu teams'],
  'Fatih Kiral Pairs' => [
    'fatih kiral cup'],
  'Gelibolu Peace Teams' => ['gelibolu peace cup'],
  'Istanbul Club Teams' => [
    'istanbul klupler arasi',
    'istanbul kulupler sampiyonasi',
    'kulupler arasi istanbul',
    'turkiye kulupler arasi istanbul',
    'ýstanbul kulüpler takim fýnallerý'],
  'Istanbul Summer Teams' => [
    'istanbul team championship',
    'istanbul team championships',
    'istanbul club teams championship',
    'ýstanbul championship',
    'ýstanbul teams'],
  'Istanbul Winter Open Teams' => [
    'istanbul kis4lu',
    'istanbul kis 4lu',
    'istanbul kis 4 lu',
    'istanbul kis dortlu',
    'istanbul kis dortlu takimlar',
    'istanbul kis dortlu takim',
    'istanbul winter champs',
    'istanbul winter team championship',
    'istanbul winter teams',
    'istanbul wýnter teams',
    'istanbul kis'],
  'Istanbul Winter Women Teams' => [
    'istanbul winter teams women'],
  'Istanbul Women Teams' => [
    'istanbul kadin takimlar sampiyonasi',
    'istanbul kadin takimlar þampiyonasi',
    'ýstanbul kadin takimlar þampýyonasi',
    'ýstanbul kadinlar takim þampýyonasi'],
  'Izmir Teams Cup' => [
    'izmir open teams championship',
    'izmir open teams championships',
    'izmir open winter teams',
    'izmir teams',
    'izmir teams championship',
    'izmýr teams cup'],
  'Izmir Winter Teams Cup' => [
    'izmir kis dortlu',
    'izmir kis 4 lu',
    'izmir play-off open winter teams',
    'izmir winter open teams',
    'izmir winter teams',
    'izmir winter teams championship',
    'turkish winter open teams izmir',
    'winter teams championship izmir'],
  'Lüleburgaz Liberation Cup' => ['luleburgaz kurtulus kupasi'],
  'Marmara Inter-Club Championship' => [
    'marmara club teams championship',
    'marmara kulupler',
    'marmara kulupler arasi elemelerý',
    'marmara kulupler bolge elemeleri',
    'marmara kulupler elemeleri',
    'marmara kulupler elemelerý'],
  'Mersin Winter Open Teams' => [
    'mersin kis dortlu'],
  'Murat Kilercioglu Turkish Spring Teams' => [
    'Murat Kilercioglu Spring Teams'],
  'Necmettin Sunget Teams Cup' => [
    'necmettin sunget teams',
    'necmettin sünget dörtlü',
    'necmettin sünget dörtlü takýmlar'],
  'Okay Gur Winter Teams' => [
    'okay gur kis dortlu',
    'okay gur winter',
    'okay gur winter champ',
    'okay gur winter champs'],
  'Sadun Su U26 Teams' => [
    'sadun su u16 takimlar'],
  'Salvador Assael IMP Pairs' => [
    'assael invitational calcutta',
    "salvador assael imp's across the field"],
  'Salvador Assael Pro-Am Pairs' => [
    'salvador assael pro-am'],
  'Thrace Cup League' => [
    'trachean club teams',
    'Thrace Club Teams',
    'thrace region clubs team championship',
    'trakya kulupler ligi',
    'trakya kulupler turnuvasi',
    'trakya kulupler turnuvasý',
    'trakya kuluplerarasi sampiyonasi',
    'turkish club teams championship aegean playoffs',
    'turkiye kulupler arasi trakya bolge elemeleri',
    'türk trakya bölge kulüpler þampýyonasi ekýbý'],
  'Turkish Club Championship' => [
    'turkey club team championship',
    'turkey club teams championship',
    'turkey clubs championship',
    'turkish club teams championship',
    'turkish club championships',
    'turkish club teams championship',
    'turkish clubs championship',
    'turkish clubs team championship',
    'turkish clubs teams championship',
    'turkish clubs team championship teams',
    'turkish club team championship',
    'turkish inter club championships',
    'turkish inter-clubs championship',
    'turkiye clubs championship', 
    'turkiye kulupler',
    'turkiye kulupler sampiyonasi',
    'turkiye kulupler sampýyonasi',
    'turkiye kulupler takim sampiyonasi',
    'turkiye kulupler takým sampiyonasý',
    'turkiye kuluplerarasi',
    'turkiye kuluplerarasi sampiyonasi',
    'turkiye kuluplerarasi takim sampiyonasi',
    'turkiye kuluplerarasý',
    'türkýye külüpler takim þampýyonasi',
    'türkýye kulüplerarasi þampýyonasi',
    'türkýye klüpler arasi brýç þampýyonasi'],
  'Turkish East Mediterranean Teams' => [
    'east mediterenean',
    'east mediterranean',
    'east mediterranen',
    'east mediterrean',
    'turkish clubs championship east & south east el',
    'turkish east & south-east teams',
    'turkish east mediterranean',
    'turkish east mediterranean club teams',
    'turkish eastern mediterranean club',
    'turkish eastern mediterranean club teams',
    'turkiye dogu akdeniz bolge'],
  'Turkish Mixed Team Trials' => [
    'karisik milli takim secme',
    'karýþýk milli takým seçmesi',
    'turkey mixed national team selection',
    'turkish mix trials',
    'turkish mixed team trails',
    'turkish mýxed team trials',
    'turkiye mix milli secme',
    'turkiye mix milli secmesi',
    'turkiye mix milli secmesý',
    'turkiye mix milli seçmesi',
    'turkiye mix milli seçmesý',
    'turkiye mix milli seçmesý',
    'turkiye mix takimlar sampiyonasi',
    'turkiye mýx takimlar sampiyonasi',
    'turkiye mýx mýllý secmesý',
    'turkýye mix milli secme',
    'turkýye mix milli seçme',
    'turkýye mix milli secmesý',
    'turkýye mýx mýllý secme',
    'türkiye karýþýk milli takým seçmesi',
    'türkiye karýþýk milli takýmlar seçmesi',
    'türkýye kariþik takimlar þampýyonasi',
    'türkýye mýx mýllý secme',
    'türkýye mýx mýllý secmesý',
    'türkýye mýx takimlar þampýyonasi'],
  'Turkish Mixed Teams' => [
    'karisik takimlar',
    'turkey mix teams ch',
    'turkey mix teams championship',
    'turkey mixed team championship',
    'turkey mixed teams',
    'turkis mixed teams',
    'turkish mixed teams',
    'turkish mixed team championship',
    'turkish mixed team championships',
    'turkish mixed teams championship',
    'turkiye mixed teams championship',
    'turkýsh mixed teams'],
  'Turkish Open Teams' => [
    'turkey open team championship',
    'turkish national open national selection',
    'turkish open team championship',
    'turkish open teams',
    'turkish open teams championship',
    'turkish open teams championships',
    'turkiye acik takimlar sampiyonasi',
    'turkiye acýk milli takim seçmesi',
    'turkish national open teams',
    'türkiye açýk milli takým seçmeleri',
    'türkiye açýk milli takým seçmesi'],
  'Turkish Open Team Trials' => [
    'turkey open trials',
    'turkish national team trials',
    'turkish national trials',
    'turkiye acik milli secme',
    'turkiye acik milli takim secme',
    'turkiye acik milli takim secmesi',
    'turkiye acik milli takimlar secme',
    'turkiye acik milli takým secme',
    'turkiye acik milli takým secmesi',
    'turkiye acýk milli takým secme',
    'turkiye acýk milli takým secmesi',
    'turkýye acik milli takým secme',
    'türkýye açik mýllý takim seçmesý',
    'türkiye açýk milli takým seçmeleri'],
  'Turkish Senior Team Trials' => [
    'turkey senior national team selection',
    'turkish senior national team selection',
    'turkish seniors team trials',
    'turkish senyor national trials',
    'turkiye senior national team selection',
    'turkiye senyor milli secme',
    'turkiye senyor milli secmesý',
    'turkiye senyor mýllý secmesý'],
  'Turkish Super Cup' => [
    'turkiye super kupa'],
  'Turkish Swiss Mixed Teams' => [
    'turkey swiss mixed teams',
    'turkish swiss mýxed teams'],
  'Turkish Swiss Open Teams' => [
    'turkiye nakavt-swiss takimlar sampiyonasi',
    'turkiye nakavt takim sampiyonasi',
    'turkiye nakavt takimlar sampiyonasi',
    'turkiye nakavt takimlar þampiyonasi'],
  'Turkish U21 Team Trials' => [
    'turkey u21 national team selection',
    'turkey u21 team selection'],
  'Turkish U26 Team Trials' => [
    'u26 genc milli takim secmeleri',
    'u26 genç milli takým seçmesi',
    'u26 genç mýllý takim seçmesý'],
  'Turkish U26 Women Team Trials' => [
    'u26 genc bayanlar milli takým secmesi',
    'u26 genc kadin milli takim secmesi',
    'u26 genc kadýn milli takým secmesi',
    'u26 genç kadin secmesý',
    'u26 kadin secmesý'],
  'Turkish U16 Pairs' => [
    'turkey u16 championship'],
  'Turkish U31 Team Trials' => [
    'turkey u31 trials',
    'turkiye u31 national team selections',
    'türkiye u31 milli takým seçmesi',
    'u31 national team selection',
    'u31 natýonal team selectýon'],
  'Turkish University Teams' => [
    'turkish Universities championship',
    'turkish universities bridge championship'],
  'Turkish Winter Open Teams' => [
    'kis dortlu',
    'kýþ dörtlü',
    'turkey bridge federation winter championship',
    'turkey open winter teams',
    'turkey winter open teams',
    'turkey winter teams',
    'turkey winter team championship',
    'turkey winter teams championship',
    'turkis winter teams',
    'turkish winter chanpionship',
    'turkish winter championship',
    'turkish winter championships',
    'turkish winter team championship',
    'turkish winter team championships',
    'turkish winter teams',
    'turkiye kis 4 lu',
    'turkiye kis 4lu',
    'turkiye kis dortlu',
    'turkiye kis takimlar sampiyonasi',
    'turkiye kis acik takimlar sampiyonasi',
    'turkiye kiþ açik takimlar þampýyonasi',
    'türkýye kiþ açik takimlar þampýyonas',
    'türkýye kiþ açik takimlar þampýyonasi'],
  'Turkish Winter Women Teams' => [
    'turkey winter women teams',
    'turkish winter woman team championship',
    'turkish winter women teams',
    "turkish woman's winter teams",
    "turkish women's winter championship",
    "turkish women's winter teams"],
  'Turkish Women Teams' => [
    'turkey winter women teams',
    'turkish ladies teams championships',
    'turkish ladies teams',
    'turkish women championships',
    'turkish womens teams championship',
    'turkiye kadin dortlu',
    'turkiye kadin sampiyonasi',
    'turkiye kadin takimlar sampiyonasi',
    'türkish ladies teams',
    'türkiye kadin dörtlü',
    'türkiye kadýn dörtlü',
    'türkiye kadýn takýmlar þampiyonasi'],
  'Turkish Women Team Trials' => [
    'turkey women team trials',
    'turkish national woman trials',
    'turkish national women trials',
    'turkish womens trials',
    'turkiye kadin milli secme',
    'turkiye kadin milli secmeleri',
    'turkiye kadin milli takim secme',
    'turkiye kadin milli takim secmesi',
    'turkiye kadin mýllý seçmesý',
    'türkýye kadin mýllý takim seçmesý'],
  'Western Mediterranean Club Teams' => [
    'western mediterranean clubs team championship'],
  'Yalcin Atabey Open Teams' => [
    'yalcin atabey open',
    'yalcin atabey summer open'],
);

my %SINGLE_TYPOS =
(
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
