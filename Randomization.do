clear
set obs 5
gen x=_n
expand 100000

gen temp=runiform()
gen d=(temp>=0.5)

tab d
su x
su x if d==0
su x if d==1
ttest x, by(d)
