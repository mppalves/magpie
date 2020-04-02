*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields(t,j,kve,w)               Biophysical input yields (excluding technological change) (tDM per ha per yr)
 p14_pyield_LPJ_reg(t_all,i)         Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)                Regional pasture management correction for historical time steps (1)
;

positive variables
 vm_yld(j,kve,w)                     Yields (variable because of technical change) (tDM per ha per yr)
;

equations
 q14_yield_crop(j,kcr,w)             Crop yields (tDM per ha per yr)
 q14_yield_past(j,w)                 Pasture yields (tDM per ha per yr)
;

* model hash ID 2b6bbb2913486ce8498891cb1057c91bfaac3a14
variables
vm_lsu(j) a
v14_inlsu(j,lnp1) a
v14_inEnv(j,lnp1) a
v14_z1(j,lnp1) a
v14_a1(j,lnp1) a
v14_z2(j,lnp2) a
v14_a2(j,lnp2) a
v14_z3(j,lnp3) a
v14_a3(j,lnp3) a
v14_z4(j,lnp4) a
v14_a4(j,lnp4) a
v14_z5(j,lnp5) a
v14_a5(j,lnp5) a
v14_z6(j,lnp6) a
v14_a6(j,lnp6) a
v14_z7(j,lnp7) a
v14_a7(j,lnp7) a
;
equations
q14_inlsu(j,lnp1) a
q14_inEnv(j,lnp1) a
q14_rlsu(j) a
q14_maxlsu(j) a
q14_minlsu(j) a
q14_past_yld(j) a
q14_z1(j,lnp1) a
q14_a1(j,lnp1) a
q14_z2(j,lnp2) a
q14_a2(j,lnp2) a
q14_z3(j,lnp3) a
q14_a3(j,lnp3) a
q14_z4(j,lnp4) a
q14_a4(j,lnp4) a
q14_z5(j,lnp5) a
q14_a5(j,lnp5) a
q14_z6(j,lnp6) a
q14_a6(j,lnp6) a
q14_z7(j,lnp7) a
q14_a7(j,lnp7) a
;
positive variables
v14_past_yld(j) a
v14_rlsu(j) a
;
scalars
s14_mean lsu conversion factor /1.12500723594219/
s14_std lsu conversion factor /0.733845338253695/
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)          Yields (variable because of technical change) (tDM per ha per yr)
 oq14_yield_crop(t,j,kcr,w,type) Crop yields (tDM per ha per yr)
 oq14_yield_past(t,j,w,type)     Pasture yields (tDM per ha per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
