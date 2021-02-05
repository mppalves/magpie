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


# Calibration
  cfg$results_folder <- "output/:title:"
  cfg$calib_maxiter <- 300
  cfg$recalibrate <- TRUE
  cfg$title <- "calib_run"
  cfg$gms$c_timesteps <- 1
  cfg$output <- c("report")
  cfg$sequential <- TRUE
  cfg$debug <- TRUE
  cfg$damping_factor <- 0.3
  cfg$gms$past <- "endo_dec20"               # def = endo_jun13
  # cfg$gms$land <- "feb15"
  cfg$gms$trade <- "free_apr16"
  start_run(cfg,codeCheck=FALSE)
  magpie4::submitCalibration("H12")


