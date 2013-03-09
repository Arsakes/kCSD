function [luca_el_pos, luca_pots] = get_pots_regular(pots, time_span, el_pos)

nr_of_electrodes = length(el_pos);

luca_pots   = zeros(nr_of_electrodes,time_span);
luca_el_pos = zeros(nr_of_electrodes,2);

el_index = 1;

for m=1:nr_of_electrodes
    
    real_x = el_pos(m,1);  %4*m;
    real_y = el_pos(m,2);     %4*n;
    pots_temp = squeeze(pots(real_x,real_y,1:time_span));
    
    if isempty(find(abs(pots_temp(:))>4000,1))
        luca_el_pos(el_index,1) = real_y;    % y coordinate
        luca_el_pos(el_index,2) = real_x;    % x coordinate
        luca_pots(el_index,:) = pots_temp;
        el_index = el_index+1;
    end
    
end

luca_pots = luca_pots(1:el_index-1,:);
luca_el_pos = luca_el_pos(1:el_index-1,:);

