%
% This function handles reconstruction of 
% current for given potential 
%
% out_grid 3xN dimmensional vector, mesh of points for which CSD is to be calculated
% base_grid 3xN dimmensional vector, mesh of centers of base functions
% src_grid 3xN dimmensional vector, mesh of points for which we have measures of potential
% params - parametrs for base functions
function obj = reconstruct(obj, src_pos, V, out_grid, base_grid)
  %if obj.updateList(3) == 1 || obj.updateList(1) == 1
    obj=calcCurrentK(obj, src_pos, out_grid, base_grid';
    obj=calcK(obj, src_pos, base_grid);
    obj.solver = (cK*(inv(K)))*V;
  %end
end
