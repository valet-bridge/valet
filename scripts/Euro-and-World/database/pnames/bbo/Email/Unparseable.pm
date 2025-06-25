#!perl

package Email::Unparseable;

use strict;
use warnings;
use v5.10;
use utf8;
use open ':std', ':encoding(UTF-8)';

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw($UNPARSEABLE_HASH);

my @UNPARSEABLE =
(
  'a_b_g',
  'ankara_samsun_yavuz',
  'b_subrata_b',
  'bad_boy_pala',
  'benim_ad_res',
  'daniel.a.2b',
  'bob_t_s',
  'c_k_y',
  'club_el_ned',
  'cn_chm_cn',
  'duo_cris_building',
  'emre_game_over',
  'go_go_grandma',
  'gpc_chen_xi',
  'hl_md_wj',
  'hot_canuck_eh',
  'ian_the_bear',
  'jord_an_il',
  'jq_jq_xcx',
  'king_msa_king',
  'l_ab_a',
  'l_o_r',
  'last_of_blood',
  'll_ss_xx',
  'm_g_m',
  'mari_s_a',
  'mick_and_i',
  'ok_rich_wil',
  'orizz_the_one',
  'pheno_the_best',
  'ry_the_guy',
  'the_first_bul',
  'tito_in_italia',
  'v_g_s',
  'w_w_w',
  'wizard_of_ozz',
  'y_l_x',
  'zc_zhou_zc',
  'asoares.cmo.rrh',
  'atanas.atanasov.atanasov',
  'avvocato.marco.gatti',
  'basia.the.legend',
  'bridge.bbo.master',
  'ce.fi.m',
  'federation.luxembourg.bridge',
  'h.o.d',
  'iv.georgiev.georgiev',
  'mc.bedu.doc',
  'p.c.s',
  's.c.l',
  's.v.s',
  't.o.m',
  'top.free.stats',
  'un.mot.juste',
  'veneration.of.mars',
  'x.worshipper.x',
  'zet.i.m',
  'se_is_ro',
  't_tee_ty',
  'b-al-joh',
  'bridge-base-online',
  'g-c-p',
  'lei-er-l',
  'o-e-sko',
  'o-j-hau',
  'p-c-mos',
  'r-w-o',
  's-g-c',
  't-ole-sv',
  'wil-a2wil-a',
  'z-r-p',
  'hotel-de-lunivers',
  'marin-dobrotich-bg',
);

our $UNPARSEABLE_HASH = { map { $_ => 1 } @UNPARSEABLE };

1;
