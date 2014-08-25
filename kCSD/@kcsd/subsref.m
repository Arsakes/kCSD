% OCTAVE ONLY 
% definition of indexing operation for kcsd
%
%
function retr = subsref(obj, idx)
  if(isempty(idx))
    error('kcsd: missing index');
  end
  if (idx(1).type == '.')
    switch idx(1).subs
      case 'kernel'
        retr=obj.kernel;
      case 'currentKernel'
        retr=obj.currentKernel;
      case 'params'
        retr=obj.params;
      case 'updateList'
        retr=obj.updateList;
      case 'prePin'
        retr=obj.prePin;
      case 'prePout'
        retr=obj.prePout;
      case 'preCout'
        retr=obj.preCout;
      case 'CSD'
        retr=obj.CSD;
      case 'src_grid'
        retr=obj.src_grid;
      case 'out_grid'
        retr=obj.out_grid;
      case 'solver'
        retr=obj.solver;
      case 'base_grid'
        retr=obj.base_grid;
      otherwise
        error('@kcsd: reading non existing property!');
  end
  % other case
  if not(idx(1).type == '.')
    error('invalid subscript type');
  end
end
