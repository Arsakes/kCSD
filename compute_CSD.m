function compute_CSD(pa,da,log_file)


for dataset_nr=pa.subset
    
    % Load the data
    cd(pa.where_are_the_data);
    load([da.dataset_name{dataset_nr}, '.mat'])
    
    % Transform the data conveniently for viewing pots    
    %pots = fix_pots(da.time_span(dataset_nr));
    fix_pots;
    
    %% Transform the data conveniently for kcsd
    nr_of_x_electrodes = 16;
    nr_of_y_electrodes = 16;
    
    el_pos = zeros(nr_of_x_electrodes*nr_of_y_electrodes,2);
    
    el_index = 1;
    for m=1:nr_of_x_electrodes
        for n=1:nr_of_y_electrodes
            el_pos(el_index,1) = 4*m-2;
            el_pos(el_index,2) = 4*n-2;            
            el_index = el_index+1; 
        end
    end    
    el_pos = el_pos(1:el_index-1,:);
    
    %[luca_el_pos, luca_pots] = get_pots_randomly(pots,da.time_span(dataset_nr));
    [luca_el_pos, luca_pots] = get_pots_regular(pots,da.time_span(dataset_nr),el_pos);
 
    %% calculate kCSD estimate
    %profile on
    k = kcsd2d(luca_el_pos, luca_pots, 'h', 20, 'R', 5.8);
    %k.choose_R_lambda;
    
    est_potentials = k.pots_est;
    est_CSD = k.CSD_est;
    
    cd(pa.where_to_put_results);
    savefile = [da.dataset_name{dataset_nr}, '_results.mat'];
    save(savefile, 'est_potentials', 'est_CSD', 'pots');
    
    % k.plot_CSD
end
