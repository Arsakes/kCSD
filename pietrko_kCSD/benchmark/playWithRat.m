
%% plays the rat movie
%
if (exist('ratBrainSuperstar.mat','file') == 0)
  disp('..........Run rat3D.m first!.............');
else
  load('ratBrainSuperstar.mat');
  [h,w,p]=size(F(1).cdata);
  hf=figure;
  set(hf, 'position', [150,150,w,h]);
  axis off
  movie(hf,F);
end
