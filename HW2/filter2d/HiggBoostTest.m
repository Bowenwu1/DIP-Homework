% High-boost Filter script
img_name = '10.png';

subplot(2, 3, 1);
imshow(imread(img_name));
title('origin');
% Paramter K
for k = 1 : 5
    % g(x, y) = f(x,y) + k * [f(x, y) - f'(x,y)]
    % I will directly use my result
    highboost = [-k -k -k;-k (8 * k + 9) -k; -k -k -k];
    output = filter2d(img_name, highboost, false);
    subplot(2, 3, k + 1);
    imshow(output);
    title(strcat('k=', int2str(k)));
end

    
