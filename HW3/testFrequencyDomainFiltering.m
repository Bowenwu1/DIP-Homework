filter_average3  = ones(3);
filter_average7  = ones(7);
filter_average11 = ones(11);

img = imread('88.png');

output_average3  = filter2d_freq(img, filter_average3);
output_average7  = filter2d_freq(img, filter_average7);
output_average11 = filter2d_freq(img, filter_average11);

lap_filter = [0 -1 0;-1 4 -1;0 -1 0];
%lap_filter = [0 1 0;1 -4 1;0 1 0];

output_sharp = filter2d_freq(img, lap_filter);

subplot(2, 2, 1);
imshow(output_average3);
title('3x3');
subplot(2, 2, 2);
imshow(output_average7);
title('7x7');
subplot(2, 2, 3);
imshow(output_average11);
title('11x11');
subplot(2, 2, 4);
imshow(output_sharp);
title('sharp');