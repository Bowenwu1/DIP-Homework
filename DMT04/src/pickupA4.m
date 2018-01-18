function target_area = pickupA4(img)
% pickupA4 - pick up A4 area of a image
%
% Syntax: target_area = myFun(img)

% Translate into gray image
gray_img = rgb2gray(img);

% Filter for noise
gray_img = filter2(fspecial('average', 5), 'same');

edge_img = edge(gray_img);

[H,Theta,Rho] = hough(edge_img);

P  = houghpeaks(H,4,'threshold',ceil(0.3*max(H(:))));

lines = houghlines(edge_img,Theta,Rho,P,'FillGap',25,'MinLength',120);


end