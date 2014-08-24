%
% Computes kernel for calculation of CSD from potential interpolation
%
% code is dimmension independent only evaluation of base function is!
% 
% out_grid 3xN dimmensional vector, mesh of points for which CSD is to be calculated
% params - parametrs for base functions
function obj = calcCurrentK(obj, src_pos, out_grid, base_grid)
tic
% dimension of functions space where we look for approximation
n = size(src_pos);
n = n(2);
m = size(base_grid);	
m = m(2);
% 3xl vector of output positions
l = size(out_grid);
l = l(2);



% first step - calculate b_j(x_i)
tmp1=zeros(n,m);
tmp2=zeros(l,m);
g=[];
% input prekernel updated
if obj.updateList(3) == 0 && obj.updateList(1) == 1
  for i=1:m
    tmp1(:,i) = potential_base(obj, src_pos,base_grid(:,i)*ones(1,n));
  end
  obj.prePin=tmp1;
  obj.preCout=tmp2;
  obj.currentKernel=obj.prePin*transpose(obj.preCout);
end


% case of computation depending on the kernels that need update
% output kernel updated
if obj.updateList(3) == 1 && obj.updateList(1) == 0
  for i=1:m
    tmp2(:,i) = current_base(obj, out_grid,base_grid(:,i)*ones(1,l));
  end
  obj.preCout=tmp2;
  obj.currentKernel=obj.prePin*transpose(obj.preCout);
end


% both need update
if obj.updateList(3) == 1 && obj.updateList(1) == 1
  for i=1:m
    tmp1(:,i) = potential_base(obj, src_pos,base_grid(:,i)*ones(1,n));
    tmp2(:,i) = current_base(obj, out_grid,base_grid(:,i)*ones(1,l));
  end
  obj.prePin=tmp1;
  obj.preCout=tmp2;
  % compute kernel (sum along one dimmension)
  obj.currentKernel=obj.prePin*transpose(obj.preCout);
end
% by definiton from paper by Wójcik and Potworowski RKHS 
% for space V is sum of product base functions taken respectively in x and y points

obj.updateList(1) = 0;
obj.updateList(3) = 0;
toc
end
