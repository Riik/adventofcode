#!/usr/bin/env python
# coding: utf-8

# In[60]:


from aocd import get_data, submit
data = """2,2,2
1,2,2
3,2,2
2,1,2
2,3,2
2,2,1
2,2,3
2,2,4
2,2,6
1,2,5
3,2,5
2,1,5
2,3,5"""
data = get_data(year=2022, day=18)
data = data.splitlines()
data = set(tuple(map(int, line.split(","))) for line in data)


# In[61]:


def get_neighbours(p):
    return [
        (p[0]+1, p[1], p[2]),
        (p[0]-1, p[1], p[2]),
        (p[0], p[1]+1, p[2]),
        (p[0], p[1]-1, p[2]),
        (p[0], p[1], p[2]+1),
        (p[0], p[1], p[2]-1)]


# In[62]:


def get_surface(p):
    surface = 0
    for n in get_neighbours(p):
        if n not in data:
            surface += 1
    return surface

surface = 0
for p in data:
    surface += get_surface(p)
surface


# In[63]:


submit(surface, year=2022, day=18, part="a")


# In[64]:


import numpy as np
coords = list(data)


# In[65]:


MAX_COORDS = np.max(np.max(np.array(coords), axis=0)) + 1
MAX_COORDS


# In[66]:


def in_bounds(p):
    return (min(p) >= 0) and (max(p) < MAX_COORDS)

in_bounds((-1, 0, 0))


# In[67]:


all_tiles = set((x,y,z) for x,y,z in product(range(MAX_COORDS), range(MAX_COORDS), range(MAX_COORDS)))
visit_nodes = set([(0,0,0)])
reachable = set([(0,0,0)])

i = 0
while True:
    print(f"ROUND {i}:")
    i += 1
    new_visit_nodes = set()
    for node in visit_nodes:
        neighbours = get_neighbours(node)
        neighbours = [n for n in neighbours if in_bounds(n)]
        neighbours = [n for n in neighbours if n not in data]
        neighbours = [n for n in neighbours if n not in reachable]
#         print(node, neighbours)
        new_visit_nodes.update(neighbours)
        reachable.update(neighbours)
#     print(new_visit_nodes)
    if len(new_visit_nodes) == 0:
        print("CONVERGED AH YEAH")
        break
    visit_nodes = new_visit_nodes
        
        
    


# In[68]:


interior = all_tiles - data - reachable
interior


# In[69]:


interior_surface = 0
for p in interior:
    interior_surface += 6 - get_surface(p)

interior_surface


# In[70]:


exterior_surface = surface - interior_surface
exterior_surface

