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
% One can also specify dimmension: ...,"dimmension", 1/2/3,...)
%
% @note the method is internal and shouldn't be called from outside!
% @compatibility Matlab R2012A, Octave 3.8+
function obj = calcK(obj, src_pos, base_grid, varargin)
% "definition" of functions space where we look for approximation
% funcion space is defined by base function, but we assume that
% each base function is of form g_n(x) = f(x - x_n)
% therofre its enought to define list of x_n
tic
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
if ( exist('out_grid') == 0 )
  out_grid = src_pos;
  one_grid = 1;
  disp('STATE: Source grid = output grid');
end

% usually this kernel is used to get the function interpolating potential
% but it can be also used interpolate this function itself ! (to plot it)
l = size(out_grid);
l = l(2);


% first step - calculate b_j(x_i)
tmp=zeros(n,m);
g=[];


% COMPUTATION
%
% there is one grid only (src grid = output grid)
if obj.updateList(1) == 1
  for i=1:m
    tmp(:,i)=potential_base(obj, src_pos, base_grid(:,i)*ones(1,n));
  end
  obj.prePin = tmp;
end


if not(one_grid == 1) && obj.updateList(2) == 1
  for i=1:m
    tmp(:,i)=potential_base(obj, out_grid, base_grid(:,i)*ones(1,l) );
  end
  obj.prePout = tmp;
end

% we have one grid
if (one_grid == 1)
  obj.prePout = obj.prePin;
end

% any update  need to compute kernel again
if obj.updateList(1) == 1 || obj.updateList(2) == 1
  obj.kernel=obj.prePin*transpose(obj.prePout);
end
 

% two grids

% tell the class that pre kernels were recently updated
obj.updateList(1) = 0;
obj.updateList(2) = 0;

toc
end
