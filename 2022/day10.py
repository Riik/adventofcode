#!/usr/bin/env python
# coding: utf-8

# In[ ]:


get_ipython().run_line_magic('pip', 'install matplotlib')


# In[139]:


from aocd import get_data, submit
data = get_data(year=2022, day=10).splitlines()
data = [d.split(" ") for d in data]


# In[141]:


x = 1
values = []
for d in data:
    if d[0] == "noop":
        values.append(x)
    elif d[0] == "addx":
        values.append(x)        
        values.append(x)
        x += int(d[1])
    else:
        raise ValueError(d)


# In[142]:


signal_strength = lambda values, i: i * values[i-1]
indices = [20, 60, 100, 140, 180, 220]
indices = [i for i in indices]


# In[129]:


[values[i] for i in indices]


# In[143]:


answer = sum(signal_strength(values, i) for i in indices)
answer


# In[145]:


submit(answer, year=2022, day=10, part="a")


# In[146]:


get_pixel = lambda x,i: 1 if x-(i%40) in [-1, 0, 1] else 0


# In[147]:


import numpy as np
import matplotlib.pyplot as plt
screen = np.array([get_pixel(x,i) for x, i in zip(values, range(len(values)))])
screen = np.reshape(screen, (-1, 40))
plt.imshow(screen)


# In[148]:


answer = "ZFBFHGUP"


# In[149]:


submit(answer, year=2022, day=10, part="b")

