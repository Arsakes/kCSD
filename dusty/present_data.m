%
% Scripts shows gathered data
%
%
start_loc=pwd();

%% Setup parameters for data analysis
pa=set_parameters; % pa - a structure with all the parameters
cd(pa.where_to_put_results);


% Loading the results
load('results_pietrko.mat');


% For each electrode set(in this case one electrode in one set) make plots
for ind1 = 1:2
    for ind2 =1:4
        figure;
        % plotting the CSD reconstruction
        subplot(2,3,1);
        imagesc( results{ind1}{ind2}.CSD );
        text=strcat('CSD reconstruction, cverr:', num2str(results{ind1}{ind2}.cverr) );
        title(text);
        % plotting the n-th components
        for ind3 = (1:results{ind1}{ind2}.IC_comp)
            subplot(2,3,ind3+1);
            imagesc( results{ind1}{ind2}.IC{ind3} );
            text=strcat('IC component:', num2str(ind3));
            title(text);
	end
    end
end


% going back to 
cd(start_loc);
