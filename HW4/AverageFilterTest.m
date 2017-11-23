
img_name = '10.png';

average_3 = filter2d(img_name, ones(3,3), false);
average_7 = filter2d(img_name, ones(7, 7), false);
average_11 = filter2d(img_name, ones(11, 11), false);

subplot(2, 2, 1);
imshow(average_3);
title('3X3');

subplot(2, 2, 2);
imshow(average_7);
title('7X7');

subplot(2, 2, 3);
imshow(average_11);
title('11X11');