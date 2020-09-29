*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
loop(t_all,
 if(m_year(t_all) <= sm_fix_SSP2,
  im_slaughter_feed_share(t_all,i,kap,attributes) = f70_slaughter_feed_share(t_all,i,kap,attributes,"ssp2");
  i70_livestock_productivity(t_all,i,sys) = f70_livestock_productivity(t_all,i,sys,"ssp2");
  im_feed_baskets(t_all,i,kap,kall) = f70_feed_baskets(t_all,i,kap,kall,"ssp2");
 else
  im_slaughter_feed_share(t_all,i,kap,attributes) = f70_slaughter_feed_share(t_all,i,kap,attributes,"%c70_feed_scen%");
  i70_livestock_productivity(t_all,i,sys) = f70_livestock_productivity(t_all,i,sys,"%c70_feed_scen%");
  im_feed_baskets(t_all,i,kap,kall) = f70_feed_baskets(t_all,i,kap,kall,"%c70_feed_scen%");
 );
);



*################################# DEVELOPMENT #################################
p70_lsus_dist(t,j) = f70_livestock_GLW3(t,j);
p70_livestock_conversion(t,i) = sum(i_to_iso(i,iso), f70_livestock_conversion(t,iso, "Large"))/sum(i_to_iso(i,iso),1);
p70_lsus_dist_reg(t,i) =  sum(cell(i,j),p70_lsus_dist(t,j));
p70_lsus_dist_weight(t,j)$(p70_lsus_dist(t,j) > 0) = p70_lsus_dist(t,j) / sum(cell(i,j),p70_lsus_dist_reg(t,i));

*################################################################################
p70_total_pasture_demand(i) = sum(k, vm_dem_food(i,k) * sum(t,im_feed_baskets(t,i,k,"pasture")));
* p70_lsus_dist_weight(t,j)
*sum(cell(i2,j2),v70_lsus_reg(i2)) * sum(ct, p70_lsus_dist_weight(ct,j2))
*################################# DEVELOPMENT #################################
