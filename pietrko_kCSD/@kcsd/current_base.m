function f = current_base(obj, x, origin)
% function_base(x, origin, three_sigma)
% Calculates the base functions for kCSD3D, both currents
% accepts vector argument
%
% INPUT 
% x                 - vector from R^3 x n defining position
% three_sigma       - three times the std of the distribution
%
% OUTPUT
% f - value  of a density proportional to - standard gaussian with std=three_sigma/3
% centered in point origin
%
% TODO make this function able to handle arbitrary dimmension
%
three_sigma = obj.params(1);
sigma = (three_sigma./3);
dim = obj.dim;
sigma_n2=sigma^2;

switch dim
  case 3
    r2 = sum((x-origin).^2, 1)*0.5/sigma_n2;
  case 2
    r2 = sum((x-origin).^2, 1)*0.5/sigma_n2;
  case 1
    r2 = (x-origin).^2 *0.5/sigma_n2;
end

% I'm supprised that this is working
% one must remember that we assume gaussian profile in EVERY direction
% (with different sigmas) that's why output is so simple
f = 1./sqrt(2.*pi.*sigma_n2)^3 .* exp(-r2) .* (sqrt(r2)<3/sqrt(2)); 

end
