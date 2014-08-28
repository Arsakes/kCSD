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
  N = size(obj.V);
  T = size(obj.V)
  N = N(1);
  T = T(2);
  l = size(obj.out_grid);
  l = l(2);
  obj.CSD = zeros(l  ,T);
  for i=(1:T)
    obj.CSD(:,i) = obj.solver*obj.V(:,i);
  end
end
