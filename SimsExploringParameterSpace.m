% Runs simulations of the BLI model for various parameter combinations

codeFolder = '~/Dropbox/BLI_Modeling_MITMayoPSOC/Codes_and_Data/Codes/Simulations';
plotsFolder = '~/Dropbox/BLI_Modeling_MITMayoPSOC/Codes_and_Data/OutputData/Simulations/Plots at day 84';

addpath('~/Dropbox/BLI_Modeling_MITMayoPSOC/Codes_and_Data/Codes')

cd(codeFolder)
%% Specify time and fixed parameter values

% Specify time length for simulations 
stepsize=.1;
t=0:stepsize:84; % days

% Specify fixed parameters for cells (vals for drug defined in model fcn):
C0  = 10^7;
q   = 10^-5;
rho = 0.3;

unvaried = [C0,q,rho];

%% Specify varied parameters and run simulations
for param_LoMidHi = "muS"%["muS" "z" "gamma"] % 'muS' or 'z' or 'gamma'
for LowMidHigh = "mid"%["low" "mid" "high"] % 'low' or 'mid' or 'high'

% Specify parameters to be varied for the heatmaps:
if strcmp(param_LoMidHi,'muS')
    if strcmp(LowMidHigh,'low')
        muS = 3;
    elseif strcmp(LowMidHigh,'mid')
        muS = 5;
    elseif strcmp(LowMidHigh,'high')
        muS = 7;
    end
    vec1 = linspace(0.1,1,10); %z
    param_vec1='z';
    vec2 = linspace(0.1,1,10); %gamma
    param_vec2='gamma';
elseif strcmp(param_LoMidHi,'z')
    if strcmp(LowMidHigh,'low')
    	z = 0.25;
    elseif strcmp(LowMidHigh,'mid')
        z = 0.5;
    elseif strcmp(LowMidHigh,'high')
        z = 0.75;
    end
    vec1 = linspace(1,10,10); %muS
    param_vec1='muS';
    vec2 = linspace(0.1,1,10); %gamma
    param_vec2='gamma';
elseif strcmp(param_LoMidHi,'gamma')
    if strcmp(LowMidHigh,'low')
    	gamma = 0.3;
    elseif strcmp(LowMidHigh,'mid')
        gamma = 0.5;
    elseif strcmp(LowMidHigh,'high')
        gamma = 0.7;
    end
    vec1 = linspace(0.1,1,10); %z
    param_vec1='z';
    vec2 = linspace(1,10,10); %muS
    param_vec2='muS';
end

Simdata = struct;

for i=1:length(vec1)
    if strcmp(param_vec1,'muS')
        muS=vec1(i);
    elseif strcmp(param_vec1,'z')
        z=vec1(i);
    elseif strcmp(param_vec1,'gamma')
        gamma=vec1(i);
    end
    
    for j=1:length(vec2)
        if strcmp(param_vec2,'muS')
            muS=vec2(j);
        elseif strcmp(param_vec2,'z')
            z=vec2(j);
        elseif strcmp(param_vec2,'gamma')
            gamma=vec2(j);
        end
        
        Simdata(i,j).z=z;
        Simdata(i,j).gamma=gamma;
        Simdata(i,j).muS=muS;
        
        varied = [muS,z,gamma];

        [Simdata(i,j).S,Simdata(i,j).R] = BLImodel(t,unvaried,varied);
%         [Simdata(i,j).S,Simdata(i,j).R,ADC] = BLImodel(t,unvaried,varied);
    end
end

%% Subplots for visualizing dynamics
figure(1); clf
FigureSize(50,40,'centimeters')
for i=1:length(vec1)
    for j=1:length(vec2)
        ind = 10*(i-1)+j;
        subplot(length(vec2),length(vec1),ind)
        semilogy(t,Simdata(i,j).S);
        hold on
        semilogy(t,Simdata(i,j).R);
        title([param_vec1,'=',num2str(vec1(i)),' & ',param_vec2,'=',num2str(vec2(j))])
    end
end

cd(plotsFolder)
saveas(gcf,strcat(param_LoMidHi,num2str(eval(param_LoMidHi)),'_totalPlots.fig'))
saveas(gcf,strcat(param_LoMidHi,num2str(eval(param_LoMidHi)),'_totalPlots.png'))
cd(codeFolder)

%% Heatmaps of resistant fraction
T = 841; % time index of interest

colormapType = 'total'; %'total' or 'ratio'

if strcmp(colormapType,'total')
    total=zeros(length(vec1),length(vec2));
elseif strcmp(colormapType,'ratio')
    ratio=zeros(length(vec1),length(vec2));
else
    error('Ensure proper spelling for colormapType variable')
end

for i=1:length(vec1)
    for j=1:length(vec2)
        if strcmp(colormapType,'total')
            total(i,j) = Simdata(i,j).S(T) + Simdata(i,j).R(T);
        elseif strcmp(colormapType,'ratio')
            ratio(i,j) = Simdata(i,j).R(T) ./ (Simdata(i,j).R(T) + Simdata(i,j).S(T));
        end  
    end
end

% figure(2); clf
% FigureSize(35,30,'centimeters')
% if strcmp(colormapType,'total')
%     h=heatmap(vec1,vec2,total,'ColorScaling','log');
% %     set(gca,'YDir','normal')
%     title('Total Cells')
% elseif strcmp(colormapType,'ratio')
%     heatmap(vec1,vec2,ratio)
%     title('Resistant fraction')
% end
% xlabel(param_vec1)
% ylabel(param_vec2)

figure(3); clf
FigureSize(35,30,'centimeters')
if strcmp(colormapType,'total')
    sc=imagesc(vec1,vec2,total');
    % the way that imagesc plots, it goes down the column (i) and NOT left to right as one might expect
    % thus the total matrix needs to be transposed to match this directionality
    set(gca,'YDir','normal')
    set(gca,'ColorScale','log');
    colorbar
    caxis([10^3, 10^13])
    title('Total Cells')
elseif strcmp(colormapType,'ratio')
    imagesc(vec1,vec2,ratio)
    title('Resistant fraction')
end
xlabel(param_vec1)
ylabel(param_vec2)

cd(plotsFolder)
saveas(gcf,strcat(param_LoMidHi,num2str(eval(param_LoMidHi)),'_totalHeatmap.fig'))
saveas(gcf,strcat(param_LoMidHi,num2str(eval(param_LoMidHi)),'_totalHeatmap.png'))
cd(codeFolder)
end
end