%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure S1 % Jiwon Park % 2023/09/21
% Logistic stepwise regression 
% DV = smoker or not 
% IV = demographical factors 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part 1. demographics
clear; clc; format compact
load gitHub_Sample2.mat

subjS=find(Sample2_smoking_StatusS==1);
subjPS=find(Sample2_smoking_StatusPS==1);
subjNS=find(Sample2_smoking_StatusNS==1);

%% 1: gender won
DV=double(Sample2_smoking_StatusS);
y=categorical(DV);

x1 = [];
alpha=[zscore(Sample2_demo_Age), Sample2_demo_Sex zscore(Sample2_demo_Education) zscore(Sample2_demo_Income) zscore(Sample2_demo_PoliticalOrientation)];

clc
for idx=1:size(alpha,2)
    '---'
    idx
    x=[x1 alpha(:,idx)];

    [B,dev,stats] = mnrfit(x,y);

    Beta=-B'
    BetaP=stats.p'
    BetaSE=stats.se';
end

%% 2: political orientation won
x1 = [Sample2_demo_Sex];
alpha=[zscore(Sample2_demo_Age) zscore(Sample2_demo_Education) zscore(Sample2_demo_Income) zscore(Sample2_demo_PoliticalOrientation)];

clc;
for idx=1:size(alpha,2)
    '---'
    idx
    x=[x1 alpha(:,idx)];
    
    [B,dev,stats] = mnrfit(x,y);

    Beta=-B'
    BetaP=stats.p'
    BetaSE=stats.se';
    
end


%% 3: political orientation won
x1 = [Sample2_demo_Sex zscore(Sample2_demo_PoliticalOrientation)];
alpha=[zscore(Sample2_demo_Age) zscore(Sample2_demo_Education) zscore(Sample2_demo_Income)];

clc;
for idx=1:size(alpha,2)
    '---'
    idx
    x=[x1 alpha(:,idx)];
    
     [B,dev,stats] = mnrfit(x,y);

    Beta=-B'
    BetaP=stats.p'
    BetaSE=stats.se';
    
end

%% 4:END 
x1 = [Sample2_demo_Sex zscore(Sample2_demo_Education) zscore(Sample2_demo_PoliticalOrientation)];
alpha=[zscore(Sample2_demo_Age) zscore(Sample2_demo_Income)];

clc;
for idx=1:size(alpha,2)
    '---'
    idx
    x=[x1 alpha(:,idx)];
 
         [B,dev,stats] = mnrfit(x,y);

    Beta=-B'
    BetaP=stats.p'
    BetaSE=stats.se';
    
end

%% --> Sample 2 significant demo factors: sex, education, political orientation
% Figure
DV=double(Sample2_smoking_StatusS);
y=categorical(DV);

IV = [Sample2_demo_Sex zscore(Sample2_demo_Education) zscore(Sample2_demo_PoliticalOrientation)];
Predictors={'Sex','Education', 'Political'};

[B,dev,stats] = mnrfit(IV,y);

Beta=-B'
BetaP=stats.p'
BetaSE=stats.se';
regRst=[Beta;BetaP]

% plot
data1_index=1:length(Beta(2:end));
idxPlot=1:length(Beta(2:end));
 c=[162 201 239]./255;

figure('color','w'); hold on;
for idx=1:length(Beta(2:end))
    plot(idxPlot(idx), Beta(idx+1), 's','markersize',20,'markerfacecolor',c,'markeredgecolor',[0.7 0.7 0.7],'linewidth',2)
    errorbar(idxPlot(idx), Beta(idx+1), BetaSE(idx+1),'vertical','linewidth',2,'color','k','CapSize',0)
end

xlim([0.5 3.5]);
ylim([-2.5 1]); yticks([-2.5 0 1])
set(gca,'linewidth',2,'fontsize',25);

plot([0 length(Beta)],[0 0],'--','linewidth',1.5','color',[0.7 0.7 0.7])
xticks(1:length(Beta(2:end)))
xticklabels(Predictors)
ylabel('Standardized beta');
ylabel('');

set(gca, 'color', 'none')
set(gcf, 'color', 'none')

