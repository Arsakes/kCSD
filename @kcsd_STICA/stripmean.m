function im2 = stripmean(im1, type)

% function stripmean(im1, type)
%
% remove space/time means from image block
%
% im1  = input ni x nj x nt array
% type = 's'  remove space mean
%        't'  remove time mean
%        'st' remove both
%
% im2  = output ni x nj x nt array

[ni, nj, nt] = size(im1); npix = ni*nj;
im2 = reshape(im1, ni*nj, nt);

if ismember('s', type)
   m = mean(im2);
   m = m(ones(npix, 1), :);
   im2 = im2-m;
end

if ismember('t', type)
   im2 = im2';
   m = mean(im2);
   m = m(ones(nt, 1), :);
   im2 = im2-m;
   im2 = im2';
end

im2 = reshape(im2, ni, nj, nt);
