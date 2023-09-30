
from numpy import sqrt, max

def solve(u, v, boundary, dx, dy, u_inf, nu):
    assert u.shape == v.shape
    assert u.shape[0] == boundary.shape[0]
    [x_count, y_count] = u.shape
    
    # Calculate u, from inside to outside
    for i in range(1, x_count):
        boundaryFound = False
        for j in range(1, y_count):
            
            prev = u[i-2][j] if i >= 2 else u_inf
            top = u[i-1][j+1] if j < y_count - 1 else u_inf
            
            a = 1 / (4 * dx)
            b = nu / (dy * dy)
            c = - 1 / (4*dx) * prev*prev - nu / (dy*dy) * (top + u[i-1][j-1] - prev) \
                + v[i-1][j] * (top - u[i-1][j-1]) / (2 * dy)
            
            pu = (-b + sqrt(b*b - 4*a*c)) / (2*a)
            
            if (pu) > u_inf * 0.9995:
                if not boundaryFound:
                    boundaryFound = True
                    print('outer boundary found for x =', i, 'at y =', j, 'u =', pu)
                    boundary[i] = j
                u[i][j] = u_inf
            else:
                u[i][j] = pu
            
    # Calculate v
    for i in range(1, x_count):
        for j in range(1, y_count):
            pv = - (u[i][j] + u[i][j-1] - u[i-1][j] - u[i-1][j-1]) / (2 * dx) + v[i][j-1] / dy
            pv = pv * dy
            v[i][j] = pv
