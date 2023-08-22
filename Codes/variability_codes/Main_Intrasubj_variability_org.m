clear,clc;

DataPath = ' ';

OutPath = ' ';

mkdir(OutPath)

subs = textread(['**.txt'], '%s');

Netpath = './fsaverage3';
Net1_lh = squeeze(load_mgh([Netpath '/lh_network_1.mgh']));
Net1_rh = squeeze(load_mgh([Netpath '/rh_network_1.mgh']));
Net1 = [Net1_lh;Net1_rh];
IndNet = find(Net1 == 0);

num_fs4=2562;
IntraVariance = zeros(23, num_fs4);

for s = 1:23
    index=(s-1)*5+1
    sub = subs{index}(1:7);
    Rmat = zeros(num_fs4, length(IndNet), 10);
    for i = 1:5
	    idx=(s-1)*5+i;
        sub_name = subs{idx};	
        sub_name(end-2:end)=[];
        % Load Surface Signal
        FileName=[DataPath '/' sub_name '/surf/lh.' sub_name '_bld010_***_fsaverage4.nii.gz'];
        hdr  = MRIread(FileName);
        data_lh = reshape(hdr.vol, [hdr.nvoxels, hdr.nframes]);
        data_fs4_lh= data_lh';

        FileName=[DataPath '/' sub_name '/surf/lh.' sub_name '_bld010_***_fsaverage3.nii.gz'];
        hdr  = MRIread(FileName);
        data_lh = reshape(hdr.vol, [hdr.nvoxels, hdr.nframes]);
        data_lh=squeeze(data_lh);

        FileName=[DataPath '/' sub_name '/surf/rh.' sub_name '_bld010_***_fsaverage3.nii.gz'];
        hdr  = MRIread(FileName);
        data_rh = reshape(hdr.vol, [hdr.nvoxels, hdr.nframes]);
        data_rh=squeeze(data_rh);
        data_tmp=[data_lh;data_rh]';
        
        data_fs4_all = single(data_fs4_lh);
        Data_All = single(data_tmp(:, IndNet));
        Rmat(:,:,i) = my_corr(data_fs4_all, Data_All);
    end 
    Rmat(isnan(Rmat)) = 0;
    count = 0;
    AveRmat = zeros(num_fs4, 1);
    for m = 1:5
        for n = m+1:5
            count = count + 1;
            tmp = my_corr(squeeze(Rmat(:,:,m))', squeeze(Rmat(:,:,n))');
            tmp(isnan(tmp)) = 0;
            AveRmat = AveRmat + diag(tmp);
        end
    end
    count
    IntraVariance(s, :) = 1 - AveRmat/count;
    save_mgh(IntraVariance(s,:), [OutPath '/lh.' sub '_intravariance_fs4.mgh'],eye(4))
end
meanIntraVariance = mean(IntraVariance);
save_mgh(meanIntraVariance, [OutPath '/lh.meanIntravariance_across5sess_fs4.mgh'],eye(4))
