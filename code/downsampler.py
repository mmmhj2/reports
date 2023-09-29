import numpy as np

def downsample1d(array, x_divisor):
    [h] = array.shape
    assert h % x_divisor == 0
    
    nh = h // x_divisor
    narray = np.copy(array).reshape([nh, x_divisor])
    narray = np.mean(narray, axis=1)
    return narray

def downsample2d(array, x_divisor, y_divisor):
    [h, w] = array.shape
    assert h % x_divisor == 0 and w % y_divisor == 0
    
    nh, nw = h // x_divisor, w // y_divisor
    narray = np.copy(array).reshape([h, nw, y_divisor])
    narray = np.mean(narray, axis=2)
    narray = narray.reshape([nh, x_divisor, nw])
    narray = np.mean(narray, axis=1)
    return narray

if __name__ == '__main__':
    a = np.array([[1, 2], [3, 4]], np.float64)
    a1 = downsample2d(a, 2, 1)
    a2 = downsample2d(a, 1, 2)
    a3 = downsample2d(a, 2, 2)
    print(a1, a2, a3)
    