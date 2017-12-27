% Created by Bowen Wu in 2017/12/26
% This Script is aim to Train the Cluster Model for Super Resolution
clear;
tic;
% ###### Change These Variables to fit your own computer ########
train_img_dir = ('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/AllFive/*.jpg');
sigma = 0.4;
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
% approximation_patch_num_per_image = 4000;
max_patches = 100000;
% Making the kernel size odd will be easier to implement
gaussian_kernel_size = ceil(sigma*3)*2+1;
gaussian_kernel = gaussianFilterGenerator(gaussian_kernel_size, sigma);

images = dir(train_img_dir);
% lr_patches = zeros(approximation_patch_num_per_image * length(images), patch_size * patch_size - 4);
% hr_patches = zeros(approximation_patch_num_per_image * length(images),hr_center_size * hr_center_size);
lr_patches = zeros(max_patches, patch_size * patch_size - 4);
hr_patches = zeros(max_patches, hr_center_size * hr_center_size);
% lr_patches = zeros(patch_size * patch_size - 4,approximation_patch_num_per_image * length(images));
% hr_patches = zeros(hr_center_size * hr_center_size, approximation_patch_num_per_image * length(images));
total_patches_num = 0;
fprintf('INFO : start gain trainning data\n');
for image_index = 1 : length(images)
    % Debug INFO
    fprintf('INFO: Processing No.%d image\n', image_index);
    % Read the Image
    img = imread(images(image_index).name);
    % Convert to YUV and only preseve Y chnnel
    img = rgb2ycbcr(img);
    img = img(:, :, 1);
    % Gaussian Conv
    img = conv2(double(img), double(gaussian_kernel));
    % Slicing
    [hr_w, hr_h] = size(img);
    patch_num_w = floor(hr_w / large_patch_size);
    patch_num_h = floor(hr_h / large_patch_size);
    for index_w = 1 : patch_num_w
        for index_h = 1 : patch_num_h
            r_min = (index_w - 1) * large_patch_size + 1; % Left-Top Coordinate
            c_min = (index_h - 1) * large_patch_size + 1;
            r_max = r_min + large_patch_size - 1;         % Right-Down Coordinate
            c_max = c_min + large_patch_size - 1;
            % Down Sampling
            hr_patch = img(r_min:r_max, c_min:c_max);
            lr_patch = bicubic(hr_patch, patch_size, patch_size);
            total_patches_num = total_patches_num + 1;
            lr_patches(total_patches_num, :) = lr_patch(patch_effective_area);
            % maybe affect efficency
            hr_patch_center_area = hr_patch(hr_center - hr_center_size_half:hr_center + hr_center_size_half,...
                                            hr_center - hr_center_size_half:hr_center + hr_center_size_half);
            hr_patches(total_patches_num, :) = hr_patch_center_area(:);
        end
    end
    if mod(total_patches_num, 1000) == 0
        fprintf('INFO:Already Generate %d patch-pairs\n', total_patches_num);
    end
    if total_patches_num > max_patches
        break;
    end
end
fprintf('INFO: end gain trainning data\n');

% Cluster
options = statset('UseParallel', 1);
[idx, C, sumd, D] = kmeans(lr_patches, cluster_num, 'Display', 'Iter', 'Options', options);
save('cluster.mat', 'lr_patches', 'hr_patches', 'idx', 'C', 'sumd', 'D');
toc;