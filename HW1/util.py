# This file provide the transfer between numpy matrix and PIL Image

from PIL import Image
import numpy as np

# img : Image
def toMatrix(img):
    data = img.getdata()
    data = np.matrix(data, dtype=np.uint8)
    # http://scikit-image.org/docs/dev/user_guide/numpy_images.html#numpy-indexing
    # Be careful: in NumPy indexing, the first dimension 
    # (camera.shape[0]) corresponds to rows, while the second (camera.shape[1]) corresponds to columns, with the origin (camera[0, 0]) on the top-left corner. 
    # This matches matrix/linear algebra notation, but is in contrast to Cartesian (x, y) coordinates.
    data = np.reshape(data, (img.size[1], img.size[0]))
    return data
# matrix : numpy.matrix
def toImage(matrix):
    img = Image.fromarray(matrix)
    return img