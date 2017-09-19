from PIL import Image
import numpy as np
import util

# input_image : path of input
# size : like (100, 200)
# output : path of output image
def scale(input_image, size, output):
    img = Image.open(input_image)
    matrix = util.toMatrix(img)
    matrix_list = matrix.tolist()
    # scale factor
    w_scale = size[0] / img.size[0]
    h_scale = size[1] / img.size[1]

    print(w_scale, h_scale)
    new_image = [[0 for i in range(size[1])] for j in range(size[0])]

    # Assign those certain value
    # Now, when down-scale the image, repeated assigment will happen
    for i in range(len(matrix_list)):
        for j in range(len(matrix_list[i])):
            x = int(i * w_scale)
            y = int(j * h_scale)
           # print((i, j), (x, y))
            new_image[x][y] = matrix_list[i][j]

    # interpolation
    
    matrix = np.matrix(new_image, dtype=np.uint8)

    img = util.toImage(matrix)

    img.save(output)

scale('10.png', (192, 128), 'test.png')
