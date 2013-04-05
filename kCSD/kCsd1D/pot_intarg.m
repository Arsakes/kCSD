%
% Function used for definiton of the trasformation beetwen CSD base function
% and potential base function: resulting function need to be integrated over X domain to give
% corresponding potential base function
%
%
% src - 
% arg - argument of function
% h   - gaussian parameter
%
function [y]=pot_intarg(src, arg, current_pos, h, R, sigma, src_type)

        y=(1/(2*sigma))*(sqrt((arg-current_pos).^2+R.^2)-abs(arg-current_pos)) .* ...
            gauss_rescale(src, current_pos, h);     
end
%
% TODO:In fact only gaussian profile for sources is available, despite passing
%      source type parameter.
%

