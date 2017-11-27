% 2.4.2
img = imread('10.png');
[m, n, p] = size(img);
L = 256;

origin_his = zeros(p, L);
for i = 1 : p
    origin_his(i, :) = calculateHistogram(img(:, :, i), L);
end

origin_his = mean(origin_his, 1);

transform_func = getHistogramEqualFunction(origin_his, L);

output_img = zeros(m, n, p);
for i = 1 : p
    output_img(:, :, i) = transformImage(img(:, :, i), transform_func);
end

output_img = uint8(output_img);

subplot(2, 1, 1);
imshow(img);
title('before histogram equalize');

subplot(2, 1, 2);
imshow(output_img);
title('after histogram equalize(2.4.2)');