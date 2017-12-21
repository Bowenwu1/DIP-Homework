function [ output_img ] = filter2d_nopadding(filter, img)
% FILTER2D
% filter : a matrix
% img : input_img

img = double(img);
[h, w] = size(img);
% output_img = zeros(h, w);
[f_h, f_w] = size(filter);
halfFilterLength_h = floor(f_h / 2);
halfFilterLength_w = floor(f_w / 2);
filter_center = [halfFilterLength_h + 1, halfFilterLength_w + 1];
output_img = zeros(h - 2 * halfFilterLength_h, w - 2 * halfFilterLength_w);
% filter
for i = 1 : h - halfFilterLength_h * 2
    for j = 1 : w - halfFilterLength_w * 2
        % center is (i + halfFilterLength_h, j + halfFilterLength_w);
        sum = 0;
        total_weight = 0;
        i_temp = i + halfFilterLength_h;
        j_temp = j + halfFilterLength_w;
        for m = -1 * halfFilterLength_h : halfFilterLength_h
            for n = -1 * halfFilterLength_w : halfFilterLength_w
                total_weight = total_weight + filter(filter_center(1) + m, filter_center(2) + n);
                sum = sum + img(i_temp + m, j_temp + n) * filter(filter_center(1) + m, filter_center(2) + n);
            end
        end
        sum = sum / total_weight;
        output_img(i, j) = sum;
    end
end

end

