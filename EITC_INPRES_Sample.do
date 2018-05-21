** 1. DID for EITC

** Q2.
gen anykids = (children>=1)
gen post93 = (year>1993)
su children year anykids post93
 
** Q3.
bys anykids post93: su work
mean work, over(anykids post93)
 
** Q4.
gen postXany = post93*anykids
reg work post93 anykids postXany



** Duflo INPRES Example

use inpres_data, replace

reg log_wage education
gen young=(birth_year>=68) if birth_year~=.

tab young high_intensity
bys young high_intensity: su education
bys young high_intensity: su log_wage

gen tp=young * high_intensity

reg education young high_intensity tp
reg log_wage young high_intensity tp

ivregress 2sls log_wage d_treat high_intensity (education=tp)
