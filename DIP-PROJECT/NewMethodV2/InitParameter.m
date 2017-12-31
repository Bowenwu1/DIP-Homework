% Created by Bowen Wu in 20171229
% This script is aim to provide parameter for the following program


train_img_dir = ('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/Train/*.jpg');
sigma = 1.2;
cluster_num = 1024;
scale_factor = 3;

lr_patch_size = 7;
lr_center_size = 3;
lr_patch_size_half = floor(lr_patch_size / 2);
lr_patch_effective_area = [2:6 8:42 44:48];

hr_center_size = lr_center_size * scale_factor;
hr_center_size_half = floor(hr_center_size / 2);
hr_center = floor(lr_patch_size * scale_factor / 2) + 1;
hr_patch_size = lr_patch_size * 3;
hr_patch_size_half = floor(hr_patch_size / 2);
hr_patch_effective_size = lr_center_size * 3;

num_patch_to_train_cluster_center = 300000;
num_patch_to_train_coef_matrix = 1500000;

gaussian_kernel_size = ceil(sigma*3)*2+1;
gaussian_kernel = gaussianFilterGenerator(gaussian_kernel_size, sigma);

% To improve efficency
approximation_patches = 11000000;