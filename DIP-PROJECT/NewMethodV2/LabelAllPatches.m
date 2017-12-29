% Created by Bowen Wu in 20171229
% This script is aim to find nearest cluster center for each patch
% output : an array contain the cluster num for each patches

clear;
clc;
fprintf('INFO : start label all patches.\n');
InitParameter
load('LR_patch_set.mat');
load('total_patch_num.mat');
load('cluster_center.mat');

patch_cluster_label = zeros(total_patch_num, 1);
for patch_index = 1 : total_patch_num
    lr_feature = LR_patch_set(:, patch_index);
    diff = (repmat(lr_feature, 1, cluster_num))' - centers;
    l2normsquare = sum(diff .^ 2, 2);
    [~, patch_cluster_label(patch_index)] = min(l2normsquare);

    if mod(patch_index, 10000) == 0
        fprintf('INFO : already label %d patches.\n', patch_index);
    end
end

save('patch_cluster_label.mat', 'patch_cluster_label');
fprintf('INFO : finish label all patches.\n')