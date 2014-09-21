%
% MATLAB ONLY
%
% obj - object of this clas
%
function get_neig(obj, proc)
  neig = 0;
  act_proc = 0;
  while act_proc<proc
    neig = neig + 1;
    d_small = diag(obj.ICA_data.D);
    d_small = d_small(1:neig);
    d_big = diag(obj.ICA_data.D);
    act_proc = sum(d_small)/sum(d_big);
  end;
  k.ICA_data.neig = neig;
end
