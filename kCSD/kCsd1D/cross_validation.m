function err = cross_validation(lambda, Pot, K, n_folds, Ind_perm)
                                     
% K - fold cross validation
% preparing subsets of electrodes

[n, ~] = size(Pot);
width = floor(n/n_folds);
Ind = cell(n_folds);
All_ind = 1:1:n;

for i = 1 : n_folds
    Ind_set = (1:1:width) + width*(i-1);
    Ind_set_perm = Ind_perm(Ind_set);
    Ind{i} = Ind_set_perm; 
end;

last = max(Ind_set);

if last < n
    Ind{n_folds} = [Ind{n_folds} Ind_perm(last+1:1:n)];
end;

errors = zeros(n_folds, 1);

for i = 1:n_folds
    Ind_test = Ind{i};
    Ind_train = All_ind;
    Ind_train(Ind{i}) =[];
    errors(i) = calc_err(lambda, Pot, K, Ind_test, Ind_train);
end;

err = mean(errors);
