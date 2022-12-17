#!/usr/bin/env python
# coding: utf-8

# In[192]:


from aocd import get_data, submit
import numpy as np
np.set_printoptions(edgeitems=30)

data = get_data(year=2022, day=17)
# data = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"
data = list(data)

shapes = [
    np.flipud(np.array([
        [0, 0, 0, 0],        
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 1, 1, 1]
    ])),
    np.flipud(np.array([
        [0, 0, 0],        
        [0, 1, 0],
        [1, 1, 1],
        [0, 1, 0]
    ])),
    np.flipud(np.array([
        [0, 0, 0],        
        [0, 0, 1],
        [0, 0, 1],
        [1, 1, 1]
    ])),
    np.flipud(np.array([
        [1],        
        [1],
        [1],
        [1]
    ])),
    np.flipud(np.array([
        [0, 0],        
        [0, 0],
        [1, 1],
        [1, 1]
    ]))]


# In[193]:


def can_move(field, shape, x, y):
    if x + shape.shape[1] > 7:
        return False
    if x < 0:
        return False
    try:
        data = field[y:y+4, x:x+shape.shape[1]]*shape
        return np.sum(np.sum(data)) == 0
    except ValueError:
        return False
    

def draw_field(field, shape, x, y):
    f = field.copy()
    f[y:y+4, x:x+shape.shape[1]] += shape  
    print()
    for row in np.flipud(f[:20,:]):
        print("|", end="")
        for c in row:
            if c:
                print("#", end="")
            else:
                print(".", end="")
        print("|")
    print("+-------+")
    


# In[226]:


field = np.zeros((20000, 7)).astype("int")

shape_i = 0
shape = shapes[0]
tower_tops = []
tower_top = 0
y = tower_top+3
x = 2
i = 0
while shape_i < 10000:
    move = data[i%len(data)]
    i += 1
    
    try_x = x + 1 if move == '>' else x - 1
    if can_move(field, shape, try_x, y):
        x = try_x
        
    try_y = y - 1
    if can_move(field, shape, x, try_y):
        y = try_y
    else:
        field[y:y+4, x:x+shape.shape[1]] += shape  
        while np.sum(field[tower_top, :]) > 0:
            tower_top += 1
        tower_tops.append(tower_top)
        
        y = tower_top+3
        x = 2
        shape_i += 1
        shape = shapes[shape_i%len(shapes)]

        
tower_top


# In[227]:


answer = tower_tops[2022 - 1]
answer


# In[228]:


submit(answer, year=2022, day=17, part="a")


# In[229]:


def guess_seq_len(tower_tops):
    guess = 1
    max_len = len(tower_tops) // 3
    for x in range(2, max_len):
        if (np.all(tower_tops[x:2*x] == tower_tops[2*x:3*x])
            and np.all(tower_tops[2*x:3*x] == tower_tops[3*x:4*x])
           ):
            return x

    return guess


# In[230]:


seq_len = guess_seq_len(np.diff(tower_tops))
seq_len


# In[231]:


rep_inc = tower_tops[2*seq_len] - tower_tops[seq_len]


# In[232]:


N = 1_000_000_000_000 - 1 # zero indexing thingy
remainder = N % seq_len
n_times = N // seq_len - 1 # first part is computed separately


# In[233]:


first_part = tower_tops[seq_len]
last_part = tower_tops[seq_len+remainder] - tower_tops[seq_len]


# In[235]:


answer = first_part + n_times * rep_inc + last_part
answer


# In[236]:


submit(answer, year=2022, day=17, part="b")

