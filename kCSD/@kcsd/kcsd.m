% kcsd class constructor
%
% @compatibility Matlab < 7.6, Octave > 3.8
% @author Piotr Stępnicki
% @note this is an old way of defining a class for matlab i use it for
% compatibility with octave
%
% 
% params = [three_sigma, conductance] - a list with parameters
function k = kcsd(params, src_grid, out_grid, base_grid, V)

  % PUBLIC PROPERTIES (with get access)
  %
  properties.params = params;      % [three_sigma, conductance]
  properties.CSD = 1;              % the current reconstructer
  properties.src_grid = src_grid;  % list of points when the input V is given
  properties.out_grid = out_grid;  % list of the points where we want to estimate CSD
  properties.V = V;                % data structure containing measured potential for each time


  % INTERNAL PROPERTIES (without access methods)
  %
  % private (only in name no such thing for Octave)
  % for method list checkout the directory
  properties.kernel = 1;
  properties.currentKernel = 1;    % kernels and preKernels
  properties.prePin = 1;           % precomputed potential base functins
  properties.prePout = 1;
  properties.preCout = 1;          % precomputed base functions on input and output grid 
  properties.base_grid = base_grid;% list of points where function spaning rkhs are centered 
  properties.solver = 1;           % final solving operator CSD = S * V
  properties.lambdas = 1;          % cross validation procedure lambdas

  % INTERNAL NOT RELEVANT TO COMPUTATION
  %               Pin   Pout Cout
  % updateList =  [0/1, 0/1, 0/1]
  % keeps information about about pre kernels that need update list 4x1
  properties.updateList = [1,1,1];


  % sole construction instruction
  k = class(properties, 'kcsd');
end
