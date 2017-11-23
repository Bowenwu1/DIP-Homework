% 2.3.4
img_name = 'task_2.png';
% transform the source picture to gray picture
img = rgb2gray(imread(img_name));

% add Salt and Pepper Noise
noise_img = noise_generator(img, 0, 0, 0.2, 0.2);

% Arithmetic Mean Filter
arithmetic_img = filter2d(noise_img, ones(5,5), false);

% Geometric Mean Filter
geometric_img = geometric_mean_filter2d(noise_img, 3, 3, 0, false);

% Max Filter
max_img = min_median_max_filter2d(noise_img, 3, 3, @max);

% Min Filter
min_img = min_median_max_filter2d(noise_img, 3, 3, @min);

% Median Filter
median_img = min_median_max_filter2d(noise_img, 5, 5, @median);

subplot(3, 2, 1);
imshow(noise_img);
title('origin img with salt and pepper noise');
xlabel(['psnr = ',  num2str(psnr(img, noise_img))]);


subplot(3, 2, 2);
imshow(arithmetic_img);
title('arithmetic filter 5x5');
xlabel(['psnr = ',  num2str(psnr(img, arithmetic_img))]);

subplot(3, 2, 3);
imshow(geometric_img);
title('geometric fitler 3x3');
xlabel(['psnr = ',  num2str(psnr(img, geometric_img))]);

subplot(3, 2, 4);
imshow(max_img);
title('max filter 3x3');
xlabel(['psnr = ',  num2str(psnr(img, max_img))]);

subplot(3, 2, 5);
imshow(min_img);
title('min filter 3x3');
xlabel(['psnr = ',  num2str(psnr(img, min_img))]);

subplot(3, 2, 6);
imshow(median_img);
title('median filter 5x5');
xlabel(['psnr = ',  num2str(psnr(img, median_img))]);