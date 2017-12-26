% Created by Bowen Wu in 2017/12/26
% This Script is aim to Train the Cluster Model for Super Resolution
clear;
% ###### Change These Variables to fit your own computer ########
train_img_dir = ('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/Train/*.jpg');
sigma = 0.4;
cluster_num = 512;
patch_size = 7;
patch_effective_area = [2:6 8:42 44:48];
scale_factor = 3;
large_patch_size = 21;
large_patch_effective_size = 9;
% Making the kernel size odd will be easier to implement
gaussian_kernel_size = ceil(sigma*3)*2+1;
gaussian_kernel = gaussianFilterGenerator(gaussian_kernel_size, sigma);

images = dir(train_img_dir);
lr_patches = [];
hr_patches = [];
total_patches_num = 0;
fprintf('INFO : start gain trainning data');
for image_index = 1 : length(images)
    % Read the Image
    img = imread(images(image_index).name);
    % Convert to YUV and only preseve Y chnnel
    img = rgb2ycbcr(img);
    img = img(:, :, 1);
    % Gaussian Conv
    img = conv2(img, gaussian_kernel);
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
            large_patch = img(r_min:r_max, c_min:c_max);
            small_patch = bicubic(large_patch, patch_size, patch_size);
            
end