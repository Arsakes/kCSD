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
jasko_kCSD='/home/piotr/projekty/NENCKI/programy/forSara/';
jasko_kCSD2='/home/piotr/projekty/NENCKI/programy/kcsd/trunk/2D';
pietrko_kCSD='/home/piotr/projekty/NENCKI/programy/pietrko_git/pietrko_kCSD';


% TODO change path - for test purposes only!
addpath(genpath(jasko_kCSD));
%addpath(genpath(jasko_kCSD2));
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
    g = kcsd(elPos, X, X, V, h, 'conductivity', sigma);
    g = chooseRegParam(g, 'n_iter', 1);
    g = estimate(g);
    pietrkoTime1=toc;
  
    % saving the results for comparison
    jasioCSD1 = k.csdEst;
    pietrkoCSD1 = g.CSD;


% BENCHMARK FOR 2D
  load('data2Dtest.mat');
  t = linspace(0,1,48);
  [X,Y] = meshgrid(t,t);  %estimation area 64x64 points
  R = 1/16;
  h = 1/16;
  sigma = 1;

  % getting the estimation pots now 
  t=linspace(0,1,8);
  [elX,elY]=meshgrid(t,t); % 64 electrodes to measure
  elPos=[reshape(elX,1,8^2); reshape(elY,1,8^2)]';  %64x2 - old kCSD format
  pots=[];
  size(elPos)
  for p=1:length(elPos);
    % adding potentials to the list
    pots=[pots, interp2(X,Y,V2d, elPos(p,1), elPos(p,2))];
  end

  % 2D data ready  time for kCSD
  k = kcsd2d(elPos, pots, 'X', X, 'Y', Y, 'n_src', 256); 


% END OF 2D CODE

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

figure(2)
subplot(1,1,1)
plot(g.lambdas, g.lambdas_err,'.');

figure(3)
subplot(1,1,1);
%pcolor(X,Y,V2d),shading('interp'), colorbar();
% painting electrodes
surf(X,Y,V2d), shading('flat');
hold on
  h=plot3(elPos(:,1),elPos(:,2), pots, 'o');
  set(h,'linewidth',(2.0));
hold off

