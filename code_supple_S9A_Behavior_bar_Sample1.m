%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure S8 % Jiwon Park % 2023/09/21
% Figure S8A: Group comparison of preventive behaviors: Sample 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
load gitHub_Sample1.mat

% smoking status
subjS=find(Sample1_smoking_StatusS==1);
subjPS=find(Sample1_smoking_StatusPS==1);
subjNS=find(Sample1_smoking_StatusNS==1);


%% behaviors
for i=1:8

    data=Sample1_covid_PreventiveBehaviors_eachElements(:,i);

    data_avg=[nanmean(data(subjS)) nanmean(data(subjPS)) nanmean(data(subjNS))]
    sem_avg=[nanstd(data(subjS))/sqrt(length(subjS)) nanstd(data(subjPS))/sqrt(length(subjPS)) nanstd(data(subjNS))/sqrt(length(subjNS))]

    c={'r','b','k'};
    figure('color','w'); hold on;
    count=0;
    for idx=1:3
        count=count+1;
        bar(idx, data_avg(count),'facecolor',c{count},'edgecolor','none','barwidth',0.7);
        errorbar(idx, data_avg(count), sem_avg(count),'linewidth',2, 'color','k');
    end
    xticks(1:3); xticklabels({'S','PS','NS'});

    ylabel('Preventive behavior');
    ylim([5 6.5])

    set(gca,'linewidth',5,'fontsize',25);

    % stats
    grp=nan(1,length(subjID_sample1));
    grp(subjS)=1; grp(subjPS)=2; grp(subjNS)=3;
    [p,tbl,stats] = anova1(data, grp)

    clc
    'S vs. PS'
    [h p ci stat]=ttest2(data(subjS), data(subjPS))
    'S vs. NS'
    [h p ci stat]=ttest2(data(subjS), data(subjNS))
    'PS vs. NS'
    [h p ci stat]=ttest2(data(subjPS), data(subjNS))

end