%
% We use this function for calculating value of potential base functions for a 
% given point on reconstruction domain
%
% 
function [y]=b_pot_quad(src,arg,h,R,sigma,src_type)
switch src_type
    case 'step'
        y=quad ( @(zp) pot_intarg(zp,arg,h,R,sigma,src_type), src-(0.5*h),src+(0.5*h));
    case 'gauss'
        y=quad ( @(current_pos) pot_intarg(src, arg, current_pos, h, R, sigma, src_type), src-4*h,src+4*h);
end;
%
%
% TODO: use integral instead of quad function(this one is obsolete).
%
% NOTE: @(argument) function(argument, other args) is passed to this function
