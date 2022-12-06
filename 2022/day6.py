#!/usr/bin/env python
# coding: utf-8

# In[13]:


from aocd import get_data, submit 
data = get_data(year=2022, day=6)


# In[14]:


N = 4
answer = 0
for i in range(len(data) - N):
    if len(set(data[i:i+N])) == N:
        answer = i+N
        break
print(answer)


# In[15]:


submit(answer, year=2022, day=6, part="a")


# In[17]:


N = 14
answer = 0
for i in range(len(data) - N):
    if len(set(data[i:i+N])) == N:
        answer = i+N
        break
print(answer)


# In[18]:


submit(answer, year=2022, day=6, part="b")


# In[ ]:




