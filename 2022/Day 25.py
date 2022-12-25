#!/usr/bin/env python
# coding: utf-8

# In[68]:


from aocd import get_data, submit
data = get_data(year=2022, day=25)
data = data.splitlines()


# In[69]:


s = {
    "2": 2, 
    "1": 1, 
    "0": 0, 
    "-": -1,
    "=": -2
}
s_inv = {v: k for k, v in s.items()}
s_inv


# In[70]:


def snafu_add_single(left, right):
    l = s[left]
    r = s[right]
    
    total = l + r
    remainder = 0
    if total > 2:
        total -= 5
        remainder = 1
    if total < -2:
        total += 5
        remainder = -1
    
    total = s_inv[total]
    remainder = s_inv[remainder]
    
    return remainder, total


# In[72]:


assert snafu_add_single("=", "-") == ("-", "2")


# In[89]:


from itertools import zip_longest

def snafu_add(a, b, verbose=False):
    print_debug = lambda p = None: print(p) if verbose else None
    
    print_debug(f"Adding {a} and {b}")
    remainder = "0"
    answer = ""
    for l, r in zip_longest(reversed(list(a)), reversed(list(b)), fillvalue="0"):
        print_debug(f"Adding left {l} with remainder {remainder}")
        remainder_a, l = snafu_add_single(l, remainder)
        print_debug(f"Remainder a is {remainder_a}")
        print_debug(f"New left is {l}")
        print_debug(f"Adding right {r}")
        remainder_b, total = snafu_add_single(l, r)
        print_debug(f"Remainder b is {remainder_b}")
        print_debug(f"Value is {total}")
        remainder_remainder, remainder = snafu_add_single(remainder_a, remainder_b)
        print_debug(f"Final remainder is {remainder}")
        print_debug("\n")

        if remainder_remainder != "0":
            raise ValueError
            
        answer += total

    if remainder != "0":
        answer += remainder
        
    answer = "".join(reversed(answer))
    print_debug(f"Answer is {answer}")

    return answer


# In[90]:


a = "1=0"
b = "1-0"

res = "120"

assert snafu_add(a, b, verbose = True) == res


# In[92]:


from functools import reduce

answer = reduce(snafu_add, data)


# In[93]:


submit(answer, year=2022, day=25, part="a")


# In[ ]:




