function compute_CSD_regular(pa,da,log_file)



for dataset_nr=pa.subset
    
    % Load the data
    load(da.dataset_name{dataset_nr})
    
    % Transform the data conveniently for viewing pots    
    nr_of_x_electrodes = 64;
    nr_of_y_electrodes = nr_of_x_electrodes;    
    time_span = 7700;
    
    pots = zeros(nr_of_x_electrodes,nr_of_y_electrodes,time_span);    
    for m=1:nr_of_x_electrodes
        for n=1:nr_of_y_electrodes
            eval(['pots(',int2str(m),',',int2str(n),',:) = Ch',int2str(m),'_',int2str(n),'(1:time_span);']);
        end
    end
    
    
    %% Transform the data conveniently for kcsd
    
    %23:62
    %1:30
    
    nr_of_x_electrodes = 30;
    nr_of_y_electrodes = 40;
    
    time_span = 7700; %38510;
    
    luca_pots = zeros(nr_of_x_electrodes*nr_of_y_electrodes,time_span);
    luca_el_pos = zeros(nr_of_x_electrodes*nr_of_y_electrodes,2);
    
    el_index = 1;
    clear m n
    for m=1:nr_of_x_electrodes
        for n=1:nr_of_y_electrodes
            real_x = m;  %4*m;
            real_y = 22+n;     %4*n;
            eval(['pots_temp = Ch',int2str(real_x),'_',int2str(real_y),'(1:time_span);']);
            
            if isempty(find(abs(pots_temp(:))>4000,1))
                luca_el_pos(el_index,1) = real_y;    % y coordinate
                luca_el_pos(el_index,2) = real_x;    % x coordinate
                luca_pots(el_index,:) = pots_temp;
                el_index = el_index+1;
            end
            
            %eval(['clear Ch',int2str(m),'_',int2str(n),';']);
        end
    end
    
    luca_pots = luca_pots(1:el_index-1,:);
    luca_el_pos = luca_el_pos(1:el_index-1,:);
    
    
    %% calculate kCSD estimate
    %profile on
    k = kcsd2d(luca_el_pos, luca_pots, 'h', 20);
    
    k.plot_CSD
    k.plot_pots
    
    %profile viewer
    
    
    %%
    % k.plot_CSD;
    
    exported_potentials = k.pots_est;
    
end
