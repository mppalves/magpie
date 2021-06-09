*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*s31_test_scalar = 0;

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov31_past_area(t,j,past_mngt,w,"marginal")  = v31_past_area.m(j,past_mngt,w);
 oq31_carbon(t,j,ag_pools,"marginal")        = q31_carbon.m(j,ag_pools);
 oq31_cost_prod_past(t,i,"marginal")         = q31_cost_prod_past.m(i);
 oq31_bv_manpast(t,j,potnatveg,"marginal")   = q31_bv_manpast.m(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"marginal") = q31_bv_rangeland.m(j,potnatveg);
 oq31_pasture_areas(t,j,"marginal")          = q31_pasture_areas.m(j);
 oq31_prod_pm(t,j,"marginal")                = q31_prod_pm.m(j);
 ov31_past_area(t,j,past_mngt,w,"level")     = v31_past_area.l(j,past_mngt,w);
 oq31_carbon(t,j,ag_pools,"level")           = q31_carbon.l(j,ag_pools);
 oq31_cost_prod_past(t,i,"level")            = q31_cost_prod_past.l(i);
 oq31_bv_manpast(t,j,potnatveg,"level")      = q31_bv_manpast.l(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"level")    = q31_bv_rangeland.l(j,potnatveg);
 oq31_pasture_areas(t,j,"level")             = q31_pasture_areas.l(j);
 oq31_prod_pm(t,j,"level")                   = q31_prod_pm.l(j);
 ov31_past_area(t,j,past_mngt,w,"upper")     = v31_past_area.up(j,past_mngt,w);
 oq31_carbon(t,j,ag_pools,"upper")           = q31_carbon.up(j,ag_pools);
 oq31_cost_prod_past(t,i,"upper")            = q31_cost_prod_past.up(i);
 oq31_bv_manpast(t,j,potnatveg,"upper")      = q31_bv_manpast.up(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"upper")    = q31_bv_rangeland.up(j,potnatveg);
 oq31_pasture_areas(t,j,"upper")             = q31_pasture_areas.up(j);
 oq31_prod_pm(t,j,"upper")                   = q31_prod_pm.up(j);
 ov31_past_area(t,j,past_mngt,w,"lower")     = v31_past_area.lo(j,past_mngt,w);
 oq31_carbon(t,j,ag_pools,"lower")           = q31_carbon.lo(j,ag_pools);
 oq31_cost_prod_past(t,i,"lower")            = q31_cost_prod_past.lo(i);
 oq31_bv_manpast(t,j,potnatveg,"lower")      = q31_bv_manpast.lo(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"lower")    = q31_bv_rangeland.lo(j,potnatveg);
 oq31_pasture_areas(t,j,"lower")             = q31_pasture_areas.lo(j);
 oq31_prod_pm(t,j,"lower")                   = q31_prod_pm.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
