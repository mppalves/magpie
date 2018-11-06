$setglobal c32_aff_mask  noboreal
* options: unrestricted, noboreal, onlytropical
$setglobal c32_aff_policy  none
$setglobal c32_rot_length  rlGTM
$setglobal c32_gs_calib  avg

scalars
  c32_reduction_start        initial annual trade balance reduction      / 0.0025 /
  c32_reduction_regionalized regionalized annual trade balance reduction / 0.005  /
  c32_reduction_globalized   globalized annual trade balance reduction   / 0.01   /
  c32_reduction_fragmented   fragmented annual trade balance reduction   / 0      /
  s32_trade_tariff                                                       / 0 /

  c32_upscaling_factor / 5 /
  c32_ProdExtCost / 10000 /
  c32_LandRednCost / 100000 /
  c32_CostComparison / 2 /
  c32_shift / 9 /

  c32_reESTBcost / 2000 /
  c32_recurring_cost / 100 /
  c32_harvesting_cost / 200 /
  s32_planing_horizon Afforestation planing horizon (years)            / 30 /
;

scalars
        s32_max_aff_area         maximum total global afforestation in Mha    / Inf /
;

parameter f32_aff_mask(j) afforestation mask (binary)
/
$ondelim
$Ifi "%c32_aff_mask%" == "unrestricted" $include "./modules/32_forestry/input/aff_unrestricted.cs2"
$Ifi "%c32_aff_mask%" == "noboreal" $include "./modules/32_forestry/input/aff_noboreal.cs2"
$Ifi "%c32_aff_mask%" == "onlytropical" $include "./modules/32_forestry/input/aff_onlytropical.cs2"
$offdelim
/;

table f32_fac_req_ha(i,fcosts32) Afforestation factor requirement costs (US Dollar 2004 per ha per annum)
$ondelim
$include "./modules/32_forestry/input/f32_fac_req_ha.csv"
$offdelim
;

table f32_harvest_cost_ha(i,fcosts32H) Harvesting cost (US Dollar 2004 per ha)
$ondelim
$include "./modules/32_forestry/input/f32_harvestingcost.csv"
$offdelim
;

table f32_aff_pol(t_all,j,pol32) npi+indc afforestation policy (Mha new forest wrt to 2010)
$ondelim
$include "./modules/32_forestry/input/npi_ndc_aff_pol.cs3"
$offdelim
;

table f32_rot_length(i,rltype) rot length
$ondelim
$include "./modules/32_forestry/input/f32_rot_length.csv"
$offdelim;

parameter f32_production_ratio(i,t_all) percentage of supply coming from plantations (percentage)
/
$ondelim
$include "./modules/32_forestry/input/f32_production_ratio.csv"
$offdelim
/;

parameter f32_production_ratio_FUTURE(i,t_all) percentage of supply coming from plantations (percentage)
/
$ondelim
$include "./modules/32_forestry/input/f32_production_ratio.csv"
$offdelim
/;

parameter f32_forestry_management(i) upscaling factor for forestry plantations
/
$ondelim
$include "./modules/32_forestry/input/f32_forestry_management.csv"
$offdelim
/;

table f32_trade_margin(i,kforestry) costs of freight and insurance (USD per DMT)
$ondelim
$include "./modules/32_forestry/input/f32_trade_margin.cs3"
$offdelim
;

table f32_trade_tariff(i,kforestry) specific duty tariffs (USD per DMT)
$ondelim
$include "./modules/32_forestry/input/f32_trade_tariff.cs3"
$offdelim
;

parameters
f32_distance(j) transport distance to urban center (Minutes)
/
$ondelim
$include "./modules/32_forestry/input/transport_distance.cs2"
$offdelim
/
;

parameter f32_transport_costs(kforestry) transport costs 2004 per tDM per minute (USD)
/
$ondelim
$include "./modules/32_forestry/input/f32_transport_costs.csv"
$offdelim
/;
