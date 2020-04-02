*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s31_fac_req_past  Factor requirements (USD05MER per tDM)          / 1 /
;

* model hash ID af93162731dc499d3190e4be7b1e533bd6fe7e24
table f31_nn_input(j,in_env_s) a
$ondelim
$include "./modules/31_past/input/environment_cell.csv"
$offdelim
;
table f31_w1(in_types_s,lns1) a
$ondelim
$include "./modules/31_past/input/s_weights_1.csv"
$offdelim
;
table f31_w2(lns1,lns2) a
$ondelim
$include "./modules/31_past/input/s_weights_2.csv"
$offdelim
;
table f31_w3(lns2,lns3) a
$ondelim
$include "./modules/31_past/input/s_weights_3.csv"
$offdelim
;
table f31_w4(lns3,lns4) a
$ondelim
$include "./modules/31_past/input/s_weights_4.csv"
$offdelim
;
table f31_w5(lns4,lns5) a
$ondelim
$include "./modules/31_past/input/s_weights_5.csv"
$offdelim
;
table f31_w6(lns5,lns6) a
$ondelim
$include "./modules/31_past/input/s_weights_6.csv"
$offdelim
;
table f31_w7(lns6,lns7) a
$ondelim
$include "./modules/31_past/input/s_weights_7.csv"
$offdelim
;
table f31_w8(lns7,lns8) a
$ondelim
$include "./modules/31_past/input/s_weights_8.csv"
$offdelim
;
parameter f31_b1(lns1) a
/
$ondelim
$include "./modules/31_past/input/s_bias_1.csv"
$offdelim
/;
parameter f31_b2(lns2) a
/
$ondelim
$include "./modules/31_past/input/s_bias_2.csv"
$offdelim
/;
parameter f31_b3(lns3) a
/
$ondelim
$include "./modules/31_past/input/s_bias_3.csv"
$offdelim
/;
parameter f31_b4(lns4) a
/
$ondelim
$include "./modules/31_past/input/s_bias_4.csv"
$offdelim
/;
parameter f31_b5(lns5) a
/
$ondelim
$include "./modules/31_past/input/s_bias_5.csv"
$offdelim
/;
parameter f31_b6(lns6) a
/
$ondelim
$include "./modules/31_past/input/s_bias_6.csv"
$offdelim
/;
parameter f31_b7(lns7) a
/
$ondelim
$include "./modules/31_past/input/s_bias_7.csv"
$offdelim
/;
parameter f31_b8(lns8) a
/
$ondelim
$include "./modules/31_past/input/s_bias_8.csv"
$offdelim
/;
