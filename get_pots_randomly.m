function [luca_el_pos, luca_pots] = get_pots_randomly(pots, time_span)

nr_of_electrodes    = 300;

luca_pots       = zeros(nr_of_electrodes,time_span);
luca_el_pos     = zeros(nr_of_electrodes,2);

for el_index=1:nr_of_electrodes
    real_x = randi(64);
    real_y = randi(64);
    pots_temp = squeeze(pots(real_x,real_y,1:time_span));
    
    
    if isempty(find(abs(pots_temp)>4000,1))
        %disp([int2str(real_x), '   ', int2str(real_y)])
        
        luca_el_pos(el_index,1) = real_y;    % y coordinate
        luca_el_pos(el_index,2) = real_x;    % x coordinate
        luca_pots(el_index,:) = pots_temp;
        %disp(el_index)
        %disp(pots_temp(1:5))
        pots(real_x,real_y,time_span) = 5000; % stupid:
        % setting a marker to avoid selecting this electrode set again
        %pause
    end
end
