function [ output_img ] = min_median_max_filter2d(img, filterSize_h, filterSize_w, handle, paddingElement, whetherDraw)

if nargin == 4
    paddingElement = 0;
    whetherDraw = false;
elseif nargin == 5
    whetherDraw = false;
end

img = double(img);
[h, w] = size(img);
output_img = zeros(h, w);
halfFilterLength_h = floor(filterSize_h / 2);
halfFilterLength_w = floor(filterSize_w / 2);
temp_matrix = zeros(filterSize_h, filterSize_w);

for i = 1 : h
    for j = 1 : w
        for m = -1 * halfFilterLength_h : halfFilterLength_h
            for n = -1 * halfFilterLength_w : halfFilterLength_w
                 if ((i + m) < 1 || (i + m) > h)
                    % over border 1
                    % padding
                    element = paddingElement;
                 elseif ((j + n) < 1 || (j + n) > w)
                    element = paddingElement;
                 else
                     element = img(i + m, j + n);
                 end
                 temp_matrix(m + halfFilterLength_h + 1, n + halfFilterLength_w + 1) = element;
            end
        end
        output_img(i, j) = handle(temp_matrix(:));
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


