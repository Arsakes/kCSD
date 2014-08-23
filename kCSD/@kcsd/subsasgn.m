% OCTAVE ONLY
% 
% class specific method defining assignment of class fields
%
%
function  obj = subsasgn(obj, idx, rhs)
  % check if we call calss with empty index
  if(isempty(idx))
    error("kcsd: missing index");
  endif
 
  % handle the nonempty input
  switch (idx(1).type)
    case "."
      if (strcmp (idx.subs, "kernel"));
        obj.kernel = rhs;
      else
        error("@kcsd: assgining to non existing property!");
      endif
    otherwise
      error("invalid subscript type");
  end
endfunction
