%
%
% MATLAB ONLY CODE
% auxiliary class to provide ICA for kcsd octave/matlab class
%
% only one needed parameter path to STICA matlab library by
%
%
function obj = kcsd_STICA(varargin)


  % PARSING INPUT
  [~,prop] = parseparams(varargin);
  while length(prop) >= 2
    key = prop{1};
    val = prop{2};
    prop = prop(3:end);
    switch key
      case 'stica_path'
        path_to_STICA =  val;
    end
  end
  % END OF PARSING INPUT

   

  % CONSTURTOR CODE
  if ~exist('path_to_STICA','var')
     path_to_STICA = 'STICA_skew_demo'; % TODO check if this sperator for *ux systems only
  end
  cd(path_to_STICA);
    run jsetpath; % runs script
  cd '../';


  % PROPERTIES
  properties.ICA_data = 1;
  obj = class(properties, 'kcsd_STICA');
end
