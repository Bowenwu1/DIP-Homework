% 2.3.2

img_name = 'task_2.png';
% transform the source picture to gray picture
img = rgb2gray(imread(img_name));

% add Gaussian Noise
noise_img = noise_generator(img, 0, 40, 0, 0);

% Arithmetic Mean Filter
arithmetic_img = filter2d(noise_img, ones(3,3), false);

% Geometric Mean Filter
geometric_img = geometric_mean_filter2d(noise_img, 3, 3, 0, false);

% Median Filter
median_img = min_median_max_filter2d(noise_img, 3, 3, @median);

subplot(2, 2, 1);
imshow(noise_img);
title('origin with Gaussian Noise');
xlabel(['psnr = ',  num2str(psnr(img, noise_img))]);

subplot(2, 2, 2);
imshow(arithmetic_img);
title('after arithmetic 3X3');
xlabel(['psnr = ',  num2str(psnr(img, arithmetic_img))]);

subplot(2, 2, 3);
imshow(geometric_img);
title('after geometric 3X3');
xlabel(['psnr = ',  num2str(psnr(img, geometric_img))]);

subplot(2, 2, 4);
imshow(median_img);
title('after median 3X3');
xlabel(['psnr = ',  num2str(psnr(img, median_img))]);