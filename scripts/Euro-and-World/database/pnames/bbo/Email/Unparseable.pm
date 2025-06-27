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
  'a_p_s_y',
  'ankara_samsun_yavuz',
  'asoares.cmo.rrh',
  'atanas.atanasov.atanasov',
  'avvocato.marco.gatti',
  'b-al-joh',
  'b_l_o_n_d_i',
  'b_subrata_b',
  'bad_boy_pala',
  'basia.the.legend',
  'benim_ad_res',
  'bob_t_s',
  'boss_the-man',
  'bridge-base-online',
  'bridge.bbo.master',
  'bridge.juan-les-pins',
  'c_k_y',
  'ce.fi.m',
  'clever_-_rock',
  'club_el_ned',
  'cn_chm_cn',
  'daniel.a.2b',
  'duo_cris_building',
  'e-t-o-t',
  'emre_game_over',
  'ex-zozo.nc',
  'federation.luxembourg.bridge',
  'g-c-p',
  'go_go_grandma',
  'gpc_chen_xi',
  'h.o.d',
  'hl_md_wj',
  'hot_canuck_eh',
  'hotel-de-lunivers',
  'i_love_little_rabbit',
  'ian_the_bear',
  'iv.georgiev.georgiev',
  'j.f.p.ar',
  'jack-daniel.s',
  'jord_an_il',
  'jq_jq_xcx',
  'king_msa_king',
  'l_ab_a',
  'l_o_r',
  'last_of_blood',
  'lei-er-l',
  'll_ss_xx',
  'm_g_m',
  'mari_s_a',
  'marin-dobrotich-bg',
  'mc.bedu.doc',
  'mick_and_i',
  'ner.g.i.s',
  'o-e-sko',
  'o-j-hau',
  'ok_rich_wil',
  'orizz_the_one',
  'p-c-mos',
  'p.c.s',
  'p.m.l.c',
  'pheno_the_best',
  'r-w-o',
  'ry_the_guy',
  's-g-c',
  's.c.l',
  's.v.s',
  'se_is_ro',
  'sultan-of_swing',
  't-ole-sv',
  't.de-luna',
  't.o.m',
  't_tee_ty',
  'the_first_bul',
  'the_good_naughty_boy',
  'tito_in_italia',
  'top.free.stats',
  'un.mot.juste',
  'v_g_s',
  'veneration.of.mars',
  'w_w_w',
  'where-do-i-go',
  'wil-a2wil-a',
  'wizard_of_ozz',
  'x.worshipper.x',
  'y_l_x',
  'z-r-p',
  'zc_zhou_zc',
  'zet.i.m',
);

our $UNPARSEABLE_HASH = { map { $_ => 1 } @UNPARSEABLE };

1;
