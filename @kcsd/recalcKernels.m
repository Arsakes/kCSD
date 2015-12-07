% Computes reproductive kernel from values of base functions
%
% @compatibility Matlab R2012A, Octave 3.8+
%
% Calculets all needed kernels and preKernels (matrices that kernels are constructed from)
% If you wish just interp the kernel out the interp_grid parameter
%
% obj = recalcKernels(obj, varargin)
function obj = recalcKernels(obj, varargin)
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
    case 'interp_grid'
      interp_grid =  val;
      obj.updateList(2) = 1;
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
n = n(1);
m = size(obj.base_grid);	
m = m(1);
l = size(obj.out_grid);
l = l(1);


% KERNEL COMPUTATION
%    obj.preCout(:,i) = current_base(obj, obj.out_grid, obj.base_grid(:,i)*ones(1,l));

% preKrenel V (CSD reconstruction case)
if obj.updateList(1) == 1
  for i=1:m
    tmp(i,:)=potential_base(obj, obj.src_grid, ones(n,1)*obj.base_grid(i,:));
  end
  obj.prePin = tmp;
end


% preKernel for current (CSD reconstruction case)
if obj.updateList(3) == 1 && (interp_mode == 0) 
  obj.preCout = zeros(m,l);
  for i=1:m
    obj.preCout(i,:) = current_base(obj, obj.out_grid, ones(l,1)*obj.base_grid(i,:));
  end
end

% we have one grid (interp_mode == 0, CSD reconstruction case)
if interp_mode == 0
  obj.prePout = obj.prePin;
end

% UPDATE CURRENT-POTENTIAL KERNEL
if obj.updateList(3) == 1 || obj.updateList(1) == 1
  obj.currentKernel=transpose(obj.preCout)*obj.prePin;
end


% INTERPOLATION CASE SPECIFIC CODE BEGIN
%
% preKernel V 
if interp_mode == 1 && obj.updateList(2) == 1
  [tl,~] = size(interp_grid);
  
  obj.prePout = zeros(m, tl);
  for i=1:m
    obj.prePout(i,:)=potential_base(obj, interp_grid, ones(tl,1)*obj.base_grid(i,:));
  end
end
%
%
% INTERPOLATION CASE SPECIFIC CODE END


% UPDATE POTENTIAL SPACE KERNEL
if obj.updateList(1) == 1 || obj.updateList(2) == 1
  obj.kernel=transpose(obj.prePout)*obj.prePin;
end


% update list update  TODO put some logic here!
obj.updateList(1) = 0;
obj.updateList(2) = 0;
obj.updateList(3) = 0;

end
