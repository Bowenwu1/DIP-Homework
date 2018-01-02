% Test for Set14 using bicubic method
clear;
images = dir('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/Set14/*.bmp');
all_psnr = zeros(length(images), 1);
all_ssim = zeros(length(images), 1);
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
    origin_image_temp = origin_image;
    big_image_temp = big_image;
    filename = sprintf('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/BicubicResult/BicubicResult%s.png', images(i).name);
    filename_image = sprintf('/Users/wubowen/Documents/DIP-Homework/DIP-PROJECT/BicubicResult/Bicubic%s.png', images(i).name);
%     imshow(big_image);
    if (3 == dimension)
        origin_image = rgb2ycbcr(origin_image);
        big_image = rgb2ycbcr(big_image);
    end
    all_psnr(i) = PSNR(origin_image(:, :, 1), big_image(:, :, 1));
    all_ssim(i) = SSIM(origin_image(:, :, 1), big_image(:, :, 1));
    fprintf(strcat(images(i).name, ' : (', num2str(all_psnr(i)), ', ', ...
                num2str(all_ssim(i)), ')\n'));
    h = figure('Visible','off');
    subplot(1, 2, 1);
    imshow(origin_image_temp);
    title('origin');
    subplot(1, 2, 2);
    imshow(big_image_temp);
    title('Bicubic');
    l = sprintf('(PSNR, SSIM)=(%f, %f)', all_psnr(i), all_ssim(i));
    xlabel(l);
    saveas(h, filename);
    close(gcf)
    imwrite(big_image_temp, filename_image);
end