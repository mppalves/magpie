*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Production of pasture biomass is restricted to pasture area which is
*' delivered as module output together with the resulting geographically
*' explicit production of pasture biomass. Cellular production is calculated by
*' multiplying pasture area `vm_land` with cellular rainfed pasture yields
*' `vm_yld` which are delivered by the module [14_yields]:

*################################ DEVELOPMENT ##################################
  q31_prod(j2) ..
    vm_prod(j2,"pasture") =e= sum(kpm, vm_prod(j2,kpm));

  q31_prod_pm(j2, kpm) ..
   vm_prod(j2,kpm) =e= vm_past_area(j2,kpm,"rainfed") * vm_yld(j2,kpm,"rainfed");

  q31_pasture_areas(j2)..
    sum(kpm, vm_past_area(j2,kpm,"rainfed")) =e= vm_land(j2,"past");

  q31_grazing_prod(j2)..
       vm_grazing_prod(j2) =e= vm_past_area(j2,"cont_grazing","rainfed") * vm_yld(j2,"cont_grazing","rainfed");
  q31_mowing_prod(j2)..
       vm_mowing_prod(j2) =e= vm_past_area(j2,"mowing","rainfed") * vm_yld(j2,"mowing","rainfed");

q31_cost_prod_past(i2) ..
    vm_cost_prod(i2,"pasture") =e= sum(cell(i2,j2), vm_past_area(j2,"mowing","rainfed") * vm_yld(j2,"mowing","rainfed") + sum(ct, vm_lsu_ha(ct,j2)));

* model hash ID ba52f428dfac0f9d5be9f1127cccc8e75210b846
    q31_inlsu(j2,lns1)..  v31_inlsu(j2,lns1) =e= sum(in_lsu_s, vm_lsu(j2) * f31_w1(in_lsu_s,lns1));
    q31_inEnv(j2,lns1)..  v31_inEnv(j2,lns1) =e= sum(in_env_s, f31_nn_input(j2,in_env_s) * f31_w1(in_env_s,lns1));
    q31_z1(j2,lns1)..  v31_z1(j2,lns1) =e= v31_inlsu(j2,lns1) + v31_inEnv(j2,lns1) + f31_b1(lns1);
    q31_a1(j2,lns1)..  v31_a1(j2,lns1) =e= 1/(1 + system.exp(-v31_z1(j2,lns1)));
    q31_z2(j2,lns2)..  v31_z2(j2,lns2) =e= sum(lns1, v31_a1(j2,lns1) * f31_w2(lns1,lns2)) + f31_b2(lns2);
    q31_a2(j2,lns2)..  v31_a2(j2,lns2) =e= 1/(1 + system.exp(-v31_z2(j2,lns2)));
    q31_z3(j2,lns3)..  v31_z3(j2,lns3) =e= sum(lns2, v31_a2(j2,lns2) * f31_w3(lns2,lns3)) + f31_b3(lns3);
    q31_a3(j2,lns3)..  v31_a3(j2,lns3) =e= 1/(1 + system.exp(-v31_z3(j2,lns3)));
    q31_soilc_yld(j2)..  v31_soilc_yld(j2) =e= sum((lns3,lns4), v31_a3(j2,lns3) * f31_w4(lns3,lns4) + f31_b4(lns4));
    q31_maxlsu(j2)..  vm_lsu(j2) =l= 2;
    q31_minlsu(j2)..  vm_lsu(j2) =g= -2;
    q31_rlsu(j2)..  v31_rlsu(j2) =e= vm_lsu(j2) * s31_std + s31_mean;


*################################ DEVELOPMENT ##################################

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools) ..
 vm_carbon_stock(j2,"past",ag_pools) =e=
         sum(ct, vm_land(j2,"past")*fm_carbon_density(ct,j2,"past",ag_pools));

*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

$ontext
q31_cost_prod_past(i2) ..
 vm_cost_prod(i2,"pasture") =e= vm_prod_reg(i2,"pasture")
 								* s31_fac_req_past;
$offtext

*' For all following time steps, factor requriements `s31_fac_req_past` are set
*' to zero.

*** EOF constraints.gms ***
