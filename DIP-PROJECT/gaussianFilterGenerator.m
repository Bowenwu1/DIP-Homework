function [ output ] = gaussianFilterGenerator(size, sigma)

half_length = floor(size / 2);
center = half_length + 1;
output = zeros(size, size);

for i = 1 : size
    for j = 1 : size
        u_sq = (i - center) ^ 2;
        v_sq = (j - center) ^ 2;
        output(i, j) = exp(-1 * (u_sq + v_sq) / (2 * sigma * sigma)) / (2 * pi * sigma * sigma);
    end
end
output = output / sum(sum(output));
end

