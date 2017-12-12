# LE

use http://fmwww.bc.edu/RePEc/bocode/o/oaxaca.dta, replace

bys female: su lnwage educ exper tenure 
reg lnwage educ exper tenure if female==0
reg lnwage educ exper tenure if female==1

* weight(0) uses the Group 2 (Female) coefficients as the reference coefficients
oaxaca lnwage educ exper tenure, by(female) weight(0) 

* weight(1) uses the Group 1 (Male) coefficients as the reference coefficients
oaxaca lnwage educ exper tenure, by(female) weight(1)

* noisily displays the models' estimation output.
oaxaca lnwage educ exper tenure, by(female) weight(1) noisily 

*  pooled computes the two-fold decomposition using the coefficients from a pooled model over both groups as the reference coefficients. groupvar is included in the pooled model as an additional control variable.
oaxaca lnwage educ exper tenure, by(female) pooled
