% Sublots and heatmaps

% Moved subplot to combine w parameter space

%% Subplots for visualizing dynamics
figure(1); clf

for i=1:length(z_vec)
   
    for j=1:length(gamma_vec)
        
        ind = 10*(i-1)+j;
        subplot(length(gamma_vec),length(z_vec),ind)
        semilogy(t,Simdata(i,j).S);
        hold on
        semilogy(t,Simdata(i,j).R);
        title(['z=',num2str(Simdata(i,j).z),' & gamma=',num2str(Simdata(i,j).gamma)])
    end
end

%% Heatmaps of resistant fraction
T = 500; % time index of interest

colormapType = 'total'; %'total' or 'ratio'

if strcmp(colormapType,'total')
    total=zeros(length(z_vec),length(gamma_vec));
elseif strcmp(colormapType,'ratio')
    ratio=zeros(length(z_vec),length(gamma_vec));
else
    error('Ensure proper spelling for colormapType')
end

for i=1:length(z_vec)
    for j=1:length(gamma_vec)
        if strcmp(colormapType,'total')
            total(i,j) = Simdata(i,j).S(T) + Simdata(i,j).R(T);
        elseif strcmp(colormapType,'ratio')
            ratio(i,j) = Simdata(i,j).R(T) ./ (Simdata(i,j).R(T) + Simdata(i,j).S(T));
        end  
    end
end

figure(2); clf
if strcmp(colormapType,'total')
    heatmap(z_vec,gamma_vec,total,'ColorScaling','log')
    title('Total Cells')
elseif strcmp(colormapType,'ratio')
    heatmap(z_vec,gamma_vec,ratio)
    title('Resistant fraction')
end
xlabel('z')
ylabel('\gamma')

figure(3); clf
if strcmp(colormapType,'total')
    imagesc(z_vec,gamma_vec,total)
    set(gca,'ColorScale','log');
    colorbar
    title('Total Cells')
elseif strcmp(colormapType,'ratio')
    imagesc(z_vec,gamma_vec,ratio)
    title('Resistant fraction')
end
xlabel('z')
ylabel('\gamma')


