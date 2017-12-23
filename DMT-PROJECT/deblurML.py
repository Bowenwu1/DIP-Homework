import os
import matplotlib.pyplot
import numpy
import scipy.misc
import sklearn.neural_network
import sklearn.ensemble
import sklearn.neighbors
import sklearn.linear_model
import sklearn.decomposition
import skimage.util
import sklearn.feature_extraction.image
import sklearn.externals.joblib


def load_data_set(directory):
    data_set = []
    for filename in sorted(os.listdir(directory)):
        if filename.endswith('.jpeg'):
            data = scipy.misc.imread(os.path.join(directory, filename))
            data = data.astype(float)
            data_set.append(data)
    return numpy.array(data_set)


def divide_into_blocks(data_set):
    image_patches_set = []
    for data in data_set:
        image_patches = skimage.util.view_as_blocks(data, block_size)
        image_patches = image_patches.reshape(
            (blocks_in_row * blocks_in_column, block_size[0] * block_size[1]))
        image_patches_set.append(image_patches)
    return numpy.array(image_patches_set)


def fit(train_patches, label_patches):
    patch_num = train_patches.shape[1]
    estimators = [sklearn.linear_model.LinearRegression() for _ in range(patch_num)]
    for i in range(patch_num):
        x = train_patches[:, i, :]
        y = label_patches[:, i, :]
        estimators[i].fit(x, y)
    return estimators


def predict(estimators, test):
    test_patches = skimage.util.view_as_blocks(test, block_size)
    test_patches = test_patches.reshape(
        (blocks_in_row * blocks_in_column, block_size[0] * block_size[1]))

    row_patches = []
    for row in range(blocks_in_row):
        column_patches = []
        for column in range(blocks_in_column):
            index = row * blocks_in_row + column
            predict_patch = estimators[index].predict(test_patches[index].reshape(1, -1))
            predict_patch = predict_patch.reshape(block_size)
            column_patches.append(predict_patch)
        row_patches.append(numpy.hstack(column_patches[:]))

    output = numpy.vstack(row_patches[:])
    return output


def save_model(file_name, model):
    sklearn.externals.joblib.dump(model, file_name)


def load_model(file_name):
    return sklearn.externals.joblib.load(file_name)


block_size = (4, 4)
image_size = (64, 64)
blocks_in_row = image_size[0] // block_size[0]
blocks_in_column = image_size[1] // block_size[1]

train_data_set = load_data_set('./data_set/train')
label_data_set = load_data_set('./data_set/label')

train_patches_set = divide_into_blocks(train_data_set)
label_patches_set = divide_into_blocks(label_data_set)

fit_estimators = fit(train_patches_set, label_patches_set)

save_model("model", fit_estimators)

test = scipy.misc.imread('./data_set/predict/test.jpeg')
ans = predict(fit_estimators, test)

matplotlib.pyplot.figure()
matplotlib.pyplot.imshow(ans, cmap='gray')
matplotlib.pyplot.figure()
matplotlib.pyplot.imshow(test, cmap='gray')
matplotlib.pyplot.show()
