%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure S8 % Jiwon Park % 2023/09/21
% Figure S8: Save data for mediation analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
load gitHub_Sample1.mat
covariates=[Sample1_demo_Sex zscore(Sample1_demo_Education) zscore(Sample1_demo_PoliticalOrientation)];

% smoking status 
subjS=find(Sample1_smoking_StatusS==1);
subjPS=find(Sample1_smoking_StatusPS==1);
subjNS=find(Sample1_smoking_StatusNS==1);

X=Sample1_smoking_StatusS;
M=Sample1_covid_PreventiveMotives_self;
Y=Sample1_covid_PreventiveBehaviors;

data=[X Y M];
covariates(isnan(sum(data')'),:)=[];
data(isnan(sum(data')'),:)=[];

Md=[];
Md(:,1)=zscore(data(:,1));
Md(:,2)=zscore(data(:,2));
Md(:,3)=zscore(data(:,3));

save('data_mediation_Sample1_additional_self.mat','Md','covariates')

%%
clear;
load gitHub_Sample2.mat
covariates=[Sample2_demo_Sex zscore(Sample2_demo_Education) zscore(Sample2_demo_PoliticalOrientation)];

% smoking status 
subjS=find(Sample2_smoking_StatusS==1);
subjPS=find(Sample2_smoking_StatusPS==1);
subjNS=find(Sample2_smoking_StatusNS==1);

X=Sample2_smoking_StatusS;
M=Sample2_covid_PreventiveMotives_self;
Y=Sample2_covid_PreventiveBehaviors;

data=[X Y M];
covariates(isnan(sum(data')'),:)=[];
data(isnan(sum(data')'),:)=[];

Md=[];
Md(:,1)=zscore(data(:,1));
Md(:,2)=zscore(data(:,2));
Md(:,3)=zscore(data(:,3));

save('data_mediation_Sample2_additional_self.mat','Md','covariates')

