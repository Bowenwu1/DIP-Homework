% test bi-cubic
clear;
origin_img = imread('lenna.bmp');
origin_img = rgb2gray(origin_img);
small_img = bicubic(origin_img, 128, 128);
big_img = bicubic(small_img, 512, 512);
imshow(big_img);
c = SSIM(big_img, origin_img);