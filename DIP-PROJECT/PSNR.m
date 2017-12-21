function [ output ] = PSNR(input_img1, input_img2)
% Calculte value of PSNR of two images with same sizes
% For gray image : directly calculate
% For RGB image : Firstly, translate it into YUV, and calculate the PSNR of
% Y
% By default : gray level : 256, which indicate that [0 255]
MAX1 = 255;
% pass the check of legal of input_img
if (rank(input_img1) == 3)
    % rgb
    % translate to ycbcr
    input_img1 = rgb2ycbcr(input_img1);
    input_img2 = rgb2ycbcr(input_img2);
    % only use Y
    input_img1 = input_img1(:, :, 1);
    input_img2 = input_img2(:, :, 1);
end
[M, N] = size(input_img1);
MSE = sum((input_img1 - input_img2) .^ 2) / (M * N);
output = 20 * log10(MAX1 / (MSE ^ 0.5));

end

