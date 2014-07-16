%
% Computes reproductive kernel from values of base functions
%
% src by src matrix
%
% valTable - vector of base functions F(r) r -> F(r), F belongs to space function V
% values we assume that this is row vector
% N - density of kernel matrix
% TODO: dimension dependent code
% base_grid 3xN dimmensional vector with base function grid
% params - parametrs for base functions
function K = calcK(src_pos, base_grid, params)

% dimension of functions space where we look for approximation
n = size(src_pos);
n = n(2);
m = size(base_grid);	
m = m(2)

% definig parametres
three_sigma = params(1);
conductance = params(2); % constant

% first step - calculate b_j(x_i)
tmp=zeros(n,m);
g=[];
for i=1:m
  tmp(:,i)=potential_base(src_pos,base_grid(:,i)*ones(1,n), three_sigma, conductance);
end
size(tmp)
tmp

% compute kernel (sum along one dimmension)
K=tmp*transpose(tmp);
% by definiton from paper by Wójcik and Potworowski RKHS 
% for space V is sum of product base functions taken respectively in x and y points

size(K)
% mapping from set of distances to set of indices r -> index 
%IndR = ones(n,1) * ((1:N)/N*L )  - ( transpose(src_pos) * ones(1,N) );

% the f(r)= is symmetrical therefore f(x-y) = f(abs(x-y));
%IndR = floor(abs(IndR))

% checking for zeros
%IndR = IndR + (IndR == 0);

% summing up!
%kernel = transpose( valTable(IndR) ) * valTable(IndR);
end
