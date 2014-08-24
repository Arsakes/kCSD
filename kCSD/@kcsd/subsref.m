% OCTAVE ONLY 
% definition of indexing operation for kcsd
%
%
function retr = subsref(obj, idx)
  if(isempty(idx))
    error("kcsd: missing index");
  end
  %idx(2).type
  %idx(2).subs
  switch (idx(1).type)
    case "."
      if (strcmp (idx.subs, "kernel"));
      retr = obj.kernel;
      else
        error("@kcsd: invalid property provided");
      end
    otherwise
      error("invalid subscript type");
  end
end
