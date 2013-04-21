%
% external method for calculating set over we perform cross-validation
%
function lambdas = calc_lambdas
    x = 0:0.025:10;
    lambdas = 1./(2.^x); %dense around zero
    lambdas = [lambdas, 0];
end
