%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure 2 % Jiwon Park % 2023/09/21
% Figure 2A: Comparison of Beliefs about the risks of smoking
%
% 1. perceived risk of direct smoking
% 2. perceived risk of second-hand smoking 
% 3. perceived risk of direct smoking, afffecting their own health 

% Figure 2B: Correlation b/w Beliefs about the risks of smoking and infection
% 1. risk of direct smoking ~ infection 
% 2. risk of second-hand smoking ~ infection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;
load gitHub_Sample2.mat

% smoking status 
subjS=find(Sample2_smoking_StatusS==1);
subjPS=find(Sample2_smoking_StatusPS==1);
subjNS=find(Sample2_smoking_StatusNS==1);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 2A: Comparison of Beliefs about the risks of smoking
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

direct=Sample2_smoking_perceivedRiskOfDirectSmoking;
indirect=Sample2_smoking_perceivedRiskOfSecondHandSmoking;
self=Sample2_smoking_perceivedRiskOfDirectSmokingSelf;
infection=Sample2_covid_PerceivedRiskOfBeingInfected;

data_avg_direct_t1=[mean(direct(subjS)) mean(direct(subjPS)) mean(direct(subjNS))]
sem_avg_direct_t1=[std(direct(subjS))/sqrt(length(subjS)) std(direct(subjPS))/sqrt(length(subjPS)) std(direct(subjNS))/sqrt(length(subjNS))]
data_avg_indirect_t1=[mean(indirect(subjS)) mean(indirect(subjPS)) mean(indirect(subjNS))]
sem_avg_indirect_t1=[std(indirect(subjS))/sqrt(length(subjS)) std(indirect(subjPS))/sqrt(length(subjPS)) std(indirect(subjNS))/sqrt(length(subjNS))]
data_avg_self_t1=[mean(self(subjS)) mean(self(subjPS))]
sem_avg_self_t1=[std(self(subjS))/sqrt(length(subjS)) std(self(subjPS))/sqrt(length(subjPS))]

%% perceived risk of direct smoking
c={'r','b','k'};
figure('color','w'); hold on;
count=0;
for idx=1:3
    count=count+1;
    bar(idx, data_avg_direct_t1(count),'facecolor',c{count},'edgecolor','none','barwidth',0.7);
    errorbar(idx, data_avg_direct_t1(count), sem_avg_direct_t1(count),'linewidth',2, 'color','k');
end
xticks(1:3); xticklabels({'S','PS','NS'});
ylim([0 100]); ylabel('Perceived risk of smoking');
yticks(0:20:100)
set(gca,'linewidth',2,'fontsize',18);

%% perceived risk of second-hand smoking
c={'r','b','k'};
figure('color','w'); hold on;
count=0;
for idx=1:3
    count=count+1;
    bar(idx, data_avg_indirect_t1(count),'facecolor',c{count},'edgecolor','none','barwidth',0.7);
    errorbar(idx, data_avg_indirect_t1(count), sem_avg_indirect_t1(count),'linewidth',2, 'color','k');
end
xticks(1:3); xticklabels({'S','PS','NS'});
ylim([0 100]); ylabel('Perceived risk of smoking');
yticks(0:20:100)
set(gca,'linewidth',2,'fontsize',18);

%% direct; affecting their own health
c={'r','b','k'};
figure('color','w'); hold on;
count=0;
for idx=1:2
    count=count+1;
    bar(idx, data_avg_self_t1(count),'facecolor',c{count},'edgecolor','none','barwidth',0.7);
    errorbar(idx, data_avg_self_t1(count), sem_avg_self_t1(count),'linewidth',2, 'color','k');
end
xticks(1:2); xticklabels({'S','PS'});
ylim([0 100]); ylabel('Perceived risk of smoking; self');
yticks(0:20:100)
set(gca,'linewidth',2,'fontsize',18);


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Figure 2B: Correlation b/w Beliefs about the risks of smoking and infection
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
s=subjNS; % S or PS or NS 
x=direct(s); % direct or indirect 
y=Sample2_covid_PerceivedRiskOfBeingInfected(s);

figure('color','w'); hold on;
plot(x, y, '.','markersize',20,'color',[0.7 0.7 0.7])
[r p]=corr(x,y,'type','Pearson')

c=[0.7 0.7 0.7];
c='r';
xaxis_=[0 100];

stats=regstats(y, x); b0=stats.beta(1); b1=stats.beta(2);
xx= linspace(xaxis_(1),xaxis_(2), 2); % Adapt n for resolution of graph
yy= b0+b1*xx;
plot(xx,yy,'linewidth',8,'color',c);
set(gca,'linewidth',2,'fontsize',18);


%% correlation test
% [p, z, za, zb] = corr_rtest(ra, rb, na, nb) 

% comparison of two correlation coefficients
% 
% input: ra, rb: r-values of correlation coefficient
%        na, nb: the number of datas
%
% ouput: p(1): pvalue of one-tailed test
%        p(2): pvalue of two-tailed test
%        za, zb: z transformed value of ra, rb
%

% comparison of two correlation coefficient 
% inspired from r.test() of Rlang
% cite: https://www.mathworks.com/matlabcentral/fileexchange/61398-comparison-test-of-two-correlation-coefficient-corr_rtest-ra-rb-na-nb
% using Fisher Z-transformation (https://www.statisticshowto.com/fisher-z/)

smokingBelief=direct;
[DrS,DpS]=corr(smokingBelief(subjS),infection(subjS))
[DrPS, DpPS]=corr(smokingBelief(subjPS),infection(subjPS))
[DrNS, DpNS]=corr(smokingBelief(subjNS),infection(subjNS))

smokingBelief=indirect;
[IDrS,IDpS]=corr(smokingBelief(subjS),infection(subjS))
[IDrPS, IDpPS]=corr(smokingBelief(subjPS),infection(subjPS))
[IDrNS, IDpNS]=corr(smokingBelief(subjNS),infection(subjNS))


clc;[p, z, za, zb] = corr_rtest(DrS, IDrS, length(subjS), length(subjS)) 
clc;[p, z, za, zb] = corr_rtest(DrPS, IDrPS, length(subjPS), length(subjPS)) 
clc;[p, z, za, zb] = corr_rtest(DrNS, IDrNS, length(subjNS), length(subjNS))

