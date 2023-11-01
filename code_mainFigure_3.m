%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 3 % Jiwon Park % 2023/09/21
% Figure 3A: Group comparison of preventive behaviors
% Figure 3B: Group comparison of preventive motives 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
load gitHub_Sample1.mat

% smoking status 
subjS=find(Sample1_smoking_StatusS==1);
subjPS=find(Sample1_smoking_StatusPS==1);
subjNS=find(Sample1_smoking_StatusNS==1);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 3A: Grp comparison of preventive behaviors 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=Sample1_covid_PreventiveBehaviors;

data_avg=[mean(data(subjS)) mean(data(subjPS)) mean(data(subjNS))];
sem_avg=[std(data(subjS))/sqrt(length(subjS)) std(data(subjPS))/sqrt(length(subjPS)) std(data(subjNS))/sqrt(length(subjNS))];

c={'r','b','k'};
figure('color','w'); hold on;
count=0;
for idx=1:3
    count=count+1;
    bar(idx, data_avg(count),'facecolor',c{count},'edgecolor','none','barwidth',0.7);
    errorbar(idx, data_avg(count), sem_avg(count),'linewidth',2, 'color','k');
end
xticks(1:3); xticklabels({'S','PS','NS'});

ylabel('Preventive behaviors');
ylim([5 6.5])

set(gca,'linewidth',5,'fontsize',35);

% anova
grp=nan(1,length(subjID_sample1));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp);

[h p ci stat]=ttest2(data(subjS), data(subjPS));
[h p ci stat]=ttest2(data(subjS), data(subjNS));
[h p ci stat]=ttest2(data(subjPS), data(subjNS));


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 3B: Grp comparison of preventive motives: social consequence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data=Sample1_covid_PreventiveMotives_others;

data_avg=[mean(data(subjS)) mean(data(subjPS)) mean(data(subjNS))];
sem_avg=[std(data(subjS))/sqrt(length(subjS)) std(data(subjPS))/sqrt(length(subjPS)) std(data(subjNS))/sqrt(length(subjNS))];

c={'r','b','k'};
figure('color','w'); hold on;
count=0;
for idx=1:3
    count=count+1;
    bar(idx, data_avg(count),'facecolor',c{count},'edgecolor','none','barwidth',0.7);
    errorbar(idx, data_avg(count), sem_avg(count),'linewidth',2, 'color','k');
end
xticks(1:3); xticklabels({'S','PS','NS'});

ylabel('Motives');
ylim([5 6.5])

set(gca,'linewidth',5,'fontsize',35);

% anova 
grp=nan(1,length(subjID_sample1));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp);

[h p ci stat]=ttest2(data(subjS), data(subjPS));
[h p ci stat]=ttest2(data(subjS), data(subjNS));
[h p ci stat]=ttest2(data(subjPS), data(subjNS));



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 3C: mediation analysis 
%  smoking status --> social motives --> preventive behaviors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

covariates=[Sample1_demo_Sex zscore(Sample1_demo_Education) zscore(Sample1_demo_PoliticalOrientation)];

X=Sample1_smoking_StatusS;
M=Sample1_covid_PreventiveMotives_others;
Y=Sample1_covid_PreventiveBehaviors;

data=[X Y M];
covariates(isnan(sum(data')'),:)=[];
data(isnan(sum(data')'),:)=[];

Md=[];
Md(:,1)=zscore(data(:,1));
Md(:,2)=zscore(data(:,2));
Md(:,3)=zscore(data(:,3));

% save('data_mediation_Sample1_additional_others.mat','Md','covariates')



