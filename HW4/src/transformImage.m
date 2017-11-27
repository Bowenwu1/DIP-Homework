function [ output ] = transformImage(img, transform_func)
%transformImage
%transform an image according to given T(r)
[h, w] = size(img);
output = zeros(h, w);

for i = 1 : h
    for j = 1 : w
        % Make a new image like that s = T(r) pixel by pixel
        output(i, j) = transform_func(img(i, j) + 1);
    end
end
output = uint8(output);
end

