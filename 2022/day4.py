#!/usr/bin/env python
# coding: utf-8

# In[48]:


challenge_day = 4
from aocd import get_data, submit
data = get_data(year=2022, day=challenge_day).split("\n")
pairs = [d.split(",") for d in data]


# In[49]:


def is_contained(a, b):
    a = list(map(int, a.split("-")))
    b = list(map(int, b.split("-")))
    if (a[0] >= b[0]) and (a[1] <= b[1]):
        return True
    if (b[0] >= a[0]) and (b[1] <= a[1]):
        return True
    return False


# In[38]:


is_contained(*pairs[0])


# In[43]:


answer = sum([is_contained(*pair) for pair in pairs])


# In[44]:


submit(answer, year=2022, day=challenge_day, part="a")


# In[54]:


def is_overlapping(a, b):
    a = list(map(int, a.split("-")))
    b = list(map(int, b.split("-")))
    if (a[0] <= b[1]) and (a[1] >= b[0]):
        return True
    if (b[0] <= a[1]) and (b[1] >= a[0]):
        return True
    return False


# In[55]:


answer = sum([is_overlapping(*pair) for pair in pairs])


# In[56]:


submit(answer, year=2022, day=challenge_day, part="b")


# In[ ]:




