#!/usr/bin/env python
# coding: utf-8

# In[133]:


challenge_day = 5
from aocd import get_data, submit
data = get_data(year=2022, day=challenge_day).split("\n\n")
# data = """    [D]    
# [N] [C]    
# [Z] [M] [P]
#  1   2   3 

# move 1 from 2 to 1
# move 3 from 1 to 3
# move 2 from 2 to 1
# move 1 from 1 to 2""".split("\n\n")


# In[134]:


crates = data[0]
crates= crates.split("\n")
# parse crate locations
crates = [[crate[i:i+4].strip() for i in range(0, len(crate)+1, 4)] for crate in crates]
# throw out number stack 
crates = crates[:-1]
# start from bottom
crates = list(reversed(crates))
crates


# In[135]:


def parse_crates(crates):
    new_crates = {}
    for layer in crates:
        for i, item in enumerate(layer):
            if i in new_crates:
                new_crates[i].append(item)
            else:
                new_crates[i] = [item]
    for i in new_crates:
        while not (new_crates[i][-1]):
            new_crates[i].pop()
    return new_crates


# In[136]:


new_crates = parse_crates(crates)
new_crates


# In[137]:


moves = data[1]
new_crates = parse_crates(crates)
moves = [list(map(int, move.split(" ")[1::2])) for move in moves.split("\n")]
for n, a, b in moves: 
    a, b = int(a) - 1, int(b) - 1
    for i in range(n):
        item = new_crates[a].pop()
        new_crates[b].append(item)
new_crates


# In[138]:


def get_answer(crates):
    answer = ""
    for key in crates:
        item = crates[key][-1].replace("[", "").replace("]", "")
        answer += item
    return answer
answer = get_answer(new_crates)
answer


# In[139]:


submit(answer, year=2022, day=5, part="a")


# In[140]:


moves = data[1]
new_crates = parse_crates(crates)
moves = [list(map(int, move.split(" ")[1::2])) for move in moves.split("\n")]
for n, a, b in moves: 
    a, b = int(a) - 1, int(b) - 1
    
    items = new_crates[a][-n:]
    new_crates[b].extend(items)
    for i in range(n):
        new_crates[a].pop()
new_crates


# In[141]:


answer = get_answer(new_crates)
answer


# In[142]:


submit(answer, year=2022, day=5, part="b")


# In[ ]:




