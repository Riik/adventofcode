#!/usr/bin/env python
# coding: utf-8

# In[131]:


import numpy as np 
from aocd import get_data, submit
data = get_data(year=2022, day=9).splitlines()
# data = """R 4
# U 4
# L 3
# D 1
# R 4
# D 1
# L 5
# R 2
# """.splitlines()
data = [(d.split(" ")[0], int(d.split(" ")[1])) for d in data]
size_grid = max(d[1] for d in data)
size_grid = 1000
data


# In[135]:


def simulate_rope(data, size_grid, N):
    visited = np.zeros((2*size_grid, 2*size_grid)).astype("int")
    dir_dict = {
        "D": [-1, 0],
        "U": [1, 0],
        "L": [0, -1],
        "R": [0, 1]
    } 
    head = np.array([size_grid,size_grid])
    tail =  [np.array([size_grid,size_grid]) for i in range(N)]
    for direction, amount in data:
        for i in range(amount):
            head += dir_dict[direction]

            for i in range(0, len(tail)):
                diff = np.array([0,0])
                if i == 0:
                    diff = head - tail[0]
                else: 
                    diff = tail[i-1] - tail[i]
                if np.max(np.abs(diff)) > 1:
                    move = np.clip(diff, -1, 1)
                    tail[i] += move
                if i == (N-1):
                    visited[tail[i][0], tail[i][1]] = 1            
    return np.sum(np.sum(visited))


# In[139]:


answer = simulate_rope(data, size_grid, 1)
answer


# In[ ]:


submit(year=20922


# In[140]:


answer = simulate_rope(data, size_grid, 9)
answer


# In[ ]:




