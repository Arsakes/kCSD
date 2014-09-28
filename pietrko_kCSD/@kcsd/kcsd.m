% kcsd class constructor
%
% compatibility: Matlab < 7.6, Octave > 3.8
% author: Piotr Stępnicki
% note: this is an old way of defining a class for matlab i use it for
% compatibility with octave
%
% Execution: 
% k = kcsd(src_grid, out_grid, base_grid, V, varargin)
%
% params = [three_sigma, conductance] - a list with parameters
% src_grid = list of electrde positions
% out_grid = list of output pixels for estimate CSD
% bsd_grid = list of centers of base functions
%
function k = kcsd(src_grid, out_grid, base_grid, V, sigma, varargin)


  % PUBLIC PROPERTIES (with get access)
  %
  properties.CSD = 0;              % the current reconstructer
  properties.src_grid = src_grid;  % list of points when the input V is given
  properties.out_grid = out_grid;  % list of the points where we want to estimate CSD
  properties.V = V;                % data structure containing measured potential for each time
  [dim, ~] = size(src_grid);
  properties.dim = dim;            % spatial dimmension of data
  properties.params = [sigma,1.0];   % [three_sigma, conductance]



  % INTERNAL PROPERTIES (without set methods)
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
  properties.lambdas = 0;          % cross validation procedure lambdas
  properties.lambdas_err = 0;          % cross validation procedure lambdas
  properties.lambda = 0;           % min(lambdas)
  properties.norm_order = 2;           % the L^p norm used for assessing errors

  % INTERNAL NOT RELEVANT TO COMPUTATION
  %               Pin   Pout Cout
  % updateList =  [0/1, 0/1, 0/1]
  % keeps information about about pre kernels that need update list 4x1
  properties.updateList = [1,1,1];
 


  % OPTIONAL PROPERTIES FORM PARSING INPUT
  %
  [~,prop] = parseparams(varargin);
  while length(prop) >= 2
    key = prop{1};
    val = prop{2};
    prop = prop(3:end);
    switch key
      case 'conductance'
        properties.params(2) = val;
      case 'norm_order'
        properties.norm_order = val;
      %case 'subset'
      %  properties.cvTestSet = val;
      %case 'subset_size'
      %  properties.cvTestSetSize = val;
      case 'lambda'
        properties.lambda = val;
      case 'lambdas'
        properties.lambdas = val;
    end
  end


  % sole construction instruction
  k = class(properties, 'kcsd');
end
