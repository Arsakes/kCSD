%% Generates a vector of dataset names and other useful parameters 
%  characterizing the experiment

%% Comments:
%
%% Output all dataset metadata as a structure

function datasets = datasets_def()

[...
    datasets.dataset_name,...
    datasets.nr_of_datasets...
] = defd();

%     datasets.dir_postfix,...
%     datasets.trial_nr,...
%     datasets.stim_velocity,...
%     datasets.response,...
%     datasets.index_ex,...
%     datasets.index_sup,...
%     datasets.name_nr_separator,...
%     datasets.typ_komorki,...
%     datasets.field_width,...
%     datasets.exclude_trials...



%%
function [dataset_name, nr_of_datasets] = defd()
    % , dir_postfix, trial_nr, stim_velocity, response,...
    % index_ex, index_sup, name_nr_separator, typ_komorki, field_width,...
    % nr_of_datasets, exclude_trials] 
    

%names_h; %load names of the parameters

nr_of_datasets = 5; 

dataset_name        = cell(1,nr_of_datasets);
% trial_nr            = cell(1,nr_of_datasets);
% stim_velocity       = cell(1,nr_of_datasets);
% name_nr_separator   = cell(1,nr_of_datasets);
% response            = cell(2,nr_of_datasets);
% index_ex            = cell(1,nr_of_datasets);
% index_sup           = cell(1,nr_of_datasets);
% typ_komorki         = zeros(1,nr_of_datasets);
% dir_postfix         = cell(1,nr_of_datasets);
% exclude_trials      = cell(1,nr_of_datasets); 
% exclude_trials{j} contains pairs of the form [stim_nr; trial_nr] which
% mean: exclude trial number trial_nr from the response to stimulus stim_nr
% 

% for i=1:nr_of_datasets 
%     dir_postfix{i}=''; 
% end

%%
dataset_name{1} = 'ev2_TI0';    
% 				trial_nr{1} = [16 20 13 17 14 18 21 15]; 
%               stim_velocity{1} = [5 10 20 50 100 200 500 1000];
%               response{1,1} = [1 2 3 4 5 6 7 8];
%               response{2,1} = [2 3 4 5 6 7 8];
%               index_ex{1}=[];         %tylko dla lewe do prawego
%               index_sup{1}=[];        %tylko dla lewe do prawego
%               name_nr_separator{1} = '-';  %nazwa komorki,name_nr_separator                                
%               typ_komorki(1)=LVEHVE;   
%               field_width{1}=50;
                                % oko{1}=CONTRA;                             
                                %is_suppressive{1}=EXC;
                                %response_to_stim_dir{1}=LERI;  

%%
dataset_name{2} = 'ev3_TI0';   
                                
%%
dataset_name{3} = 'ev4_TI0';    

%%
dataset_name{4} = 'ev5_TI0';   
                                
%%
dataset_name{5} = 'ev6_TI0';    

