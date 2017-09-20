from PIL import Image
import numpy as np
import util

# input_img : path of input img
# level : the number of gray levels of output
# output : path of output img
# no return value
def quantize(input_img, level, output):
    img = Image.open(input_img)
    matrix = util.toMatrix(img)
    
    length = (255+1)/level
    seg_length = 255/(level - 1)
    # I do not know how to iterate numpy matrix
    # I have tried many ways and can not do it correctly, so I transfer it
    # to list and operate on it then transfer it back
    matrix_list = matrix.tolist()

    # Main algorithm
    for i in range(len(matrix_list)):
        for j in range(len(matrix_list[i])):
            matrix_list[i][j] = int(matrix_list[i][j] / int(length))
            matrix_list[i][j] = matrix_list[i][j] * seg_length

    matrix = np.matrix(matrix_list, dtype=np.uint8)
    img = util.toImage(matrix)

    img.save(output)

quantize('10.png', 128, './Quantization/10-level-128.png')
quantize('10.png', 32, './Quantization/10-level-32.png')
quantize('10.png', 8, './Quantization/10-level-8.png')
quantize('10.png', 4, './Quantization/10-level-4.png')
quantize('10.png', 2, './Quantization/10-level-2.png')