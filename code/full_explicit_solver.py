
def solve(u, v, boundary, dx, dy, u_inf, nu):
    assert u.shape == v.shape
    assert u.shape[0] == boundary.shape[0]
    [x_count, y_count] = u.shape
    
    # Calculate u, from inside to outside
    for i in range(1, x_count):
        boundaryFound = False
        for j in range(1, y_count):
            
            if boundaryFound:
                u[i][j] = u_inf
            
            upper = (u[i-1][j+1] if j < y_count-1 else u_inf)
            middle = u[i-1][j]
            lower = u[i-1][j-1]
            
            pu1 = nu / (dy * dy) * (upper - 2 * middle + lower)
            pu2 = u[i-1][j] * u[i-1][j] / dx
            pu3 = v[i-1][j] / (2 * dy) * (upper - lower)
            pu = (pu1 + pu2 + pu3) / (u[i-1][j] / dx)
            
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
            pv = - (u[i][j] - u[i-1][j]) / (dx) + v[i][j-1] / dy
            pv = pv * dy
            v[i][j] = pv
