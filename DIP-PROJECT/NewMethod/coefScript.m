% Created by Bowen Wu in 2017/12/27
% This Script is aim to get the coef of each cluter
% Result of Cluster is in 'cluster.mat'
clear;
cluster_num = 512;
patch_size = 7;
scale_factor = 3;
lr_center_size = 3;
hr_center_size = lr_center_size * scale_factor;
hr_center_size_half = floor(hr_center_size / 2);
hr_center = floor(patch_size * scale_factor / 2) + 1;
patch_effective_area = [2:6 8:42 44:48];
large_patch_size = 21;
large_patch_effective_size = 9;

load('cluster.mat');
% Num of total patches
l = length(hr_patches);
% Dimension of LR patch vector
m = size(lr_patches);
m = m(2);
% Dimension of HR patch vector
n = size(hr_patches);
n = n(2);
% Some Weird Tech
lr_patches = [lr_patches ones(l, 1)];

% Least-Square
coef_matrix = zeros(patch_size * patch_size - 4 + 1, large_patch_effective_size * large_patch_effective_size, cluster_num);
% coef_matrix = zeros(large_patch_effective_size * large_patch_effective_size, patch_size * patch_size - 4 + 1, cluster_num);
for i = 1 : cluster_num
    coef_matrix(:, :, i) = lr_patches(idx == i, :) \ hr_patches(idx == i, :);
%     coef_matrix(:, :, i) = hr_patches(idx == i, :) \ lr_patches(idx == i, :);
    r = rank(lr_patches(idx == i, :));
    if r < 46
        fprintf('%d cluster rank less than 46, rank : %d', i, r);
    end
end

save('coef.mat', 'coef_matrix');