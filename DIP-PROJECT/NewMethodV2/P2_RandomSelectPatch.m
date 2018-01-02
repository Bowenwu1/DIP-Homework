% Created by Bowen Wu in 20171229
% This script is aim to randomly select about 50w patches for kmeans
% Actually, doing this step is purely to save memory.
% If I have 128GB RAM, I will not writting this script
clear;

InitParameter
fprintf('INFO : start randomly select patch for kmeans\n');
load('total_patch_num.mat');
% load('LR_patch_set.mat');
% load('HR_patch_set.mat');
seed = RandStream('mcg16807','Seed',0);
RandStream.setGlobalStream(seed) 
random_index = rand(num_patch_to_train_cluster_center,1);
random_index = ceil(random_index * total_patch_num);
random_index = sort(random_index,'ascend');
% random_index = randi([1 total_patch_num], 1, num_patch_to_train_cluster_center);
% random_index = sort(random_index,'ascend');
load('LR_patch_set.mat');
random_LR_patch_set = LR_patch_set(:, random_index);
save('random_LR_patch_set.mat', 'random_LR_patch_set', '-v7.3');
clear random_LR_patch_set;
clear LR_patch_set;

load('HR_patch_set.mat');
random_HR_patch_set = HR_patch_set(:, random_index);
save('random_HR_patch_set.mat', 'random_HR_patch_set', '-v7.3');

