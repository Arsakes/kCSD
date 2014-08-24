%
% Computes kernel for calculation of CSD from potential interpolation
%
% code is dimmension independent only evaluation of base function is!
% 
% out_grid 3xN dimmensional vector, mesh of points for which CSD is to be calculated
% params - parametrs for base functions
function tK = calcCurrentK(obj, src_pos, out_grid, base_grid, params)

% dimension of functions space where we look for approximation
n = size(src_pos);
n = n(2);
m = size(base_grid);	
m = m(2);
% 3xl vector of output positions
l = size(out_grid);
l = l(2);


% definig parametres
three_sigma = params(1);
conductance = params(2); % constant

% first step - calculate b_j(x_i)
tmp1=zeros(n,m);
tmp2=zeros(l,m);
g=[];

% for each base function a separate computation
for i=1:m
  f = potential_base(obj, src_pos,base_grid(:,i)*ones(1,n), three_sigma, conductance);
  tmp1(:,i)=f;
  g = current_base(obj, out_grid,base_grid(:,i)*ones(1,l), three_sigma, conductance);
  tmp2(:,i)=g;
end

% by definiton from paper by Wójcik and Potworowski RKHS 
% for space V is sum of product base functions taken respectively in x and y points

% compute kernel (sum along one dimmension)
tK=tmp1*transpose(tmp2);

end
