*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description In the dynamic_aug18 realization, the crop yield calculations
*' are identical as in the above described realization (biocorrect).
*' Additionally, this realization also calculates the growing stocks in commercial
*' plantations and natural vegetation using LPJmL Carbon stocks.
*'
*' @limitations The exogenous implementation of pasture intensification cannot
*' capture feedbacks between land scarcity and efforts to improve pasture
*' management.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/cont_may210/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/cont_may210/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/cont_may210/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/cont_may210/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/cont_may210/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/cont_may210/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/cont_may210/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/cont_may210/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/cont_may210/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
