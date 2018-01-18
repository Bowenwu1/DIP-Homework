function [ output, originOutput ] = preprocessForMnist( input )
% output : Mnist Style 2-value image

% first step : make it 2-value
input = rgb2gray(input);
input = im2bw(input, graythresh(input));
% second step : make it square
[m, n] = size(input);
outputSize = max([m, n]);
output = ones(outputSize, outputSize);
if m >= n
    aliasing = round((outputSize - n) / 2);
    output(1:outputSize, 1 + aliasing + 1 : 1 + aliasing + n) = input(:, :);
else
    aliasing = floor((outputSize - m) / 2);
    output(1 + aliasing : 1 + aliasing + m, 1 : outputSize) = input(:, :);
end
% third step : downsampling to 28 * 28
output_temp = imresize(output, [20 20]);
output = ones(28, 28);
output(5:24, 5:24) = output_temp(:, :);
output = im2bw(output, graythresh(output));
output = ~output;
output = double(output);
originOutput = output;
output = reshape(output, 1, 28 * 28);
end

