%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data for Smoker paper % Jiwon Park % 2023/09/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% load RAW data
savefilename='gitHub_Sample1.mat';
load('rawData_Sample1.mat');

% demo
demo_sex=data(:,3)-1;
demo_age=data(:,4);
demo_education=data(:,196);
demo_income=data(:,217);
demo_political_orientation=data(:,216);

% covid
covid_PerceivedRiskOfInfection=10.*(data(:,122:127)-1);
covid_infected_neighbor=data(:,128);
covid_infected_acquaintance=data(:,129);
covid_preventive_behaviors=data(:,150:157);
for idx=1:8
    covid_preventive_behaviors(find(covid_preventive_behaviors(:,idx)==9998),idx)=nan;
end
covid_preventive_behaviors(:,9)=nanmean(covid_preventive_behaviors,2);
covid_preventive_motives=data(:,158:166);

% smoking
smoking_status=data(:,225);
amountT_day=data(:,242);
amountT_n=data(:,243);
amountE_day=data(:,244);
amountE_n=data(:,245);
smoking_amountLast7Days=(amountT_day.*amountT_n)+(amountE_day.*amountE_n);
smoking_amountLast7Days(isnan(smoking_amountLast7Days))=0;
smoking_initiationAge=data(:,229);

t1_PS_abstinent_period=data(:,226:228);
smoking_abstinentDays=365.*t1_PS_abstinent_period(:,1)+30*t1_PS_abstinent_period(:,2)+t1_PS_abstinent_period(:,3);
smoking_type_cigarette=data(:,236);
smoking_type_electronic_cigarette=data(:,237);

smoking_perceivedRiskOfDirectSmoking=data(:,223);
smoking_perceivedRiskOfSecondHandSmoking=data(:,224);
smoking_perceivedRiskOfDirectSmokingSelf=data(:,233);

%%
% outlier
outlier_BHnan=find(isnan(covid_preventive_behaviors(:,9)));
outlier_Samount_criteria=nanmean(smoking_amountLast7Days(smoking_status==1)+3*nanstd(smoking_amountLast7Days(smoking_status==1)));
outlier_Samount=find( (smoking_status==1).*(smoking_amountLast7Days>outlier_Samount_criteria));

outlier_SstartAge_criteria=nanmean(smoking_initiationAge(smoking_status==1)+3*nanstd(smoking_initiationAge(smoking_status==1)));
outlier_SstartAge=find( (smoking_status==1).*(smoking_initiationAge>outlier_SstartAge_criteria));

outlier_PSstartAge_criteria=nanmean(smoking_initiationAge(smoking_status==2)+3*nanstd(smoking_initiationAge(smoking_status==2)));
outlier_PSstartAge=find( (smoking_status==2).*(smoking_initiationAge>outlier_PSstartAge_criteria));

outlier_sample1=unique([outlier_BHnan' outlier_Samount' outlier_SstartAge' outlier_PSstartAge']);
subjID_sample1=setdiff(1:1500, outlier_sample1);

%% save data
Sample1_demo_Sex=demo_sex(subjID_sample1);
Sample1_demo_Age=demo_age(subjID_sample1);
Sample1_demo_Education=demo_education(subjID_sample1);
Sample1_demo_Income=demo_income(subjID_sample1);
Sample1_demo_PoliticalOrientation=demo_political_orientation(subjID_sample1);

Sample1_covid_ExistenceOfInfectedNeighborFriend=min(1,(covid_infected_neighbor(subjID_sample1)==1)+(covid_infected_acquaintance(subjID_sample1)==1));
Sample1_covid_PerceivedRiskOfBeingInfected=mean(covid_PerceivedRiskOfInfection(subjID_sample1,:),2);

covid_PreventiveMotives_raw=covid_preventive_motives(subjID_sample1,:);
Sample1_covid_PreventiveMotives_self=covid_PreventiveMotives_raw(:,3);
Sample1_covid_PreventiveMotives_others=mean(covid_PreventiveMotives_raw(:,4:8),2);

Sample1_covid_PreventiveBehaviors=covid_preventive_behaviors(subjID_sample1,9);
Sample1_covid_PreventiveBehaviors_eachElements=covid_preventive_behaviors(subjID_sample1,1:8);
covid_PerceivedRiskOfBeingInfected_raw=covid_PerceivedRiskOfInfection(subjID_sample1,:);

Sample1_smoking_SmokingAmount=smoking_amountLast7Days(subjID_sample1);
Sample1_smoking_InitiationAge=smoking_initiationAge(subjID_sample1);
Sample1_smoking_perceivedRiskOfDirectSmoking=smoking_perceivedRiskOfDirectSmoking(subjID_sample1);
Sample1_smoking_perceivedRiskOfSecondHandSmoking=smoking_perceivedRiskOfSecondHandSmoking(subjID_sample1);
Sample1_smoking_perceivedRiskOfDirectSmokingSelf=smoking_perceivedRiskOfDirectSmokingSelf(subjID_sample1);

% others
Sample1_smoking_Status=smoking_status(subjID_sample1);
Sample1_smoking_StatusS=(Sample1_smoking_Status==1);
Sample1_smoking_StatusPS=(Sample1_smoking_Status==2);
Sample1_smoking_StatusNS=(Sample1_smoking_Status==3);

Sample1_smoking_Status_Cigarette=smoking_type_cigarette(subjID_sample1);
Sample1_smoking_Status_ElectronicCigarette=smoking_type_electronic_cigarette(subjID_sample1);

Sample1_smoking_nSmoker_Cigarette=size(find(Sample1_smoking_Status_Cigarette(Sample1_smoking_Status==1)==1),1);
Sample1_smoking_nSmoker_ElectricCigarette=size(find(Sample1_smoking_Status_ElectronicCigarette(Sample1_smoking_Status==1)==2),1);
Sample1_smoking_nSmoker_Both=size(find(Sample1_smoking_Status_Cigarette(Sample1_smoking_Status==1)+Sample1_smoking_Status_ElectronicCigarette(Sample1_smoking_Status==1)==3),1);

save(savefilename, 'Sample1_*')


