% 2.4.1
img = imread('10.png');
[m, n, p] = size(img);
after_img = zeros(m, n, p);

for i = 1 : p
    after_img(:, :, i) = equalize_hist(img(:, :, i), false);
end
after_img = uint8(after_img);
subplot(2, 1, 1);
imshow(img);
title('before histogram equalize');

subplot(2, 1, 2);
imshow(after_img);
title('after histogram equalize(2.4.1)');