#!/usr/bin/env python
# coding: utf-8

# In[1]:


get_ipython().run_line_magic('pip', 'install tqdm ipywidgets')


# In[2]:


import re
from aocd import get_data, submit 
from dataclasses import dataclass
from datetime import datetime 


# In[17]:


import numpy as np
data = """Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.
Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian."""
data = get_data(year=2022, day=19)
data = data.split("\n")
data = [list(map(int, re.findall(r"( [\d]* )", line))) for line in data]
data = [(
        (d[0], 0, 0, 0),
        (d[1], 0, 0, 0),
        (d[2], d[3], 0, 0),
        (d[4], 0, d[5], 0)) for d in data]


# In[19]:


# 10x speed improvement over numpy approach 
def buy_options(bp, m):
    return ((m[0] - bp[0][0] >= 0),
            (m[0] - bp[1][0] >= 0),
            (m[0] - bp[2][0] >= 0) and (m[1] - bp[2][1] >= 0),
            (m[0] - bp[3][0] >= 0) and (m[2] - bp[3][2] >= 0))

# 30x speed improvement over np.all(x >= 0)
all_nonnegative = lambda x: (x[0] >= 0) and (x[1] >= 0) and (x[2] >= 0) and (x[3] >= 0)


# In[20]:


produce = lambda b, m: (m[0]+b[0], m[1]+b[1], m[2]+b[2], m[3]+b[3])
add_bot = lambda bots, idx: tuple((b+1 if idx==i else b) for i, b in enumerate(bots))


# In[21]:


buy_bot = lambda bp, m, idx: (m[0]-bp[idx][0], m[1]-bp[idx][1], m[2]-bp[idx][2], m[3]-bp[idx][3])


# In[22]:


is_better_money = lambda a, b: False if a == b else ((a[0] >= b[0]) and (a[1] >= b[1]) 
                                                        and (a[2] >= b[2]) and (a[3] >= b[3]))


# In[23]:


is_better_money((8,4,0,0),(8,4,0,0))


# In[24]:


is_dumb_state_heuristic = lambda b: (b[0] > 10) or (b[1] > 10)


# In[42]:


from tqdm import tqdm
def find_max_geodes(bp, print_debug=True):
    states = set([
        ((1, 0, 0, 0), (0, 0, 0, 0), (0, 0, 0, 0))
    ])
    new_best_money_per_bots = {(1,0,0,0): (-1,-1,-1,-1)}
    max_obsidian_bots = 0
    max_geode_bots = 0
    for i in range(32):
        best_money_per_bots = new_best_money_per_bots.copy()
        new_states = set()
        for state in tqdm(states): 
#         for state in states: 
            bots, money, prev_buy_options = state
            
            if is_better_money(best_money_per_bots[bots], money):
                continue
                
            if ( (max_obsidian_bots // 2) > bots[2] ):
                continue
            if ( (max_geode_bots // 2) > bots[3] ):
                continue
#             if i >= 27:
#                 if ( (max_geode_bots * 3 // 4) > bots[3] ):
#                     continue
                
#             if is_dumb_state_heuristic(bots):
#                 continue
                
            options = buy_options(bp, money)
            money = produce(bots, money)
            new_money = [money]
            new_bots = [bots]
            new_prev_buy_options = [options]
            
            if bots[2] > max_obsidian_bots:
                max_obsidian_bots = bots[2]
            if bots[3] > max_geode_bots:
                max_geode_bots = bots[3]
            
            if not options == prev_buy_options:
                for idx, option in enumerate(options):
                    if option: 
                        bots_option = add_bot(bots, idx)
                        money_option = buy_bot(bp, money, idx)
                        if bots_option in new_best_money_per_bots:
                            if is_better_money(money_option, new_best_money_per_bots[bots_option]):
                                new_best_money_per_bots[bots_option] = money_option
                        else:
                            new_best_money_per_bots[bots_option] = money_option
                        new_money.append(money_option)
                        new_bots.append(bots_option)
                        new_prev_buy_options.append((-1, -1, -1, -1))
            new_states.update([(b,m, opt) for b, m, opt in zip(new_bots, new_money, new_prev_buy_options)])
        states = new_states
        if print_debug:
            
            print(f"{datetime.now()} -- {i}: {len(states)} state{'s' if len(states) > 1 else ''}. Max obs. bots: {max_obsidian_bots}. Max geo. bots: {max_geode_bots}")

    geodes = [s[1][3] for s in states]
    return states, max(geodes)

bp = data[1]

# states, g = find_max_geodes(bp)
g


# In[43]:


from tqdm import tqdm
geodes = []
print_debug = True
for idx, bp in tqdm(enumerate(data[:3])):
    print(f"Blueprint {idx}: {bp}")
    _, g = find_max_geodes(bp, print_debug)
    print(g)
    geodes.append(g)
    
print(sum(geodes))


# In[44]:


np.sum(np.array(geodes) * (np.arange(len(geodes)) + 1))


# In[45]:


geodes


# In[46]:


np.product(geodes)


# In[ ]:


# extreme pruning [11, 21, 17]

