
import Quantization
import Scaling
import os

def mkdir(path):
    if not os.path.exists(path):
        os.makedirs(path)

mkdir('./Quantization')
mkdir('./Scale')

Quantization.quantize('10.png', 128, './Quantization/10-level-128.png')
Quantization.quantize('10.png', 32, './Quantization/10-level-32.png')
Quantization.quantize('10.png', 8, './Quantization/10-level-8.png')
Quantization.quantize('10.png', 4, './Quantization/10-level-4.png')
Quantization.quantize('10.png', 2, './Quantization/10-level-2.png')

Scaling.scale('10.png', (192, 128), './Scale/down-scale(192x128).png')
Scaling.scale('10.png', (96, 64), './Scale/down-scale(96x64).png')
Scaling.scale('10.png', (48, 32), './Scale/down-scale(48x32).png')
Scaling.scale('10.png', (24, 16), './Scale/down-scale(24x16).png')
Scaling.scale('10.png', (12, 8), './Scale/down-scale(12x8).png')

Scaling.scale('10.png', (300, 200), './Scale/down-scale(300x200).png')

Scaling.scale('10.png', (450, 300), './Scale/up-scale(450x300).png')

Scaling.scale('10.png', (500, 200), './Scale/scale(500x200).png')