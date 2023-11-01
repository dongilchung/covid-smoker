%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Table S1 % Jiwon Park % 2023/09/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
load gitHub_Sample1.mat

%% Smoking type, n 
subjS=find(Sample1_smoking_StatusS==1);
subjPS=find(Sample1_smoking_StatusPS==1);
subjNS=find(Sample1_smoking_StatusNS==1);

[length(subjS) length(subjPS) length(subjNS)]
[(Sample1_smoking_nSmoker_Cigarette) (Sample1_smoking_nSmoker_ElectricCigarette) (Sample1_smoking_nSmoker_Both)]

%% Sex: Sample1_demo_Sex
% Smoking status effects
n1 = sum(Sample1_demo_Sex(subjS)); N1 = length(Sample1_demo_Sex(subjS));
n2 = sum(Sample1_demo_Sex(subjPS)); N2 = length(Sample1_demo_Sex(subjPS));
n3 = sum(Sample1_demo_Sex(subjNS)); N3 = length(Sample1_demo_Sex(subjNS));
x1 = [repmat('a',N1,1); repmat('b',N2,1); repmat('c',N3,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1); repmat(1,n3,1); repmat(2,N3-n3,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

% average
[sum(Sample1_demo_Sex) length(Sample1_demo_Sex)-sum(Sample1_demo_Sex)]
[n1 N1-n1; n2 N2-n2; n3 N3-n3]

% S vs. PS 
disp('S vs. PS')
x1 = [repmat('a',N1,1); repmat('b',N2,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

% S vs. NS 
disp('S vs. NS')
x1 = [repmat('a',N1,1); repmat('b',N3,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n3,1); repmat(2,N3-n3,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

% S vs. PS 
disp('PS vs. NS')
x1 = [repmat('a',N2,1); repmat('b',N3,1)];
x2 = [repmat(1,n2,1); repmat(2,N2-n2,1); repmat(1,n3,1); repmat(2,N3-n3,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

%% Age: Sample1_demo_Age
clc;
data=Sample1_demo_Age;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Education: Sample1_demo_Education
clc;
data=Sample1_demo_Education;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Income: Sample1_demo_Income
clc;
data=Sample1_demo_Income;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Political orientation: Sample1_demo_PoliticalOrientation
clc;
data=Sample1_demo_PoliticalOrientation;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))


%% Sex: Sample1_covid_ExistenceOfInfectedNeighborFriend
% Smoking status effects
clc;
data=Sample1_covid_ExistenceOfInfectedNeighborFriend;

n1 = sum(data(subjS)); N1 = length(data(subjS));
n2 = sum(data(subjPS)); N2 = length(data(subjPS));
n3 = sum(data(subjNS)); N3 = length(data(subjNS));
x1 = [repmat('a',N1,1); repmat('b',N2,1); repmat('c',N3,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1); repmat(1,n3,1); repmat(2,N3-n3,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

% average
disp('Agerage')
[sum(data) length(data)-sum(data) sum(data)/length(data)]
[n1 N1-n1 n1/(N1); n2 N2-n2 n2/(N2); n3 N3-n3 n3/(N3)]

% S vs. PS 
disp('S vs. PS')
x1 = [repmat('a',N1,1); repmat('b',N2,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

% S vs. NS 
disp('S vs. NS')
x1 = [repmat('a',N1,1); repmat('b',N3,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n3,1); repmat(2,N3-n3,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

% S vs. PS 
disp('PS vs. NS')
x1 = [repmat('a',N2,1); repmat('b',N3,1)];
x2 = [repmat(1,n2,1); repmat(2,N2-n2,1); repmat(1,n3,1); repmat(2,N3-n3,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)

%% Sample1_covid_PerceivedRiskOfBeingInfected
clc;
data=Sample1_covid_PerceivedRiskOfBeingInfected;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Sample1_covid_PreventiveMotives: social consequence 
clc;
data=Sample1_covid_PreventiveMotives_others;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))


%% Sample1_covid_PreventiveMotives: personal consequence 
clc;
data=Sample1_covid_PreventiveMotives_self;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))


%% Sample1_covid_PreventiveBehaviors
clc;
data=Sample1_covid_PreventiveBehaviors;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Sample1_smoking_SmokingAmount
clc;
data=Sample1_smoking_SmokingAmount;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Sample1_smoking_InitiationAge
clc;
data=Sample1_smoking_InitiationAge;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

%% Sample1_smoking_perceivedRiskOfDirectSmoking
clc;
data=Sample1_smoking_perceivedRiskOfDirectSmoking;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))


%% Sample1_smoking_perceivedRiskOfSecondHandSmoking
clc;
data=Sample1_smoking_perceivedRiskOfSecondHandSmoking;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))


%% Sample1_smoking_perceivedRiskOfDirectSmokingSelf
clc;
data=Sample1_smoking_perceivedRiskOfDirectSmokingSelf;

'average'
[mean(data) std(data); mean(data(subjS)) std(data(subjS)); mean(data(subjPS)) std(data(subjPS)); mean(data(subjNS)) std(data(subjNS));]

'ANOVA'
grp=nan(1,length(data));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)

'S vs. PS'
[h p ci stat]=ttest2(data(subjS), data(subjPS))
'S vs. NS'
[h p ci stat]=ttest2(data(subjS), data(subjNS))
'PS vs. NS'
[h p ci stat]=ttest2(data(subjPS), data(subjNS))

