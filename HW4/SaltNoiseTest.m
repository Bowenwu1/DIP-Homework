% 2.3.3

img_name = 'task_2.png';
% transform the source picture to gray picture
img = rgb2gray(imread(img_name));

% add Salt Noise
noise_img = noise_generator(img, 0, 0, 0, 0.2);

harmonic_img = contra_harmonic_mean_filter(noise_img, 3, 3, -1, 0, false);

contra_harmonic_img_smaller_0 = contra_harmonic_mean_filter(noise_img, 3, 3, -2.5, 0, false);

contra_harmonic_img_bigger_0 = contra_harmonic_mean_filter(noise_img, 3, 3, 1.5, 0, false);


subplot(2, 2, 1);
imshow(noise_img);
title('origin with salt noise');
xlabel(['psnr = ',  num2str(psnr(img, noise_img))]);


subplot(2, 2, 2);
imshow(harmonic_img);
title('harmonic mean fileter 3x3');
xlabel(['psnr = ',  num2str(psnr(img, harmonic_img))]);


subplot(2, 2, 3);
imshow(contra_harmonic_img_smaller_0);
title('contra-harmonic mean fileter 3x3 with Q = -2.5');
xlabel(['psnr = ',  num2str(psnr(img, contra_harmonic_img_smaller_0))]);


subplot(2, 2, 4);
imshow(contra_harmonic_img_bigger_0);
title('contra-harmonic mean fileter 3x3 with Q = 1.5');
xlabel(['psnr = ',  num2str(psnr(img, contra_harmonic_img_bigger_0))]);