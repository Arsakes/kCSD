function g = potential_base(obj, x, origin, three_sigma, conductance)
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
% TODO make this function able to handle arbitrary dimmension
%
sigma = (three_sigma./3.0);

% kwadrat długości odległości
r2 = sum((x-origin).^2, 1);

% construct potential function
% potential from gaussain distribution is roughly erf(r)/r
g = 1.0./(4.0*pi*conductance*sqrt(r2+eps));
g =g.* erf( sqrt(r2) ./ ( sqrt(2.0)*sigma ));
% regularisation
g(1) = g(2);
% if the function isn't truncated for big arguments the resulting kernel
% would be not invertible (there is such possibility due to the low machine
% precision
g=g.*(sqrt(r2) < three_sigma*8);
end
