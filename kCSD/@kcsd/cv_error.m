% @author Pietrko  <p.l.stepnicki@gmail.com>
% @description This function performs reconstruction used in calculation of error, based
%  on code of Potworowski & Wójcik
%
% computation of error is done for cross validation case
% the only parameter that is varied is lambda!
%
function err = cv_error(obj, ind_test, ind_train, lambda)
  % kernel matrix cuted to reconstructed
  K_train = obj.kernel(ind_train, ind_train);
  
  V_train = obj.V(ind_train);	                            %train data
  V_test = obj.V(ind_test);                                 %test data

  K_cross = obj.kernel(ind_test, ind_train);                % generates output

  I = eye(length(ind_train));
  Vt = inv(K_train + lambda.*I)*V_train;
  
  %V_test = zeros(size(ind_test'));
  %for i =(1:length(Vt))
  %  V_test = V_test + Vt(i) .* K_cross(:,i);
  %end
  V_est = K_cross*Vt;
  err = norm(V_test - V_est);
end
