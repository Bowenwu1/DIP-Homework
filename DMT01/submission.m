clear;
% Read the image
img = imread('input.jpg');

% Translate into gray image
gray_img = rgb2gray(img);

% Filter for noise
gray_img = filter2d(gray_img, ones(5,5), false);

% High-boost filter
% k = 5;
% high_boost = [-k -k -k;-k 9+8*k -k;-k -k -k];
% gray_img = filter2d(gray_img, high_boost, false);

% Filter for pcik up edge through Lap
% filter = [-1 -1 -1;-1 9 -1;-1 -1 -1];
% filter = [-1 -2 -1;0 1 0;1 2 1];
% edge_img = filter2d(gray_img, filter, false) - gray_img;


% Translate the image into 2-value image
% [w, h] = size(edge_img);
% threshold = 30;
% for m = 1 : w
    % for n = 1 : h
%         if (edge_img(m, n) < threshold)
%             edge_img(m, n) = 0;
%         else
%             edge_img(m, n) = 255;
%         end
%     end
% end
edge_img = edge(gray_img);
imshow(edge_img);


[H,Theta,Rho] = hough(edge_img);
% subplot(222), imshow(H,[],'XData',Theta,'YData',Rho,'InitialMagnification','fit'),...
%     title('rho\_theta space and peaks');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% label the top 5 intersections
P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));
% x = Theta(P(:,2)); 
% y = Rho(P(:,1));
% plot(x,y,'*','color','r');

lines = houghlines(edge_img,Theta,Rho,P,'FillGap',25,'MinLength',120);

% merge into 4 lines
%
%
%
length(lines)

figure, imshow(img), hold on
for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','g');
 
 % plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
 % plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');
end
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
debugCount = 0;
for m = 1 : totalPoint
    xy = endPoints{m};
    flag = 1;
    for n = 1 : pointIndex
        xy_exist = tempEndPoints{n};
        if (abs(xy_exist(1) - xy(1)) < 5 && abs(xy_exist(2) - xy(2)) < 5)
            flag = 0;
            debugCount = debugCount + 1;
            break;
        end
    end
    if (1 == flag)
        pointIndex = pointIndex + 1;
        tempEndPoints{pointIndex} = xy;
    end
end
endPoints = tempEndPoints;
for k = 1 : pointIndex
    xy = endPoints{k};
    plot(xy(1), xy(2), 'x', 'LineWidth', 2, 'Color', 'yellow');
end
hold off
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
destination_points = [1 1;1 target_height;target_width 1; target_width target_height]
TForm = cp2tform(src_points, destination_points, 'projective');

[target_img, xdata, ydata] = imtransform(img, TForm);


target_img = imcrop(target_img, [0 - xdata(1) 0 - ydata(1) target_width target_height]);
target_img = imresize(target_img, 2);
figure, hold on
imshow(target_img);