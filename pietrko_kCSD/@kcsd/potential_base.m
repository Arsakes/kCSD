function g = potential_base(obj, x, origin)
% potential_base(x, origin, three_sigma)
% Calculates the base functions for kCSD3D, both for potentials
% accepts vector arguments
%
% INPUT 
% x                 - vector from R^3 x n defining position
% three_sigma       - three times the std of the distribution
%
% OUTPUT
% f - value  of a density proportional to - standard gaussian with std=three_sigma/3
% centered in point origin
%
%
three_sigma = obj.params(1);
conductance = obj.params(2);
sigma = (three_sigma./3.0);
dim = obj.dim;


% 3D case
% construct potential function
% potential from gaussain distribution is roughly erf(r)/r
% if the function isn't truncated for big arguments the resulting kernel
% would be not invertible (there is such possibility due to the low machine
% precision

switch dim 
  case 3
    r2 = sum((x-origin).^2 ,1);
  case 2
    r2 = sum((x-origin).^2 ,1);
  case 1
    r2 = (x-origin).^2;
end

g = 1.0./(4.0*pi*conductance*sqrt(r2+eps));
g =g.* erf( sqrt(0.5*r2)/sigma);
g(1) = sqrt(g(2)*g(1));
g=g.*(sqrt(r2) < three_sigma*8/3);

end
