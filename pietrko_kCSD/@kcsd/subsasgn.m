% OCTAVE ONLY
% 
% class specific method defining assignment of class fields
%
%
function  obj = subsasgn(obj, idx, rhs)
  % check if we call calss with empty index
  if(isempty(idx))
    error('kcsd: missing index');
  end
 
  % handle the nonempty input
  if (idx(1).type == '.')
    % switch for diffrent properties names
    switch idx(1).subs
      %case 'kernel'
      %  obj.kernel = rhs;
      case 'sigma'
        obj.params(1) = rhs;
        obj.updateList = [1,1,1];  % input data changed flag for update
      case 'conductance'
        obj.params(2) = rhs;
        obj.updateList = [1,1,1];  % input data changed flag for update
      case 'src_grid'
        obj.src_grid = rhs;
        obj.updateList = [1,1,1];  % input data changed flag for update
      case 'out_grid'
        obj.out_grid = rhs;
        obj.updateList(3) = 1;     %input date changed flag for update
      case 'lambdas'
        obj.lambdas = rhs;
      case 'lambda'
        obj.lambda = rhs;
      case 'subset'
        obj.cvTestSet = val;
      case 'subset_size'
        obj.cvTestSetSize = val;
      case 'norm_order'
        obj.norm_order;
      %case 'prePin'
      %  obj.prePin = rhs;
      %  disp('huj trafiony');
      %case 'prePout'
      %  obj.prePout = rhs;
      %case 'preCout'
      %  obj.preCout = rhs;
      otherwise
        error('kcsd: assgining to non existing property!');
    end
      % internal switch end
  end
  if not(idx(1).type == '.')
      error('invalid subscript type');
  end
end
