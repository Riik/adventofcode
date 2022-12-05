#!/usr/bin/env python
# coding: utf-8

# In[1]:


from aocd import get_data, submit 


# In[18]:


data = get_data(year=2022, day=3).split("\n")
double_elements = [list(set(d[:len(d)//2]) & set(d[len(d)//2:]))[0]  for d in data]


# In[47]:


def priority_mapping(c):
    if ord(c) >= ord('a'):
        return ord(c) - ord('a') + 1
    else:
        return ord(c) - ord('A') + 26 + 1


# In[54]:


total_prio = sum(priority_mapping(i) for i in double_elements)


# In[55]:


submit(total_prio, year=2022, day=3, part="a")


# In[68]:


groups = list(zip(*(iter(data),) * 3))
def get_common_element(group):
    return list(set(group[0]) & set(group[1]) & set(group[2]))[0]
badges = [get_common_element(g) for g in groups]

total_prio = sum(priority_mapping(i) for i in badges)


# In[69]:


submit(total_prio, year=2022, day=3, part="b")


# In[ ]:




