function [ output_img ] = filter2d(input_img_name, filter, whetherDraw)
% FILTER2D
% filter : a matrix
% input_img_name : path of image file
% whetherDraw : whether to draw the origin and after image

if nargin == 2
    whetherDraw = true;
end

img = imread(input_img_name);
img = double(img);
[h, w] = size(img);
output_img = zeros(h, w);
[f_h, f_w] = size(filter);
halfFilterLength = floor(f_h / 2);
filter_center = [halfFilterLength + 1, halfFilterLength + 1];
% calculate total weight, in order to make total weight = 1

% filter
for i = 1 : h
    for j = 1 : w
        % center is (i, j)
        sum = 0;
        total_weight = 0;
        for m = -1 * halfFilterLength : halfFilterLength
            for n = -1 * halfFilterLength : halfFilterLength
                if ((i + m) < 1 || (i + m) > h)
                    % over border 1
                    sum = sum + 0;
                elseif ((j + n) < 1 || (j + n) > w)
                    % over border 2
                    sum = sum + 0;
                else
                    total_weight = total_weight + filter(filter_center(1) + m, filter_center(2) + n);
                    sum = sum + img(i + m, j + n) * filter(filter_center(1) + m, filter_center(2) + n);
                end
            end
        end
        sum = sum / total_weight;
        output_img(i, j) = sum;
    end
end

output_img = uint8(output_img);
img = uint8(img);

if true == whetherDraw
    subplot(2, 1, 1);
    imshow(img);
    title('origin');

    subplot(2, 1, 2);
    imshow(output_img);
    title('after filter');
end

end

