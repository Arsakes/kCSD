% @compatibility Matlab < 7.6(200X?), Octave > 3.8 (2013+)
% @author Piotr Stępnicki
%
%
%
% @note this is an old way of defining a class for matlab i use it for
% compatibility with octave
% 
function k = kcsd()
  % properties of the class
  properties.kernel = 0;

  % for method list checkout the directory
  k = class(properties, 'kcsd');
end
