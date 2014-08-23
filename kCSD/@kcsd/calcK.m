%
% Computes reproductive kernel from values of base functions
%
%
% valTable - vector of base functions F(r) r -> F(r), F belongs to space function V
% values we assume that this is row vector
% N - density of kernel matrix
% base_grid 3xN dimmensional vector with base function grid
% params - parametrs for base functions
% one may give additonal argument named "out_grid"
% to specify output grid for kernel: ...,"out_grid", X,...
%
% One can also specify dimmension: ...,"dimmension", 1/2/3,...)
function K = calcK(src_pos, base_grid, params, varargin)
% "definition" of functions space where we look for approximation
% funcion space is defined by base function, but we assume that
% each base function is of form g_n(x) = f(x - x_n)
% therofre its enought to define list of x_n


% PARSING INPUT
[~,prop] = parseparams(varargin);
while length(prop) >= 2
  key = prop{1};
  val = prop{2};
  prop = prop(3:end);
  switch key
    case 'out_grid'
      out_grid =  val;
    case 'dimmension'
  end
end


% INITIALIZATION OF INTERNAL VARIABLES
n = size(src_pos);
n = n(2);
m = size(base_grid);	
m = m(2);

% determine if out_grid = src_pos
one_grid = 0;
if (!exist('out_grid'))
  out_grid = src_pos;
  one_grid = 1;
  disp("STATE: Source grid = output grid");
endif 

% usually this kernel is used to get the function interpolating potential
% but it can be also used interpolate this function itself ! (to plot it)
l = size(out_grid);
l = l(2);

% definig parametres
three_sigma = params(1);
conductance = params(2); % constant

% first step - calculate b_j(x_i)
tmp=zeros(n,m);
g=[];


% COMPUTATION
%
% there is one grid only
if one_grid == 1
  for i=1:m
    tmp(:,i)=potential_base(src_pos, base_grid(:,i)*ones(1,n), three_sigma, conductance);
  end
  K=tmp*transpose(tmp);
endif

% two grids
if one_grid != 1
  for i=1:m
    tmp1(:,i)=potential_base(src_pos, base_grid(:,i)*ones(1,n), three_sigma, conductance);
    tmp2(:,i)=potential_base(out_grid, base_grid(:,i)*ones(1,l), three_sigma, conductance);
  end
  K=tmp1*transpose(tmp2);
endif

end
