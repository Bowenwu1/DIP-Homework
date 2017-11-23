% 2.2.3

img_name = 'task_1.png';
contra_harmonic_mean_3 = contra_harmonic_mean_filter(imread(img_name), 3, 3, -1.5, 0, false);
contra_harmonic_mean_9 = contra_harmonic_mean_filter(imread(img_name), 9, 9, -1.5, 0, false);


subplot(2, 1, 1);
imshow(contra_harmonic_mean_3);
title('contra-harmonic mean fileter 3x3');


subplot(2, 1, 2);
imshow(contra_harmonic_mean_9);
title('contra-harmonic mean fileter 9x9');