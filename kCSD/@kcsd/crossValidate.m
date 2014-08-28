%
% @author Pietrko <p.l.stepnicki@gmail.com>
% @description This method handles error correction in form of cross validation
%
%
% lambda is error correction factor tells how to neglect data and 
% take data norm into account (for some reason data norm connects to noise) 
%
% output - nothing (except of class object), internal computes the lambda and sets it
function obj = crossValidate(obj, maxLambda)
   
  k_fold = 12;
  % code for "k-fold cross validation" - common statistical procedure
  [~,n] = size(obj.src_grid);
  
  sample_size = floor(n/k_fold);
  if sample_size == 0 
    sample_size = 1;
  end
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
  

  % REAL CROSS VALIDATION - computing the best lambda
   x = 0:0.05:10;         
  lambdas = maxLambda./(2.^x);             %lambda grid
  lambdas = [lambdas,0];
  lambdas_err = [];

  for lambda = lambdas
    % computing average error
    errors = zeros(k_fold,1);                                % error computed
    for i = 1:k_fold
      ind_train = 1:n;
      ind_train(ind{i}) = [];
      ind_test = ind{i};
      errors(i) = cv_error(obj, ind_test, ind_train, lambda);
    end
    lambdas_err =[lambdas_err, mean(errors)];
  end
  %plot(lambdas, lambdas_err);
  [~,ind_lambda] = min(lambdas_err);
  obj.lambda = lambdas(ind_lambda);
  obj.lambdas = lambdas;
  obj.lambdas_err = lambdas_err;
  plot(lambdas,lambdas_err);
end


