function [target_img] = pickupA4(img)
% pickupA4 - pick up A4 area of a image
%
% Syntax: target_img = pickupA4(img)

% Translate into gray image
gray_img = rgb2gray(img);

% Filter for noise
gray_img = filter2d(gray_img, ones(5,5), false);

edge_img = edge(gray_img);

[H,Theta,Rho] = hough(edge_img);

P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(edge_img,Theta,Rho,P,'FillGap',25,'MinLength',120);


% Find Four Points
endPoints = cell(4);
pointIndex = 1;
for m = 1 : length(lines)
    for n = m + 1 : length(lines)
        xy_m = [lines(m).point1; lines(m).point2];
        xy_n = [lines(n).point1; lines(n).point2];
        k_m = (xy_m(2, 2) - xy_m(1, 2)) / (xy_m(2, 1) - xy_m(1, 1));
        k_n = (xy_n(2, 2) - xy_n(1, 2)) / (xy_n(2, 1) - xy_n(1, 1));
        if abs(k_m - k_n) > 5
            [x, y] = findEndPoint(xy_m(1, :), xy_m(2, :), xy_n(1, :), xy_n(2, :));
            endPoints{pointIndex} = [x; y];
            pointIndex = pointIndex + 1;
        end
    end
end

% merge point into four
tempEndPoints = {};
totalPoint = pointIndex - 1;
pointIndex = 0;
for m = 1 : totalPoint
    xy = endPoints{m};
    flag = 1;
    for n = 1 : pointIndex
        xy_exist = tempEndPoints{n};
        if (abs(xy_exist(1) - xy(1)) < 5 && abs(xy_exist(2) - xy(2)) < 5)
            flag = 0;
            break;
        end
    end
    if (1 == flag)
        pointIndex = pointIndex + 1;
        tempEndPoints{pointIndex} = xy;
    end
end
endPoints = tempEndPoints;

% Tou Shi Bian Huan
target_width = 210 * 2;
target_height = 297 * 2;
target_img = zeros(target_width, target_height, 3);
% Src_Image
src_points = zeros(4, 2);
srcIndex = 1;
[h, w] = size(edge_img);
for i = 1 : pointIndex
    xy = endPoints{i}(:);
    if (0 < xy(1) && xy(1) < w && 0 < xy(2) && xy(2) < h)
        src_points(srcIndex, :) = endPoints{i}(:);
        srcIndex = srcIndex + 1;
    end
end

src_points = sortCordination(src_points);
destination_points = [1 1;1 target_height;target_width 1; target_width target_height];
TForm = cp2tform(src_points, destination_points, 'projective');

[target_img, xdata, ydata] = imtransform(img, TForm);


target_img = imcrop(target_img, [0 - xdata(1) 0 - ydata(1) target_width target_height]);
target_img = imresize(target_img, 2);
end