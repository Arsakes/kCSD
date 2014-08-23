%
% This function handles reconstruction of 
% current for given potential 
%
% out_grid 3xN dimmensional vector, mesh of points for which CSD is to be calculated
% base_grid 3xN dimmensional vector, mesh of centers of base functions
% src_grid 3xN dimmensional vector, mesh of points for which we have measures of potential
% params - parametrs for base functions
function C = reconstruct(src_pos, V, out_grid, base_grid, params)
  cK=calcCurrentK(src_pos, out_grid, base_grid, params)';
  %disp('size cK');
  size(cK)
  K=calcK(src_pos, base_grid, params);
  %disp('size K');
  C = (cK*(inv(K)))*V;
