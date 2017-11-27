function [ transform_func ] = getHistogramEqualFunction( his, L)
% getHistogramEqualFunction
% s = T(r) = (L - 1) * sum(from i = 1 : r prob(i))

% Calculate Number of pixels
total_pixel = 0;
for i = 1 : L
    total_pixel = total_pixel + his(i);
end
%Get cdf min(f(x))
min = 0;
for i = 1 : L
    if (his(i) > 0)
        min = his(i);
        break;
    end
end
%total_pixel = total_pixel - min;
transform_func = zeros(1, L);
prob = 0;

for i = 1 : L
    prob = prob + his(i);
    % Calculate sum of frequency
 %   prob = prob - min;
    % Transform frequency to probability
    transform_func(i) = (prob / total_pixel) * (L - 1);

transform_func = uint8(transform_func);
end

