%% Copyright Daniel Wojcik (2012)
% Scripts to analyze the data from Dusty
% data coming from Andrew Jackson laboratory
%
% chagned by Piotr Stępnicki (2013)

% Remember the current location
start_loc=pwd();


%% Setup parameters for data analysis
pa=set_parameters; % pa - a structure with all the parameters

% generate positions for the electrodes, 12 sets of them
estimations_N=64;
varPos=transpose(variatePos(0.5, 1.0, 12, estimations_N));

% outpout format
%
% results.csd - csd
% results.cverr - matrx of erroers for different measurements and positions
% results.pos - best position for
results.csd={};
results.varPos=varPos;
% result 
results.cverr=zeros(8,estimations_N);
results.lambda=zeros(8,estimations_N);
 


cd(pa.where_are_the_kcsd_scripts);
addpath(genpath(pwd));
path(pa.where_are_the_scripts,path);

[~,~,~] = mkdir(pa.where_to_put_results);
[~,~,~] = mkdir(pa.where_to_put_figures);

cd(pa.where_are_the_data);
load('microwire_move_data')

%% Description of experimental setup by Peter
%
% EXPERIMENTAL SETUP
%  
% Dusty was stiffed with two pairs of electrodes one set 
% in M1(motor cortex) second pair in PMv (prefrontal cortex)
% there were 12 electrodes in M1(channels 1-12) and 10 in PM (channels 13-23)
% For M1 signal only form two electrodes were moved namely lfp6 and lfp11.
% For PMv 
% Not sure which channels are associated with them.
%
%
% 
% DATA FORMAT (Peter notes)
% what is unit  "u" ?
%
%
%
%


%% From Andrew


%DATA FORMAT

%staStore and staNormStore have the same format. staNormStore is normalised
%by dividing the kernel by the standard deviation of that LFP channel (std
%of the whole recording). Their format is:

%staStore{u}(dim1,dim2,dim3)    

    %u = unit index (1:2), where: TODO: what are these units
    %unitsToProc= [8,1;12,1]; %ie. unit 1 is ch8-code1, unit 2 is ch12-code1
    %TODO: what is it units to proc?
        %dim1 = sta kernel samples, symmetrical around zero (1:width-1)
        %dim2 = lfp ch (1:24)
        %dim3 = block index (1:12), where:
        blockInfo= {'248','day00','pos00';...
                    '256','day02','pos01';...
                    %'265','day06','pos02';...
                    '268','day07','pos02';...
                    '273','day09','pos03';...
                    '277','day13','pos04';...
                    %'283','day15','pos05';...
                    '285','day16','pos05';...
                    '296','day20','pos06';...
                    '304','day22','pos07';...
                    '310','day24','pos08';...
                    '314','day29','pos09';...
                    %'318','day35','pos10';...
                    '321','day36','pos10';...
                    '332','day38','pos11'};


%TODO: remove not needed variables
%blocks=blockInfo(:,1);
width=200;
%samplingRate=48.828125000;

%nUnits=size(unitsToProc,1);

%lfpsToPlot = 1:23;
%tSTA  =((1:width-1)-width/2)/samplingRate;
%TODO: scale time, and set middle as zero


moving_electrodes = [6, 11, 13, 21];
unit = [1, 2];


% amount of indopendent components
n_components=4;
I=1;

% result is a structure composed of matrix of errors
% and matrix of vector of best pos
% this time what is needed is matrix dependent on position
 
for u = unit
    ind=1;
    for lfpi = moving_electrodes
        moveMat=squeeze(staNormStore{u}(:,lfpi,:));  % 199x12
        %plot(tSTA,moveMat);
        
        pots = moveMat';
        
       
        % You can also provide more a-priori knowledge at this stage, like
        
        % the radius of cylinder in the 1d model (corresponds to the 'r'
        % parameter in section 2.1.2 in the paper):
        R = 0.3;
        
        % the thicknes of the basis element (corresponds to the 'R' parameter in
        % equation 2.25 in the paper):
        h = 0.5;
        
        % space conductivity (assumed to be constant)
        sigma = 0.3;
        

       
        for s = (1:estimations_N)
            elPos=varPos(s,:);
            % geometry depends random
            X = 0:0.05:(max(elPos)+0.5);
            k = kCSD1d(elPos, pots, 'X', X, 'R', R, 'h', h, 'sigma', sigma);
            % the arguments can be provided in arbitrary order in ('ArgName', 'ArgVal')
            % pairs
        
        
            % Now you have to run the estimation method - is included in chooseLambda
            k.chooseLambda();
            k.getCVerror;
            %saving cross validation error and lambda parameter
            results.cverr(I,s) = k.getCVerror;
            results.lambda(I,s)=k.lambda;
            results.csd{I,s} = k.csdEst;
        end
        I=I+1;
        %saviing to bigger structure
    end
end

%preparing the out data 
hist(mean(results.cverr), 10);


%saving results
cd(pa.where_to_put_results);
save('results_position', 'results');

%going back
cd(start_loc);
