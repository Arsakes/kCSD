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
      case 'params'
        obj.params = rhs;
      %case 'prePin'
      %  obj.prePin = rhs;
      %  disp('huj trafiony');
      %case 'prePout'
      %  obj.prePout = rhs;
      %case 'preCout'
      %  obj.preCout = rhs;
      otherwise
        error('@kcsd: assgining to non existing property!');
    end
      % internal switch end
  end
  if not(idx(1).type == '.')
      error('invalid subscript type');
  end
end
