% @compatibility Matlab < 7.6, Octave > 3.8
% @author Piotr Stępnicki
%
%
%
% @note this is an old way of defining a class for matlab i use it for
% compatibility with octave
% 
% params = [three_sigma, conductance] - a list with parameters
%
function k = kcsd(params)
  % PUBLIC
  properties.params = params;
 
   % the current reconstructer
  properties.CSD = 1;


  % INTERNAL (PRIVATE)
  % private (only in name no such thing for Octave)
  % for method list checkout the directory
  % kernels and preKernels
  properties.kernel = 1;
  properties.currentKernel = 1;
  
  % precomputed potential base functions on input grid
  properties.prePin = 1;
  properties.prePout = 1;
  % precomputed base functions on input and output grid 
  % (maybe different output grid than the one for potential)
  properties.preCout = 1;


  % INTERNAL NOT RELEVANT TO COMPUTATION
  %               Pin   Pout Cout
  % updateList =  [0/1, 0/1, 0/1]
  % keeps information about about pre kernels that need update list 4x1
  properties.updateList = [1,1,1];

  k = class(properties, 'kcsd');
end
