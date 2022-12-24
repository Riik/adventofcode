#!/usr/bin/env python
# coding: utf-8

# In[83]:


from aocd import get_data, submit
import numpy as np
data = get_data(year=2022, day=24)
data = data.split("\n")
data = np.array(list(map(list, data)))
data = data[1:-1, 1:-1]
get_blizzards = lambda data: {direction: list(zip(*map(list, np.where(data == direction)))) 
             for direction in ['>', 'v', '<', '^']}
blizzards = get_blizzards(data)
max_y, max_x = data.shape
endgoal = (max_y, max_x-1)


# In[84]:


moves = {
    '>': (0,1),
    'v': (1,0),
    '<': (0,-1),
    '^': (-1,0)
}

move_blizz = lambda b, m: ( (b[0]+m[0]) % max_y, (b[1]+m[1]) % max_x )


def move_blizzards(blizzards):
    new_blizzards = {}
    for direction, blizz in blizzards.items():
        m = moves[direction]
        new_blizzards[direction] = [move_blizz(b, m) for b in blizz]
    return new_blizzards

blizzards = get_blizzards(data)

blizzard_locations = lambda blizzards: set([b for blizz in blizzards.values() for b in blizz])

def get_player_locs(p):
    return [
        p, 
        (p[0]+1, p[1]),
        (p[0]-1, p[1]),        
        (p[0], p[1]-1),        
        (p[0], p[1]+1)
    ]

def is_valid_loc(p, blizz):
    if p == (-1, 0):
        return True
    if p == endgoal:
        return True
    if not 0 <= p[0] < max_y:
        return False
    if not 0 <= p[1] < max_x:
        return False
    if p in blizz:
        return False
    return True


# In[92]:


blizzards = get_blizzards(data)
blizz_locs = blizzard_locations(blizzards)

player_locs = set([(-1,0)])
reached_end = False
got_snacks = False
answer_a = 0

for i in range(1000):
    if i % 100 == 0:
        print(f"*** Minute {i} ***")
        print(f"No. states: {len(player_locs)}")
    blizzards = move_blizzards(blizzards)
    blizz_locs = blizzard_locations(blizzards)
    
    new_player_locs = set()
    for player_loc in player_locs:
        candidates = get_player_locs(player_loc)
        candidates = [c for c in candidates if is_valid_loc(c, blizz_locs)]
        new_player_locs.update(candidates)
    
    player_locs = new_player_locs
    if endgoal in player_locs and not reached_end:
        reached_end = True
        player_locs = set([endgoal])
        print("Reached goal!")
        if not got_snacks:
            answer_a = i + 1
    if (-1, 0) in player_locs and reached_end and not got_snacks:
        got_snacks = True
        player_locs = set([(-1,0)])
        print("Back home!")
    if endgoal in player_locs and got_snacks:
        print("Made it with the snacks!")
        break
answer = i + 1
answer


# In[90]:


submit(answer_a, year=2022, day=24, part="a")


# In[91]:


submit(answer, year=2022, day=24, part="b")

