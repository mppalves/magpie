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


test <- c(0,10,20,30,40,50,70,90,200,300,400)

for(i in 1:length(test)){
  cfg$title <- paste0("correct_factor_NoDefc",test[i])
  cfg$gms$s14_corr_fact <- test[i]
  start_run(cfg=cfg,codeCheck=T)
}
