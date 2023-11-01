%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure S4 % Jiwon Park % 2023/09/21
% Figure S4A: Regression; 
% DV = Beliefs about the risk of infection
% IV = Beliefs about the risk of Direct smoking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
load gitHub_Sample1.mat

% smoking status 
subjS=find(Sample1_smoking_StatusS==1);
subjPS=find(Sample1_smoking_StatusPS==1);
subjNS=find(Sample1_smoking_StatusNS==1);

DV = zscore(Sample1_covid_PerceivedRiskOfBeingInfected);
IV = [Sample1_demo_Sex zscore(Sample1_demo_Education) zscore(Sample1_demo_PoliticalOrientation),...
    zscore(Sample1_smoking_perceivedRiskOfDirectSmoking).*Sample1_smoking_StatusS, ...
    zscore(Sample1_smoking_perceivedRiskOfDirectSmoking).*Sample1_smoking_StatusPS, ...
    zscore(Sample1_smoking_perceivedRiskOfDirectSmoking).*Sample1_smoking_StatusNS];
IV_names = {'gender','education','political','S*direct','PS*direct', 'NS*direct'};

stats=regstats(DV, IV);
dataB1=[0:length(stats.tstat.beta')-1 ; stats.tstat.beta'; stats.tstat.pval']
Beta=(stats.tstat.beta);
BetaSE=(stats.tstat.se);
BetaP=(stats.tstat.pval);
delta=0.1;

% plot: Sample 1
figure('color','w'); hold on;
plot([0 length(IV_names)+1],[0 0],'linewidth',1','color',[0.5 0.5 0.5])

plot([0 length(IV_names)+1],[0 0],'linewidth',1','color',[0.5 0.5 0.5])
c=[195 227 54]./255;

for idx=1:length(Beta(2:end))
    plot(idx-delta, Beta(idx+1), 'o','markersize',20,'markerfacecolor',c,'markeredgecolor',[0.7 0.7 0.7],'linewidth',2)
    errorbar(idx-delta, Beta(idx+1), BetaSE(idx+1),'vertical','linewidth',2,'color','k','CapSize',0)
end

%% data 2
load gitHub_Sample2.mat

% smoking status 
subjS=find(Sample2_smoking_StatusS==1);
subjPS=find(Sample2_smoking_StatusPS==1);
subjNS=find(Sample2_smoking_StatusNS==1);

DV = zscore(Sample2_covid_PerceivedRiskOfBeingInfected);
IV = [Sample2_demo_Sex zscore(Sample2_demo_Education) zscore(Sample2_demo_PoliticalOrientation),...
    zscore(Sample2_smoking_perceivedRiskOfDirectSmoking).*Sample2_smoking_StatusS, ...
    zscore(Sample2_smoking_perceivedRiskOfDirectSmoking).*Sample2_smoking_StatusPS, ...
    zscore(Sample2_smoking_perceivedRiskOfDirectSmoking).*Sample2_smoking_StatusNS];
IV_names = {'gender','education','political','S*direct','PS*direct', 'NS*direct'};

stats=regstats(DV, IV);
dataB1=[0:length(stats.tstat.beta')-1 ; stats.tstat.beta'; stats.tstat.pval']
Beta=(stats.tstat.beta);
BetaSE=(stats.tstat.se);
BetaP=(stats.tstat.pval);
delta=0.1;

% plot: Sample 2

c=[162 201 239]./255;

for idx=1:length(Beta(2:end))
    plot(idx+delta, Beta(idx+1), 's','markersize',20,'markerfacecolor',c,'markeredgecolor',[0.7 0.7 0.7],'linewidth',2)
    errorbar(idx+delta, Beta(idx+1), BetaSE(idx+1),'vertical','linewidth',2,'color','k','CapSize',0)
end


ylabel('Standardized beta');

ylim([-0.2 0.4])
xticks(1:6)
set(gca,'linewidth',3,'fontsize',27);


