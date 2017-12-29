% Created by Bowen Wu in 20171229
% This script is aim to train cluster center
% according to the subset of patches generated
% by the previous step

clear;
clc;
InitParameter
load('random_LR_patch_set.mat');

options = statset('UseParallel', 1);
[idx, centers, sumd, D] = kmeans(random_LR_patch_set', cluster_num, 'Display', 'Iter', 'Options', options, 'MaxIter', 1000);
save('cluster_center.mat', 'centers');