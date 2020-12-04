*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** EOF presolve.gms ***
vm_lsu.l(j2) = 0;
v31_inlsu.l(j2,lns1) = sum(in_lsu_s, vm_lsu.l(j2) * f31_w1(in_lsu_s,lns1));
v31_inEnv.l(j2,lns1) = sum(in_env_s, f31_nn_input(j2,in_env_s) * f31_w1(in_env_s,lns1));
v31_z1.l(j2,lns1) = v31_inlsu.l(j2,lns1) + v31_inEnv.l(j2,lns1) + f31_b1(lns1);
v31_a1.l(j2,lns1) = ((system.sqrt(power(v31_z1.l(j2,lns1),2) + 1) -1)/2)*v31_z1.l(j2,lns1);
v31_z2.l(j2,lns2) = sum(lns1, v31_a1.l(j2,lns1) * f31_w2(lns1,lns2)) + f31_b2(lns2);
v31_a2.l(j2,lns2) = ((system.sqrt(power(v31_z2.l(j2,lns2),2) + 1) -1)/2)*v31_z2.l(j2,lns2);
v31_z3.l(j2,lns3) = sum(lns2, v31_a2.l(j2,lns2) * f31_w3(lns2,lns3)) + f31_b3(lns3);
v31_a3.l(j2,lns3) = ((system.sqrt(power(v31_z3.l(j2,lns3),2) + 1) -1)/2)*v31_z3.l(j2,lns3);
v31_soilc_yld.l(j2) = sum((lns3,lns4), v31_a3.l(j2,lns3) * f31_w4(lns3,lns4) + f31_b4(lns4));
