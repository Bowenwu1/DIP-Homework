function [ output_img ] = equalize_hist( img , whetherDraw)
%equalize_hist
%   Detailed explanation goes here
if nargin == 1
    whetherDraw = false;
end
L = 256;

origin_his = calculateHistogram(img, L);

transform_func = getHistogramEqualFunction(origin_his, L);

output_img = transformImage(img, transform_func);

output_his = calculateHistogram(output_img, L);

std_img = histeq(img);
std_his = calculateHistogram(std_img, L);

if whetherDraw
    % plot
    x = 0 : 1 : 255;

    subplot(3, 2, 1);
    imshow(img);
    title('Origin Image');

    subplot(3, 2, 2);
    bar(x, origin_his);
    title('Origin Histogram');

    subplot(3, 2, 3);
    imshow(output_img);
    title('After Image');

    subplot(3, 2, 4);
    bar(x, output_his);
    title('After Histogram');

    subplot(3, 2, 5);
    imshow(std_img);
    title('standard transform image');

    subplot(3, 2, 6);
    bar(x, std_his);
    title('standard transform histogram');
end
end