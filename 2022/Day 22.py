#!/usr/bin/env python
# coding: utf-8

# In[56]:


import numpy as np
from aocd import get_data, submit 
import re
data = get_data(year=2022, day=22)
field, instructions = data.split("\n\n")
field = field.splitlines()
width = max([len(line) for line in field])

field = [line + " " * (width - len(line)) for line in field]

field = np.array(list(map(list, field)))

directions = list(zip(re.split("[LR]+", instructions), re.split("\d+", instructions)))


# In[2]:


starting_x = np.where(field[0,:] == ".")[0][0]
starting_y = 0
starting_x


# In[3]:


max_y, max_x = field.shape


# In[4]:


headings = ["N", "E", "S", "W"]

get_facing_idx = lambda facing: next(i for i, f in enumerate(headings) if f == facing)
turn_dir = {"L": -1, "R": 1, "": 0}
get_new_facing = lambda facing, turn: headings[ (get_facing_idx(facing) + turn_dir[turn]) % len(headings) ]


# In[5]:


list(headings)


# In[35]:


move_dict = {
    "N": (-1, 0),
    "S": (1, 0),
    "E": (0, 1),
    "W": (0, -1)
}

def find_wrap_topdown(x, y, facing):
    dy, dx = move_dict[facing]
    new_x = (x + dx) % max_x
    new_y = (y + dy) % max_y
    while field[new_y, new_x] == ' ':
        new_x = (new_x + dx) % max_x
        new_y = (new_y + dy) % max_y
    return new_x, new_y, facing
    

def move_until_stops(x, y, dist, facing, find_wrap):
    dist = int(dist)
    dy, dx = move_dict[facing]
    print(f"Moving y:{dy}, x:{dx} ({facing})")
    for _ in range(dist):
        new_x = (x + dx) % max_x
        new_y = (y + dy) % max_y
        new_facing = facing
        if field[new_y, new_x] == ' ':
            print(f"Wrapping around edge from {x}, {y}")
            new_x, new_y, new_facing = find_wrap(x, y, facing)
            dy, dx = move_dict[new_facing]
        if field[new_y, new_x] == "#":
            print(f"Wall at ({new_x}, {new_y})")
            break
        if field[new_y, new_x] == ".":
            x = new_x
            y = new_y
            facing = new_facing
            print(f"Moving to ({x}, {y})")
        else:
            raise ValueError(field[new_y, new_x])

    return x, y, facing


# In[36]:


def simulate_path(x, y, facing, wrap_func):
    for dist, turn in directions:

        facing = get_new_facing(facing, turn)
        print(f"Turning {turn}, now facing {facing}")
        print(f"Will move {dist}")

        x, y, facing = move_until_stops(x, y, dist, facing, wrap_func)

        print(f"Now at ({x}, {y}) facing:{facing}")
    return x, y, facing

x, y, facing = simulate_path(starting_x, starting_y, "E", find_wrap_topdown)


# In[37]:


answer = (y+1) * 1000 + (x+1) * 4 + (get_facing_idx(facing) - 1) % len(headings)
answer


# In[49]:


face_ids = {
    (-1,1): 6, 
    (-1,2): 6,
    (0,0): 4,
    (0,1): 1,
    (0,2): 2,
    (0,3): 5,
    (1,0): set([4,3]),
    (1,1): 3,
    (1,2): set([3,2]),
    (2,-1): 1,
    (2,0): 4,
    (2,1): 5,
    (2,2): 2,
    (3,-1): 1,
    (3,0): 6,
    (3,1): set([5,6]), 
    (4,0): 2
}

N = 50
get_face_id = lambda x, y: face_ids[(y//N, x//N)]


# In[50]:


def get_new_orientation(x, y, old_face, new_face):
    
    x %= N
    y %= N
    print(f"rel x {x}")
    print(f"rel y {y}")
    print(f"N: {N}")
  

    n = N-1
    face_rotations = {
        (1,4): (n-y, 0, "E"), 
        (1,6): (x, 0, "E"),
        (2,3): (x, n, "W"),
        (2,5): (n-y, n, "W"),
        (2,6): (n, x, "N"), 
        (3,2): (n, y, "N"), 
        (3,4): (0, y, "S"), 
        (5,2): (n-y, n, "W"), 
        (5,6): (x, n, "W"), 
        (4,1): (n-y, 0, "E"), 
        (4,3): (x, 0, "E"), 
        (6,5): (n, y, "N"), 
        (6,2): (0, x, "S"), 
        (6,1): (0, y, "S")
    }
    
    return face_rotations[(old_face, new_face)]


# In[51]:


face_offsets = {
    1: (0, N), 
    2: (0, 2*N), 
    3: (N, N),
    4: (2*N, 0), 
    5: (2*N, N),
    6: (3*N, 0)
}


# In[52]:


def find_wrap_cube(x, y, facing):
    old_face = get_face_id(x, y)
    print(f"Old face ID: {old_face}")
    dy, dx = move_dict[facing]
    new_x = (x + dx)
    new_y = (y + dy)
    print(f"Finding new face for {new_x}, {new_y}")
    new_face = get_face_id(new_x, new_y)
    if isinstance(new_face, set):
        new_face = list(new_face - set([old_face]))[0]
    print(f"New face ID: {new_face}")
    
    rel_y, rel_x, facing = get_new_orientation(x, y, old_face, new_face)
    face_y, face_x = face_offsets[new_face]
    
    print(f"New relative coordinates: {rel_x}, {rel_y}. Facing: {facing}")
    print(f"Face coordinates: {face_x}, {face_y}")
    x = rel_x + face_x
    y = rel_y + face_y
    print(f"New absolute coordinates: {x}, {y}")
    
    return x, y, facing
    


# In[54]:


x, y, facing = simulate_path(starting_x, starting_y, "E", find_wrap_cube)


# In[55]:


answer = (y+1) * 1000 + (x+1) * 4 + (get_facing_idx(facing) - 1) % len(headings)
answer


# In[ ]:




