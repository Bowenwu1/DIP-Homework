% Created by Bowen Wu in 20171229
% This script is aim to generate all patches in train dir
% This script run very slow
clc;
clear;
InitParameter
fprintf('INFO : start generate patches version 2.0 \n');

images = dir(train_img_dir);
image_num = length(images);
total_patch_num = 0;
LR_patch_set = zeros(lr_patch_size * lr_patch_size - 4, approximation_patches);
HR_patch_set = zeros(hr_center_size * hr_center_size, approximation_patches);
kernel = gaussianFilterGenerator(gaussian_kernel_size, sigma);
for image_index = 1 : image_num
    fprintf('INFO : Processing No.%d image\n', image_index);
    HRImage = imread(images(image_num).name);
    [HR_w, HR_h, dimension] = size(HRImage);
    if (3 == dimension)
        HRImage = rgb2gray(HRImage);
    end
    HRImage_gaussian = conv2(double(HRImage), kernel, 'same');
    % Cut hr patches, and generate lr patches
    for hr_r = 1 : hr_patch_size : HR_w - hr_patch_size + 1
        for hr_c = 1 : hr_patch_size : HR_h - hr_patch_size + 1
            % Left-Top (hr_r, hr_c)
            % Right-Bottom (hr_r1, hr_c1)
            hr_r1 = hr_r + hr_patch_size - 1;
            hr_c1 = hr_c + hr_patch_size - 1;
            % Center area
            % Center point : (hr_center_rr, hr_center_cc)
            hr_center_rr = hr_r + hr_patch_size_half;
            hr_center_cc = hr_c + hr_patch_size_half;
            % Left-Top of center area : (hr_center_r, hr_center_c)
            hr_center_r = hr_center_rr - hr_center_size_half;
            hr_center_c = hr_center_cc - hr_center_size_half;
            % Rigth-Bottom of center area : (hr_center_r1, hr_center_c1)
            hr_center_r1 = hr_center_rr + hr_center_size_half;
            hr_center_c1 = hr_center_cc + hr_center_size_half;
            
            hr_patch_gaussian = HRImage_gaussian(hr_r:hr_r1, hr_c:hr_c1);
            lr_patch = imresize(hr_patch_gaussian, [lr_patch_size lr_patch_size], 'nearest');
            lr_feature = double(lr_patch(lr_patch_effective_area));
            lr_feature_mean = mean(lr_feature);
            hr_patch_center_area = HRImage(hr_center_r:hr_center_r1, hr_center_c:hr_center_c1);
            hr_feature = double(hr_patch_center_area(:));
            
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