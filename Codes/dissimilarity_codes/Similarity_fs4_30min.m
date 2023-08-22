clear;clc;
group_path = '/home/eyre/anesthesia/results/similarity/group_level';
data_path = '/media/eyre/DATA/HenNan-anesthesia';
indi_path =  '/home/eyre/anesthesia/results/similarity/indi_level';
dir_sub = dir(fullfile(data_path,'MR*'));
dir_sub = {dir_sub(:).name}';

state = {'control','control2'};

load('./ind_fs4_surf.mat'); 
sim = zeros(5124,numel(dir_sub));
for si = 1:numel(dir_sub)
    
   %%  similarity fs4
    for ses = 1:numel(state)
        dir_ses = dir(fullfile(data_path,dir_sub{si},['*',state{ses}]));
        dir_surf = fullfile(data_path,dir_sub{si},dir_ses.name,'Preprocess','surf');
        name_runs = dir(fullfile(dir_surf,'*fsaverage4.nii.gz'));
        name_runs = {name_runs(:).name}';
        for runi = 1:numel(name_runs)
            name_runs{runi} = name_runs{runi}(4:end);
        end
        name_runs = unique(name_runs);

        run_all = [];
        for runi = 1:numel(name_runs)
            name_subrun = dir(fullfile(dir_surf,['*h*',name_runs{runi}]));
            name_subrun = {name_subrun(:).name}';
            run_tmp = [];
            % read surf data
            for hemi = 1:numel(name_subrun)
                name_subrun{hemi}
                hdr = MRIread(fullfile(dir_surf,name_subrun{hemi}));
                subrun_tmp = single(hdr.vol);
                subrun_tmp = reshape(subrun_tmp,[hdr.nvoxels,hdr.nframes]);
                run_tmp = cat(1,run_tmp,subrun_tmp);
                clear subrun_tmp hdr
            end
            run_all = cat(2,run_all,run_tmp);
        end
        % correlation
        fc_all(:,:,ses) = corr(run_all(ind_mask,:)');
        fc_all(isnan(fc_all)) = 0;

    end
    
   
    fc_tmp1 = corr(fc_all(:,:,1)',fc_all(:,:,2)');
    fc_tmp1(isnan(fc_tmp1)) = 0;
    sim(ind_mask,si) = diag(fc_tmp1);

    dir_out = fullfile(indi_path,dir_sub{si},'similarity_fs4','30min_control1-control2');
    mkdir(dir_out);
    save_mgh(sim(1:2562,si),[dir_out,'/lh.mgh'],eye(4));
    save_mgh(sim(2563:end,si),[dir_out,'/rh.mgh'],eye(4));

end
sim_mean = mean(sim,2);
dir_out_group = fullfile(group_path,'similarity_fs4','30min_control1-control2');
mkdir(dir_out_group);
save_mgh(sim_mean(1:2562),[dir_out_group,'/lh.mgh'],eye(4));
save_mgh(sim_mean(2563:end),[dir_out_group,'/rh.mgh'],eye(4));
