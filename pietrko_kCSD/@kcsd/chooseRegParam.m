%
% @author Pietrko <p.l.stepnicki@gmail.com>
% @description This method chooses regularisation parmeter via cross validation
%
% if one want to use regularisation this method should be called first 
function obj = chooseRegParam(obj, varargin)
 
   % some stuff
  disp('Regularisation parameter choosing via cross validation...');


  % some properties must have definite values for regularistion
  obj=recalcKernels(obj);  


  % DEFAULT PARAMETERS
  [k_fold,~] = size(obj.V);
  n_iter = 1;
  maxLambda = sqrt(trace(obj.kernel'*obj.kernel));   % norm of kernel ~ eigenvalues
  cvTestSet = 'all';
  cvTestSetSize = 1;


  % GETTING EXTRA INPUT
  [~,prop] = parseparams(varargin);
  while length(prop) >= 2
    key = prop{1};
    val = prop{2};
    prop = prop(3:end);
    switch key
      case 'n_folds'
        k_fold = val;
      case 'n_iter' 
        n_iter = val;
      case 'maxLambda' 
        maxLambda = val;
      case 'subset'
        cvTestSet = val;
      case 'subset_size'
        cvTestSetSize = val;
      otherwise
        error(['no method defined for input', prop, 'Available inputs: n_folds, n_iter']);
    end
  end
 

  % SET OPTIONS
  %
  % determnation of size of input for training (which time snapshots use)
  nr_of_frames = size(obj.V, 2);
  switch cvTestSet
    case 'all'
      Time_ind  = 1:nr_of_frames;
    case 'part'
      Time_ind  = randperm(nr_of_frames, cvTestSetSize);
    case 'one'
      diffs = max(obj.V) - min(obj.V);
      Time_ind = find(diffs == max(diffs), 1);
    otherwise
  end
 
  x = 0:0.04:16;         
  lambdas = maxLambda./(2.^x);             %lambda grid
  lambdas = [lambdas,0];
  lambdas_err = zeros(size(lambdas));


  % RUN CV
  % loop over iterations
  for i = (1:n_iter)
    % table of errors
    lambdas_err = lambdas_err + crossValidate(obj, lambdas, k_fold, Time_ind);
  end
  lambdas_err = lambdas_err/n_iter;

  % choosing the best lambda
  [~,ind_lambda] = min(lambdas_err);
  obj.lambda = lambdas(ind_lambda);
  obj.lambdas = lambdas;
  obj.lambdas_err = lambdas_err;

end
