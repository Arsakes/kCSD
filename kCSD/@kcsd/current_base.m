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
sigma_n2=sigma^2;
r2 = sum((x-origin).^2, 1);
f = 1./sqrt(2.*pi.*sigma)^3 .* exp(-r2./(2.*sigma_n2) ) .* (sqrt(r2)<three_sigma); 

end
