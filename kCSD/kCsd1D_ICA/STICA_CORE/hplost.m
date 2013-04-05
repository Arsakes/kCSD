function [ys, yt] = hplost(K, M, w, h, x)% Name altered to demo cos are 2 versions in dirs.% x = fundat.% Spatial ICA% Generates graphics and tracks minimumglobal ncall nr nc;global hmin wmin;global pct sval;global SPATIAL_ICA TEMPORAL_ICA SPATIOTEMPORAL_ICA;if nargin==5 override=0; end;override=1;% heval calls hplos every ndrw calls ndrw = 10;ncall = ncall+1;% remember minimumif hmin > h	wmin = w;	hmin = h;end[Ws Wt D]=get_VWD(w,x);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%if override==1 | ndrw == 1 | ncall == 1 | rem(ncall, ndrw) == 1	fprintf('%6d | %12.6f %12.6f\n', ncall, hmin, h);	y = x.P*Ws; % unmix!	y = y';	ys=y;	% SPATIAL%	plot spatial IC's	if TEMPORAL_ICA		str_title = 'Dual Spatial #';	elseif SPATIOTEMPORAL_ICA | SPATIAL_ICA		str_title = 'Spatial IC #';	end;	jfig(3);	for k = 1:K		subplot(K/2, 2, k);		pnshow( reshape(y(k, :), nr, nc) );		title( ['Spatial IC #', int2str(k)] );		axis off; axis square; 	end	% TEMPORAL Q%	get and plot dual time sequence	if SPATIAL_ICA		str_title = 'Dual Temporal #';	elseif SPATIOTEMPORAL_ICA | TEMPORAL_ICA		str_title = 'Temporal IC #';	end;	jfig(4);	yt = x.Q * Ws;	for k = 1:K		subplot(K/2, 2, k);		plot( yt(:, k) );		title( [str_title, int2str(k)] );	end	temp=1:360;	f(23); plot( temp,yt(:, 2),  temp,yt(:, 3));jcorr( yt(:, 2),  yt(:, 3))	jfig(5);	for k = 1:K		subplot(2, K/2, k);		hist(yt(:,k), 50);		title( ['Histogram For SIC #' int2str(k)] );	endend