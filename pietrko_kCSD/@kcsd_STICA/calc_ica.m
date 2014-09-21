%
% matlab only function wrapper for STICA functions
%
function k=calc_ica(k, varargin)
  %k.get_neig(0.99);
  %varargin{end+1}='neig';
  %varargin{end+1}=k.ICA_data.neig;
  [S_components, T_components, S, T] = stica_stone(k, varargin);
  k.ICA_data.S_components = S_components;
  k.ICA_data.T_components = T_components;
  k.ICA_data.Scp = S';
  k.ICA_data.Tcp = T';
  k.ICA_data.arglist = varargin;
end
