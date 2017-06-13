*********************************************************************************************
** Instrumental Variable Estimation: Evans Example - Twin Study (Based on PS by Prof. Evans)
*********************************************************************************************

use twin1st, replace

** generate variables
gen second=kids>1

tab second twin1st
su worked weeks
su lincome, detail

** run OLS of weeks on second
reg weeks second

** run the first stage, does having a twin (z) increase the kids in the home (x)?
reg second twin1st

** run the reduced form, impact of twins (z)
reg weeks twin1st

** run the 2sls model (Wald estimate)
ivregress 2sls weeks (second=twin1st)

