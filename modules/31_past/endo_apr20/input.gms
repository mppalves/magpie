*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


scalars
  s31_fac_req_past  Factor requirements (USD05MER per tDM)          / 1 /
;

table f31_coefs(j,soilc_reg) Pasture soil carbon regression coeficients
$ondelim
$include "./modules/31_past/input/lpj_soil_emu.csv"
$offdelim
;
