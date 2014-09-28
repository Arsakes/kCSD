% @author Pietrko  <p.l.stepnicki@gmail.com>
% @description This function performs reconstruction used in calculation of error, based
%  on code of Potworowski & Wójcik
%
% computation of error is done for cross validation case
% the only parameter that is varied is lambda!
%
function err = cv_error(obj, ind_test, ind_train, lambda)
 
  % determnation of size of input for training (which time snapshots use)
  nr_of_frames = size(obj.V, 2);
  switch obj.cvTestSet
    case 'all'
      Time_ind  = 1:nr_of_frames;
    case 'part'
      Time_ind  = randperm(nr_of_frames, obj.cvTestSetSize);
    case 'one'
      diffs = max(obj.V) - min(obj.V);
      Time_ind = find(diffs == max(diffs), 1);
    otherwise
  end

  % kernel matrix cuted to reconstructed
  K_train = obj.kernel(ind_train, ind_train);
  
  V_train = obj.V(ind_train, Time_ind);                     %train data
  V_test = obj.V(ind_test);                                 %test data

  K_cross = obj.kernel(ind_test, ind_train);                % generates output

  I = eye(size(K_train));
  %size(V_train)
  %size(K_train)
  %size(I)
  Vt = inv(K_train + lambda.*I)*V_train;
  
  V_est = K_cross*Vt;
  %V_est = K_cross*inv(K_train + lambda.*I)*V_train;
  err = norm(V_test - V_est, obj.norm_order);
end
