*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


$setglobal c70_feed_scen  ssp2
*   options:    ssp1,ssp2,ssp3,ssp4,ssp5,constant

scalars
  s70_dist_fact  development          / 0 /
;

scalars
  s70_pyld_intercept     Intercept of linear relationship determining pasture intensification (1)        / 0.24 /
;

table f70_feed_baskets(t_all,i,kap,kall,feed_scen70) Feed baskets in tDM per tDM livestock product (1)
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_feed_baskets.cs3"
$offdelim;


table fm_feed_balanceflow(t_all,i,kap,kall) Balanceflow balance difference between estimated feed baskets and FAO (mio. tDM)
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_feed_balanceflow.cs3"
$offdelim;

table f70_livestock_productivity(t_all,i,sys,feed_scen70) Productivity indicator for livestock production (t FM per animal)
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_livestock_productivity.cs3"
$offdelim;

table f70_cost_regr(kap,cost_regr) Factor requirements livestock (USD04 per tDM (A) and USD (B))
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_capit_liv_regr.csv"
$offdelim
;

parameter f70_slaughter_feed_share(t_all,i,kap,attributes,feed_scen70) Share of feed that is incorprated in animal biomass (1)
/
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_slaughter_feed_share.cs4"
$offdelim
/
;

parameter f70_pyld_slope_reg(i) Regional slope of linear relationship determining pasture intensification (1)
/
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_pyld_slope_reg.cs4"
$offdelim
/;

*###################################### DEVELOPMENT #############################
parameter f70_livestock_GLW3(t,j) livestock numbers per cell
/
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_livstkDist.csv"
$offdelim
/
;

table f70_livestock_conversion(t_all,iso, species70) Feed baskets in tDM per tDM livestock product (1)
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_livestock_conversion.csv"
$offdelim;

table f70_feed_baskets2(t_all,i,kfo_ap,kall,feed_scen70) Feed baskets in tDM per tDM livestock product (1)
$ondelim
$include "./modules/70_livestock/lvtk_aug20/input/f70_feed_baskets.cs3"
$offdelim;


parameter f70_calib(i) calibration yields
/
$ondelim
CAZ, 92.47838
CHA, 1.18776
EUR,  1.00657
IND,  0.74655
JPN,  1.09007
LAM,  1.00782
MEA,  1.28284
NEU,  1.00049
OAS,  2.09429
REF,  1.36277
SSA,  1.00161
USA,  2.44562
$offdelim
/;
*###################################### DEVELOPMENT #############################
