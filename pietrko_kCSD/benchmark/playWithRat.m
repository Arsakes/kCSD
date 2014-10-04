
%% plays the rat movie
%
if (exist('ratBrainSuperstar') == 0)
  disp("..........Run rat3D.m first!.............");
end
load('ratBrainSuperstar.mat');
[h,w,p]=size(F(1).cdata);
hf=figure;
set(hf, 'position', [150,150,w,h]);
axis off
movie(hf,F);
