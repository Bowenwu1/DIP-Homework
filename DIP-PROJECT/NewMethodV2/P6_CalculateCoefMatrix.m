% Created by Bowen Wu in 20171230
% This script is aim to get coef matrix for each cluster
% according to the label result from previous step

clear;

InitParameter
load('total_patch_num.mat');

% coef_matrix = zeros(hr_center_size * hr_center_size, ...
%                     lr_patch_size * lr_patch_size - 3, cluster_num);
coef_matrix = zeros(lr_patch_size * lr_patch_size - 4, ...
                     hr_center_size * hr_center_size, cluster_num);
whetherRankDeficiency = zeros(cluster_num, 1); % 1 for Deficiency, 0 otherwise

% special tech
% LR_patch_set = [LR_patch_set; ones(1, total_patch_num)];

for cluster_index = 1 : cluster_num
    fprintf('INFO : calculating %d cluster coef\n', cluster_index);
    filename = sprintf('%d_cluster_patch_set', cluster_index);
    load(filename);
    % calculate rank
    % special tech
    % l = length(LR_subset);
    if isempty(LR_subset)
        % for j = 1 : hr_center_size * hr_center_size
        %     coef_matrix(:, j, cluster_index) = zeros(lr_patch_size * lr_patch_size - 3, 1);
        % end
        continue;
    end
    [~, l] = size(LR_subset);
%     LR_subset = [LR_subset; ones(1, l)];
    %  r = rank(LR_subset');
    %  whetherRankDeficiency(cluster_index) = r;
%     if r < lr_patch_size * lr_patch_size - 3
%         fprintf('INFO : cluster No.%d have rank %d\n', cluster_index, r);
%         whetherRankDeficiency(cluster_index) = 1;
%     end
% coef_matrix(:, :, cluster_index) = LR_subset' \ HR_subset';
    for j = 1 : hr_center_size * hr_center_size
        B = HR_subset(j, :);
        coef_matrix(:, j, cluster_index) = LR_subset' \ B';
    end
end

save('coef_matrix.mat', 'coef_matrix', '-v7.3');