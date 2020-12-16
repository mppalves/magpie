*** |  (C) 1008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s31_test_scalar  Factor requirements (USD05MER per tDM)          / 1 /
;

*################################DEVELOPMENT####################################
parameter f31_Intensifying_past_areas(t_all,j) Intensifying pasture areas
/
$ondelim
$include "./modules/31_past/input/f31_Intensifying_past_areas.csv"
$offdelim
/

parameter mowing_costs(i) mowing costs
/
CAZ 100
CHA 100
EUR 100
IND 100
JPN 100
LAM 100
MEA 100
NEU 100
OAS 100
REF 100
SSA 100
USA 100
/

* model hash ID 65707bf8d0cfd62280f48b8ed49cd7cdd77fa702
table f31_nn_input(j,in_env_s) aggregated environmental cell values
$ondelim
$include "./modules/31_past/input/environment_cell3.csv"
$offdelim
;
table f31_w1(in_types_s,lns1) weight
$ondelim
$include "./modules/31_past/input/65707b_s_weights_1.csv"
$offdelim
;
table f31_w2(lns1,lns2) weight
$ondelim
$include "./modules/31_past/input/65707b_s_weights_2.csv"
$offdelim
;
table f31_w3(lns2,lns3) weight
$ondelim
$include "./modules/31_past/input/65707b_s_weights_3.csv"
$offdelim
;
parameter f31_b1(lns1) bias
/
$ondelim
$include "./modules/31_past/input/65707b_s_bias_1.csv"
$offdelim
/;
parameter f31_b2(lns2) bias
/
$ondelim
$include "./modules/31_past/input/65707b_s_bias_2.csv"
$offdelim
/;
parameter f31_b3(lns3) bias
/
$ondelim
$include "./modules/31_past/input/65707b_s_bias_3.csv"
$offdelim
/;

*################################DEVELOPMENT####################################
