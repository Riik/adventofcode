#!/usr/bin/env python
# coding: utf-8

# In[1]:


from aocd import get_data, submit
import numpy as np 
data = get_data(year=2022, day=8).splitlines()
data = """30373
25512
65332
33549
35390""".splitlines()
data = [list(d) for d in data]
data = np.array(data).astype("int")
data


# In[2]:


up_mask = np.maximum.accumulate(data, axis=0)
left_mask = np.maximum.accumulate(data, axis=1)
right_mask = np.fliplr(np.maximum.accumulate(np.fliplr(data), axis=1))
down_mask = np.flipud(np.maximum.accumulate(np.flipud(data), axis=0))
up_mask


# In[4]:


visible_up = np.diff(up_mask, axis=0, prepend=-1) > 0 
visible_right = np.fliplr(np.diff(np.fliplr(right_mask), axis=1, prepend=-1)) > 0 
visible_left = np.diff(left_mask, axis=1, prepend=-1) > 0 
visible_down = np.flipud(np.diff(np.flipud(down_mask), axis=0, prepend=-1)) > 0
visible_up.astype("int")


# In[136]:


visible = visible_up | visible_right | visible_left | visible_down
answer = np.sum(np.sum(visible))


# In[137]:


submit(answer, year=2022, day=8, part="a")


# In[138]:


data


# In[6]:


N = 5
def view_count_N(data, direction, N):
    H, W = data.shape
    
    if direction == "up":
        rows, cols = range(H), range(W)
    elif direction == "down":
        rows = list(reversed(range(H)))
        cols = range(W)
    elif direction == "left":
        rows, cols = range(H), range(W)
    elif direction == "right":
        rows = range(H)
        cols = list(reversed(range(W)))
    
    count_view = np.zeros(data.shape).astype("int")
    if direction in ["up", "down"]:
        for col in cols:
            h = -1
            count = -1
            for row in rows:
                count += 1
                count_view[row, col] = count
                if data[row, col] >= N:
                    count = 0
        return count_view
    else:
        for row in rows:
            h = -1
            count = -1
            for col in cols:
                count += 1
                count_view[row, col] = count
                if data[row, col] >= N:
                    count = 0
        return count_view

view_count_N(data, "left", 5)


# In[140]:


def get_view_count_N(data, N):
    return (
        view_count_N(data, "left", N) * 
        view_count_N(data, "right", N) * 
        view_count_N(data, "down", N) * 
        view_count_N(data, "up", N) * 
        (data == N)
    )



best_count = 0
for n in range(1,10):
    if (best_for_N := np.max(np.max(get_view_count_N(data, n)))) > best_count:
        best_count = best_for_N
    print(n, best_for_N)
best_count


# In[ ]:





# In[ ]:




