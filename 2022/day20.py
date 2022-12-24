#!/usr/bin/env python
# coding: utf-8

# In[72]:


import numpy as np
from aocd import get_data, submit 

data = """1
2
-3
3
-2
0
4"""
data = get_data(year=2022, day=20) 
print(len(data.split("\n")))

data = list(map(int, data.split("\n")))
data = np.array(data)


# In[73]:


data[np.abs(data) > len(data)]


# In[121]:


print_debug = lambda p=None: None

import numpy as np
def encrypt(data, indices):
    data_list = np.array(data.copy())
    N = len(data)
    for idx, val in enumerate(data):
        data_idx = np.where(np.array(indices) == idx)[0][0]
        value = data_list[data_idx]
        print_debug(f"input: {data_list}")
        print_debug(f"Move '{value}' {value} steps")
        updated_idx = (data_idx + value)
        if value == 0: 
            continue 
        updated_idx %= (N-1)

        a, b = sorted([updated_idx, data_idx])
        if updated_idx > data_idx:
            data_list[a:b+1] = np.concatenate((data_list[a+1:b+1], [data_list[data_idx]]))
            indices[a:b+1] = np.concatenate((indices[a+1:b+1], [indices[data_idx]]))
        else:
            data_list[a:b+1] = np.concatenate(([data_list[data_idx]], data_list[a:b]))
            indices[a:b+1] = np.concatenate(([indices[data_idx]], indices[a:b]))
        print_debug(f"output: {data_list}")
        print_debug()

    return data_list, indices


# In[130]:


data_list, _ = encrypt(data, np.arange(len(data)))
def get_answer(data_list):
    N = len(data_list)
    zero_value_idx = np.where(data_list == 0)[0][0]
    return data_list[(1000 + zero_value_idx) % N] + data_list[(2000 + zero_value_idx) % N] + data_list[(3000 + zero_value_idx) % N]

answer = get_answer(data_list)
answer


# In[131]:


submit(answer, year=2022, day=20, part="a")


# In[133]:


decryption_key = 811589153
keyed_data = data*decryption_key
indices = np.arange(len(keyed_data))
for i in range(10):
    keyed_data, indices = encrypt(keyed_data, indices)
answer = get_answer(keyed_data)
answer


# In[134]:


submit(answer, year=2022, day=20, part="b")


# In[ ]:




