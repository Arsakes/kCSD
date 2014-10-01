%
% Script to benchmark the kCSD programs on real data 
% data sets come from Dusty experiment by Andrew Jackson
%
% MATLAB ONLY 
%  


%-----------------------------PATHS---------------------------------
jasko_kCSD='/home/piotr/projekty/NENCKI/programy/kcsd/trunk/2D';
pietrko_kCSD='../';
%-----------------------------PATHS---------------------------------


% TODO change path - for test purposes only!
addpath(genpath(jasko_kCSD));
addpath(pietrko_kCSD);


    
% BENCHMARK FOR 2D
  load('data2Dtest.mat');
  base_nr = 256;
  t = linspace(0,1,48);
  [X,Y] = meshgrid(t,t);  %estimation area 48x48 points
  R = 1/8;
  h = 1/8;
  sigma = 1;

  % getting the estimation pots now 
  t=linspace(0,1,8);
  [elX,elY]=meshgrid(t,t); % 64 electrodes to measure
  elPos=[reshape(elX,1,8^2); reshape(elY,1,8^2)]';  %64x2 - old kCSD format
  pots=[];
  for p=1:length(elPos);
    % adding potentials to the list
    pots=[pots; interp2(X,Y,V2d, elPos(p,1), elPos(p,2))];
  end

  % 2D data ready  time for kCSD
  tic
  k = kcsd2d(elPos, pots, 'X', X, 'Y', Y, 'n_src', base_nr, 'R',R, 'sigma', sigma); 
  jasioTime=toc;
 
  % Additional data for pietrko kCSD
  %
  % mesh for output 48x48 = 2304
  out_grid = [reshape(X, 48^2,1) , reshape(Y,48^2,1)];

  % mesh for base functions
  ps_base = 17;
  t = linspace(-0.0333,1.03333,ps_base);
  [Xb,Yb]=meshgrid(t,t);
  base_grid = [reshape(Xb,ps_base^2,1) , reshape(Yb, ps_base^2,1)];

  tic
  % R for method below should be different that the one for old kcsd since it uses gaussians 
  % instead of indicator functions 1.84
  g = kcsd(elPos, out_grid, base_grid, pots, 1.38/17, 'conductivity', sigma);
  %g = chooseRegParam(g, 'n_iter', 4);
  g = estimate(g);
  pietrkoTime=toc;
  
  % saving the results for comparison
  pietrkoCSD = reshape(g.CSD,48,48);
  jasioCSD = k.CSD_est;

% END OF 2D CODE

% OUTPUT

% SUBTITLES
disp('2D:');
disp(strcat('stare kCSD(s): ', num2str(jasioTime)));
disp(strcat('nowe kCSD(s): ', num2str(pietrkoTime)));
disp('Względny czas wykonywania (1.0 dla starego kCSD): ');
disp(pietrkoTime/jasioTime);


% PLOTTING
figure(1)
subplot(2,2,1)
pcolor(X,Y,jasioCSD); colormap(hot); shading('interp');
xlabel('x')
ylabel('y')

title('2D: oryginalne kCSD1d');
subplot(2,2,2)
%size(pietrkoCSD)
pcolor(X,Y,pietrkoCSD); colormap(hot); shading('interp');
title('2D: moje kCSD1d');
xlabel('x')
ylabel('y')

subplot(2,2,3);


%pcolor(X,Y,V2d),shading('interp'), colorbar();
% painting electrodes
pcolor(X,Y,csd2d), shading('interp');
title('oryginał')
%hold on
%  h=plot3(elPos(:,1),elPos(:,2), pots, 'o');
%  set(h,'linewidth',(2.0));
%hold off
