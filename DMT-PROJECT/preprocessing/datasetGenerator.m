% ??????????
clear;
images = dir('DIP-Homework/DMT-PROJECT/data_set/trainning-set/puredata/*.jpg');

for file = images'
    try
        image= imread(file.name);
        image = rgb2gray(image);
        image = imresize(image, [64 64]);
        blur = imgaussfilt(image, 1.5);
        imwrite(image, strcat('DIP-Homework/DMT-PROJECT/data_set/trainning-set/ans/', file.name));
        imwrite(blur, strcat('DIP-Homework/DMT-PROJECT/data_set/trainning-set/predict/', file.name));
    catch ErrorInfo
    end
end