function [ his ] = calculateHistogram(img, L)
%calculateHistogram

his = zeros(1, L);
[h, w] = size(img);
for i = 1 : h
    for j = 1 : w
        value = img(i, j) + 1;
        his(value) = his(value) + 1;
    end
end


end

