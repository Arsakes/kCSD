%% Copyright Daniel Wojcik (2012)
% Scripts to analyze the data from Dusty
% data coming from Andrew Jackson laboratory



%% Setup parameters for data analysis
pa=set_parameters; % pa - a structure with all the parameters

cd(pa.where_are_the_kcsd_scripts);
addpath(genpath(pwd));
path(pa.where_are_the_scripts,path);

[~,~,~] = mkdir(pa.where_to_put_results);
[~,~,~] = mkdir(pa.where_to_put_figures);

cd(pa.where_are_the_data);
load('microwire_move_data')


%% From Andrew


%DATA FORMAT

%staStore and staNormStore have the same format. staNormStore is normalised
%by dividing the kernel by the standard deviation of that LFP channel (std
%of the whole recording). Their format is:

%staStore{u}(dim1,dim2,dim3)    

    %u = unit index (1:2), where:
    unitsToProc= [8,1;12,1]; %ie. unit 1 is ch8-code1, unit 2 is ch12-code1
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

blocks=blockInfo(:,1);
width=200;
sRate=48.828125000;

nUnits=size(unitsToProc,1);

lfpsToPlot = 1:23;
tSTA  =((1:width-1)-width/2)/sRate;



%%
%figure

moving_electrodes = [6, 11, 13, 21];
unit = [1, 2];

for u = unit
    for lfpi = moving_electrodes
        moveMat=squeeze(staNormStore{u}(:,lfpi,:));  % 199x12
        %plot(tSTA,moveMat);
        
        elPos = 0.5*(1:12);
        pots = moveMat';
        X = 0:0.05:6.5;
        k = kCSD1d(elPos, pots, 'X', X);
        % generate positions for the electrodes
        
        %
        k.estimate;
        figure
        subplot(1,2,1)
        imagesc(k.csdEst);
        
        
        
        %%
        
        % You can also provide more a-priori knowledge at this stage, like
        
        % the radius of cylinder in the 1d model (corresponds to the 'r'
        % parameter in section 2.1.2 in the paper):
        R = 0.3;
        
        % the thicknes of the basis element (corresponds to the 'R' parameter in
        % equation 2.25 in the paper):
        h = 0.5;
        
        % space conductivity (assumed to be constant)
        sigma = 0.3;
        
        k = kCSD1d(elPos, pots, 'X', X, 'R', R, 'h', h, 'sigma', sigma);
        % the arguments can be provided in arbitrary order in ('ArgName', 'ArgVal')
        % pairs
        
        
        % Now you have to run the estimation method
        k.estimate;
        
        % The results of the estimation are now available in the k.csdEst property
        % it is a (n_rec_x x nt), where n_rec_x denotes the spatial resolution
        % and nt denotes the number of time points at which the potential was
        % measured.
        subplot(1,2,2)
        imagesc(k.csdEst);
        
    end
end




% %% read in dataset parameters
% 
% da = datasets_def();
% if (da.nr_of_datasets ~= size(da.dataset_name,2))
%     disp('fix the number of datasets in function "datasets_def.m"');
%     return
% end
% 
% 
% %%
% cd(pa.where_to_put_results);
% log_file = fopen(pa.log_file_name,'a+');
% % my_print(log_file,['start: ' datestr(now,'yyyy.mm.dd.HH.MM')],pa.verb);
% 
% 
% for todo = pa.protocol
%     % my_print(log_file,['todo = ' int2str(todo)],pa.verb);
%     switch todo        
%         case 1            
%             compute_CSD(pa,da,log_file);
%             
%         case 2
%             visualize_CSD(pa,da,log_file);
%                     
%         otherwise
%             my_print(log_file,['protocol ' int2str(todo) ' has not been defined yet'],pa.verb);
%             return
%     end
% end
% cd ('..');
% fprintf(log_file,['finish: ' datestr(now,'yyyy.mm.dd.HH.MM') ]);
% fclose(log_file);
% 
