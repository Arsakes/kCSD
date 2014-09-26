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

if dim == 3
  r2 = sum((x-origin).^2 ,1);
  g = 1.0./(4.0*pi*conductance*sqrt(r2+eps));
  g =g.* erf( sqrt(0.5*r2)/sigma);
  %g(1) = sqrt(g(2)*g(1));
  g=g.*(sqrt(r2) < three_sigma*8/3);

end


if dim == 2
  y = (x-origin)/(sqrt(2)*sigma);
  r2 = sum(y.^2, 1);
  g = expint(-r2) / (4*pi*conductance);
  g=g.*(sqrt(r2) < 8/sqrt(2));
end


if dim == 1 
  % TODO checki in maple
  % scale according to things
  y = (x-origin)/(sqrt(2)*sigma);
  r2 = y.^2;
  %
  g = y.*erf(y) + exp(-r2)/sqrt(pi);
  g = -g*0.5*sqrt(2)*sigma/conductance;
  g = g.*(y < 8/sqrt(2));
end


end
