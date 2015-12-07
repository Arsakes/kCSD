% potential_base(x, origin, three_sigma)
% Calculates the base functions for kCSD3D
% accepts vector arguments
%
% INPUT 
% x                 - vector from  n x {1,2,3} defining position
% three_sigma       - three times the std of the distribution
% origin            - vector n x {1,2,3} that defines centers of base functions
%
% OUTPUT
% f - value  of a density proportional to - gaussian with std=sigma
%
% g = potential_base(obj, x, origin)
function g = potential_base(obj, x, origin)
sigma = obj.params(1);
conductance = obj.params(2);
dim = obj.dim;


% 3D case
% construct potential function
% potential from gaussain distribution is roughly erf(r)/r
if dim == 3 || dim == 2
  r = sqrt(sum((x-origin).^2, 2));
else
  r = abs(x-origin);
end
  g = erf( r/ (sqrt(2)*sigma) ) ./ (4.0*pi*conductance*r + 1e5*eps);
  % if the function isn't truncated for big arguments the resulting kernel
  % would be not invertible (there is such possibility due to the low machine precision
  g=g.*(r < 10*sigma);
end
