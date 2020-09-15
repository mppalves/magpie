*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @code
*' The fbask_jan16 realization of the livestock module also estimates an exogenous
*' pasture management factor `pm_past_mngmnt_factor` that is used to scale
*' biophysical pasture yields in the module [14_yields].

*' The exogenous calculation of pasture management requires information on
*' the number of cattle reared to fulfil the domestic demand for ruminant
*' livestock products:

p70_cattle_stock_proxy(t,i) = im_pop(t,i)*pm_kcal_pc_initial(t,i,"livst_rum")
		              /i70_livestock_productivity(t,i,"sys_beef");

*' The lower bound for `p70_cattle_stock_proxy` is set to 20% of initial cattle
*' stocks in 1995:

p70_cattle_stock_proxy(t,i)$(p70_cattle_stock_proxy(t,i) < 0.2*p70_cattle_stock_proxy("y1995",i)) = 0.2*p70_cattle_stock_proxy("y1995",i);

*' The parameter `p70_incr_cattle` describes the changes in cattle stocks
*' relative to the previous time step:

p70_incr_cattle(t,i)  =  1$(ord(t)=1)
			+ (p70_cattle_stock_proxy(t,i)/p70_cattle_stock_proxy(t-1,i))$(ord(t)>1);

*' The pasture management factor is calculated by applying a linear relationship
*' that links changes in pasture management with changes in cattle stocks:

if (sum(sameas(t_past,t),1) = 1,
   pm_past_mngmnt_factor(t,i) = 1;
else
   pm_past_mngmnt_factor(t,i) =   ( (s70_pyld_intercept + f70_pyld_slope_reg(i)*p70_incr_cattle(t,i)**(5/(m_year(t)-m_year(t-1)))
	         )**((m_year(t)-m_year(t-1))/5) )*pm_past_mngmnt_factor(t-1,i);
 );

 if (sum(sameas(t_past,t),1) <> 1,
 	 p70_lsu_limit(t,j) = p70_lsu_limit(t-1,j);
  );

	p70_total_lvstk(t,i) = -3.011e+03 + 5.154e-02 * im_gdp_pc_ppp(t,i) + 2.689e+03 * vm_dem_food.l(i,"livst_milk") + 4.313e+03 * p70_livestock_conversion(t,i) + 3.924e+01 * im_pop(t,i) + 3.272e+03 * im_urb_ratio(t,i) - 3.739e-02 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") + 1.388e+02 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") - 9.000e-02 * im_gdp_pc_ppp(t,i) * p70_livestock_conversion(t,i) - 3.443e+03 * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) - 1.479e-03 * im_gdp_pc_ppp(t,i) * im_pop(t,i) - 1.667e+01 * vm_dem_food.l(i,"livst_rum") * im_pop(t,i) - 1.356e+01 * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) - 5.604e+01 * p70_livestock_conversion(t,i) * im_pop(t,i) + 1.420e+02 * vm_dem_food.l(i,"livst_rum") * im_urb_ratio(t,i) - 4.321e+03 * vm_dem_food.l(i,"livst_milk") * im_urb_ratio(t,i) - 5.034e+03 * p70_livestock_conversion(t,i) * im_urb_ratio(t,i) - 5.300e+01 * im_pop(t,i) * im_urb_ratio(t,i) + 5.885e-02 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) - 3.202e+02 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) + 9.057e-04 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * im_pop(t,i) + 4.901e-04 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) + 1.154e+00 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) + 2.115e-03 * im_gdp_pc_ppp(t,i) * p70_livestock_conversion(t,i) * im_pop(t,i) + 2.392e+01 * vm_dem_food.l(i,"livst_rum") * p70_livestock_conversion(t,i) * im_pop(t,i) + 1.878e+01 * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) - 4.395e-03 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * im_urb_ratio(t,i) + 5.435e-02 * im_gdp_pc_ppp(t,i) * p70_livestock_conversion(t,i) * im_urb_ratio(t,i) + 5.310e+03 * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_urb_ratio(t,i) + 2.217e-03 * im_gdp_pc_ppp(t,i) * im_pop(t,i) * im_urb_ratio(t,i) + 2.527e+01 * vm_dem_food.l(i,"livst_rum") * im_pop(t,i) * im_urb_ratio(t,i) + 2.057e+01 * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) * im_urb_ratio(t,i) + 7.641e+01 * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) + 1.225e-02 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) - 5.997e-05 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) - 1.293e-03 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * p70_livestock_conversion(t,i) * im_pop(t,i) - 7.245e-04 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) - 1.505e+00 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) - 2.680e-02 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_urb_ratio(t,i) + 2.772e+02 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_urb_ratio(t,i) - 1.407e-03 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * im_pop(t,i) * im_urb_ratio(t,i) - 6.859e-04 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) * im_urb_ratio(t,i) - 2.071e+00 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) * im_urb_ratio(t,i) - 3.157e-03 * im_gdp_pc_ppp(t,i) * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) - 3.663e+01 * vm_dem_food.l(i,"livst_rum") * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) - 2.764e+01 * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) + 7.638e-05 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) - 1.860e-02 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_urb_ratio(t,i) + 1.011e-04 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * im_pop(t,i) * im_urb_ratio(t,i) + 2.013e-03 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) + 1.006e-03 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) + 2.569e+00 * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i) - 1.245e-04 * im_gdp_pc_ppp(t,i) * vm_dem_food.l(i,"livst_rum") * vm_dem_food.l(i,"livst_milk") * p70_livestock_conversion(t,i) * im_pop(t,i) * im_urb_ratio(t,i);

$ontext
	gpdpc_region im_gdp_pc_ppp(t_all,i)
	meat_cell vm_dem_food(i,"livst_rum")
	milk_cell vm_dem_food(i,"livst_milk")
	pop_region im_pop(t_all,i)
	urban_ratio_region im_urb_ratio(t_all,i)
	LU_region  p70_livestock_conversion(t_all,j)
$offtext

p70_check(ct,j) = p70_lsu_limit(ct,j) - f70_livestock_cell(ct,j);
display p70_check;
display p70_lsu_limit;
display p70_total_lvstk;

*' @stop
