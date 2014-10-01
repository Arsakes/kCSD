%
% Script to benchmark the kCSD programs on real data 
% data sets come from some rat experiment
%
% MATLAB ONLY 
%  
% by Piotr Stępnicki (2014)

% Remember the current location
%% plays the rat movie
%
load('ratBrainSuperstar.mat');
[h,w,p]=size(F(1).cdata);
hf=figure;
set(hf, 'position', [150,150,w,h]);
axis off
movie(hf,F);
