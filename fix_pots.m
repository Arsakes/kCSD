%function pots = fix_pots(time_span)

time_span = da.time_span(dataset_nr);

nr_of_x_electrodes = 64;
nr_of_y_electrodes = nr_of_x_electrodes;

pots = zeros(nr_of_x_electrodes,nr_of_y_electrodes,time_span);
for m=1:nr_of_x_electrodes
    for n=1:nr_of_y_electrodes
        eval(['pots(',int2str(m),',',int2str(n),',:) = Ch',int2str(m),'_',int2str(n),'(1:time_span);']);
    end
end