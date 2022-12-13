#!/usr/bin/env python
# coding: utf-8

# In[149]:


from aocd import get_data, submit
data = get_data(year=2022, day=13)
data = data.split("\n\n")
data = [d.split("\n") for d in data]
data = [(eval(left), eval(right)) for left, right in data]


# In[150]:


DEBUG = 0
def print_debug(p):
    if DEBUG:
        print(p)

def compare(left, right):
    for l, r in zip(left, right):
        if isinstance(l, int) and isinstance(r, int):
            print_debug(f"{l} and {r} are both ints")
            if l == r: 
                print_debug("Equal, continue to next item")
                continue
            print_debug(f"Returning {l-r}")
            return l - r
        if isinstance(l, list) and isinstance(r, int):
            print_debug(f"{l} is a list, converting {r} to list")
            if not (c := compare(l, [r])): 
                continue
            return c
        if isinstance(l, int) and isinstance(r, list):
            print_debug(f"Convertin {l} to a list and {r} is a list")
            if not (c := compare([l], r)): 
                continue
            return c
        if isinstance(l, list) and isinstance(r, list):
            print_debug(f"{l} and {r} are both list")
            if not (c := compare(l, r)): 
                continue
            return c
    print_debug(f"Ran out of elements, checking length of {left} and {right}")
    print_debug(f"Returning {len(left) - len(right)}")
    return len(left) - len(right)


# In[151]:


result = []
i = 1
for l,r in data:
    print_debug(f"\n{i}")
    result.append(compare(l,r))
    i += 1


# In[152]:


import numpy as np
answer = np.sum(np.where(np.array(result) < 0)[0] + 1)
answer


# In[153]:


submit(answer, year=2022, day=13, part="a")


# In[154]:


from functools import cmp_to_key
compare_key = cmp_to_key(compare)

dividers = [[[2]], [[6]]]

flat_data = list(sum(data.copy(), ()))
flat_data.extend(dividers)
flat_data.sort(key=compare_key)


# In[155]:


indices = []
for i, d in enumerate(flat_data):
    if d in dividers:
        indices.append(i+1)
answer = np.product(indices)
answer


# In[156]:


submit(answer, year=2022, day=13, part="b")

