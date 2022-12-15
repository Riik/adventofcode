#!/usr/bin/env python
# coding: utf-8

# In[100]:


get_ipython().run_line_magic('pip', 'install shapely')


# In[101]:


from aocd import get_data, submit
import re
import numpy as np

data = """Sensor at x=2, y=18: closest beacon is at x=-2, y=15
Sensor at x=9, y=16: closest beacon is at x=10, y=16
Sensor at x=13, y=2: closest beacon is at x=15, y=3
Sensor at x=12, y=14: closest beacon is at x=10, y=16
Sensor at x=10, y=20: closest beacon is at x=10, y=16
Sensor at x=14, y=17: closest beacon is at x=10, y=16
Sensor at x=8, y=7: closest beacon is at x=2, y=10
Sensor at x=2, y=0: closest beacon is at x=2, y=10
Sensor at x=0, y=11: closest beacon is at x=2, y=10
Sensor at x=20, y=14: closest beacon is at x=25, y=17
Sensor at x=17, y=20: closest beacon is at x=21, y=22
Sensor at x=16, y=7: closest beacon is at x=15, y=3
Sensor at x=14, y=3: closest beacon is at x=15, y=3
Sensor at x=20, y=1: closest beacon is at x=15, y=3"""
data = get_data(year=2022, day=15)

dist = lambda p1, p2: int(np.linalg.norm(p1-p2, 1))

data = data.splitlines()
data = [re.findall(r"=([-\d]*)", line) for line in data]
data = [list(map(int, d)) for d in data]
data = [[np.array([d[0], d[1]]), np.array([d[2], d[3]])] for d in data]
data = [(p, b, dist(p, b)) for p,b in data]
data


# In[102]:


def merge_ranges(left, right):
    if left.stop >= right.start:
        new_min = min(left.start, left.start)
        new_max = max(left.stop, right.stop)
        return [range(new_min, new_max)]
    return [left, right]
    
    
merge_ranges(range(-4, 0), range(1, 103))


# In[103]:


x = [range(5), range(10, 12), range(-4, 10), range(13, 15), range(-10, -7)]
def overlap_ranges(ranges):
    ranges.sort(key=lambda r: min(r))
    output = []
    l = ranges[0]
    for r in ranges[1:]:
        res = merge_ranges(l, r)
        if len(res) == 2:
            l = res[1]
            output.append(res[0])
        else: 
            l = res[0]
    output.append(l)
    return output

overlap_ranges(x)


# In[104]:


y = 2000000
def gen_range(p, d, y):
    y_offset = y - p[1]
    n_x = d-abs(y_offset)
    return range(-n_x + p[0], n_x + 1 + p[0])
    
def ranges_for_row(y):
    ranges = [gen_range(p, d, y) for p, _, d in data if abs(y - p[1]) <= d]
    coverage = overlap_ranges(ranges)
    return coverage


# In[105]:


ranges_for_row(2000000)
answer = coverage.stop - coverage.start - 1
answer


# ## Runs in 286 ms which is quite nice, but no way that that will work for 4 million rows 

# In[106]:


get_ipython().run_line_magic('timeit', 'ranges_for_row(2000000)')


# ## We'll treat the range of each sensor as a diamond shaped area, intersect all areas and find the interior of that shape. Only space for the distress beacon to hide 

# In[111]:


import shapely
from shapely.geometry import Polygon
from shapely.ops import unary_union

def make_polygon(d):
    p, _, radius = d
    points = p + np.array([[0,radius], [radius,0], [0,-radius], [-radius,0]])
    points = [tuple(p) for p in points]
    return Polygon(points)

polygons = [make_polygon(d) for d in data]
all_coverages = unary_union(polygons)


# In[112]:


all_coverages


# In[118]:


p.interiors[0].coords.xy


# In[99]:


answer = 2829680*4000000 + 3411840
answer


# In[ ]:




