function [result] = recognizeDigits(input, model)
% recognizeDigits - Description
% input : cell of ROI
% Syntax: [result] = recognizeDigits(input)
% data = load(modelPath);
% model = data.model;
[~, n] = size(input);
result = zeros(n, 1);
for i = 1 : n
    plotIndex = (i - 1) * 2 + 1;
    subplot(6, 12, plotIndex);
    imshow(input{i});
    [temp, temp2] = preprocessForMnist(input{i});
    result = model.predict(temp);
    title(result);
    subplot(6, 12, plotIndex + 1);
    imshow(temp2);
end