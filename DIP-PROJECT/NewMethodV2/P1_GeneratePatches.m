% Created by Bowen Wu in 20171229
% This script is aim to generate all patches in train dir

clc;
clear;
InitParameter
fprintf('INFO : start generate patches');

images = dir(train_img_dir);
image_num = length(images);
total_patch_num = 0;
LR_patch_set = zeros(lr_patch_size * lr_patch_size - 4, approximation_patches);
HR_patch_set = zeros(hr_center_size * hr_center_size, approximation_patches);

for image_index = 1 : image_num
    fprintf('INFO : Processing No.%d image\n', image_index);
    if image_index > 300
        break;
    end
    HRImage = imread(images(image_index).name);
    [LRImage, HRImage] = GenerateLRImageHRImagePair(HRImage, scale_factor, gaussian_kernel_size, sigma);
    [HR_w, HR_h] = size(HRImage);
    [LR_w, LR_h] = size(LRImage);
    LR_patch_num_w = LR_w / lr_patch_size;
    LR_patch_num_h = LR_h / lr_patch_size;
    for lr_r = 1 : LR_w - lr_patch_size + 1
        for lr_c = 1 : LR_h - lr_patch_size + 1
            % Cordination for LR
            % Left-Top (lr_r, lr_c)
            % lr_r;
            % lr_c;
            % Right-Bottom (lr_r1, lr_c1)
            lr_r1 = lr_r + lr_patch_size - 1;
            lr_c1 = lr_c + lr_patch_size - 1;

            % Calculate the Cordination of HR patch center area
            % ########### CENTER AREA ##########
            lr_center_r = lr_r + lr_patch_size_half;
            lr_center_c = lr_c + lr_patch_size_half;
            hr_center_r = (lr_center_r - 1 + 0.5) * scale_factor + 1 - 0.5;
            hr_center_c = (lr_center_c - 1 + 0.5) * scale_factor + 1 - 0.5;
            hr_r = hr_center_r - hr_center_size_half;
            hr_c = hr_center_c - hr_center_size_half;
            hr_r1 = hr_center_r + hr_center_size_half;
            hr_c1 = hr_center_c + hr_center_size_half;

            %
            lr_patch = LRImage(lr_r:lr_r1, lr_c:lr_c1);
            lr_feature = double(lr_patch(lr_patch_effective_area));
            hr_patch = HRImage(hr_r:hr_r1, hr_c:hr_c1);
            hr_feature = double(hr_patch(:));
            lr_feature_mean = mean(lr_feature);

            total_patch_num = total_patch_num + 1;
            LR_patch_set(:, total_patch_num) = lr_feature - lr_feature_mean;
            HR_patch_set(:, total_patch_num) = hr_feature - lr_feature_mean;
        end
    end
end

% To avoid total patch_num less than the size of patch_set
LR_patch_set = LR_patch_set(:, 1:total_patch_num);
HR_patch_set = HR_patch_set(:, 1:total_patch_num);
save('LR_patch_set.mat', 'LR_patch_set', '-v7.3');
save('HR_patch_set.mat', 'HR_patch_set', '-v7.3');
save('total_patch_num.mat', 'total_patch_num', '-v7.3');
fprintf('INFO : total generate %d patches\n', total_patch_num);