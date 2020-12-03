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


#test <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
test <- 1


for(i in 1:length(test)){

  cfg$input <- c("isimip_rcp-HadGEM2_ES-rcp8p5-co2_rev48_c200_690d3718e151be1b450b394c1064b1c5.tgz",
           "rev4.52_h12_magpie.tgz",
           "rev4.52_h12_validation.tgz",
           "calibration_H12_c200_26Feb20.tgz",
           "additional_data_rev3.86.tgz")
  cfg$force_download <- FALSE
  #cfg$title <- paste0("experiment_11_mod_lpjm_", gsub("\\.","_",test[i]))
  cfg$title <- paste0("soil_experiment_1")
  cfg$output <- c("rds_report","lsu_evaluation","validation","disaggregation")
  #cfg$gms$s31_fac_req_past  <- test[i]
  cfg$gms$livestock <- "lvtk_i_aug20"           # def = fbask_jan16, lvtk_aug20
  cfg$gms$yields <- "nn_aug20"           # def = dynamic_aug18,dynamic_aug20
  cfg$gms$past <- "develop_dec20"             # def = endo_jun13
  cfg$gms$crop <- "develop_nov20"           # "coup2100"
  cfg$gms$c_timesteps <- "coup2100"           # "coup2100"
  cfg$gms$c14_yields_scenario  <- "nocc"   # def = "nocc"

  start_run(cfg=cfg,codeCheck=F)

# Calibration
#  cfg$results_folder <- "output/:title:"
#  cfg$recalibrate <- TRUE
#  cfg$title <- "calib_run"
#  cfg$gms$c_timesteps <- 1
#  cfg$output <- c("report")
#  cfg$sequential <- TRUE
#  start_run(cfg,codeCheck=FALSE)
#  magpie4::submitCalibration("H12")

}
