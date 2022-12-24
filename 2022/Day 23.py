#!/usr/bin/env python
# coding: utf-8

# In[128]:


import numpy as np
from aocd import get_data, submit 
data = get_data(year=2022, day=23)
data = data.split("\n")
data = np.array(list(map(list, data)))
data_to_elves = lambda data: list(zip(*map(list, np.where(data == "#"))))
elves = data_to_elves(data)


# In[109]:


def check_fields(elve, fields, elves_set):
    for f in fields:
        if (elve[0]+f[0], elve[1]+f[1]) in elves_set:
            return False
    return True

move_to = lambda elve, move: (elve[0]+move[0], elve[1]+move[1])
push_to_end_list = lambda x: x[1:] + [x[0]]


# In[110]:


orig_directions = [ 
    ((-1,-1), (-1,0), (-1,1)),
    ((1,1), (1,0), (1,-1)),
    ((-1,-1), (0,-1), (1,-1)),
    ((-1,1), (0,1), (1,1))
]
orig_moves = [(-1,0), (1,0), (0,-1), (0,1)]


surrounding_fields = [(-1,-1),(-1,0),(-1,1),(0,1),(1,1),(1,0),(1,-1),(0,-1)]


# In[121]:


def get_empty_fields(elves):
    min_x = min([x for x,y in elves])
    max_x = max([x for x,y in elves])
    min_y = min([y for x,y in elves])
    max_y = max([y for x,y in elves])

    return (max_x - min_x + 1) * (max_y - min_y + 1) - len(elves) 


# In[124]:


directions = orig_directions[:]
moves = orig_moves[:]
elves = data_to_elves(data)


print_debug = lambda p=None: None
answer_a = 0
answer_b = 0

for i in range(1000):
    if i % 100 == 0: 
        print(i)
    if i == 10:
        answer_a = get_empty_fields(elves)
    print_debug(f"*** ROUND {i} ***")
#     print_field(elves, tuple(data.shape))
    new_locations = []
    collisions = set()
    elves_set = set(elves)
    new_elves_set = set()
    has_converged = True
    for elve in elves:
        if check_fields(elve, surrounding_fields, elves_set):
            print_debug(f"Elve {elve} is clear, not moving")
            new_locations.append(elve)
            new_elves_set.add(elve)
            continue
        has_converged = False
        for direction, move in zip(directions, moves):
            
            if check_fields(elve, direction, elves_set):
                print_debug(f"Elve {elve} moving by {move}")
                new_loc = move_to(elve, move)
                new_locations.append(new_loc)
                if new_loc in new_elves_set:
                    collisions.add(new_loc)
                new_elves_set.add(new_loc)
                break
        else:
            print_debug(f"Elve {elve} can't move in any direction....")
            new_locations.append(elve)
            new_elves_set.add(elve)

    elves = [(new if new not in collisions else old) for new, old in zip(new_locations, elves)]
    
    directions = push_to_end_list(directions)
    moves = push_to_end_list(moves)
    
    
    if has_converged: 
        print(f"Converged after {i+1} rounds!")
        answer_b = i+1
        break



# In[125]:


submit(answer_a, year=2022, day=23, part="a")


# In[127]:


submit(answer_b, year=2022, day=23, part="b")


# In[ ]:




