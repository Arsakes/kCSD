%
% Peter: not very useful funciton imho
%
function [n_folds, n_iter, sampling] = get_choose_lambda_parameters(k, args)
propertyArgIn = args;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    
    switch prop
        case 'n_folds'
            n_folds = val;
        case 'n_iter'
            n_iter = val;
        case 'sampling'
            sampling = val;
        otherwise
            error(['no method defined for input: ',prop, ' Available inputs: n_foldsm n_iter, sampling, choose_R']);
    end %case
end %while
if ~exist('nFolds', 'var')
    [n_el, ~] = size(k.pots);
    n_folds = n_el;
end
if ~exist('n_iter', 'var')
    n_iter = 1;
end
if ~exist('sampling', 'var')
    sampling = 1;
end
