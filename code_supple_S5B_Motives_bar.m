%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure S5 % Jiwon Park % 2023/09/21
% Figure S5B: Group comparison of preventive motives 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
load gitHub_Sample2.mat

% smoking status 
subjS=find(Sample2_smoking_StatusS==1);
subjPS=find(Sample2_smoking_StatusPS==1);
subjNS=find(Sample2_smoking_StatusNS==1);


%% covid-related factors: social consequence
data=Sample2_covid_PreventiveMotives_others;

data_avg=[mean(data(subjS)) mean(data(subjPS)) mean(data(subjNS))]
sem_avg=[std(data(subjS))/sqrt(length(subjS)) std(data(subjPS))/sqrt(length(subjPS)) std(data(subjNS))/sqrt(length(subjNS))]

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

set(gca,'linewidth',5,'fontsize',25);
set(gca,'linewidth',5,'fontsize',35);
% 2 sample t-test
grp=nan(1,length(subjID_Sample2));
grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
[p,tbl,stats] = anova1(data, grp)


%%
clc
[h p ci stat]=ttest2(data(subjS), data(subjPS))
%%
[h p ci stat]=ttest2(data(subjS), data(subjNS))
%%
[h p ci stat]=ttest2(data(subjPS), data(subjNS))


