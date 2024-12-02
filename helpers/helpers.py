import numpy as np

def parse_int_list(l, sep=','):
    return [int(x) for x in l.split(sep)]

def parse_single_matrix(data):
    return np.array([list(d) for d in data.split("\n")])