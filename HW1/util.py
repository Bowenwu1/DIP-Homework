# This file provide the transfer between numpy matrix and PIL Image

from PIL import Image
import numpy as np

# img : Image
def toMatrix(img):
    data = img.getdata()
    data = np.matrix(data, dtype=np.uint8)
    # 这样做其实不符合numpy的风格
    # http://scikit-image.org/docs/dev/user_guide/numpy_images.html#numpy-indexing
    # Be careful: in NumPy indexing, the first dimension 
    # (camera.shape[0]) corresponds to rows, while the second (camera.shape[1]) corresponds to columns, with the origin (camera[0, 0]) on the top-left corner. 
    # This matches matrix/linear algebra notation, but is in contrast to Cartesian (x, y) coordinates.
    data = np.reshape(data, img.size)
    return data
# matrix : numpy.matrix
def toImage(matrix):
    # 这很奇怪 我发现如果直接转换回image 那么长宽会刚好反过来 可能是库里的bug
    # It is weird that this function will exchange image's width and height if 
    # use it directly. It may a bug of PIL
    w, h = matrix.shape
    matrix = np.reshape(matrix, (h, w))
    img = Image.fromarray(matrix)
    return img