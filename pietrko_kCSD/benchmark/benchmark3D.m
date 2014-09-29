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
x=linspace(0,2.1,4);
y=linspace(0,2.8,5);
z=linspace(0,4.2,7);
n_el = 4*5*7;
[X,Y,Z]=meshgrid(x,y,z);

src_grid=[reshape(X,n_el,1), reshape(Y,n_el,1), reshape(Z,n_el,1)];

% test for grid
plot3(src_grid(:,1), src_grid(:,2), src_grid(:,3),'.');
% src grid

% out_grid
x=linspace(0,2.1,12);
y=linspace(0,2.8,15);
z=linspace(0,4.2,21);
n_o = 12*15*21;
[Xo,Yo,Zo]=meshgrid(x,y,z);
out_grid=[reshape(Xo,n_o,1), reshape(Yo,n_o,1), reshape(Zo,n_o,1)];


% src_grid
x=linspace(0,2.1,5);
y=linspace(0,2.8,6);
z=linspace(0,4.2,8);
n_b = 5*6*8;
[Xb,Yb,Zb]=meshgrid(x,y,z);
base_grid=[reshape(Xb,n_b,1), reshape(Yb,n_b,1), reshape(Zb,n_b,1)];

size(X)
size(src_grid)
% getting data in reasonable format
V=zeros(14000,n_el);
for i=1:14000
  V(i,:)=reshape(field_potentials(i,:,:),n_el,1,1);
end


% stupid part TODO fixe kcsd to be able to receive 
base_grid=base_grid';
out_grid=out_grid';
src_grid=src_grid';
V=V';

% gauss radius
sigma = 1/5;
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
% ciekawe czy to działas
CSD = reshape(g.CSD',14000, 12,15,21);
% setting maximal values


% choosing time moment
CSD_frame = squeeze(CSD(500,:,:,:));
cma=max(max(max(CSD_frame)));
cmi=min(min(min(CSD_frame)));

%size(CSD_frame)
%size(Xo)
%size(Yo)
%size(Zo)
% just seven slices 
for i=1:7
  subplot(3,3,i)
  z=(i-1)*4.2/6;
  ind = i*2-1;
  pcolor(Xo(:,:,1)', Yo(:,:,1)', CSD_frame(:,:,ind) ),shading('interp');
  caxis([cmi,cma]);
end

