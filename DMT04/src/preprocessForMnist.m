function [ output, originOutput ] = preprocessForMnist( input )
% output : Mnist Style 2-value image

% first step : make it 2-value
input = rgb2gray(input);
input = min_median_max_filter2d(input, 3, 3, @min, 255);
input = im2bw(input, graythresh(input));
input = ~input;
% second step : rotate the 2-value image, make it stronger

% input = rotateDigit(input);
% third step : make it square
[m, n] = size(input);
outputSize = max([m, n]);
output = zeros(outputSize, outputSize);
if m >= n
    aliasing = round((outputSize - n) / 2);
    output(1:outputSize, 1 + aliasing + 1 : 1 + aliasing + n) = input(:, :);
else
    aliasing = floor((outputSize - m) / 2);
    output(1 + aliasing : 1 + aliasing + m, 1 : outputSize) = input(:, :);
end
% fourth step : downsampling to 28 * 28
output_temp = imresize(output, [20 20]);
output = zeros(28, 28);
output(5:24, 5:24) = output_temp(:, :);
output = im2bw(output, graythresh(output));
output = double(output);
originOutput = output;
output = reshape(output, 1, 28 * 28);
end

