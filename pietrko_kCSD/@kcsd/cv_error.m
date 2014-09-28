% @author Pietrko  <p.l.stepnicki@gmail.com>
% @description This function performs reconstruction used in calculation of error, based
%  on code of Potworowski & Wójcik
%
% computation of error is done for cross validation case
% the only parameter that is varied is lambda!
%
function err = cv_error(obj, ind_test, ind_train, lambda, Time_ind)
 

  % kernel matrix cuted to reconstructed
  K_train = obj.kernel(ind_train, ind_train);
  K_cross = obj.kernel(ind_test, ind_train);                % generates output
  
  V_train = obj.V(ind_train, Time_ind);                     %train data
  V_test = obj.V(ind_test, Time_ind);                       %test data

  I = eye(length(ind_train));
  
  %Vt = inv(K_train + lambda.*I)*V_train;
  %V_est = K_cross*Vt;

  V_est = K_cross*inv(K_train + lambda.*I)*V_train;
  err = norm(V_test - V_est, obj.norm_order);
end
