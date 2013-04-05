function bPot = calc_bPot(k)
nsx = length(k.src);
n_obs = length(k.el_pos);
Lx = max(k.src(:) - min(k.src));
dsx = Lx./(nsx+1);
bPot = zeros(nsx,n_obs);
for i=1:nsx
    for j=1:n_obs
        %for all the observation points
        %calculating the base value of the i-th base function
        bPot(i,j)=b_pot_quad(k.src(i),k.elPos(j),k.h,k.R,k.sigma);
    end;
end;

end

    
