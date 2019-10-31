clc
clear

alphas = [90 30 15 0];
legend_entry = {'k','r','m','b'};

tunnel_90 = [0.0539	0.0078; ...
0.0598	0.0075; ...
0.0654	0.0069; ...
0.0709	0.0066; ...
0.0783	0.006; ...
0.084	0.0054; ...
0.0911	0.005; ...
0.0979	0.0044; ...
0.1044	0.0039; ...
0.111	0.0032; ...
0.1181	0.0027; ...
0.1244	0.0021; ...
0.1317	0.0015; ...
0.1404	0.0007];

tunnel_15 = [0.05	0.0096; ...
0.0683	0.0097; ...
0.0831	0.0098; ...
0.0992	0.0099; ...
0.1151	0.01; ...
0.1337	0.0101; ...
0.1523	0.01; ...
0.1702	0.01; ...
0.1877	0.0098; ...
0.2064	0.0098; ...
0.2238	0.0098; ...
0.2403	0.0098; ...
0.258	0.0097; ...
0.275	0.0096; ...
0.2917	0.0094; ...
0.3087	0.0093; ...
0.3261	0.0091];

tunnel_0 = [0.0416	0.0098; ...
0.0593	0.0101; ...
0.0766	0.0106; ...
0.0935	0.0111; ...
0.1113	0.0117; ...
0.1298	0.0124; ...
0.1496	0.013; ...
0.1695	0.0135; ...
0.1873	0.014; ...
0.2055	0.0144; ...
0.2231	0.0147; ...
0.2405	0.0151; ...
0.2579	0.0155; ...
0.2753	0.0159; ...
0.2915	0.0163; ...
0.3087	0.0166; ...
0.3249	0.0172];

%%
valRPM = 3000;

offset = -1e-3;
CT_90 = [];
J_90 = [];
fileList = dir('Alpha 90 Results/TMotor_Relaxed_*.mat');
for i = 1:size(fileList,1)
    load(['Alpha 90 Results/', fileList(i).name], 'CT', 'valJ', 'valDELTIME')
    num_azm = 1/((valRPM/60).*valDELTIME);
    CT = CT(~isnan(CT));
%     CT_90(:,i) = mean(CT(end-(num_azm):end));
    CT_90(:,i) = CT(end)+offset;
    J_90(:,i) = valJ;
end

%%
valRPM = 3000;

offset = 0;
CT_15 = [];
J_15 = [];
fileList = dir('Alpha 15 Results/TMotor_Relaxed_*.mat');
for i = 1:size(fileList,1)
    load(['Alpha 15 Results/', fileList(i).name], 'CT', 'valJ', 'valDELTIME')
    num_azm = 1/((valRPM/60).*valDELTIME);
    CT = CT(~isnan(CT));
    CT_15(:,i) = mean(CT(end-(num_azm):end));
    J_15(:,i) = valJ;
end


%%
valRPM = 3000;

offset = 0;
CT_0 = [];
J_0 = [];
fileList = dir('Alpha 0 Results/TMotor_Relaxed_*.mat');
for i = 1:size(fileList,1)
    load(['Alpha 0 Results/', fileList(i).name], 'CT', 'valJ', 'valDELTIME')
    num_azm = 1/((valRPM/60).*valDELTIME);
    CT = CT(~isnan(CT));
    CT_0(:,i) = mean(CT(end-(num_azm):end));
    J_0(:,i) = valJ;
end


%% Without OPERA
hFig10 = figure(10);
clf(10);

hold on
plot(tunnel_90(:,1), tunnel_90(:,2), '-ok')
plot(tunnel_15(:,1), tunnel_15(:,2), '--^r')
plot(tunnel_0(:,1), tunnel_0(:,2), '-.sb')

box on
axis tight
grid minor
xlabel('Rotor Advance Ratio, \mu')
ylabel('Thrust Coefficient')
legend(['Experimental (\alpha_{tpp} = 90', char(176), ')'], ['Experimental (\alpha_{tpp} = 15', char(176), ')'], ['Experimental (\alpha_{tpp} = 0', char(176), ')'],'Location','SouthEast')

fcnFIG2LATEX(hFig10, 'TMotor_tunnel_overview.pdf', [8 5])

%% With OPERA

hFig11 = figure(11);
clf(11);

hold on
plot(tunnel_90(:,1), tunnel_90(:,2), '-k')
plot(tunnel_15(:,1), tunnel_15(:,2), '--r')
plot(tunnel_0(:,1), tunnel_0(:,2), '-.b')

scatter(J_90, CT_90 + offset, ['o', legend_entry{1}])
scatter(J_15, CT_15 + offset, ['^', legend_entry{2}])
scatter(J_0, CT_0 + offset, ['s', legend_entry{4}])
hold off

box on
axis tight
grid minor
xlabel('Rotor Advance Ratio, \mu')
ylabel('Thrust Coefficient')
legend(['Experimental (\alpha_{tpp} = 90', char(176), ')'], ['Experimental (\alpha_{tpp} = 15', char(176), ')'], ['Experimental (\alpha_{tpp} = 0', char(176), ')'], ['DDE Method (\alpha_{tpp} = 90', char(176), ')'], ['DDE Method (\alpha_{tpp} = 15', char(176), ')'], ['DDE Method (\alpha_{tpp} = 0', char(176), ')'],'Location','SouthEast')


fcnFIG2LATEX(hFig11, 'OPERA_overview.pdf', [8 5])







