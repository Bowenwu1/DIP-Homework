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

lr_patches = [lr_patches; ones(patch_size * patch_size - 4)];
