# LE

use http://fmwww.bc.edu/RePEc/bocode/o/oaxaca.dta, replace

oaxaca lnwage educ exper tenure, by(female)

reg lnwage educ exper tenure if female==0
reg lnwage educ exper tenure if female==1
oaxaca lnwage educ exper tenure, by(female) weight(1)

oaxaca lnwage educ exper tenure, by(female) noi weight(1)

oaxaca lnwage educ exper tenure, by(female) pooled
