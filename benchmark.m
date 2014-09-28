%
% Script to benchmark the kCSD programs on real data 
% data sets come from Dusty experiment by Andrew Jackson
%
% MATLAB ONLY 
%  
% by Piotr Stępnicki (2014)

% Remember the current location
%% Setup parameters for data analysis
start_loc=pwd();
data_path='/home/piotr/projekty/NENCKI/nencki_repo/dane/dusty';
jasko_kCSD='/home/piotr/projekty/NENCKI/nencki_repo/forSara/';
pietrko_kCSD='/home/piotr/projekty/NENCKI/nencki_repo/pietrko_git/pietrko_kCSD';


% TODO change path - for test purposes only!
addpath(data_path);
addpath(genpath(jasko_kCSD));
addpath(pietrko_kCSD);

% load data
load('microwire_move_data');

%nUnits=size(unitsToProc,1);

% WE DON
%moving_electrodes = [6, 11, 13, 21];
%unit = [1, 2];
% just singular data set for test
unit = [1];
moving_electrodes = [6];


for u = unit
  ind=1;
  for lfpi = moving_electrodes 
    % reading data
    data = squeeze(staNormStore{u}(:,lfpi,:)); % 199x12 <<temporal,spatial>
    
    % JAŚKO kCSD
    % configuration
    elPos = (0.5*(1:12));
    V = data';
    X = (0:0.05:6.5);     % reconstruction area I believe
    R = 0.3;              % radius of cylinder in 1D model( 'r' from 2.1.2 section in paper
    h = 0.5;              % thickness of basis element ('R' from eq 2.25 in paper)
    sigma = 0.3;          % conductivity

    % running Jaśko code without cross validation (for now)
    tic;
    k = kCSD1d(elPos, V, 'X', X, 'R', R, 'h',h, 'sigma', sigma);
    k.estimate();
    jasioTime=toc;


    % pietrko kCSD, without cross validation
    tic;
    g = kcsd(elPos, X, X, V, h, 'conductivity', sigma);
    g = chooseRegParam(g, 'n_iter', 1);
    g = estimate(g);
    pietrkoTime=toc;
  

    % saving the results for comparison
    jasioCSD = k.csdEst;
    pietrkoCSD = g.CSD;
  end
end



% SUBTITLES
disp('Czasy:');
disp(strcat('stare kCSD(s): ', num2str(jasioTime)));
disp(strcat('nowe kCSD(s): ', num2str(pietrkoTime)));
disp('Względny czas wykonywania (1.0 dla starego kCSD): ');
disp(pietrkoTime/jasioTime);



% PLOTTING
subplot(2,1,1)
pcolor(jasioCSD); colorbar; colormap(hot); shading('interp');
xlabel('time')
ylabel('x')

title('stare kCSD1d(góra) vs nowe (dół)' );
subplot(2,1,2)
pcolor(pietrkoCSD); colorbar; colormap(hot); shading('interp');
xlabel('time')
ylabel('x')

figure(2)
subplot(1,1,1)
plot(g.lambdas, g.lambdas_err,'.');
