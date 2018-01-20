img = imread('input.jpg');
A4 = pickupA4(img);
fprintf('finish pickupA4\n');
ROI = findContour(A4);
fprintf('finish findContour\n');
data = load('/Users/wubowen/Documents/DIP-Homework/DMT04/digit_model.mat');
recognizeDigits(ROI, data.model);
fprintf('finish recognize\n');