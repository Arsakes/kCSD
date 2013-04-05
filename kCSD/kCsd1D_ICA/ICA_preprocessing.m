function ICA_data = ICA_preprocessing(input)

[nx, ~] = size(input);
mixtures = stripmean(input,'st');
fprintf('\nPerforming Singular Value Decomposition (SVD), wait...\n\n');
[U D V] = svd(mixtures, 0);

ICA_data = struct('mixtures', mixtures, 'nx', nx,...
        'U', U, 'V', V,  'D', D);