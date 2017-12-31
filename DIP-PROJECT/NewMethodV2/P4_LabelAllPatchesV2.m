% Created by Bowen Wu in 20171229
% This script is aim to find nearest cluster center for each patch
% output : an array contain the cluster num for each patches

clear;
clc;
fprintf('INFO : start label all patches. version 2\n');
InitParameter
load('LR_patch_set.mat');
load('total_patch_num.mat');
load('cluster_center.mat');

% Randomly select some patches to calculate Coef
seed = RandStream('mcg16807','Seed',0);
RandStream.setGlobalStream(seed) 
random_index = rand(num_patch_to_train_coef_matrix,1);
random_index = ceil(random_index * total_patch_num);
random_index = sort(random_index,'ascend');
LR_patch_set = LR_patch_set(:, random_index);
patch_cluster_label = zeros(num_patch_to_train_coef_matrix, 1);
for patch_index = 1 : num_patch_to_train_coef_matrix
    lr_feature = LR_patch_set(:, patch_index);
    diff = (repmat(lr_feature, 1, cluster_num))' - centers;
    l2normsquare = sum(diff .^ 2, 2);
    [~, patch_cluster_label(patch_index)] = min(l2normsquare);

    if mod(patch_index, 10000) == 0
        fprintf('INFO : already label %d patches.\n', patch_index);
    end
end
load('HR_patch_set.mat');
HR_patch_set = HR_patch_set(:, random_index);

save('patch_cluster_label.mat', 'patch_cluster_label');
save('lr_patches_train_coef.mat', 'LR_patch_set');
save('hr_patches_train_coef.mat', 'HR_patch_set');
fprintf('INFO : finish label all patches.\n')