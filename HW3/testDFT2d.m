img = imread('88.png');

% centerlize
img_centerlize = double(img);
[M, N] = size(img);
for i = 1 : M
    for j = 1 : N
        img_centerlize(i, j) = img_centerlize(i, j) * (-1)^(i + j);
    end
end

output = dft2d(img_centerlize, true);

% get specturm of Fourier transformation
specturm = abs(output);
% log transformation
specturm = log(1 + specturm);
% scaling linearly
maxNum = max(max(specturm, [], 2));
minNum = min(min(specturm, [], 2));
specturm = (specturm - minNum)/(maxNum - minNum) * 255;
specturm = uint8(specturm);

subplot(3, 1, 1);
imshow(specturm);
title('spectrum');

inverse_picture = dft2d(dft2d(img, true), false);
inverse_picture = uint8(real(inverse_picture));

subplot(3, 1, 2);
imshow(inverse_picture);
title('inverse Fourier');

subplot(3, 1, 3);
imshow(img);
title('origin');