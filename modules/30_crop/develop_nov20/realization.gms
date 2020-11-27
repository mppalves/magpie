*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The develop_nov20 realization calculates the crop specific
*' agricultural land use endogenously based on yield data coming from the
*' module [14_yields] and the rotational as well as suitability constrains
*' stated in the input data of the module.
*'
*' Cropland areas are linked to the crop specific production and the carbon
*' content of the different land carbon pools. The crop specific land use areas
*' are also used in [18_residues], [38_factor_costs],
*' [41_area_equipped_for_irrigation], [42_water_demand], [50_nr_soil_budget],
*' [53_methane] and [59_som].

*' @limitations There are currently no known limitations of this realization.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/30_crop/develop_nov20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/30_crop/develop_nov20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/30_crop/develop_nov20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/30_crop/develop_nov20/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/30_crop/develop_nov20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/30_crop/develop_nov20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/30_crop/develop_nov20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
