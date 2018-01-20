function [ output ] = rotateDigit( input )
% input : 2-value digit image(logical)
% output : 2-value digit image(logical) and rotate
% make the width of digit minimum
    function [width] = widthOfROI(input)
        roi = bwlabel(input);
        [~, col] = find(roi == 1);
        width = max(col) - min(col);
    end
% assumption : -30 ~ +30
degreeAliasing = 31;
width = zeros(61, 1);
for i = 1 : 61
    width(i) = widthOfROI(imrotate(input, i - degreeAliasing));
end
[~, degree] = min(width);
output = imrotate(input, degree - degreeAliasing);
% imshow(output);
end

