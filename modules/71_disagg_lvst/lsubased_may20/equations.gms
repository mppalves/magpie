*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q71_lsu_dem_cluster(j2) ..
      v71_lsu_dem_cluster(j2) =e= vm_rlsu(j2) * vm_land(j2,"past");

q71_lsu_dem_reg(i2) ..
      v71_lsu_dem_reg(i2) =e= sum(cell(i2,j2), vm_rlsu(j2) * vm_land(j2,"past"));

q71_lsu_dem_reg_disagg(j2)..
      v71_lsu_dem_reg_disagg(j2) =e= sum(cell(i2,j2), v71_lsu_dem_reg(i2));

q71_ratio_lsu(j2) ..
      v71_ratio_lsu(j2) =e= v71_lsu_dem_cluster(j2) / (v71_lsu_dem_reg_disagg(j2) + 1e-6);

q71_past_dem_reg_disagg(j2)..
      v71_past_dem_reg_disagg(j2) =e= sum(cell(i2,j2), vm_prod_reg(i2,"pasture"));

q71_ratio_past(j2) ..
      v71_ratio_past(j2) =e= vm_prod(j2,"pasture") / (v71_past_dem_reg_disagg(j2) + 1e-6);

q71_ratio_comparisson(j2)..
      v71_ratio_lsu(j2) + 1 =e= v71_ratio_past(j2) + 1;


*' To account for the above mentioned fact that monogastric livestock are held close to the population, it is
*' distributed based on urban area by the formula

q71_prod_mon_liv(j2,kli_mon) ..
                 vm_prod(j2,kli_mon) =l=
                  i71_urban_area_share(j2) * s71_scale_mon * sum(cell(i2,j2),vm_prod_reg(i2,kli_mon))
                  + v71_additional_mon(j2,kli_mon)
                 ;

*' Note that s71_scale_mon relaxes the constraint (per default by 10%) and v71_additional_mon ensures
*' feasability by punishing additonal monogastric production within a cluster.

*' The punishmment of additional monogastric livestock production are calculated via

q71_punishment_mon(i2) ..
                vm_costs_additional_mon(i2) =e=
                sum((cell(i2,j2),kli_mon), v71_additional_mon(j2,kli_mon)) *  s71_punish_additional_mon
                ;

*' Note that the punishment costs are based on transport costs and scaled up by one order of magnitude
*' of the average transport costs to account for additional transport between clusters.
