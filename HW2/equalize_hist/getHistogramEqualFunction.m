function [ transform_func ] = getHistogramEqualFunction( his, L)
% getHistogramEqualFunction
% s = T(r) = (L - 1) * sum(from i = 1 : r prob(i))

% Calculate Number of pixels
total_pixel = 0;
for i = 1 : L
    total_pixel = total_pixel + his(i);
end

transform_func = zeros(1, L);
for i = 1 : L
    prob = 0;
    % Calculate sum of frequency
    for j = 1 : i
        prob = prob + his(j);
    end
    % Transform frequency to probability
    prob = prob / total_pixel;
    transform_func(i) = prob * (L - 1);

transform_func = uint8(transform_func);
end

