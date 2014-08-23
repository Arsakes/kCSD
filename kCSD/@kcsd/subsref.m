% OCTAVE ONLY 
% definition of indexing operation for kcsd
%
%
function retr = subsref(obj, idx)
  if(isempty(idx))
    error("kcsd: missing index");
  endif
  %idx(2).type
  %idx(2).subs
  switch (idx(1).type)
    case "."
      if (strcmp (idx.subs, "kernel"));
      retr = obj.kernel;
      else
        error("@kcsd: invalid property provided");
      endif
    otherwise
      error("invalid subscript type");
  end
endfunction
