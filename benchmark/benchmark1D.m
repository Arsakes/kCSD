%
% Script to benchmark the kCSD programs on real data 
% data sets come from Dusty experiment by Andrew Jackson
%
% MATLAB ONLY 
%  


%-----------------------------PATHS---------------------------------
jasko_kCSD='/home/piotr/projekty/NENCKI/programy/forSara/';
pietrko_kCSD='../';
%-----------------------------PATHS---------------------------------







% TODO change path - for test purposes only!
addpath(genpath(jasko_kCSD));
addpath(pietrko_kCSD);


% BENCHMARK FOR 1D
    % reading data
    load('dusty1Dtest.mat')
    
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
    jasioTime1=toc;

    % pietrko kCSD, without cross validation
    tic;
    g = kcsd(elPos', X', X', V, 0.73*R, 'conductivity', sigma);
    %g = chooseRegParam(g, 'n_iter', 1);
    g = estimate(g);
    pietrkoTime1=toc;
  
    % saving the results for comparison
    jasioCSD1 = k.csdEst;
    pietrkoCSD1 = g.CSD;

% OUTPUT

% SUBTITLES
disp('1D:');
disp(strcat('stare kCSD(s): ', num2str(jasioTime1)));
disp(strcat('nowe kCSD(s): ', num2str(pietrkoTime1)));
disp('Względny czas wykonywania (1.0 dla starego kCSD): ');
disp(pietrkoTime1/jasioTime1);



% PLOTTING
subplot(2,1,1)
pcolor(jasioCSD1); colorbar; colormap(hot); shading('interp');
xlabel('time')
ylabel('x')

title('1D: stare kCSD1d(góra) vs nowe (dół)' );
subplot(2,1,2)
pcolor(pietrkoCSD1); colorbar; colormap(hot); shading('interp');
xlabel('time')
ylabel('x')

%figure(2)
%subplot(1,1,1)
%plot(g.lambdas, g.lambdas_err,'.');
