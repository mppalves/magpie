*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Demand for different feed items is derived by multiplying the regional
*' livestock production with the respective feed baskets. Additionally,
*' inconsistencies with the FAO inventory of national feed use in the case of
*' crops as well as consideration of alternative feed sources that reduce e.g.
*' the demand for grazed biomass like scavenging and roadside grazing are
*' balanced out by the parameter `fm_feed_balanceflow`.

q70_feed(i2,kap,kall) ..
 vm_dem_feed(i2,kap,kall) =g= vm_prod_reg(i2,kap)
     *sum(ct,im_feed_baskets(ct,i2,kap,kall))
     +sum(ct,fm_feed_balanceflow(ct,i2,kap,kall));

*' Factor requirement costs (e.g. labour, capital, but without costs for feed)
*' of livestock production depend on the amount of production and the per-unit
*' costs. For ruminant products (milk and meet), we use a regression of per-unit
*' factor costs from the GTAP database [@narayanan_gtap7_2008] and livestock
*' productivity. Here, factor costs rise with intensification. The per-unit
*' costs for non-ruminants and fish are assumed to be independent from
*' productivity trajectories for simplification. Therefore,
*' `f70_cost_regr(kli,"cost_regr_b")` is set to zero in the case of livestock
*' products generated in monogastric systems.

q70_cost_prod_liv(i2,kli) ..
 vm_cost_prod(i2,kli) =e= vm_prod_reg(i2,kli)
     *(f70_cost_regr(kli,"cost_regr_a") + f70_cost_regr(kli,"cost_regr_b")
     *sum((ct, sys_to_kli(sys,kli)),i70_livestock_productivity(ct,i2,sys)));

q70_cost_prod_fish(i2) ..
 vm_cost_prod(i2,"fish") =e=
     vm_prod_reg(i2,"fish")*f70_cost_regr("fish","cost_regr_a");

q70_total_lvstk(j2)..
  v70_total_lvstk(j2) =e= sum(ct,vm_rlsu(ct,j2)) * vm_land(j2,"past");

$ontext
q70_lsu_range_max(j2)..
  v70_total_lvstk(j2) =l= 1.1 * sum(ct, p70_lsu_limit(ct,j2));

q70_lsu_range_min(j2)..
  v70_total_lvstk(j2) =g= 0.9 * sum(ct, p70_lsu_limit(ct,j2));
*  v70_total_lvstk(j2) =g= sum(ct, f70_livestock_cell(ct,j2)/1e6);
$offtext

*development
q70_dem_past(j2)..
 v70_dem_past(j2) =e= sum((cell(i2,j2),kli), vm_dem_feed(i2,kli,"pasture"));

q70_total_lvstk_regress(j2)..
v70_total_lvstk(j2) =g= sum(ct,  4.98e-01 + 3.05e-04 * i70_gdp_pc_ppp(ct,j2) + 1.10e+02 * vm_prod(j2,"livst_rum") - 1.14e+02 * vm_prod(j2,"livst_milk") - 1.04e-02 * i70_pop(ct,j2) - 1.12e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") + 5.57e+02 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") - 4.15e-04 * i70_gdp_pc_ppp(ct,j2) * i70_livestock_conversion(ct,j2) - 1.14e+02 * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) + 2.27e+02 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) + 5.13e-01 * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) + 1.20e-02 * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) - 3.95e-04 * i70_gdp_pc_ppp(ct,j2) * i70_urb_ratio(ct,j2) - 2.50e+02 * vm_prod(j2,"livst_rum") * i70_urb_ratio(ct,j2) + 7.99e+01 * vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) + 3.18e-02 * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 1.51e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") - 4.78e-03 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) + 1.69e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) - 7.26e+02 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) + 4.08e-06 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_pop(ct,j2) - 2.35e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) - 1.80e+00 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) - 7.00e-01 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 1.21e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_urb_ratio(ct,j2) + 1.59e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) - 8.08e+02 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) + 4.77e-04 * i70_gdp_pc_ppp(ct,j2) * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) + 4.47e+02 * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 3.05e+02 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 7.80e-07 * i70_gdp_pc_ppp(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 1.21e-01 * vm_prod(j2,"livst_rum") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 3.89e-01 * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 3.61e-02 * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 1.78e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) + 5.18e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) + 2.33e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 2.43e+00 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 2.00e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) - 1.23e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 2.12e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) + 1.05e+03 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 1.47e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 2.68e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 2.73e+00 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 9.73e-07 * i70_gdp_pc_ppp(ct,j2) * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 7.03e-01 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 6.64e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) - 2.34e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 8.10e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 1.30e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 2.87e-05 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 3.67e+00 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 1.04e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2));

$ontext
gpdpc_region i70_gdp_pc_ppp(ct,j2)
meat_cell vm_prod(j2,"livst_rum")
milk_cell vm_prod(j2,"livst_milk")
pop_region i70_pop(ct,j2)
urban_ratio_region i70_urb_ratio(ct,j2)
LU_region  i70_livestock_conversion(ct,j2)

i70_livestock_conversion(t_all,j)
i70_gdp_pc_ppp(t_all,j)
i70_pop(t_all,j)
i70_urb_ratio(t_all,j)
$offtext
