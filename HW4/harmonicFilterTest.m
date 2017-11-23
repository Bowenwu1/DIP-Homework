% 2.2.2
img_name = 'task_1.png';
harmonic_mean_3 = contra_harmonic_mean_filter(imread(img_name), 3, 3, -1, 0, false);
harmonic_mean_9 = contra_harmonic_mean_filter(imread(img_name), 9, 9, -1, 0, false);

% 2.2.3
contra_harmonic_mean_3 = contra_harmonic_mean_filter(imread(img_name), 3, 3, -1.5, 0, false);
contra_harmonic_mean_9 = contra_harmonic_mean_filter(imread(img_name), 9, 9, -1.5, 0, false);

subplot(2, 2, 1);
imshow(harmonic_mean_3);
title('harmonic mean fileter 3x3');


subplot(2, 2, 2);
imshow(harmonic_mean_9);
title('harmonic mean fileter 9x9');


subplot(2, 2, 3);
imshow(contra_harmonic_mean_3);
title('contra-harmonic mean fileter 3x3');


subplot(2, 2, 4);
imshow(contra_harmonic_mean_9);
title('contra-harmonic mean fileter 9x9');