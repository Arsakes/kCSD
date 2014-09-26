%
% This function handles reconstruction of 
% current for given potential 
%
% out_grid 3xN dimmensional vector, mesh of points for which CSD is to be calculated
% base_grid 3xN dimmensional vector, mesh of centers of base functions
% src_grid 3xN dimmensional vector, mesh of points for which we have measures of potential
% params - parametrs for base functions
function obj = estimate(obj)
  if obj.cvOn == 1
    % perform cross validation - kernels are calculated there too-obviously
    obj = crossValidate(obj, 100);
  end
  if not(obj.cvOn == 1)
    obj = recalcKernels(obj);
  end

  % TODO   we don't run cross-validation beacuse its slow (now)
  R = obj.lambda*eye(size(obj.kernel));
  obj.solver = (transpose(obj.currentKernel)*(inv(obj.kernel + R)));

  % the incoming argument V should be a matrix <electrode number> x <time samples>
  NT = size(obj.V);
  N = NT(1);
  T = NT(2);
  l = size(obj.out_grid);
  l = l(2);
  % TODO CSD should arranged the same way the grid is so (T,point number)
  obj.CSD = zeros(l,T);
  for i=(1:T)
    obj.CSD(:,i) = obj.solver*obj.V(:,i);
  end
end
