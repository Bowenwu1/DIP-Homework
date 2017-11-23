function [ output ] = transformRGBtoHSI( img )
% transform an RGB colour image to HSI


[m, n, p] = size(img);
img = double(img);
output = zeros(m, n, p);

for i = 1 : m
    for j = 1 : n
        R = img(i, j, 1);
        G = img(i, j, 2);
        B = img(i, j, 3);
        numerator = 0.5 * (R - G + R - B);
        denominator = ((R - G) ^ 2 +(R - G) * (G - B))^0.5 + eps;
        angle = acos(numerator / denominator);
        if B <= G
            output(i, j, 1) = angle;
        else
            output(i, j, 1) = 2*pi - angle;
        end
        output(i, j, 2) = 1 - 3 * min(img(i, j, :)) / sum(img(i, j, :));
        output(i, j, 3) = mean(img(i, j, :));
    end
end

end

