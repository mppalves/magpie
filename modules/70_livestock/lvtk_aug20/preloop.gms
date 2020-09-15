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

$ontext
loop (t_past,
 p70_lsu_limit(t_past,j) = f70_livestock_cell(t_past,j);
);
$offtext

p70_lsu_limit(t,j) = f70_livestock_cell(t,j);


*p70_livestock_conversion(t_all,j) = sum(cell(i,j), sum(i_to_iso(i,iso), f70_livestock_conversion(t_all,iso, "Large"))/sum(i_to_iso(i,iso),1));
p70_livestock_conversion(t_all,i) = sum(i_to_iso(i,iso), f70_livestock_conversion(t_all,iso, "Large"))/sum(i_to_iso(i,iso),1);
p70_gdp_pc_ppp(t_all,j) = sum(cell(i,j), im_gdp_pc_ppp(t_all,i));
p70_pop(t_all,j) = sum(cell(i,j), im_pop(t_all,i));
p70_urb_ratio(t_all,j) = sum(cell(i,j), im_urb_ratio(t_all,i));
