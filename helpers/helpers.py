import numpy as np

def parse_int_list(l, sep=','):
    return [int(x) for x in l.split(sep)]

def parse_single_matrix(data):
    return np.array([list(d) for d in data.split("\n")])

from itertools import product
def search_star(y, x, m):
    count = 0
    depth = 4
    pattern = "XMAS"
    for dy, dx in product([-1, 0, 1], [-1, 0, 1]):
        if dy == dx == 0: continue
        if not ((0 <= y+dy*(depth-1) < m.shape[0]) and (0 <= x+dx*(depth-1) < m.shape[1])):
            continue
        if all(m[y+i*dy, x+i*dx] == pattern[i] for i in range(depth)):
            count += 1
    return count