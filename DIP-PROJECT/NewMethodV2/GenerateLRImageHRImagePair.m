function [LRImage, HRImage] = GenerateLRImageHRImagePair(HRImage, scaleFactor, gaussian_kernel_width, sigma)
%GenerateLRImage - Description
%
% Syntax: [LRImage] = GenerateLRImage(HRImage)
% Input : HRImage RGB Image Type : uint8
% I will make the mod(width, 3) == 0 and mod(length, 3) == 0 For HRImage
% Return : uint8 image

% Use gray level image to train the cluster 
% HRImage = rgb2gray(HRImage);
HRImage = rgb2ycbcr(HRImage);
HRImage = HRImage(:, : ,1);
[hr_w, hr_h] = size(HRImage);
% Make it can be perfectly divide by scaleFactor
HRImage = HRImage(1:hr_w - mod(hr_w, scaleFactor), 1:hr_h - mod(hr_h, scaleFactor));
kernel = gaussianFilterGenerator(gaussian_kernel_width, sigma);
% Be careful about the type, I'm not sure for that
% ##################
HRImage_after_gaussian = conv2(double(HRImage), double(kernel), 'same');
[hr_w, hr_h] = size(HRImage);
LRImage = bicubic(uint8(HRImage_after_gaussian), hr_w / scaleFactor, hr_h / scaleFactor);

% change on 2017/12/31
HRImage = HRImage_after_gaussian;
end