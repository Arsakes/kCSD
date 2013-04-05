function [S, T] = average_components(k, n_ics)

P = k.ICA_data.P;
Scp = k.ICA_data.Scp;
Tcp = k.ICA_data.Tcp;
S = zeros(n_ics, size(Scp, 2));
T = zeros(n_ics, size(Tcp, 2));

partition = P(n_ics, :);

for i = 1:n_ics
    ind = (partition == i);
    S(i,:) = mean(Scp(ind,:));
    T(i,:) = mean(Tcp(ind,:));
end

S = permute(S, [2 1]);
T = permute(T, [2 1]);


