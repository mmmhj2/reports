import numpy as np
import matplotlib.pyplot as plt
from downsampler import downsample2d, downsample1d
from exact_boundary import solve_exact
from full_explicit_solver import solve

x_length = 10
x_count = 1000
y_length = 0.005
y_count = 50
dx = x_length / x_count
dy = y_length / y_count

nu = 1e-6
u_inf = 10

downsample_coef_x = 20
downsample_coef_y = 2
downsamplexy = lambda x : downsample2d(x, downsample_coef_x, downsample_coef_y)
downsamplex = lambda x : downsample1d(x, downsample_coef_x)

u = np.zeros([x_count, y_count])
v = np.zeros([x_count, y_count])
boundary = np.zeros([x_count])

# Leading edge
for j in range(y_count):
    u[0][j], v[0][j] = u_inf, 0

# Buttom edge
for i in range(x_count):
    u[i][0] = v[i][0] = 0

solve(u, v, boundary, dx, dy, u_inf, nu)
solve(u, v, boundary, dx, dy, u_inf, nu)

U, V = downsamplexy(u), downsamplexy(v)
plt.quiver(np.transpose(U), np.transpose(V), scale=500)

B = downsamplex(boundary)
plt.plot(B / downsample_coef_y)

B2 = solve_exact(x_length, dx, nu, u_inf, x_count=x_count, dy=dy)
B2 = downsamplex(B2 / downsample_coef_y)
plt.plot(B2)

plt.show()
