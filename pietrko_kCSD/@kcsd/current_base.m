% Calculates the base functions for kCSD3D, both currents
% accepts vector argument
%
% INPUT 
% x           - vector from {1,2,3} x n defining position to compute current
% sigma       - three times the std of the distribution
%
% OUTPUT
% f - value  of a density proportional to - gaussian with std=sigma
% centered in point origin
%
%
% f = current_base(obj, x, origin)
function f = current_base(obj, x, origin)
sigma = obj.params(1);
dim = obj.dim;
sigma_n2=sigma^2;

if dim == 3 || dim == 2
  r2 = sum((x-origin).^2, 1)*0.5/sigma_n2;
else
  r2 = ((x-origin).^2 )*0.5/sigma_n2;
end
 
f = (exp(-r2) ./ sqrt(2.*pi.*sigma_n2)^3 ) .* (r2 < 9/2); 
% cuted for r greter than 3 sigma

end
