%
% Script to benchmark the kCSD programs on real data 
% data sets come from some rat experiment
%
% MATLAB ONLY 
%  
% by Piotr Stępnicki (2014)

% Remember the current location
%% Setup parameters for data analysis
pietrko_kCSD='/home/piotr/projekty/NENCKI/programy/pietrko_git/pietrko_kCSD';
data_path='/home/piotr/projekty/NENCKI/programy/dane'

addpath(data_path);
addpath(pietrko_kCSD);


% note matrix dimmension is 4:5:7 
% meshgrid when given x,y,z data in this order gives data matrices 5:4:7
% i'm trying y:x:z order
load('rat3D.mat');
 

% DEFINITION OF NEEDED GRIDS
y=linspace(0,4,4);
x=linspace(0,5,5);
z=linspace(0,7,7);
n_el = 4*5*7;
[X,Y,Z]=meshgrid(x,y,z);

src_grid=[reshape(X,n_el,1), reshape(Y,n_el,1), reshape(Z,n_el,1)];

% test for grid
%plot3(src_grid(:,1), src_grid(:,2), src_grid(:,3),'.');
% src grid

% out_grid
y=linspace(0,4,12);
x=linspace(0,5,15);
z=linspace(0,7,21);
n_o = 12*15*21;
[Xo,Yo,Zo]=meshgrid(x,y,z);
out_grid=[reshape(Xo,n_o,1), reshape(Yo,n_o,1), reshape(Zo,n_o,1)];


% src_grid
y=linspace(0,4,5);
x=linspace(0,5,6);
z=linspace(0,7,8);
n_b = 5*6*8;
[Xb,Yb,Zb]=meshgrid(x,y,z);
base_grid=[reshape(Xb,n_b,1), reshape(Yb,n_b,1), reshape(Zb,n_b,1)];

% getting data in reasonable format
V=zeros(n_el,14000);
for i=1:14000
  V(:,i)=reshape(field_potentials(i,:,:,:),n_el,1);
end
% columns - constat time


% stupid part TODO fixe kcsd to be able to receive 
base_grid=base_grid';
out_grid=out_grid';
src_grid=src_grid';
%size(src_grid)
%size(V)

% gauss radius
sigma = 0.9;
g = kcsd(src_grid, out_grid, base_grid,V ,sigma);
g = estimate(g);

% BENCHMARK FOR 3D

% SUBTITLES
%disp('2D:');
%disp(strcat('stare kCSD(s): ', num2str(jasioTime)));
%disp(strcat('nowe kCSD(s): ', num2str(pietrkoTime)));
%disp('Względny czas wykonywania (1.0 dla starego kCSD): ');
%disp(pietrkoTime/jasioTime);

% PLOTTING

CSD = reshape(g.CSD,12,15,21, 14000);
% setting maximal values
cma=max(max(max(max(CSD))));
cmi=min(min(min(min(CSD))));


% choosing time moment
time = 5;
frame=@(ts) int32(14000*(ts+10)/30);


%size(CSD_frame)
%size(Xo)
%size(Yo)
%size(Zo)
j=1;
% just seven slices 
Z=peaks;
fig=figure('Renderer', 'zbuffer', 'position', [100,100, 800,600]);
set(gca,'NextPlot','replaceChildren');
surf(Z);
for t=linspace(-9,19,1024)
  CSD_frame = squeeze(CSD(:,:,:,frame(t)));
  for i=1:7
    subplot(3,3,i)
    ind = i*3-1;
    pcolor(Xo(:,:,1), Yo(:,:,1), CSD_frame(:,:,ind) ),shading('interp');
    title(strcat('t=',num2str(t)));
    caxis([cmi,cma]);
  end
  F(j)=getframe(fig);
  j=j+1;
end
close all;
save ratBrainSuperstar.mat -v7 F;
