*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s31_test_scalar  Factor requirements (USD05MER per tDM)          / 1 /
;

table f31_past_suitability(t_all,j,past_suit,ssp_past) LPJmL potential yields per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/31_past/input/f31_pastr_suitability.cs3"
$offdelim
;

table fm_LUH2v2(t_all,j,f14_luh) LPJmL potential yields per cell (rainfed and irrigated) (tDM per ha per yr)
$ondelim
$include "./modules/31_past/input/f31_LUH2v2.cs3"
$offdelim
;

Parameter
grassland_costs(past_mngt) "past costs" / pastr 10, range 20 /;
