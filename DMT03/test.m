clear;
train_images = loadMNISTImages('/Users/wubowen/Documents/Handwritten-Digit-Recognition/training-set/train-images-idx3-ubyte');
train_labels = loadMNISTLabels('/Users/wubowen/Documents/Handwritten-Digit-Recognition/training-set/train-labels-idx1-ubyte');

test_images = loadMNISTImages('/Users/wubowen/Documents/Handwritten-Digit-Recognition/test-set/test-images-idx3-ubyte');
test_labels = loadMNISTLabels('/Users/wubowen/Documents/Handwritten-Digit-Recognition/test-set/test-labels-idx1-ubyte');

% binary
train_images(train_images > 2) = 1;
test_images(test_images > 2) = 1;
tic;
model = TreeBagger(50, train_images', train_labels);
time = toc;
result = model.predict(test_images');
% calculate rate
[~, test_num] = size(test_images);
result_array = zeros(test_num, 1);

for i = 1 : test_num
temp = result(i);
result_array(i) = str2double(temp{1});
end

rate = sum(result_array == test_labels);
rate = rate / test_num;
fprintf('Accuracy : %f. With Running Time : %f\n', rate, time);

% Save the model
save('/Users/wubowen/Documents/DIP-Homework/DMT03/digit_model.mat', 'model', '-v7.3');