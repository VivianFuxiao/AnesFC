clear;clc
% %% fs4
load('./ind_fs4_surf.mat');
data_path = '/home/eyre/anesthesia/results/similarity/indi_level';
dir_sub = dir(fullfile(data_path,'MR*'));
dir_sub = {dir_sub(:).name}';
indi_outpath = '/home/eyre/anesthesia/results/dissimilarity/indi_level_control1-control2';
group_outpath  = '/home/eyre/anesthesia/results/dissimilarity/group_level_control1-control2';
mkdir(group_outpath)
for si = 1:numel(dir_sub)
    
allrun_path = fullfile(data_path,dir_sub{si},'similarity_fs4','30min_control1-control2');%[/similarity_fs4/30min_con1-anes'];
lh = load_mgh([allrun_path,'/lh.mgh']);
rh = load_mgh([allrun_path,'/rh.mgh']);
l = [lh;rh];
l0 = l(ind_mask);
l0 = ones(size(l0)) - l0;
l(ind_mask) = l0;
mkdir([allrun_path,'/dissimilarity'])
save_mgh(l(1:2562),[allrun_path,'/dissimilarity/lh.mgh'],eye(4));
save_mgh(l(2563:end),[allrun_path,'/dissimilarity/rh.mgh'],eye(4));

con_path = fullfile(data_path,dir_sub{si},'similarity_fs4','con1_15min-15min');
lh = load_mgh([con_path,'/lh.mgh']);
rh = load_mgh([con_path,'/rh.mgh']);
l1 = [lh;rh];
l0 = l1(ind_mask);
l0 = ones(size(l0)) - l0;
l1(ind_mask) = l0;
mkdir([con_path,'/dissimilarity'])
save_mgh(l1(1:2562),[con_path,'/dissimilarity/lh.mgh'],eye(4));
save_mgh(l1(2563:end),[con_path,'/dissimilarity/rh.mgh'],eye(4));

anes_path = fullfile(data_path,dir_sub{si},'similarity_fs4','con2_15min-15min');
lh = load_mgh([anes_path,'/lh.mgh']);
rh = load_mgh([anes_path,'/rh.mgh']);
l2 = [lh;rh];
l0 = l2(ind_mask);
l0 = ones(size(l0)) - l0;
l2(ind_mask) = l0;
mkdir([anes_path,'/dissimilarity'])
save_mgh(l2(1:2562),[anes_path,'/dissimilarity/lh.mgh'],eye(4));
save_mgh(l2(2563:end),[anes_path,'/dissimilarity/rh.mgh'],eye(4));

L = l(ind_mask);

L1 = l1(ind_mask);
L2 = l2(ind_mask);

[b,bint,r] = regress(L,[ones(size(L)),L1,L2]);
 L = L-b(2)*L1-b(3)*L2;

label = zeros(size(l));

label(ind_mask) = L;
L_14(:,si) = L;
outpath = [indi_outpath,'/regress'];
mkdir(outpath);
save_mgh(label(1:2562),[outpath,'/',dir_sub{si},'_lh_regress.mgh'],eye(4));
save_mgh(label(2563:end),[outpath,'/',dir_sub{si},'_rh_regress.mgh'],eye(4));

Lz = zscore(L);
label(ind_mask) = Lz;
Lz_14(:,si) = Lz;
outpath_z = [outpath,'/zscore'];
mkdir(outpath_z);
save_mgh(label(1:2562),[outpath_z,'/',dir_sub{si},'_regress_zscore.mgh'],eye(4));
save_mgh(label(2563:end),[outpath_z,'/',dir_sub{si},'_regress_zscore.mgh'],eye(4));

end

m_Lz_14 = mean(Lz_14,2);
label(ind_mask) = m_Lz_14;
save_mgh(label(1:2562),[group_outpath,'/lh_mean_regress_zscore.mgh'],eye(4));
save_mgh(label(2563:end),[group_outpath,'/rh_mean_regress_zscore.mgh'],eye(4));

m_L_14 = mean(L_14,2);
label(ind_mask) = m_L_14;
save_mgh(label(1:2562),[group_outpath,'/lh_mean_regress.mgh'],eye(4));
save_mgh(label(2563:end),[group_outpath,'/rh_mean_regress.mgh'],eye(4));

