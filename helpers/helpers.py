from collections import defaultdict

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

def flood_fill():
    visited = set() # this must always start out empty

    positions = [(0,0)] # this is the starting position
    for _ in range(10_000):
        new_positions = set()
        for p in positions:
            # check for visit and add to visited first thing
            if p in visited:
                continue
            visited.add(p)

            y, x = p

            for dir in directions:
                if val == C:
                    new_positions.add(new_p)
                else:
                    edges += 1

        if not new_positions:
            return edges, area

        positions = list(new_positions.copy())
    raise ValueError("Too many iterations")



directions_map = {
    "W": (0, -1),
    "NW": (-1, -1),
    "N": (-1, 0),
    "NE": (-1, 1),
    "E": (0, 1),
    "SE": (1, 1),
    "S": (1, 0),
    "SW": (1, -1)
}

def in_bounds(y, x):
    return 0 <= y < H and 0 <= x < W

def get_rel_coords(y, x, dir):
    dy, dx = directions_map[dir]
    return y+dy, x+dx

def loc_data(y, x):
    return data[y][x] if in_bounds(y, x) else ""

def loc_data_rel(y, x, dir):
    return loc_data(*get_rel_coords(y, x, dir))


def simple_bfs(initial_state, m):
    all_visited = set()
    to_visit = [initial_state]
    for iteration in range(1_000):
        new_to_visit = set()
        print(len(to_visit))
        for s in to_visit:
            for new_s in (...):
                if some_condition:
                    new_to_visit.add(new_s)
                    all_visited.add(new_s)
        if not new_to_visit:
            print("DONE")
            break
        to_visit = list(new_to_visit)

    else:
        raise ValueError("max iterations exceeded")