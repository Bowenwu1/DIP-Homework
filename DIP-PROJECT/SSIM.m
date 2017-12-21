function [ output ] = SSIM(input_img1, input_img2)
% suppose input_img are both in 2-D
% CONST VARIABLE
K1 = 0.01;
K2 = 0.03;
L = 255;
C1 = (K1 * L) ^ 2;
C2 = (K2 * L) ^ 2;
WINDOW_SIZE = 11;

window = gaussianFilterGenerator(WINDOW_SIZE, 1.5);
window = window / sum(sum(window));

% Handle type
input_img1 = double(input_img1);
input_img2 = double(input_img2);

mu1 = filter2d_nopadding(window, input_img1);
mu2 = filter2d_nopadding(window, input_img2);
mu1_sq = mu1 .* mu1;
mu2_sq = mu2 .* mu2;
% According to some proerties of Sigma
sigma1_sq = filter2d_nopadding(window, input_img1 .* input_img1) - mu1 .* mu1;
sigma2_sq = filter2d_nopadding(window, input_img2 .* input_img2) - mu2 .* mu2;

% Refer to another form of Covariance. https://en.wikipedia.org/wiki/Covariance
sigma12 = filter2d_nopadding(window, input_img1 .* input_img2) - mu1 .* mu2;

numerator = (2 * mu1 .* mu2 + C1) .* (2 * sigma12 + C2);
denominator = (mu1_sq + mu2_sq + C1) .* (sigma1_sq + sigma2_sq + C2);
ssim = numerator ./ denominator;
output = mean2(ssim);
end

