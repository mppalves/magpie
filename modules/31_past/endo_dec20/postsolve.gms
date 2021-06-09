*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*s31_test_scalar = 0;

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_past_area(t,j,past_mngt,w,"marginal") = v31_past_area.m(j,past_mngt,w);
 ov31_lsu(t,j,"marginal")                 = v31_lsu.m(j);
 ov31_inlsu(t,j,lns1,"marginal")          = v31_inlsu.m(j,lns1);
 ov31_inEnv(t,j,lns1,"marginal")          = v31_inEnv.m(j,lns1);
 ov31_z1(t,j,lns1,"marginal")             = v31_z1.m(j,lns1);
 ov31_a1(t,j,lns1,"marginal")             = v31_a1.m(j,lns1);
 ov31_z2(t,j,lns2,"marginal")             = v31_z2.m(j,lns2);
 ov31_a2(t,j,lns2,"marginal")             = v31_a2.m(j,lns2);
 ov31_lsu_ha(t,j,"marginal")              = v31_lsu_ha.m(t,j);
 ov31_soilc(t,j,"marginal")               = v31_soilc.m(j);
 ov_soilc_target(t,j,"marginal")          = vm_soilc_target.m(j);
 oq31_carbon(t,j,ag_pools,"marginal")     = q31_carbon.m(j,ag_pools);
 oq31_cost_prod_past(t,i,"marginal")      = q31_cost_prod_past.m(i);
 oq31_pasture_areas(t,j,"marginal")       = q31_pasture_areas.m(j);
 oq31_prod_pm(t,j,"marginal")             = q31_prod_pm.m(j);
 oq31_lsu_convert(t,j,"marginal")         = q31_lsu_convert.m(j);
 oq31_suitability(t,j,"marginal")         = q31_suitability.m(j);
 oq31_yld_lsu(t,j,w,"marginal")           = q31_yld_lsu.m(j,w);
 oq31_inlsu(t,j,lns1,"marginal")          = q31_inlsu.m(j,lns1);
 oq31_inEnv(t,j,lns1,"marginal")          = q31_inEnv.m(j,lns1);
 oq31_soilc_yld(t,j,"marginal")           = q31_soilc_yld.m(j);
 oq31_z1(t,j,lns1,"marginal")             = q31_z1.m(j,lns1);
 oq31_a1(t,j,lns1,"marginal")             = q31_a1.m(j,lns1);
 oq31_z2(t,j,lns2,"marginal")             = q31_z2.m(j,lns2);
 oq31_a2(t,j,lns2,"marginal")             = q31_a2.m(j,lns2);
 oq31_soilc_convert(t,j,"marginal")       = q31_soilc_convert.m(j);
 ov_past_area(t,j,past_mngt,w,"level")    = v31_past_area.l(j,past_mngt,w);
 ov31_lsu(t,j,"level")                    = v31_lsu.l(j);
 ov31_inlsu(t,j,lns1,"level")             = v31_inlsu.l(j,lns1);
 ov31_inEnv(t,j,lns1,"level")             = v31_inEnv.l(j,lns1);
 ov31_z1(t,j,lns1,"level")                = v31_z1.l(j,lns1);
 ov31_a1(t,j,lns1,"level")                = v31_a1.l(j,lns1);
 ov31_z2(t,j,lns2,"level")                = v31_z2.l(j,lns2);
 ov31_a2(t,j,lns2,"level")                = v31_a2.l(j,lns2);
 ov31_lsu_ha(t,j,"level")                 = v31_lsu_ha.l(t,j);
 ov31_soilc(t,j,"level")                  = v31_soilc.l(j);
 ov_soilc_target(t,j,"level")             = vm_soilc_target.l(j);
 oq31_carbon(t,j,ag_pools,"level")        = q31_carbon.l(j,ag_pools);
 oq31_cost_prod_past(t,i,"level")         = q31_cost_prod_past.l(i);
 oq31_pasture_areas(t,j,"level")          = q31_pasture_areas.l(j);
 oq31_prod_pm(t,j,"level")                = q31_prod_pm.l(j);
 oq31_lsu_convert(t,j,"level")            = q31_lsu_convert.l(j);
 oq31_suitability(t,j,"level")            = q31_suitability.l(j);
 oq31_yld_lsu(t,j,w,"level")              = q31_yld_lsu.l(j,w);
 oq31_inlsu(t,j,lns1,"level")             = q31_inlsu.l(j,lns1);
 oq31_inEnv(t,j,lns1,"level")             = q31_inEnv.l(j,lns1);
 oq31_soilc_yld(t,j,"level")              = q31_soilc_yld.l(j);
 oq31_z1(t,j,lns1,"level")                = q31_z1.l(j,lns1);
 oq31_a1(t,j,lns1,"level")                = q31_a1.l(j,lns1);
 oq31_z2(t,j,lns2,"level")                = q31_z2.l(j,lns2);
 oq31_a2(t,j,lns2,"level")                = q31_a2.l(j,lns2);
 oq31_soilc_convert(t,j,"level")          = q31_soilc_convert.l(j);
 ov_past_area(t,j,past_mngt,w,"upper")    = v31_past_area.up(j,past_mngt,w);
 ov31_lsu(t,j,"upper")                    = v31_lsu.up(j);
 ov31_inlsu(t,j,lns1,"upper")             = v31_inlsu.up(j,lns1);
 ov31_inEnv(t,j,lns1,"upper")             = v31_inEnv.up(j,lns1);
 ov31_z1(t,j,lns1,"upper")                = v31_z1.up(j,lns1);
 ov31_a1(t,j,lns1,"upper")                = v31_a1.up(j,lns1);
 ov31_z2(t,j,lns2,"upper")                = v31_z2.up(j,lns2);
 ov31_a2(t,j,lns2,"upper")                = v31_a2.up(j,lns2);
 ov31_lsu_ha(t,j,"upper")                 = v31_lsu_ha.up(t,j);
 ov31_soilc(t,j,"upper")                  = v31_soilc.up(j);
 ov_soilc_target(t,j,"upper")             = vm_soilc_target.up(j);
 oq31_carbon(t,j,ag_pools,"upper")        = q31_carbon.up(j,ag_pools);
 oq31_cost_prod_past(t,i,"upper")         = q31_cost_prod_past.up(i);
 oq31_pasture_areas(t,j,"upper")          = q31_pasture_areas.up(j);
 oq31_prod_pm(t,j,"upper")                = q31_prod_pm.up(j);
 oq31_lsu_convert(t,j,"upper")            = q31_lsu_convert.up(j);
 oq31_suitability(t,j,"upper")            = q31_suitability.up(j);
 oq31_yld_lsu(t,j,w,"upper")              = q31_yld_lsu.up(j,w);
 oq31_inlsu(t,j,lns1,"upper")             = q31_inlsu.up(j,lns1);
 oq31_inEnv(t,j,lns1,"upper")             = q31_inEnv.up(j,lns1);
 oq31_soilc_yld(t,j,"upper")              = q31_soilc_yld.up(j);
 oq31_z1(t,j,lns1,"upper")                = q31_z1.up(j,lns1);
 oq31_a1(t,j,lns1,"upper")                = q31_a1.up(j,lns1);
 oq31_z2(t,j,lns2,"upper")                = q31_z2.up(j,lns2);
 oq31_a2(t,j,lns2,"upper")                = q31_a2.up(j,lns2);
 oq31_soilc_convert(t,j,"upper")          = q31_soilc_convert.up(j);
 ov_past_area(t,j,past_mngt,w,"lower")    = v31_past_area.lo(j,past_mngt,w);
 ov31_lsu(t,j,"lower")                    = v31_lsu.lo(j);
 ov31_inlsu(t,j,lns1,"lower")             = v31_inlsu.lo(j,lns1);
 ov31_inEnv(t,j,lns1,"lower")             = v31_inEnv.lo(j,lns1);
 ov31_z1(t,j,lns1,"lower")                = v31_z1.lo(j,lns1);
 ov31_a1(t,j,lns1,"lower")                = v31_a1.lo(j,lns1);
 ov31_z2(t,j,lns2,"lower")                = v31_z2.lo(j,lns2);
 ov31_a2(t,j,lns2,"lower")                = v31_a2.lo(j,lns2);
 ov31_lsu_ha(t,j,"lower")                 = v31_lsu_ha.lo(t,j);
 ov31_soilc(t,j,"lower")                  = v31_soilc.lo(j);
 ov_soilc_target(t,j,"lower")             = vm_soilc_target.lo(j);
 oq31_carbon(t,j,ag_pools,"lower")        = q31_carbon.lo(j,ag_pools);
 oq31_cost_prod_past(t,i,"lower")         = q31_cost_prod_past.lo(i);
 oq31_pasture_areas(t,j,"lower")          = q31_pasture_areas.lo(j);
 oq31_prod_pm(t,j,"lower")                = q31_prod_pm.lo(j);
 oq31_lsu_convert(t,j,"lower")            = q31_lsu_convert.lo(j);
 oq31_suitability(t,j,"lower")            = q31_suitability.lo(j);
 oq31_yld_lsu(t,j,w,"lower")              = q31_yld_lsu.lo(j,w);
 oq31_inlsu(t,j,lns1,"lower")             = q31_inlsu.lo(j,lns1);
 oq31_inEnv(t,j,lns1,"lower")             = q31_inEnv.lo(j,lns1);
 oq31_soilc_yld(t,j,"lower")              = q31_soilc_yld.lo(j);
 oq31_z1(t,j,lns1,"lower")                = q31_z1.lo(j,lns1);
 oq31_a1(t,j,lns1,"lower")                = q31_a1.lo(j,lns1);
 oq31_z2(t,j,lns2,"lower")                = q31_z2.lo(j,lns2);
 oq31_a2(t,j,lns2,"lower")                = q31_a2.lo(j,lns2);
 oq31_soilc_convert(t,j,"lower")          = q31_soilc_convert.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
