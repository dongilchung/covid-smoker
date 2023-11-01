%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data for Smoker paper % Jiwon Park % 2023/09/21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load RAW data

savefilename='gitHub_Sample2.mat';
load('rawData_Sample2.mat');


% demo
demo_sex=data(:,128)-1;
demo_age=data(:,129);
demo_education=data(:,131);
demo_income=data(:,153);
demo_political_orientation=data(:,152);

% covid
covid_PerceivedRiskOfInfection=10.*(data(:,29:34)-1);
covid_infected_neighbor=data(:,35);
covid_infected_acquaintance=data(:,36);
covid_preventive_behaviors=data(:,57:64);
for idx=1:8
    covid_preventive_behaviors(find(covid_preventive_behaviors(:,idx)==9998),idx)=nan;
end
covid_preventive_behaviors(:,9)=nanmean(covid_preventive_behaviors,2);
covid_preventive_motives=data(:,65:73);

% smoking
smoking_status=data(:,161);
amountT_day=data(:,178);
amountT_n=data(:,179);
amountE_day=data(:,180);
amountE_n=data(:,181);
smoking_amountLast7Days=(amountT_day.*amountT_n)+(amountE_day.*amountE_n);
smoking_amountLast7Days(isnan(smoking_amountLast7Days))=0;
smoking_initiationAge=data(:,165);

t1_PS_abstinent_period=data(:,162:164);
smoking_abstinentDays=365.*t1_PS_abstinent_period(:,1)+30*t1_PS_abstinent_period(:,2)+t1_PS_abstinent_period(:,3);
smoking_type_cigarette=data(:,172);
smoking_type_electronic_cigarette=data(:,173);

smoking_perceivedRiskOfDirectSmoking=data(:,159);
smoking_perceivedRiskOfSecondHandSmoking=data(:,160);
smoking_perceivedRiskOfDirectSmokingSelf=data(:,169);

%%
% outlier
outlier_BHnan=find(isnan(covid_preventive_behaviors(:,9)));
outlier_Samount_criteria=nanmean(smoking_amountLast7Days(smoking_status==1)+3*nanstd(smoking_amountLast7Days(smoking_status==1)));
outlier_Samount=find( (smoking_status==1).*(smoking_amountLast7Days>outlier_Samount_criteria));

outlier_SstartAge_criteria=nanmean(smoking_initiationAge(smoking_status==1)+3*nanstd(smoking_initiationAge(smoking_status==1)));
outlier_SstartAge=find( (smoking_status==1).*(smoking_initiationAge>outlier_SstartAge_criteria));

outlier_PSstartAge_criteria=nanmean(smoking_initiationAge(smoking_status==2)+3*nanstd(smoking_initiationAge(smoking_status==2)));
outlier_PSstartAge=find( (smoking_status==2).*(smoking_initiationAge>outlier_PSstartAge_criteria));

outlier_Sample2=unique([outlier_BHnan' outlier_Samount' outlier_SstartAge' outlier_PSstartAge']);
subjID_Sample2=setdiff(1:length(demo_age), outlier_Sample2);

%% save data
Sample2_demo_Sex=demo_sex(subjID_Sample2);
Sample2_demo_Age=demo_age(subjID_Sample2);
Sample2_demo_Education=demo_education(subjID_Sample2);
Sample2_demo_Income=demo_income(subjID_Sample2);
Sample2_demo_PoliticalOrientation=demo_political_orientation(subjID_Sample2);

Sample2_covid_ExistenceOfInfectedNeighborFriend=min(1,(covid_infected_neighbor(subjID_Sample2)==1)+(covid_infected_acquaintance(subjID_Sample2)==1));
Sample2_covid_PerceivedRiskOfBeingInfected=mean(covid_PerceivedRiskOfInfection(subjID_Sample2,:),2);

covid_PreventiveMotives_raw=covid_preventive_motives(subjID_Sample2,:);
Sample2_covid_PreventiveMotives_self=covid_PreventiveMotives_raw(:,3);
Sample2_covid_PreventiveMotives_others=mean(covid_PreventiveMotives_raw(:,4:8),2);

Sample2_covid_PreventiveBehaviors=covid_preventive_behaviors(subjID_Sample2,9);
Sample2_covid_PreventiveBehaviors_eachElements=covid_preventive_behaviors(subjID_Sample2,1:8);

Sample2_smoking_SmokingAmount=smoking_amountLast7Days(subjID_Sample2);
Sample2_smoking_InitiationAge=smoking_initiationAge(subjID_Sample2);
Sample2_smoking_perceivedRiskOfDirectSmoking=smoking_perceivedRiskOfDirectSmoking(subjID_Sample2);
Sample2_smoking_perceivedRiskOfSecondHandSmoking=smoking_perceivedRiskOfSecondHandSmoking(subjID_Sample2);
Sample2_smoking_perceivedRiskOfDirectSmokingSelf=smoking_perceivedRiskOfDirectSmokingSelf(subjID_Sample2);

% others
Sample2_smoking_Status=smoking_status(subjID_Sample2);
Sample2_smoking_StatusS=(Sample2_smoking_Status==1);
Sample2_smoking_StatusPS=(Sample2_smoking_Status==2);
Sample2_smoking_StatusNS=(Sample2_smoking_Status==3);

Sample2_smoking_Status_Cigarette=smoking_type_cigarette(subjID_Sample2);
Sample2_smoking_Status_ElectronicCigarette=smoking_type_electronic_cigarette(subjID_Sample2);

Sample2_smoking_nSmoker_Cigarette=size(find(Sample2_smoking_Status_Cigarette(Sample2_smoking_Status==1)==1),1);
Sample2_smoking_nSmoker_ElectricCigarette=size(find(Sample2_smoking_Status_ElectronicCigarette(Sample2_smoking_Status==1)==2),1);
Sample2_smoking_nSmoker_Both=size(find(Sample2_smoking_Status_Cigarette(Sample2_smoking_Status==1)+Sample2_smoking_Status_ElectronicCigarette(Sample2_smoking_Status==1)==3),1);


save(savefilename, 'Sample2_*')


