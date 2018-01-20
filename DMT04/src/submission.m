img = imread('input.jpg');
A4 = pickupA4(img);
fprintf('finish pickupA4\n');
ROI = findContour(A4);
fprintf('finish findContour\n');
recognizeDigits(ROI, model);
fprintf('finish recognize\n');