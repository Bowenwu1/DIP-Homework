% Created by Bowen Wu in 20171230
% This script is aim to rebuild HR image from LR image

clear;
clc;
InitParameter

load('coef_matrix.mat');
load('cluster_center.mat');
load('total_patch_num.mat');

sample_image = imread('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/Set14/pepper.bmp');
[origin_h, origin_w, channel_num] = size(sample_image);
lr_h = floor(origin_h / scale_factor);
lr_w = floor(origin_w / scale_factor);
lr_image = zeros(lr_h, lr_w, channel_num);
hr_h = lr_h * scale_factor;
hr_w = lr_w * scale_factor;
for i = 1 : channel_num
    lr_image(:, :, i) = bicubic(sample_image(:, :, i), lr_h, lr_w);
end

hr_image = zeros(hr_h, hr_w, channel_num);

% Transfer lr_image to YUV
lr_image = rgb2ycbcr(uint8(lr_image));
lr_image = double(lr_image);
% apply bicubic in U and V
for i = 2 : channel_num
    hr_image(:, :, i) = bicubic(lr_image(:, :, i), hr_h, hr_w);
end
lr_image = double(lr_image);
hr_image = double(hr_image);
hr_image_restore_count = zeros(hr_h, hr_w);

for r = 1 : lr_h - (lr_patch_size - 1)
    for c = 1 : lr_w - (lr_patch_size - 1)
        r1 = r + lr_patch_size - 1;
        c1 = c + lr_patch_size - 1;
        r_center = r + lr_patch_size_half;
        c_center = c + lr_patch_size_half;
        target_r_center = (r_center - 1) * scale_factor + 1;
        target_c_center = (c_center - 1) * scale_factor + 1;
        target_r = target_r_center - hr_center_size_half;
        target_c = target_c_center - hr_center_size_half;
        target_r1 = target_r_center + hr_center_size_half;
        target_c1 = target_c_center + hr_center_size_half;
        lr_patch = lr_image(r:r1, c:c1, 1);
        lr_feature = lr_patch(lr_patch_effective_area);
        lr_feature_mean = mean(lr_feature);
        lr_feature = lr_feature - lr_feature_mean;
        % Determin cluster index
        diff = repmat(lr_feature, cluster_num, 1) - centers;
        l2normsquare = sum(diff .^ 2, 2);
        [~, clusterIndex] = min(l2normsquare);
        % Generate hr_feature from coef matrix
        hr_feature = [lr_feature 1] * coef_matrix(:, :, clusterIndex);
        hr_patch = reshape(hr_feature + lr_feature_mean, hr_center_size, hr_center_size) + lr_feature_mean;
        % Add to HR image
        hr_image(target_r:target_r1, target_c:target_c1, 1) = hr_image(target_r:target_r1, target_c:target_c1, 1)...
                                                            + hr_patch;
        hr_image_restore_count(target_r:target_r1, target_c:target_c1) = ...
                hr_image_restore_count(target_r:target_r1, target_c:target_c1) + 1;
        
    end
end

% Divide Count
hr_image(:, :, 1) = hr_image(:, :, 1) ./ hr_image_restore_count;
% hr_image = ycbcr2rgb(uint8(hr_image));
% imshow(uint8(hr_image));
                