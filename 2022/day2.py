#!/usr/bin/env python
# coding: utf-8

# In[3]:


from aocd import get_data, submit


# In[4]:


convert = lambda inputs: [(ord(c) - ord('A')) % (ord('X') - ord('A')) for c in inputs]


# In[12]:


data = get_data(year=2022, day=2).split("\n")
data = [d.split(" ") for d in data]
left, right = zip(*data)
left = convert(left)
right = convert(right)
data


# In[14]:


points_map = {
    0: 3, # tie 
    1: 0, # loss
    2: 6 # win
}


# In[15]:


get_points_games = lambda left, right: sum([points_map[(l-r)%3] for l, r in zip(left, right)])
get_points_plays = lambda plays: sum(plays) + len(plays)


# In[16]:


total_points = get_points_games(left, right) + get_points_plays(right)
total_points


# In[17]:


submit(total_points, year=2022, day=2, part="a")


# In[21]:


reaction_play = [(l+(r-1))%3 for l, r in zip(left, right)]


# In[20]:


total_points = get_points_games(left, reaction_play) + get_points_plays(reaction_play)
total_points


# In[22]:


submit(total_points, year=2022, day=2, part="b")


# In[ ]:




