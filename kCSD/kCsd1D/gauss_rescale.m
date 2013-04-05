function [f] = gauss_rescale(x, mi, three_sigma)

% INPUT 
% r                 - radius of the point at which we calculate the density
% three_sigma       - three times the std of the distribution

% OUTPUT
% gauss_rescale - value  of a density proportional to
%                 - standard gaussian with std=three_sigma/3

sigma_n2 = (three_sigma./3)^2;

f = 1./sqrt(2.*pi.*sigma_n2) .* exp(-(1./(2.*sigma_n2)).* (x-mi).^2) .* (abs(x-mi)<three_sigma); 