% Created by Bowen Wu in 20171230
% This script is aim to divide LR_patch_set and HR_patch_set
% into subset and in seperate file to decrease the use of memory


clear;
load('lr_patches_train_coef.mat');
load('hr_patches_train_coef.mat');
load('patch_cluster_label.mat');

InitParameter

for cluster_index = 1 : cluster_num
    filename = sprintf('%d_cluster_patch_set.mat', cluster_index);
    LR_subset = LR_patch_set(:, patch_cluster_label == cluster_index);
    HR_subset = HR_patch_set(:, patch_cluster_label == cluster_index);
    save(filename, 'LR_subset', 'HR_subset', '-v7.3');
    fprintf('INFO : finish cluster index %d\n', cluster_index);
end