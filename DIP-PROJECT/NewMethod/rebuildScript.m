% Created by Bowen Wu in 2017/12/28
% This script is aim to restore HR Image From LR Image
% Input : Set14

clear;
clc;

load('cluster.mat');
load('coef.mat');

% ###########CONST VARIABLE###########
sigma = 1.2;
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
% ####################################

sample_image = imread('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/Set14/baboon.bmp');
[origin_h, origin_w, chanel_num] = size(sample_image);
lr_image = zeros(floor(origin_h / 3), floor(origin_w / 3), chanel_num);
for i = 1 : chanel_num
    lr_image(:, :, i) = bicubic(sample_image(:, :, i), floor(origin_h / 3), floor(origin_w / 3));
end
imshow(lr_image);
hr_image = zeros(origin_h, origin_w, chanel_num);

% Transfer lr_image to YUV
lr_image = rgb2ycbcr(uint8(lr_image));
lr_image = double(lr_image);
% Apple Bicubic in U and V
for i = 2 : chanel_num
    hr_image(:, :, i) = bicubic(lr_image(:, :, i), origin_h, origin_w);
end
hr_image = double(hr_image);
hr_image_restore_count = zeros(origin_h, origin_w);

for r = 1 : floor(origin_h / 3) - (patch_size - 1)
    for c = 1 : floor(origin_w / 3) - (patch_size - 1)
        % (r, c) is left-top cordination
        % (r1, c1) is the right-bottom cordination
        r1 = r + patch_size - 1;
        c1 = c + patch_size - 1;
        r_center = r + floor(patch_size / 2);
        c_center = c + floor(patch_size / 2);
        target_r_center = (r_center - 1) * scale_factor + 1;
        target_c_center = (c_center - 1) * scale_factor + 1;
        lr_patch = lr_image(r:r1, c:c1, 1);
        lr_feature = lr_patch(patch_effective_area);
        lr_patch_mean = mean(lr_feature);
        lr_feature = lr_feature - lr_patch_mean;
        % Determin cluster index
        diff = repmat(lr_feature, cluster_num, 1) - C;
        l2normsquare = sum(diff .^ 2, 2);
        [~, clusterIndex] = min(l2normsquare);
        % Generate hr_feature from coef matrix
        hr_feature = [lr_feature 1] * coef_matrix(:, :, clusterIndex);
        % hr_feature = coef_matrix(:, :, clusterIndex) * [lr_feature 1]';
        hr_patch = reshape(hr_feature, large_patch_effective_size, large_patch_effective_size);
        % Add to HR image
        hr_image(target_r_center - 4 : target_r_center + 4, target_c_center - 4 : target_c_center + 4, 1) = hr_patch + lr_patch_mean...
            + hr_image(target_r_center - 4 : target_r_center + 4, target_c_center - 4 : target_c_center + 4, 1);
        hr_image_restore_count(target_r_center - 4 : target_r_center + 4, target_c_center - 4 : target_c_center + 4) = ...
            hr_image_restore_count(target_r_center - 4 : target_r_center + 4, target_c_center - 4 : target_c_center + 4) + 1;
        
    end
end

% Divide Count
hr_image(:, :, 1) = hr_image(:, :, 1) ./ hr_image_restore_count;
hr_image = ycbcr2rgb(uint8(hr_image));
imshow(uint8(hr_image));