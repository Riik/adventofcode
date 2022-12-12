#!/usr/bin/env python
# coding: utf-8

# In[1]:


from aocd import get_data, submit
import numpy as np 
data = get_data(year=2022, day=12)
data = data.splitlines()
data = [list(d) for d in data]
data = np.array(data)
data
def converted_h(h):
    h = 'z' if h == 'E' else h
    h = 'a' if h == 'S' else h
    return h

height_diff = lambda new, old: ord(converted_h(new)) - ord(converted_h(old))


# In[11]:


def visit_node(pos, best_stepcount, best_predecessor, step_test, data):
    height = data[tuple(pos)]
    step_count = best_stepcount[tuple(pos)]
    moves = [[0,1], [1,0], [-1,0], [0,-1]]
    H, W = data.shape
    
    for move in moves:
        p = pos + move
        if (p[0] < 0) or (p[0] >= H) or (p[1] < 0) or (p[1] >= W):
            continue
        new_height = data[tuple(p)]
        known_stepcount = best_stepcount[tuple(p)]
        if step_count >= known_stepcount:
            continue
        else:
            diff = height_diff(new_height, height)
            if step_test(diff):
                best_stepcount[p[0]][p[1]] = step_count + 1
                best_predecessor[tuple(p)] = tuple(pos)
    return best_stepcount, best_predecessor


# In[12]:


from collections import defaultdict
def pathfinding(data, start_node, step_test):
    best_stepcount = (np.ones(data.shape)*np.inf)
    best_predecessor = defaultdict()
    unvisited = (np.ones(data.shape))

    best_stepcount[start_node] = 1

    moves = np.array([[0, 1], [1, 0], [0, -1], [-1, 0]])

    H, W = data.shape

    new_node = start_node
    while True:
        new_node = np.unravel_index(np.argmin(unvisited * best_stepcount), unvisited.shape)
        best_stepcount, best_predecessor = visit_node(np.array(new_node), best_stepcount, best_predecessor, step_test, data)
        unvisited[new_node] = np.inf
        if not ( np.min(unvisited * best_stepcount) < np.inf ):
            break
    
    return best_stepcount, best_predecessor


# In[28]:


step_test = lambda x: x <= 1
start_node = np.where(data == "S")
start_node = (start_node[0][0], start_node[1][0])
best_stepcount, best_predecessor = pathfinding(data, start_node, step_test)
answer = int(best_stepcount[np.where(data == 'E')][0]) - 1
answer


# In[14]:


submit(answer, year=2022, day=12, part="a")


# In[15]:


# Start at end walking backwards, inverse step test
step_test = lambda x: x >= -1
start_node = np.where(data == "E")
start_node = (start_node[0][0], start_node[1][0])
best_stepcount, best_predecessor = pathfinding(data, start_node, step_test)
ground_level = best_stepcount.copy()
ground_level[data != "a"] = np.inf
answer = int(np.min(ground_level)) - 1
answer


# In[16]:


submit(answer, year=2022, day=12, part="b")


# In[17]:


curr = np.where(data == "S")
curr = (curr[0][0], curr[1][0])
path = [curr]
while curr != start_node:
    curr = best_predecessor[curr]
    path.append(curr)


# In[29]:


import plotly.express as px 
px.imshow(best_stepcount)


# In[22]:


ord_vec = np.vectorize(ord)
px.imshow(ord_vec(data[:, :]))


# In[27]:


path_data = ord_vec(data)
for p in path: 
    path_data[p] = 90
px.imshow(path_data)


# In[ ]:




