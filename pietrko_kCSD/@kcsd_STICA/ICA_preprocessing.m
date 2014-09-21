function obj = ICA_preprocessing(obj, input)

[nx, ~] = size(input);
mixtures = stripmean(input,'st');
fprintf('\nPerforming Singular Value Decomposition (SVD), wait...\n\n');
[U D V] = svd(mixtures, 0);

obj.ICA_data = struct('mixtures', mixtures, 'nx', nx,...
        'U', U, 'V', V,  'D', D);
