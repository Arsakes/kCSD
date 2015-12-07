%
% This function handles reconstruction of 
% current for given potential 
%
function obj = estimate(obj)
  % recalcs kernels if anything has changed
  obj = recalcKernels(obj);

  R = obj.lambda*eye(size(obj.kernel));
  obj.solver = obj.currentKernel*(inv(obj.kernel + R));

  % the incoming argument V should be a matrix <electrode number> x <time samples>
  % TODO CSD should arranged the same way the grid is so (T,point number)
  obj.CSD = obj.solver*obj.V;
  
  %for i=(1:T)
  %  obj.CSD(:,i) = obj.solver*obj.V(:,i);
  %end
end
