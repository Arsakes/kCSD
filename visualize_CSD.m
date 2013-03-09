function visualize_CSD(pa,da,log_file)



for dataset_nr=pa.subset
    cd(pa.where_to_put_results);
    resultsfile = [da.dataset_name{dataset_nr}, '_results.mat'];
    load(resultsfile, 'est_potentials', 'est_CSD', 'pots');
    
    cd(pa.where_to_put_figures);
    mkdir(da.dataset_name{dataset_nr}) 
    cd(da.dataset_name{dataset_nr})
    
    clims_CSD = [-max(abs(est_CSD(:))) max(abs(est_CSD(:)))];
    clims_pots = [-max(abs(est_potentials(:))) max(abs(est_potentials(:)))];
    
    nFrames = 380; %da.time_span(dataset_nr)/2; % NOTE THE division by 2 - remove!
    for part = 1:10
        %figg = 
        figure('Position',[100 100 950 350]);
        
        %winsize = get(figg,'Position');
        %winsize(1:2) = [0 0];
        %mov=moviein(nFrames,figg,winsize);
        
        %set(figg,'NextPlot','replacechildren');
        %a = get(figg, 'Position');
        
        %mov(:,1)=getframe(figg,winsize);
        
        for n=1:nFrames; %da.time_span(dataset_nr); % NOTE THE division by 2 - remove!
            frame = 2*((part-1)*nFrames+n);
            subplot(1,3,1)
            imagesc(pots(:,:,frame),0.5*clims_pots)
            axis square
            subplot(1,3,2)
            imagesc(est_potentials(:,:,frame),0.5*clims_pots)
            title(['time frame: ' int2str(frame)])
            axis square
            subplot(1,3,3)
            imagesc(est_CSD(:,:,frame),0.5*clims_CSD)
            axis square
            % drawnow
            %set(gcf, 'Position', winsize);
            %mov(:,n)=
            mov(n) = getframe(gcf); %figg,winsize);
            
        end
        
       
        fname = [da.dataset_name{dataset_nr},'_',int2str(part-1), '_movie'];
        mname = [fname, '.avi'];
        
        movie2avi(mov, fname, 'compression', 'None');
        command = sprintf('mencoder %s -o %s -ovc lavc >/dev/null', mname, ...
            [mname(1:end-4) '_compressed' mname(end-3:end)]);
        system(command);
        command = sprintf('rm %s', mname);
        system(command);
        close all
        clear mov
    end
    
    command = sprintf('mencoder -oac copy -ovc copy -o "%s.avi" *',da.dataset_name{dataset_nr});
    system(command);
end