%
% Function choose best fitting value of lambda from preset set
%
function [value,err] = lambda_sampling_1(k, n_folds, n_iter)
    n = length(k.lambdas);
    errors = zeros(1,n);
    errors_iter = zeros(1,n_iter);

    % loop over preset set of lambdas
    for i = 1:n
        k.lambda = k.lambdas(i);
        for j=1:n_iter
            errors_iter(j) = k.calcCvError(n_folds);
        end;
        errors(i) = mean(errors_iter);
    end;
    value = k.lambdas(errors == min(errors));
    err=min(errors);
end
