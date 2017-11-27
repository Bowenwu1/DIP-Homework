% 2.4.3
img = imread('10.png');

img_hsi = (transformRGBtoHSI(img));

intensity = uint8(img_hsi(:, :, 3));

img_hsi(:, :, 3) = uint8(equalize_hist(intensity));

img_after = uint8(transformHSItoRGB(img_hsi));

subplot(2, 1, 1);
imshow(img);
title('origin');

subplot(2, 1, 2);
imshow(img_after);
title('after(2.4.3)');