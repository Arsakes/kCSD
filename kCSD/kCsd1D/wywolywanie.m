clear all;


addpath(genpath('../kCsd1D'));
addpath(genpath('../kCsd1D_ICA'));
load('kCsd1DTestData');



%%
clear k;
X = 0:0.01:2.8;
k = kCSD1d_ICA(elPos, pots, 'X', X);
k.estimate;
k.ICA_preprocessing;
n_comp = 5;
k.calc_ica('neig', n_comp, 'hi_kurt_s', 1:n_comp, 'lo_kurt_t', 1:n_comp, ...
    'mode', 's', 'alpha', 1 );
imagesc(k.csdEst);

%%

% global clims
maxx = 0;
for i = 1:n_comp
    im = k.ICA_data.S_components(:,i)*k.ICA_data.T_components(:,i)';
    max_temp = max(abs(im(:)));
    if maxx<max_temp
        maxx = max_temp;
    end
end

clims = [-maxx maxx];
%%
figure;
i = 6;
component = k.ICA_data.S_components(:,i)*k.ICA_data.T_components(:,i)';
imagesc(component, clims);

