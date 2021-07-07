# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ---------------------------------------------------------------
# description: Calculates soil carbon stocks based on LSU and climate variables
# comparison script: FALSE
# autor: Marcos Alves
# ---------------------------------------------------------------

library(magpie4)
library(madrat)
library(lucode2)
library(tidyr)
library(magclass)
library(mrmagpie)

############################# BASIC CONFIGURATION ##############################

if (!exists("source_include")) {
  outputdir <- "output/SSP2_Ref_c200"
  readArgs("outputdir")
}

land_hr_out_file           <- try(read.magpie(file.path(outputdir, "cell.land_0.5.mz")), silent = T)
lsu_ha_file                <- try(read.magpie(file.path(outputdir, "lsu_ha.mz")), silent = T)
environment_data           <- try(read.magpie(file.path("./modules/31_past/input/environment_scaled_new.mz")), silent = T)
environment_data           <- try(read.magpie(file.path(outputdir, "environment_scaled_new.mz")), silent = T)
weights                    <- try(readRDS(Sys.glob(file.path(outputdir, "weights_*.rds"))))
input_names                <- try(readRDS(Sys.glob(file.path(outputdir, "inputs_*.Rds"))))
load(paste0(outputdir, "/config.Rdata"))

################################################################################

if (cfg$gms$past != "endo_dec20") {
  stop("This MAgPIE run dont have the grassland management module enabled.")
}
if (attr(land_hr_out_file, "class") == "try-error") {
  stop("Failed to load cell.land_0.5.mz. Make sure the script disaggregate.R
        was succesfully run before")
}
if (attr(lsu_ha_file, "class") == "try-error") {
  stop("Failed to load lsu_ha.nc. Make sure the script disaggregate.R
        was succesfully run before")
}
if (attr(environment_data, "class") == "try-error") {
  stop("Failed to load environment_scaled_new.mz from module 31_past.")
}

# Harmonizing magpie objects names and years
years <- intersect(getYears(environment_data), getYears(lsu_ha_file))
environment_data <- environment_data[, years, ]
lsu_ha_file <- lsu_ha_file[, years, ]
input <- mbind(setNames(lsu_ha_file[, , "range"], grep("lsu", input_names, value = T)), environment_data)
input <- as.data.frame(input)
input_df <- pivot_wider(input, names_from = Data1, values_from = Value)

# Making predictions and saving files
soil_carbon <- toolNeuralNet(input_df[, input_names], weights, "softplus")
soil_carbon <- cbind(input_df[, c("Cell", "Year")], soil_carbon)
soil_carbon <- as.magpie(soil_carbon, spatial = 1)
soil_carbon <- toolCell2isoCell(soil_carbon)
soil_pastr <- land_hr_out_file[, years, "range"] * soil_carbon

.tmpwrite <- function(x, file, comment, message) {
  write.magpie(x, file, comment = comment)
  write.magpie(x, sub(".mz", ".nc", file), comment = comment, verbose = FALSE)
  cat(message)
}

.tmpwrite(soil_carbon, "soil_carbon_base.mz", comment = "unit: grams of Carbon per squared meter (gCm)",
  message = "Write outputs soil_carbon_base")

.tmpwrite(soil_pastr, "soil_pastr.mz", comment = "unit: grams of Carbon per squared meter (gCm)",
  message = "Write outputs soil_pastr")


#####################################################################################################
#####################################################################################################
# Write read anf cal function for the model weights out from the grassland emulator source folder!
#####################################################################################################
#####################################################################################################