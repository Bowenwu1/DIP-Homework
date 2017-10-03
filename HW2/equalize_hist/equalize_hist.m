function [ output_img ] = equalize_hist( input_img_name )
%equalize_hist
%   Detailed explanation goes here
img = imread(input_img_name);

L = 256;

origin_his = calculateHistogram(img, L);

transform_func = getHistogramEqualFunction(origin_his, L);

output_img = transformImage(img, transform_func);

output_his = calculateHistogram(output_img, L);

% plot
x = 0 : 1 : 255;

subplot(2, 2, 1);
imshow(img);
title('Origin Image');

subplot(2, 2, 2);
bar(x, origin_his);
title('Origin Histogram');

subplot(2, 2, 3);
imshow(output_img);
title('After Image');

subplot(2,  2, 4);
bar(x, output_his);
title('After Histogram');
end