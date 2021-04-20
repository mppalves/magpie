*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de




*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_yld(t,j,kve,w,"marginal")                      = vm_yld.m(j,kve,w);
 ov_past_yld(t,j,past_mngt,w,"marginal")           = vm_past_yld.m(j,past_mngt,w);
 oq14_yield_crop(t,j,kcr,w,"marginal")             = q14_yield_crop.m(j,kcr,w);
 oq14_yield_past(t,j,w,"marginal")                 = q14_yield_past.m(j,w);
 oq14_yield_past_contg(t,j,past_mngt,w,"marginal") = q14_yield_past_contg.m(j,past_mngt,w);
 oq14_yield_past_mow(t,j,past_mngt,w,"marginal")   = q14_yield_past_mow.m(j,past_mngt,w);
 ov_yld(t,j,kve,w,"level")                         = vm_yld.l(j,kve,w);
 ov_past_yld(t,j,past_mngt,w,"level")              = vm_past_yld.l(j,past_mngt,w);
 oq14_yield_crop(t,j,kcr,w,"level")                = q14_yield_crop.l(j,kcr,w);
 oq14_yield_past(t,j,w,"level")                    = q14_yield_past.l(j,w);
 oq14_yield_past_contg(t,j,past_mngt,w,"level")    = q14_yield_past_contg.l(j,past_mngt,w);
 oq14_yield_past_mow(t,j,past_mngt,w,"level")      = q14_yield_past_mow.l(j,past_mngt,w);
 ov_yld(t,j,kve,w,"upper")                         = vm_yld.up(j,kve,w);
 ov_past_yld(t,j,past_mngt,w,"upper")              = vm_past_yld.up(j,past_mngt,w);
 oq14_yield_crop(t,j,kcr,w,"upper")                = q14_yield_crop.up(j,kcr,w);
 oq14_yield_past(t,j,w,"upper")                    = q14_yield_past.up(j,w);
 oq14_yield_past_contg(t,j,past_mngt,w,"upper")    = q14_yield_past_contg.up(j,past_mngt,w);
 oq14_yield_past_mow(t,j,past_mngt,w,"upper")      = q14_yield_past_mow.up(j,past_mngt,w);
 ov_yld(t,j,kve,w,"lower")                         = vm_yld.lo(j,kve,w);
 ov_past_yld(t,j,past_mngt,w,"lower")              = vm_past_yld.lo(j,past_mngt,w);
 oq14_yield_crop(t,j,kcr,w,"lower")                = q14_yield_crop.lo(j,kcr,w);
 oq14_yield_past(t,j,w,"lower")                    = q14_yield_past.lo(j,w);
 oq14_yield_past_contg(t,j,past_mngt,w,"lower")    = q14_yield_past_contg.lo(j,past_mngt,w);
 oq14_yield_past_mow(t,j,past_mngt,w,"lower")      = q14_yield_past_mow.lo(j,past_mngt,w);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
