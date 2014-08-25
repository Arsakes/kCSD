% Computes reproductive kernel from values of base functions
%
% @note the method is internal and shouldn't be called from outside!
% @compatibility Matlab R2012A, Octave 3.8+
%
% calculets all needed kernels and preKernels (matrices that kernels are constructed from)
%
%
% if you wish just interp the kernel out the interp_grid parameter
function obj = recalcKernels(obj, varargin)
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
    case 'interp_grid'
      interp_grid =  val;
      obj.updateList(2) = 1;
    case 'dimmension'
  end
end
% determine interp_mode of work (CSD calc or just potential kernel
interp_mode = 0;
% interp_mode 0 is not a typical interp_mode
if ( exist('interp_grid') == 1 )
  interp_mode = 1;
  disp('STATE: Interpolation mode - no CSD reconstruction');
end


% INITIALIZATION OF INTERNAL VARIABLES
n = size(obj.src_grid);
n = n(2);
m = size(obj.base_grid);	
m = m(2);
l = size(obj.out_grid);
l = l(2);


% KERNEL COMPUTATION
%
% preKrenel V (CSD reconstruction case)
if obj.updateList(1) == 1
  tmp=zeros(n,m);
  for i=1:m
    tmp(:,i)=potential_base(obj, obj.src_grid, obj.base_grid(:,i)*ones(1,n));
  end
  obj.prePin = tmp;
end


% preKernel for current (CSD reconstruction case)
if obj.updateList(3) == 1 && (interp_mode == 0) 
  obj.preCout = zeros(l,m);
  for i=1:m
    obj.preCout(:,i) = current_base(obj, obj.out_grid, obj.base_grid(:,i)*ones(1,l));
  end
end

% we have one grid (interp_mode == 0, CSD reconstruction case)
if interp_mode == 0
  obj.prePout = obj.prePin;
end

% UPDATE CURRENT-POTENTIAL KERNEL
if obj.updateList(3) == 1 || obj.updateList(1) == 1
  obj.currentKernel=obj.prePin*transpose(obj.preCout);
end


% INTERPOLATION CASE SPECIFIC CODE BEGIN
%
% preKernel V 
if interp_mode == 1 && obj.updateList(2) == 1
  tmp_l = size(interp_grid);
  obj.prePout = zeros(tmp_l(2), m);
  for i=1:m
    obj.prePout(:,i)=potential_base(obj, interp_grid, obj.base_grid(:,i)*ones(1,l) );
  end
end
%
%
% INTERPOLATION CASE SPECIFIC CODE END


% UPDATE POTENTIAL SPACE KERNEL
if obj.updateList(1) == 1 || obj.updateList(2) == 1
  obj.kernel=obj.prePin*transpose(obj.prePout);
end


% update list update  TODO put some logic here!
obj.updateList(1) = 0;
obj.updateList(2) = 0;
obj.updateList(3) = 0;

% tell the class that pre kernels were recently updated

toc
end
