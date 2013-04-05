function [S_components, T_components, S, T] = stica_stone(k, varargin)
global num_funevals plot_inverval num_linesearches;
global ncall hmin wmin pcs pct sval nr nc;
global U D V nt nr nc;
global nplt P Q hs ncall nic neig;
global SPATIAL_ICA TEMPORAL_ICA SPATIOTEMPORAL_ICA;
global fundat mindat temp_s temp_t mode;
global U0 V0 D0 U_orig V_orig D_orig beta;
global wm_sm;
global SKEW_PDF_s SKEW_PDF_t;

m = k.ICA_data.mixtures;
nx = k.ICA_data.nx;
U = k.ICA_data.U;
V = k.ICA_data.V;
D = k.ICA_data.D;


arglist = varargin;
arglist = arglist{1};
[nic, SKEW_PDF_s, hi_kurt_s, lo_kurt_s,...
    SKEW_PDF_t, hi_kurt_t, lo_kurt_t, mode, alpha, clustering] = ...
    get_stica_stone_vars(arglist);
neig = nic;
%----------------------------------------------------------------------
% SET GLOBALS
%----------------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERAL GLOBALS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RAND_SEED 	= 'clock'; % 999 for original REAL DATA for neuroimage paper
jrand_set_seed(RAND_SEED); % 999

func_count			= 0;
num_linesearches 	= 0;
temp_s				= 0;
temp_t				= 0;
num_funevals		= 0; 
plot_inverval		= 10; % counts line searches.

init		= 1; % New everything.
init_W		= 1; % New wt matrix.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GLOBALS FOR ICA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%neig 		= 4; % 16 	% number of eigenvectors used for ICA.
%mode		= 'st'; 	% s=spatial, t=temporal, st=spatiotemporal
wm_sm		= 0; 		% Use weak model (temporal smoothness).
beta 		= 0.5; 		% 0.5; weak model - see sticafg.m.


% SET KURTOSIS OF REQUIRED SPATIAL AND TEMPORAL ICS.
% CLASSIC hi_kurt_s=[1 2];lo_kurt_s=[3 4];	hi_kurt_t = [1 3];lo_kurt_t = [2 4];
% GOOD hi_kurt_s=[1 2]; lo_kurt_s=[3 4];		hi_kurt_t=[1 3 4]; lo_kurt_t=[2];


hs	= [];
ncall 	= 0;	% counts calls to heval
hmin 	= 1e10;

% number of ICs to extract.
nplt	= 10;

% SET FLAGS.
SPATIAL_ICA		= 0; 
TEMPORAL_ICA		= 0;
SPATIOTEMPORAL_ICA	= 0;
if  strcmp(mode,'st')
	SPATIOTEMPORAL_ICA	= 1;
	SPATIAL_ICA			= 1; 
	TEMPORAL_ICA		= 1;
	fprintf('Using SPATIOTEMPORAL_ICA\n\n');
elseif strcmp(mode,'s')
	SPATIAL_ICA			= 1; 
	fprintf('Using SPATIAL_ICA\n\n');
elseif  strcmp(mode,'t')
    TEMPORAL_ICA		= 1;
    fprintf('Using TEMPORAL_ICA\n\n');
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PREPARE DATA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

U0=U;V0=V;D0=D;
U_orig=U;V_orig=V;D_orig=D;
U=U_orig; V=V_orig; D=D_orig;
pcs=U; pct=V; sval=D;

% SET SPATIAL AND TEMPORAL EIGENVECTORS.
try
pcs 	= pcs(:, 1:neig); 
catch err
    keyboard
end
pct 	= pct(:, 1:neig); 
sval 	= sval(1:neig, 1:neig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ICA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if init_W
	% Initialise weight matrix.
	% Must add rand else W0 is singular and cannot be inverted.
        %W0 = eye(nic,neig)+randn(nic,neig)*0.9;
    W0 = randn(nic,neig);
	%W0 = 1:nic*neig;
   	% W0 = W0/sum(W0); W0 = reshape(W0,[nic neig]);
else
	warning('Starting from old W0 ...');
	W0=reshape(wmin,size(W0));
	jsize(W0,'W0');
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAXMIMISE ENTROPY.

	% Ensure that x=PQ; and P=kxm, Q=kxn.
	if init==1
		% Make svals sum to one. 
		d = diag(D);
		sval = D(1:neig, 1:neig)./sum(d(1:neig));
		% figure(10); plot(d(1:neig)); drawnow;
		sval = D(1:neig, 1:neig);

		P=pcs*sqrt(sval);
		Q=pct*sqrt(sval);
	end;
	jsize(P,'P');jsize(Q,'Q');
	% stica
	%alpha = 0.5;
    C1=[]; C2=[];
	[V1, d, S, T, w] = stica(P, Q, alpha, W0, hi_kurt_s,lo_kurt_s,hi_kurt_t,lo_kurt_t, C1, C2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Export to format that can be read by component_viewer
T_components = T;
if clustering == 0
    S_components = ...
        S;
else
    S_components = S;
end;




          
            
            