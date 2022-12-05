#!/usr/bin/env python
# coding: utf-8

# In[3]:


from aocd import get_data, submit


# In[5]:


data = get_data(year=2022, 
                day=1)


# In[16]:


import numpy as np
food_per_elve = data.split("\n\n")
food_per_elve = [list(map(int, f.split("\n"))) for f in food_per_elve]
food_per_elve


# In[24]:


calories = []
for food_list in food_per_elve:
    total = np.sum(food_list)
    calories.append(total)
calories.sort()
max_calories = calories[-1]


# In[20]:


submit(max_cal, part="a", day=1, year=2022)


# In[27]:


top_three = np.sum(calories[-3:])
top_three


# In[28]:


submit(top_three, part="b", day=1, year=2022)


# In[ ]:




