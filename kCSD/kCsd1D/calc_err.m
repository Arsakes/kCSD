function err = calc_err(lambda, Pot, K, Ind_test, Ind_train)

%Kernel matrix cuted to reconstructed subspace of measures
K_train = K(Ind_train, Ind_train);

%mesures used for reconstruction
Pot_train = Pot(Ind_train);

%mesures used for comparision
Pot_test = Pot(Ind_test);

I = eye(length(Ind_train));

%
beta = (K_train + lambda.*I)^(-1)*Pot_train;

K_cross = K(Ind_test, Ind_train);

Pot_est = zeros(size(Ind_test'));

%this is not the full error, we should iterate on all Ind_train
for i = 1:length(beta)
    Pot_est = Pot_est + beta(i) .* K_cross(:, i);
end;

err = norm(Pot_test - Pot_est);

