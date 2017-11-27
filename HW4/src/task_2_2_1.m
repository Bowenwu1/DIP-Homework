% 2.2.1
img_name = 'task_1.png';

average_3 = filter2d(imread(img_name), ones(3,3), false);
average_9 = filter2d(imread(img_name), ones(9, 9), false);

subplot(2, 1, 1);
imshow(average_3);
title('arithmetic mean filter 3x3');

subplot(2, 1, 2);
imshow(average_9);
title('arithmetic mean filter 9x9');