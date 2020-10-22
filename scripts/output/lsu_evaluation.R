# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# Version 1.0, Marcos Alves
#

library(magclass)
library(magpie4)
library(lucode)
library(luplot)
library(ggplot2)
library(luscale)

options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- "."
}

load(paste0(outputdir, "/config.Rdata"))
file <- paste0(outputdir, "/fulldata.gdx")
folder <-
  file.path(outputdir, paste0(cfg$title, "_livestock_evaluation"))
dir <- outputdir



variables <-
  c(
    "ov70_total_lsus",
    "ov_lsu_ha",
    "oq70_livestock",
    "ov_land",
    "ov_prod",
    "ov_mowing_yld",
    "ov14_past_yld",
    "ov71_cluster_lsu_past_productivity",
    "ov71_past_prod_cluster",
    "ov71_past_prod_reg,Parameter",
    "ov71_regional_lsu_past_productivity",
    "ov71_total_lsu_cluster",
    "ov71_total_lsu_reg",
    "ov_mowing_yld",
    "ov31_past_fraction",
    "ov_carbon_stock",
    "ov71_total_prod_rum_cluster",
    "ov71_total_prod_rum_reg",
    "pm_past_mngmnt_factor",
    "ov_past_area",
    "vm_dem_feed",
    "ov_yld",
    "ov70_lsus",
    "ov70_dem_past",
    "ov14_relax",
    "p70_lsus_dist_weight",
    "lsu_disagg",
    "ov_past_area"
  )

var_names <-
  c(
    "pasture",
    "level",
    "past_mowing.level",
    "pasture.level",
    "past.level",
    "mowing.level",
    "cont_grazing.level",
    "pasture.rainfed.level",
    "livst_rum.level",
    "livst_milk.level",
    "past.soilc.level",
    "Value"
  )


plotvariables <- function(variables,
                          file,
                          var_names,
                          dir,
                          folder,
                          quant = 0.95) {
  setwd(dir)
  dir.create(folder)
  setwd(folder)
  for (variable in variables) {
    setwd("..")
    try(x <- gdx::readGDX(file, variable))
    y <- NULL

    if(is.null(unlist(dimnames(x)[3]))){
      try(dimnames(x)[3] <- "Value")
    }

    names <- var_names[!is.na(match(var_names, unlist(dimnames(x)[3])))]
    print(variable)
    for (i in 1:length(names)) {
      try({
        setwd(folder)
        temp <- list()
        regions <- getRegions(x)
        for (r in getRegions(x)) {
          if (variable %in% c("ov_lsu_ha", "ov14_past_yld")) {
            temp[[r]] <- colSums(x[r, , names[i]]) / dim(x[r, , names[i]])[1]
          } else {
            temp[[r]] <- colSums(x[r, , names[i]])
          }
        }

        magpie_region <- do.call(mbind, temp)
        magpie_region <- as.magpie(aperm(magpie_region, c(3, 2, 1)), spatial = 1)
        getCells(magpie_region) <- regions
        luplot::magpie2ggplot2(magpie_region, title = paste0(cfg$title, " | ", variable," | ",names[i]))
        ggplot2::ggsave(paste0("magpie_", variable, "_", names[i], "_", ".png"),  width = 15, height = 5)
        print(paste0("magpie_", variable, "_", names[i], "_", ".png"))

        y <- luscale::speed_aggregate(x[, , names[i]], rel = read.spam(file.path("../", "0.5-to-c200_sum.spam")))

        for (j in 1:dim(y)[2]) {
          print(paste(unlist(dimnames(y)[2])[j]))
          print(names[i])
          luplot::plotmap2(
            y[, j, names[i]],
            file = paste0(variable, "_", names[i], "_", j, ".png"),
            legend_range = c(0, quantile(y[, j, names[i]], quant)),
            # legend_range = c(0, max(y)),
            lowcol = "grey95",
            midcol = "white",
            highcol = "darkred",
            midpoint = 0
          )
        }
      })
    }
  }
}

plotvariables(variables, file, var_names, dir, folder, quant = 0.95)
