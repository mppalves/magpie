*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/dynpast_sep20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/dynpast_sep20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/dynpast_sep20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/dynpast_sep20/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/dynpast_sep20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/dynpast_sep20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/dynpast_sep20/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/dynpast_sep20/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/dynpast_sep20/nl_release.gms"
*######################## R SECTION END (PHASES) ###############################
