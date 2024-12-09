import numpy as np

def solve_exact(x_length, dx, nu, u_inf, **kwargs):
    boundary = np.arange(0, x_length, dx)
    
    if 'x_count' in kwargs:
        assert boundary.shape[0] == kwargs['x_count']

    boundary = 5.0 * np.sqrt( boundary * nu / u_inf )
    if 'dy' in kwargs:
        boundary /= kwargs['dy']
    return boundary

if __name__ == '__main__':
    import matplotlib.pyplot as plt
    x_length = 10
    x_count = 1000
    y_length = 0.005
    y_count = 50
    dx = x_length / x_count
    dy = y_length / y_count
    nu = 1e-6
    u_inf = 10
    
    b = solve_exact(x_length, dx, nu, u_inf, x_count=x_count, dy=dy)
    plt.plot(b)
    plt.show()
