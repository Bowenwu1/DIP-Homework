% Created by Bowen Wu in 20171230
% This script is aim to get coef matrix for each cluster
% according to the label result from previous step

clear;
clc;
InitParameter
load('LR_patch_set.mat');
load('HR_patch_set.mat');
load('patch_cluster_label.mat');
load('total_patch_num.mat');

coef_matrix = zeros(hr_center_size * hr_center_size, ...
                    lr_patch_size * lr_patch_size - 3, cluster_num);
whetherRankDeficiency = zeros(cluster_num, 1); % 1 for Deficiency, 0 otherwise

% special tech
LR_patch_set = [LR_patch_set; ones(1, total_patch_num)];

for cluster_index = 1 : cluster_num
    fprintf('INFO : calculating %d cluster coef\n', cluster_index);
    LR_subset = LR_patch_set(:, patch_cluster_label == cluster_index);
    HR_subset = HR_patch_set(:, patch_cluster_label == cluster_index);
    % calculate rank
    r = rank(LR_subset);
    if r < lr_patch_size * lr_patch_size - 3
        fprintf('INFO : cluster No.%d have rank %d\n', cluster_index, r);
        whetherRankDeficiency(cluster_index) = 1;
    end
    coef_matrix(:, :, cluster_index) = LR_subset \ HR_subset;
end
