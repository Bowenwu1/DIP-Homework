% test SSIM
% Just a basic Test for SSIM
clear
img = imread('lenna.bmp');
img = rgb2gray(img);
G = fspecial('gaussian', [5 5], 1);
Ig = imfilter(img,G,'same');
b = SSIM(img, Ig);
c = ssim(img, Ig);
% d = ssim_index(img, Ig);