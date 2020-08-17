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
$ontext
table f14_pyld_hist(t_all,i) Modelled regional pasture yields in the past (tDM per ha per yr)
$ondelim
$include "./modules/14_yields/input/f14_pasture_yields_hist.csv"
$offdelim;
$offtext

* model hash ID 5860897949b623d66f6d6ec7afc6a537638a96da
table f14_nn_input(t_all,j,in_env_p) aggregated environmental cell values
$ondelim
$include "./modules/14_yields/input/environment_cell_ct.csv"
$offdelim
;
table f14_w1(in_types_p,lnp1) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_1.csv"
$offdelim
;
table f14_w2(lnp1,lnp2) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_2.csv"
$offdelim
;
table f14_w3(lnp2,lnp3) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_3.csv"
$offdelim
;
table f14_w4(lnp3,lnp4) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_4.csv"
$offdelim
;
table f14_w5(lnp4,lnp5) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_5.csv"
$offdelim
;
table f14_w6(lnp5,lnp6) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_6.csv"
$offdelim
;
table f14_w7(lnp6,lnp7) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_7.csv"
$offdelim
;
table f14_w8(lnp7,lnp8) weight
$ondelim
$include "./modules/14_yields/input/586089_p_weights_8.csv"
$offdelim
;
parameter f14_b1(lnp1) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_1.csv"
$offdelim
/;
parameter f14_b2(lnp2) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_2.csv"
$offdelim
/;
parameter f14_b3(lnp3) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_3.csv"
$offdelim
/;
parameter f14_b4(lnp4) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_4.csv"
$offdelim
/;
parameter f14_b5(lnp5) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_5.csv"
$offdelim
/;
parameter f14_b6(lnp6) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_6.csv"
$offdelim
/;
parameter f14_b7(lnp7) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_7.csv"
$offdelim
/;
parameter f14_b8(lnp8) bias
/
$ondelim
$include "./modules/14_yields/input/586089_p_bias_8.csv"
$offdelim
/;
