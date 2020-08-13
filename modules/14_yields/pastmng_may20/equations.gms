*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

***CROP YIELD CALCULATIONS**********************************************
q14_yield_crop(j2,kcr,w) ..
 vm_yld(j2,kcr,w) =e= sum(ct,i14_yields(ct,j2,kcr,w))*sum(cell(i2,j2),vm_tau(i2)/fm_tau1995(i2));


***PASTURE YIELD CALCULATIONS*******************************************
*' Pasture yields are not linked to yield increases in the crop sector, but to
*' an exogenous pasture management factor `pm_past_mngmnt_factor`:

*q14_yield_past(j2,w) ..
* vm_yld(j2,"pasture",w) =e=
* sum(ct,(i14_yields(ct,j2,"pasture",w)
* *sum(cell(i2,j2),pm_past_mngmnt_factor(ct,i2))));

* model hash ID f41f19be671fe2b50f989841d666fd8008141a78
q14_inlsu(j2,lnp1)..  v14_inlsu(j2,lnp1) =e= sum((in_lsu_p, ct), vm_lsu(ct,j2) * f14_w1(in_lsu_p,lnp1));
q14_inEnv(j2,lnp1)..  v14_inEnv(j2,lnp1) =e= sum((in_env_p, ct), f14_nn_input(ct,j2,in_env_p) * f14_w1(in_env_p,lnp1));
q14_z1(j2,lnp1)..  v14_z1(j2,lnp1) =e= v14_inlsu(j2,lnp1) + v14_inEnv(j2,lnp1) + f14_b1(lnp1);
q14_a1(j2,lnp1)..  v14_a1(j2,lnp1) =e= log(1 + system.exp(v14_z1(j2,lnp1)));
q14_z2(j2,lnp2)..  v14_z2(j2,lnp2) =e= sum(lnp1, v14_a1(j2,lnp1) * f14_w2(lnp1,lnp2)) + f14_b2(lnp2);
q14_a2(j2,lnp2)..  v14_a2(j2,lnp2) =e= log(1 + system.exp(v14_z2(j2,lnp2)));
q14_z3(j2,lnp3)..  v14_z3(j2,lnp3) =e= sum(lnp2, v14_a2(j2,lnp2) * f14_w3(lnp2,lnp3)) + f14_b3(lnp3);
q14_a3(j2,lnp3)..  v14_a3(j2,lnp3) =e= log(1 + system.exp(v14_z3(j2,lnp3)));
q14_z4(j2,lnp4)..  v14_z4(j2,lnp4) =e= sum(lnp3, v14_a3(j2,lnp3) * f14_w4(lnp3,lnp4)) + f14_b4(lnp4);
q14_a4(j2,lnp4)..  v14_a4(j2,lnp4) =e= log(1 + system.exp(v14_z4(j2,lnp4)));
q14_z5(j2,lnp5)..  v14_z5(j2,lnp5) =e= sum(lnp4, v14_a4(j2,lnp4) * f14_w5(lnp4,lnp5)) + f14_b5(lnp5);
q14_a5(j2,lnp5)..  v14_a5(j2,lnp5) =e= log(1 + system.exp(v14_z5(j2,lnp5)));
q14_z6(j2,lnp6)..  v14_z6(j2,lnp6) =e= sum(lnp5, v14_a5(j2,lnp5) * f14_w6(lnp5,lnp6)) + f14_b6(lnp6);
q14_a6(j2,lnp6)..  v14_a6(j2,lnp6) =e= log(1 + system.exp(v14_z6(j2,lnp6)));
q14_z7(j2,lnp7)..  v14_z7(j2,lnp7) =e= sum(lnp6, v14_a6(j2,lnp6) * f14_w7(lnp6,lnp7)) + f14_b7(lnp7);
q14_a7(j2,lnp7)..  v14_a7(j2,lnp7) =e= log(1 + system.exp(v14_z7(j2,lnp7)));
q14_past_yld(j2)..  v14_past_yld(j2) =e= sum((lnp7,lnp8), v14_a7(j2,lnp7) * f14_w8(lnp7,lnp8) + f14_b8(lnp8));
q14_maxlsu(j2)..  sum(ct, vm_lsu(ct,j2)) =l= 2.5;
q14_minlsu(j2)..  sum(ct, vm_lsu(ct,j2)) =g= -2.5;
q14_rlsu(j2)..  vm_rlsu(j2) =e= sum(ct,vm_lsu(ct,j2)) * s14_std + s14_mean;


* q14_yield_past(j2,w)..
*   vm_yld(j2,"pasture","rainfed") =e= v14_past_yld(j2) * 0.01 * 0.45 * v14_rlx_past(j2);
*q14_min_tc(j2).. v14_rlx_past(j2) =g= 0;

q14_yield_past(j2,w)..
*     vm_yld(j2,"pasture","rainfed") =e= sum(ct, v14_past_yld(j2) * sum(cell(i2,j2),p14_pyield_corr(ct,i2)) * (10000 * 2.21 / 1e6) * sum(cell(i2,j2),f14_yld_calib(i,"past")));
     vm_yld(j2,"pasture","rainfed") =e= sum(ct, v14_past_yld(j2) * sum(cell(i2,j2),p14_pyield_corr(ct,i2)) * (10000 * 2.21 / 1e6));
q14_correction_factor(ct,j2)..
    v14_correction(ct,j2) =l= f14_correction(ct, j2);
