*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q31_prod(j)              Cellular pasture production constraint (mio. tDM per yr)
 q31_carbon(j,ag_pools)   Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)    Costs for putting animals on pastures (mio. USD05MER per yr)
;

* model hash ID af93162731dc499d3190e4be7b1e533bd6fe7e24
variables
v31_inlsu(j,lns1) a
v31_inEnv(j,lns1) a
v31_z1(j,lns1) a
v31_a1(j,lns1) a
v31_z2(j,lns2) a
v31_a2(j,lns2) a
v31_z3(j,lns3) a
v31_a3(j,lns3) a
v31_z4(j,lns4) a
v31_a4(j,lns4) a
v31_z5(j,lns5) a
v31_a5(j,lns5) a
v31_z6(j,lns6) a
v31_a6(j,lns6) a
v31_z7(j,lns7) a
v31_a7(j,lns7) a
;
equations
q31_inlsu(j,lns1) a
q31_inEnv(j,lns1) a
q31_rlsu(j) a
q31_maxlsu(j) a
q31_minlsu(j) a
q31_soilc_yld(j) a
q31_z1(j,lns1) a
q31_a1(j,lns1) a
q31_z2(j,lns2) a
q31_a2(j,lns2) a
q31_z3(j,lns3) a
q31_a3(j,lns3) a
q31_z4(j,lns4) a
q31_a4(j,lns4) a
q31_z5(j,lns5) a
q31_a5(j,lns5) a
q31_z6(j,lns6) a
q31_a6(j,lns6) a
q31_z7(j,lns7) a
q31_a7(j,lns7) a
;
positive variables
v31_soilc_yld(j) a
v31_rlsu(j) a
;
scalars
s31_mean lsu conversion factor /1.12500723594219/
s31_std lsu conversion factor /0.733845338253695/
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq31_prod(t,j,type)            Cellular pasture production constraint (mio. tDM per yr)
 oq31_carbon(t,j,ag_pools,type) Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)  Costs for putting animals on pastures (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
