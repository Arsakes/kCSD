function params=set_parameters
%names_h;

%params.run_name = ['run.' datestr(now,'yyyy.mm.dd.HH.MM') ];
%params.run_name = 'neco_run2';
params.run_name = '/run_time';

params.main_dir                 = '/home/piotr/projekty/NENCKI/nencki_repo';
params.where_are_the_data       = '/home/piotr/projekty/NENCKI/nencki_repo/dane/dusty';
params.where_to_put_results     = [params.main_dir params.run_name '/wyniki/'];
params.where_to_put_figures     = [params.main_dir params.run_name '/wykresy/'];
params.log_file_name            = [params.where_to_put_results 'run.log'];

params.where_are_the_scripts    = '/home/piotr/projekty/NENCKI/nencki_repo/pietrko_git';
params.where_are_the_kcsd_scripts = '/home/piotr/projekty/NENCKI/nencki_repo/pietrko_git/kCSD/';

% TODO: is it enough to give path just for child class?

% params.nr_of_data_sets = 4;% exp data plus 3 models
% params.prefix    = cell(params.nr_of_data_sets,1);
% params.prefix{1} = 'exp';
% params.prefix{2} = 'poisson';
% params.prefix{3} = 'imi';
% params.prefix{4} = 'gamma_imi';
% params.prefix{5} = 'gamma';
% params.prefix{5} = 'imi_simple';


params.verb = 3;    % verbosity: 1 - display on screen, 
                    % 2 - print to file, 
                    % 3 - do both
                    
%% specify the protocol of analysis
%params.protocol = 1:9; %full protocol
%params.protocol = [3];
params.protocol = 2;

%params.do_models=[POISSON GAMMA IMI GAMMA_IMI];
%params.do_models=[POISSON IMI GAMMA_IMI];
%params.do_models=[IMI];

params.subset = 5:6; % 1:6 is for all datasets
