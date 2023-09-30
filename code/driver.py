import numpy as np
import matplotlib.pyplot as plt
from downsampler import downsample2d, downsample1d
from full_explicit_solver import solve

x_length = 10
x_count = 1000
y_length = 5
y_count = 50
dx = x_length / x_count
dy = y_length / y_count

nu = 1e-6
u_inf = 10

u = np.zeros([x_count, y_count])
v = np.zeros([x_count, y_count])
boundary = np.zeros([x_count])

# Leading edge
for j in range(y_count):
    u[0][j], v[0][j] = u_inf, 0

v.fill(2 * nu / dy)
# Buttom edge
for i in range(x_count):
    u[i][0] = v[i][0] = 0
    v[i][1] = nu / dy

solve(u, v, boundary, dx, dy, u_inf, nu)
solve(u, v, boundary, dx, dy, u_inf, nu)

U, V, B = downsample2d(u, 20, 2), downsample2d(v, 20, 2), downsample1d(boundary, 20)
plt.quiver(np.transpose(U), np.transpose(V), scale=500)
plt.plot(B/2)
plt.show()
