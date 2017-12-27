% Test for Set14 using bicubic method
clear;
images = dir('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/Set14/*.bmp');
for i = 1 : length(images)
    origin_image = imread(images(i).name);
    [origin_h, origin_w, dimension] = size(origin_image);
    small_image = zeros(floor(origin_h / 3), floor(origin_w / 3), dimension);
    big_image = zeros(origin_h, origin_w, dimension);
    for m = 1 : dimension
        small_image(:, :, m) = bicubic(origin_image(:, :, m), floor(origin_h / 3), floor(origin_w / 3));
        big_image(:, :, m) = bicubic(small_image(:, :, m), origin_h, origin_w);
%         small_image(:, :, m) = imresize(origin_image(:, :, m), [floor(origin_h / 3) floor(origin_w / 3)], 'bicubic');
%         big_image(:, :, m) = imresize(small_image(:, :, m), [origin_h origin_w], 'bicubic');
    end
    small_image = uint8(small_image);
    big_image = uint8(big_image);
%     imshow(big_image);
    if (3 == dimension)
        origin_image = rgb2ycbcr(origin_image);
        big_image = rgb2ycbcr(big_image);
    end
    fprintf(strcat(images(i).name, ' : (', num2str(PSNR(origin_image(:, :, 1), big_image(:, :, 1))), ', ', ...
                num2str(SSIM(origin_image(:, :, 1), big_image(:, :, 1))), ')\n'));
end