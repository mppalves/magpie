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

q31_prod(j2) ..
 vm_prod(j2,"pasture") =l= vm_land(j2,"past")
 						   * vm_yld(j2,"pasture","rainfed");

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools) ..
 vm_carbon_stock(j2,"past",ag_pools) =e=
         sum(ct, vm_land(j2,"past")*fm_carbon_density(ct,j2,"past",ag_pools));

*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

q31_cost_prod_past(i2) ..
 vm_cost_prod(i2,"pasture") =e= vm_prod_reg(i2,"pasture")
 								* s31_fac_req_past;

*' For all following time steps, factor requriements `s31_fac_req_past` are set
*' to zero.

* model hash ID af93162731dc499d3190e4be7b1e533bd6fe7e24
q31_inlsu(j2,lns1)..  v31_inlsu(j2,lns1) =e= sum(in_lsu_s, vm_lsu(j2) * f31_w1(in_lsu_s,lns1));
q31_inEnv(j2,lns1)..  v31_inEnv(j2,lns1) =e= sum(in_env_s, f31_nn_input(j2,in_env_s) * f31_w1(in_env_s,lns1));
q31_z1(j2,lns1)..  v31_z1(j2,lns1) =e= v31_inlsu(j2,lns1) + v31_inEnv(j2,lns1) + f31_b1(lns1);
q31_a1(j2,lns1)..  v31_a1(j2,lns1) =e= log(1 + system.exp(v31_z1(j2,lns1)));
q31_z2(j2,lns2)..  v31_z2(j2,lns2) =e= sum(lns1, v31_a1(j2,lns1) * f31_w2(lns1,lns2)) + f31_b2(lns2);
q31_a2(j2,lns2)..  v31_a2(j2,lns2) =e= log(1 + system.exp(v31_z2(j2,lns2)));
q31_z3(j2,lns3)..  v31_z3(j2,lns3) =e= sum(lns2, v31_a2(j2,lns2) * f31_w3(lns2,lns3)) + f31_b3(lns3);
q31_a3(j2,lns3)..  v31_a3(j2,lns3) =e= log(1 + system.exp(v31_z3(j2,lns3)));
q31_z4(j2,lns4)..  v31_z4(j2,lns4) =e= sum(lns3, v31_a3(j2,lns3) * f31_w4(lns3,lns4)) + f31_b4(lns4);
q31_a4(j2,lns4)..  v31_a4(j2,lns4) =e= log(1 + system.exp(v31_z4(j2,lns4)));
q31_z5(j2,lns5)..  v31_z5(j2,lns5) =e= sum(lns4, v31_a4(j2,lns4) * f31_w5(lns4,lns5)) + f31_b5(lns5);
q31_a5(j2,lns5)..  v31_a5(j2,lns5) =e= log(1 + system.exp(v31_z5(j2,lns5)));
q31_z6(j2,lns6)..  v31_z6(j2,lns6) =e= sum(lns5, v31_a5(j2,lns5) * f31_w6(lns5,lns6)) + f31_b6(lns6);
q31_a6(j2,lns6)..  v31_a6(j2,lns6) =e= log(1 + system.exp(v31_z6(j2,lns6)));
q31_z7(j2,lns7)..  v31_z7(j2,lns7) =e= sum(lns6, v31_a6(j2,lns6) * f31_w7(lns6,lns7)) + f31_b7(lns7);
q31_a7(j2,lns7)..  v31_a7(j2,lns7) =e= log(1 + system.exp(v31_z7(j2,lns7)));
q31_soilc_yld(j2)..  v31_soilc_yld(j2) =e= sum((lns7,lns8), v31_a7(j2,lns7) * f31_w8(lns7,lns8) + f31_b8(lns8));
q31_maxlsu(j2)..  vm_lsu(j2) =l= 2;
q31_minlsu(j2)..  vm_lsu(j2) =g= -2;
q31_rlsu(j2)..  v31_rlsu(j2) =e= vm_lsu(j2) * s31_std + s31_mean;

*** EOF constraints.gms ***
