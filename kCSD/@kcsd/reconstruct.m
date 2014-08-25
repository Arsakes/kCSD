%
% This function handles reconstruction of 
% current for given potential 
%
% out_grid 3xN dimmensional vector, mesh of points for which CSD is to be calculated
% base_grid 3xN dimmensional vector, mesh of centers of base functions
% src_grid 3xN dimmensional vector, mesh of points for which we have measures of potential
% params - parametrs for base functions
function obj = reconstruct(obj)
  obj = recalcKernels(obj);
  obj.solver = (transpose(obj.currentKernel)*(inv(obj.kernel)));

  % the incoming argument V should be a matrix <electrode number> x <time samples>
  N = size(obj.V)(1);
  T = size(obj.V)(2);

  obj.CSD = zeros(size(obj.out_grid)(2)  ,T);
  for i=(1:T)
    obj.CSD(:,i) = obj.solver*obj.V(:,i);
  end
end
