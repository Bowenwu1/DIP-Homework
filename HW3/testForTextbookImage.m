img = zeros(300, 300);

for x = 130:170
    for y = 130:170
        img(x, y) = 255;
    end
end
img = uint8(img);
center_img = zeros(300, 300);
for x = 1 : 300
    for y = 1 : 300
        center_img(x, y) = img(x, y) * (-1)^(x + y);
    end
end
output = dft2d(center_img, true);

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
title('spectrum');
imshow(specturm);

inverse_picture = dft2d(output, false);
inverse_picture = uint8(real(inverse_picture));

subplot(3, 1, 2);
title('inverse Fourier');
imshow(inverse_picture);

subplot(3, 1, 3);
title('origin');
imshow(img);