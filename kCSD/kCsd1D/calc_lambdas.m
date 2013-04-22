%
% External method for calculating set over we perform cross-validation
% Lambdas are dense around zero
%
function lambdas = calc_lambdas( maxLambda )
    x = 0:0.02:10;
    lambdas = maxLambda./(2.^x); %dense around zero
    lambdas = [lambdas, 0];
end
