function [ output_img ] = contra_harmonic_mean_filter( img, filterSize_h, filterSize_w, Q, paddingElement, whetherDraw)
% filterSize : size of filter
% Q : param of filter
if nargin == 3
    paddingElement = 0;
    whetherDraw = false;
elseif nargin == 4
    whetherDraw = false;
end

img = double(img);
[h, w] = size(img);
output_img = zeros(h, w);
halfFilterLength_h = floor(filterSize_h / 2);
halfFilterLength_w = floor(filterSize_w / 2);

for i = 1 : h
    for j = 1 : w
        % center is (i, j)
        numerator   = 0;
        denominator = 0;
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
                 numerator  = numerator + element ^ (Q + 1);
                 denominator = denominator + element ^ Q;
            end
        end
        output_img(i, j) = numerator / denominator;
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

                 