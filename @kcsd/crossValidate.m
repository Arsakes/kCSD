% @author Pietrko <p.l.stepnicki@gmail.com>
% @description This method handles error correction in form of cross validation
% lambda is error correction factor tells how to neglect data and 
% take data norm into account (for some reason data norm connects to noise) 
%
% FOR INTERNAL CALLS ONLY!
%
% TODO check this code
%
% output - table with errors corresponding to different lambdas
function lambdas_err = crossValidate(obj, lambdas, k_fold, Time_ind)
  

  % code for "k-fold cross validation" - common statistical procedure
  [~,n] = size(obj.src_grid);
  
  sample_size = floor(n/k_fold);
  if sample_size == 0 
    sample_size = 1;
  end
  %disp(sample_size) FIXME TEST 

  rand_ind = randperm(n);                % permutation of indices of electrodes
  ind = {};

  % division into k subsets
  for i = 1:k_fold
    temp = (1:sample_size) + sample_size * (i-1);
    ind{i} = rand_ind(temp);
  end


  last = max(temp);
  % fixing the last sample (adding indices that weren't chosen
  if last < n
    ind{k_fold} = [ind{k_fold} rand_ind( (last+1):n) ];
  end
  

  % REAL CROSS VALIDATION - computing lambdas errors
  lambdas_err = [];
  for lambda = lambdas
    % computing average error
    errors = zeros(k_fold,1);                                % error computed
    for i = 1:k_fold
      ind_train = 1:n;
      ind_train(ind{i}) = [];
      ind_test = ind{i};
      errors(i) = cv_error(obj, ind_test, ind_train, lambda, Time_ind);
    end
    lambdas_err =[lambdas_err, mean(errors)];
  end
  
  % now return lambdas_err
end
