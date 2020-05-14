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



* model hash ID 9d30d5243cfcd2adb4e0d15fcbb0f1873e8782dc
q31_inlsu(j2,lns1)..  v31_inlsu(j2,lns1) =e= sum(in_lsu_s, vm_lsu(j2) * f31_w1(in_lsu_s,lns1));
q31_inEnv(j2,lns1)..  v31_inEnv(j2,lns1) =e= sum(in_env_s, f31_nn_input(j2,in_env_s) * f31_w1(in_env_s,lns1));
q31_z1(j2,lns1)..  v31_z1(j2,lns1) =e= v31_inlsu(j2,lns1) + v31_inEnv(j2,lns1) + f31_b1(lns1);
q31_a1(j2,lns1)..  v31_a1(j2,lns1) =e= log(1 + system.exp(v31_z1(j2,lns1)));
q31_z2(j2,lns2)..  v31_z2(j2,lns2) =e= sum(lns1, v31_a1(j2,lns1) * f31_w2(lns1,lns2)) + f31_b2(lns2);
q31_a2(j2,lns2)..  v31_a2(j2,lns2) =e= log(1 + system.exp(v31_z2(j2,lns2)));
q31_z3(j2,lns3)..  v31_z3(j2,lns3) =e= sum(lns2, v31_a2(j2,lns2) * f31_w3(lns2,lns3)) + f31_b3(lns3);
q31_a3(j2,lns3)..  v31_a3(j2,lns3) =e= log(1 + system.exp(v31_z3(j2,lns3)));
q31_soilc_yld(j2)..  v31_soilc_yld(j2) =e= (sum((lns3,lns4), v31_a3(j2,lns3) * f31_w4(lns3,lns4) + f31_b4(lns4))+2.281819) * 10543.66 + 9843.049;


q31_carbon_soilc(j2,c_pools) ..
  vm_carbon_stock(j2,"past","soilc") =e= (v31_soilc_yld(j2)/1e6/10000) * vm_land(j2,"past");


q31_past_factor(i2) ..
  v31_past_fraction(i2) =e= (sum((ct,kli_rum),im_feed_baskets(ct,i2,kli_rum,"pasture")) /
                                          sum((ct,kli_rum,kall),im_feed_baskets(ct,i2,kli_rum,kall)));

q31_prod_lsu(j2,k) ..
  vm_prod(j2,"pasture") =g= (vm_rlsu(j2) * vm_land(j2,"past") * (4000 * 2.25/1e6) * 365)
                                               * sum(cell(i2,j2),v31_past_fraction(i2));

*** EOF constraints.gms ***
