* Jack Ogle Do file for Final Project for new FIgures

clear 


* Need to clean and find all the data for this figure. We have all the outcome variables
* We still need the explantory variables which are:
* Maximum weeks of job-protected leave
* Percentage of total leave that is paid
* Average payment rate
* Early childhood education and care


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

