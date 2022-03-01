*This do file re-creates Figure 1 in Olivetti and Petrongolo "The Economic Consequences of Family Policies: Lessons from a Century of Legislation in High-Income Countries"

u Figure1.dta, clear

 	
**** Sort by employment in 2010s
sort femptopop6
g country2=_n
labmask country2, val(country) // ssc install labmask

separate femptopop6, by(country == "United States")

label variable femptopop60 "2010s"
label variable femptopop61 " "

g femptopop_1970=femptopop2
label variable femptopop_1970 "1970s"

g femptopop_1980=femptopop3 if femptopop2==. 
label variable femptopop_1980 "1980s"


twoway bar femptopop60 country2, ylab(0(20)80, notick) barwidth(.7) xtitle("") ytitle("") xla(1/30, valuelabel notick ang(60)) fcolor(gray) fintensity(inten20) lcolor(gray) lpattern(solid) || ///
 bar femptopop61 country2, ylab(0(20)80, notick) barwidth(.7) xtitle("") ytitle("") xla(1/30, valuelabel notick ang(60)) fcolor(gray) fintensity(inten50) lcolor(gray) lpattern(solid) || /// 
scatter femptopop4 country2, ms(X) mcolor(green) || ///
 scatter femptopop_1980 country2, ms(th) mcolor(blue) || /// 
scatter femptopop_1970 country2, ms(th) mcolor(red) legend(row(1)) ytitle(Female Employment Rate) 

graph export "Figure1.pdf", replace



