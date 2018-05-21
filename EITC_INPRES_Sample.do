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
