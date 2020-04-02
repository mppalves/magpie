*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c14_yields_scenario  nocc
*   options:   cc  (climate change)
*             nocc (no climate change)

******* Calibration factor
table f14_yld_calib(i,ltype14) Calibration factor for the LPJmL yields (1)
$ondelim
$include "./modules/14_yields/input/f14_yld_calib.csv"
$offdelim;

table f14_yields(t_all,j,kve,w) LPJmL potential yields per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/lpj_yields.cs3"
$offdelim
;
* set values to 1995 if nocc scenario is used
$if "%c14_yields_scenario%" == "nocc" f14_yields(t_all,j,kve,w) = f14_yields("y1995",j,kve,w);
m_fillmissingyears(f14_yields,"j,kve,w");

table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;

* model hash ID af93162731dc499d3190e4be7b1e533bd6fe7e24
table f31nn_input(j,in_env_s)
$ondelim
$include "./modules/31_past/input/environment_cell.csv"
$offdelim
;
table f31_w1(in_types_s,lns1)
$ondelim
$include "./modules/31_past/input/s_weights_1.csv"
$offdelim
;
table f31_w2(lns1,lns2)
$ondelim
$include "./modules/31_past/input/s_weights_2.csv"
$offdelim
;
table f31_w3(lns2,lns3)
$ondelim
$include "./modules/31_past/input/s_weights_3.csv"
$offdelim
;
table f31_w4(lns3,lns4)
$ondelim
$include "./modules/31_past/input/s_weights_4.csv"
$offdelim
;
table f31_w5(lns4,lns5)
$ondelim
$include "./modules/31_past/input/s_weights_5.csv"
$offdelim
;
table f31_w6(lns5,lns6)
$ondelim
$include "./modules/31_past/input/s_weights_6.csv"
$offdelim
;
table f31_w7(lns6,lns7)
$ondelim
$include "./modules/31_past/input/s_weights_7.csv"
$offdelim
;
table f31_w8(lns7,lns8)
$ondelim
$include "./modules/31_past/input/s_weights_8.csv"
$offdelim
;
parameter f31_b1(lns1)
/
$ondelim
$include "./modules/31_past/input/s_bias_1.csv"
$offdelim
/;
parameter f31_b2(lns2)
/
$ondelim
$include "./modules/31_past/input/s_bias_2.csv"
$offdelim
/;
parameter f31_b3(lns3)
/
$ondelim
$include "./modules/31_past/input/s_bias_3.csv"
$offdelim
/;
parameter f31_b4(lns4)
/
$ondelim
$include "./modules/31_past/input/s_bias_4.csv"
$offdelim
/;
parameter f31_b5(lns5)
/
$ondelim
$include "./modules/31_past/input/s_bias_5.csv"
$offdelim
/;
parameter f31_b6(lns6)
/
$ondelim
$include "./modules/31_past/input/s_bias_6.csv"
$offdelim
/;
parameter f31_b7(lns7)
/
$ondelim
$include "./modules/31_past/input/s_bias_7.csv"
$offdelim
/;
parameter f31_b8(lns8)
/
$ondelim
$include "./modules/31_past/input/s_bias_8.csv"
$offdelim
/;
