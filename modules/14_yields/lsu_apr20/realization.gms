
*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/14_yields/lsu_apr20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/14_yields/lsu_apr20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/14_yields/lsu_apr20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/14_yields/lsu_apr20/equations.gms"
$Ifi "%phase%" == "scaling" $include "./modules/14_yields/lsu_apr20/scaling.gms"
$Ifi "%phase%" == "preloop" $include "./modules/14_yields/lsu_apr20/preloop.gms"
$Ifi "%phase%" == "presolve" $include "./modules/14_yields/lsu_apr20/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/14_yields/lsu_apr20/solve.gms"
$Ifi "%phase%" == "intersolve" $include "./modules/14_yields/lsu_apr20/intersolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/14_yields/lsu_apr20/postsolve.gms"
$Ifi "%phase%" == "nl_fix" $include "./modules/14_yields/lsu_apr20/nl_fix.gms"
$Ifi "%phase%" == "nl_release" $include "./modules/14_yields/lsu_apr20/nl_release.gms"
$Ifi "%phase%" == "nl_relax" $include "./modules/14_yields/lsu_apr20/nl_relax.gms"
*######################## R SECTION END (PHASES) ###############################
