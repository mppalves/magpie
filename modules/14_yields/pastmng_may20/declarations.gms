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

* model hash ID a0045b6118215f5e5ffdaaef64fbc7168f1bc851
variables
vm_lsu(j) LSU variable
v14_inlsu(j,lnp1) LSU input layer
v14_inEnv(j,lnp1) Environmental input layer
v14_z1(j,lnp1) layer neurons
v14_a1(j,lnp1) layer activation
v14_z2(j,lnp2) layer neurons
v14_a2(j,lnp2) layer activation
v14_z3(j,lnp3) layer neurons
v14_a3(j,lnp3) layer activation
v14_z4(j,lnp4) layer neurons
v14_a4(j,lnp4) layer activation
v14_z5(j,lnp5) layer neurons
v14_a5(j,lnp5) layer activation
v14_z6(j,lnp6) layer neurons
v14_a6(j,lnp6) layer activation
v14_z7(j,lnp7) layer neurons
v14_a7(j,lnp7) layer activation
;
equations
q14_inlsu(j,lnp1) LSU input equation
q14_inEnv(j,lnp1) LSU input equation
q14_rlsu(j) real lsu equation
q14_maxlsu(j) max LSU
q14_minlsu(j) min LSU
q14_past_yld(j) output equation
q14_z1(j,lnp1) layer equation
q14_a1(j,lnp1) activation equation
q14_z2(j,lnp2) layer equation
q14_a2(j,lnp2) activation equation
q14_z3(j,lnp3) layer equation
q14_a3(j,lnp3) activation equation
q14_z4(j,lnp4) layer equation
q14_a4(j,lnp4) activation equation
q14_z5(j,lnp5) layer equation
q14_a5(j,lnp5) activation equation
q14_z6(j,lnp6) layer equation
q14_a6(j,lnp6) activation equation
q14_z7(j,lnp7) layer equation
q14_a7(j,lnp7) activation equation
*q14_min_tc(j) min tc value
;
positive variables
v14_past_yld(j) output variable
vm_rlsu(j) real LSU variable
;
variable
vm_rlx_past(j)  technological change pasture
;

scalars
s14_mean lsu conversion factor /1.12477570376585/
s14_std lsu conversion factor /0.733718079997699/
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)          Yields (variable because of technical change) (tDM per ha per yr)
 oq14_yield_crop(t,j,kcr,w,type) Crop yields (tDM per ha per yr)
 oq14_yield_past(t,j,w,type)     Pasture yields (tDM per ha per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
