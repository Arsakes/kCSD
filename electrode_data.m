% river data

% channel 1 in the data, is PIN 2 in the connector, which according to the
% sheet is hole 1 

% page 366 in TDTSys3_Manual.pdf has the description on the coding of
% different pins to the channels

% this is according to the holes!!!
% distances in mm
true_el_pos_PFd = zeros(36,3);
true_el_pos_PFd(:,3) = ...
    [2 0 3 4 0 3 5 0 2 3 6 4 5 1.5 5 6 4 3 ...
    4 7 5 6 4 6 7 5 4 6 8 6 7 8 7 6 8 7];
for n=1:9
    true_el_pos_PFd(n,1) = n*0.4-0.2;
    true_el_pos_PFd(n,2) = 0.2;
    
    true_el_pos_PFd(n+9,1) = n*0.4;
    true_el_pos_PFd(n+9,2) = 0.2+0.4*sqrt(3)/2;
    
    true_el_pos_PFd(n+18,1) = n*0.4-0.2;
    true_el_pos_PFd(n+18,2) = 0.2+2*0.4*sqrt(3)/2;
    
    true_el_pos_PFd(n+27,1) = n*0.4;
    true_el_pos_PFd(n+27,2) = 0.2+3*0.4*sqrt(3)/2;
end
    

% now recording into the channel numbers
channel_numbers = [17 19 21 23 18 20 22 24 26 28 30 32 25 27 29 31 1 3 5 7 2 4 6 8 10 12 14 16 9 11 13 15];

hole_numbers = [1 3 4 6 7 9 10 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36];

el_pos_PFd = zeros(32,3);
el_pos_PFd(channel_numbers,:) = true_el_pos_PFd(hole_numbers,:);