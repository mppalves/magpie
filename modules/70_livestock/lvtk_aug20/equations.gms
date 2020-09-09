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


q70_lsu_range_max(j2)..
  v70_total_lvstk(j2) =l= 1.1 * sum(ct, p70_lsu_limit(ct,j2));

q70_lsu_range_min(j2)..
  v70_total_lvstk(j2) =g= 0.9 * sum(ct, p70_lsu_limit(ct,j2));
*  v70_total_lvstk(j2) =g= sum(ct, f70_livestock_cell(ct,j2)/1e6);


q70_total_lvstk_regress(j2)..
v70_total_lvstk(j2) =l= sum(ct, - 2.96e+00 + 3.08e-05 * i70_gdp_pc_ppp(ct,j2) + 1.96e+03 *
vm_prod(j2,"livst_rum") - 4.84e+02 * vm_prod(j2,"livst_milk") + 8.58e-03 * i70_pop(ct,j2) + 2.34e+01 *
i70_urb_ratio(ct,j2) - 1.49e-01 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") + 5.69e-02 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") - 2.48e+03 * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) + 6.65e+02 *
vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) - 5.65e+00 * vm_prod(j2,"livst_rum") * i70_pop(ct,j2) + 8.54e-01 *
vm_prod(j2,"livst_milk") * i70_pop(ct,j2) - 3.53e+03 * vm_prod(j2,"livst_rum") * i70_urb_ratio(ct,j2) + 7.34e+02 *
vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) - 2.07e+01 * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 5.63e-02 *
i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 3.97e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") *
vm_prod(j2,"livst_milk") + 1.70e-01 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) - 6.34e-02 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) - 6.10e+01 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") *
i70_livestock_conversion(ct,j2) + 4.00e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_pop(ct,j2) - 9.99e-05 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) + 7.85e+00 * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) *
i70_pop(ct,j2) - 1.36e+00 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 2.69e-01 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_urb_ratio(ct,j2) - 1.03e-01 * i70_gdp_pc_ppp(ct,j2) *
vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) + 4.28e+03 * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) *
i70_urb_ratio(ct,j2) - 9.62e+02 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) + 7.13e+00 *
vm_prod(j2,"livst_rum") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 4.77e-02 * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) *
i70_urb_ratio(ct,j2) - 4.29e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") *
i70_livestock_conversion(ct,j2) - 1.05e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) - 5.27e-04 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 1.25e-04 * i70_gdp_pc_ppp(ct,j2) *
vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 8.10e-02 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) *
i70_pop(ct,j2) - 5.69e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_urb_ratio(ct,j2) - 2.98e-01 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) + 1.12e-01 * i70_gdp_pc_ppp(ct,j2) *
vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) + 1.18e+02 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") *
i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) - 5.63e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * i70_pop(ct,j2) *
i70_urb_ratio(ct,j2) + 1.25e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) *
i70_urb_ratio(ct,j2) + 9.95e-02 * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_pop(ct,j2) *
i70_urb_ratio(ct,j2) - 9.64e+00 * vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) *
i70_urb_ratio(ct,j2) + 4.45e-01 * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) *
i70_urb_ratio(ct,j2) + 1.34e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") *
i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) + 5.79e-02 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") *
i70_livestock_conversion(ct,j2) * i70_urb_ratio(ct,j2) + 1.41e-04 * i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") *
vm_prod(j2,"livst_milk") * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) + 7.20e-04 * i70_gdp_pc_ppp(ct,j2) *
vm_prod(j2,"livst_rum") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 1.52e-04 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 3.25e-01 *
vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2) - 1.72e-04 *
i70_gdp_pc_ppp(ct,j2) * vm_prod(j2,"livst_rum") * vm_prod(j2,"livst_milk") * i70_livestock_conversion(ct,j2) * i70_pop(ct,j2) * i70_urb_ratio(ct,j2));

$ontext
i70_gdp_pc_ppp(ct,j2) i70_gdp_pc_ppp(ct,j2)
vm_prod(j2,"livst_rum") vm_prod(j2,"livst_rum")
vm_prod(j2,"livst_milk") vm_prod(j2,"livst_milk")
i70_pop(ct,j2) i70_pop(ct,j2)
i70_urb_ratio(ct,j2) i70_urb_ratio(ct,j2) fazer a desagregation usando a pop como weight
i70_livestock_conversion(ct,j2)  i70_livestock_conversion(ct,j2)

i70_livestock_conversion(t_all,j)
i70_gdp_pc_ppp(t_all,j)
i70_pop(t_all,j)
i70_urb_ratio(t_all,j)
$offtext
