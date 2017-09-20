from PIL import Image
import numpy as np
import util
import math

# input_image : path of input
# size : like (100, 200)
# output : path of output image
def scale(input_image, size, output):
    img = Image.open(input_image)
    matrix = util.toMatrix(img)
    f = matrix.tolist()
    # scale factor
    w_scale = img.size[0] / size[0]
    h_scale = img.size[0] / size[0]

    src_width = img.size[0]
    src_height = img.size[1]

    print(w_scale, h_scale)
    new_image = [[0 for i in range(size[1])] for j in range(size[0])]

    # Assign those certain value
    # Now, when down-scale the image, repeated assigment will happen
    for x in range(len(new_image)):
        for y in range(len(new_image[x])):
            u = (x) * w_scale
            v = (y) * h_scale

            # integer part
            i = int(math.floor(u))
            j = int(math.floor(v))
            # fractional part
            u = u - i
            v = v - j

            # bi-linear interpolation
            
            # first find four nearest point
            # And make sure this four points are distinct
            x1 = i
            y1 = j
            if y1 >= src_height:
                print('y1 exceed', y1)
                print('y : ', y)
            y2 = j + 1
            if j + 1 >= src_height:
                print(y2)
                y2 = j - 1
                print(y2)
            x2 = i + 1
            if i + 1 >= src_width:
                print('x2 exceed')
                x2 = i - 1
            #print((x1, y1), (x2, y2))
            # Interpolation of X axis
            f_x_y1 = ((x2 - i - u)/(x2 - x1)) * f[x1][y1] + ((i + u - x1)/(x2 - x1)) * f[x2][y1]
            f_x_y2 = ((x2 - i - u)/(x2 - x1)) * f[x1][y2] + ((i + u - x1)/(x2 - x1)) * f[x2][y2]
            # Interpolation of Y axis
            new_image[x][y] = ((y2 - j - v)/(y2 - y1)) * f_x_y1 + ((j + v - y1)/(y2-y1)) * f_x_y2
    # interpolation
    
    matrix = np.matrix(new_image, dtype=np.uint8)

    img = util.toImage(matrix)

    img.save(output)

scale('10.png', (192, 128), 'test.png')
