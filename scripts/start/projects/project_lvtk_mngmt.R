# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

  cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev48_c200_690d3718e151be1b450b394c1064b1c5.tgz",
           "rev4.52_h12_magpie.tgz",
           "rev4.52_h12_validation.tgz",
           "calibration_H12_c200_26Feb20.tgz",
           "additional_data_rev3.86.tgz")
  cfg$gms$past <- "endo_dec20"               # def = endo_jun13
  cfg$title <- paste0("code_cleaning_1")
  start_run(cfg=cfg,codeCheck=F)


}
