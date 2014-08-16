%
% Computes reproductive kernel from values of base functions
%
%
% valTable - vector of base functions F(r) r -> F(r), F belongs to space function V
% values we assume that this is row vector
% N - density of kernel matrix
% TODO: dimension dependent code
% base_grid 3xN dimmensional vector with base function grid
% params - parametrs for base functions
function K = calcK(probe_pos, base_grid, params)

% "definition" of functions space where we look for approximation
% funcion space is defined by base function, but we assume that
% each base function is of form g_n(x) = f(x - x_n)
% therofre its enought to define list of x_n
n = size(probe_pos);
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
  tmp(:,i)=potential_base(probe_pos, base_grid(:,i)*ones(1,n), three_sigma, conductance);
end
size(tmp)
tmp;

% compute kernel (sum along one dimmension) sum along j
K=tmp*transpose(tmp);
% by definiton from paper by Wójcik and Potworowski RKHS 
% for space V is sum of product base functions taken respectively in x and y points
%size(K)
%size(probe_pos)
%size(base_grid)
end
