
*This do file re-creates Table 3 and Table 4 in Olivetti and Petrongolo "The Economic Consequences of Family Policies: Lessons from a Century of Legislation in High-Income Countries"


************************************************************
*               Table 3 
************************************************************
clear 

use Table3.dta

g perc_total_paid = (total_paid/total_protected)*100
g total_sq=total_protected^2/100


*Placeholder
xi: reg E_gap total_protected total_sq i.year i.country, robust
outreg2 using Table3.xls, replace ctitle("placeholder") label dec(3) keep(total_protected total_sq perc_total_paid avg_payment_rate ecec )
outreg2 using Table3_summary.xls, replace ctitle("`label'") label dec(3) sum drop(_I*)

log using T3regs_stats.log, replace


foreach x in Femp_rate E_gap W_gap fertility {

xi: reg `x' total_protected total_sq i.year i.country, robust
outreg2 using Table3.xls, append ctitle("`label'") label dec(3) keep(total_protected total_sq perc_total_paid avg_payment ecec)
outreg2 using Table3_summary.xls, append ctitle("`label'") label dec(3) sum drop(_I*)

egen country_tag=tag(country) if e(sample)
egen year_min=min(year) if e(sample), by(country)
egen year_max=max(year) if e(sample), by(country)

log on
sum country_tag if e(sample) & country_tag==1
sum year if e(sample)
list country year_min year_max if country_tag==1, sep(0)
log off
drop country_tag-year_max


xi: reg `x' total_protected total_sq perc_total_paid avg_payment ecec i.year i.country, robust
outreg2 using Table3.xls, append ctitle("`label'") label dec(3) keep(total_protected total_sq perc_total_paid avg_payment ecec)
outreg2 using Table3_summary.xls, append ctitle("`label'") label dec(3) sum drop(_I*)

egen country_tag=tag(country) if e(sample)
egen year_min=min(year) if e(sample), by(country)
egen year_max=max(year) if e(sample), by(country)

log on
sum country_tag if e(sample) & country_tag==1
sum year if e(sample)
list country year_min year_max if country_tag==1, sep(0)
log off
drop country_tag-year_max

}

log close




************************************************************
*               Table 3 
************************************************************
 *Note: We have dropped year 2013 for Belgium because of a break in the series (education goes from 3 to 2 education categories (less than college and college+)


clear
u Table4.dta

g total_sq=total_protected^2/100


*Placeholder
xi: reg Femp_rate total_protected total_sq i.year i.country, robust
outreg2 using Table4.xls, replace ctitle("placeholder") label dec(3) keep(total_protected total_sq)
outreg2 using Table4_summary.xls, replace ctitle("`label'") label dec(3) sum drop(_I*)

log using T4regs_stats.log, replace


forvalues i = 1(1)3 {

foreach x in Femp_rate W_gap {

xi: reg `x' total_protected total_sq i.year i.country if edu==`i', robust
outreg2 using Table4.xls, append ctitle("`label'") label dec(3) keep(total_protected total_sq)
outreg2 using Table4_summary.xls, append ctitle("`label'") label dec(3) sum drop(_I*)

egen country_tag=tag(country) if e(sample)
egen year_min=min(year) if e(sample), by(country)
egen year_max=max(year) if e(sample), by(country)

log on
sum country_tag if e(sample) & country_tag==1
sum year if e(sample)
list country year_min year_max if country_tag==1, sep(0)
log off

drop country_tag-year_max

}

}

log close


