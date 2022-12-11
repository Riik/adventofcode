#!/usr/bin/env python
# coding: utf-8

# In[195]:


from aocd import get_data, submit
data = get_data(year=2022, day=11).split("Monkey")[1:]
from dataclasses import dataclass
d = data[0]
d.split("/n")


# In[196]:


@dataclass 
class Monkey:
    monkey: int
    items: list
    operation: str
    test_div: int
    if_true: int
    if_false: int
    handle_count: int = 0


# In[197]:


def parse_monkey(d):
    d = d.split("\n")
    monkey = int(d[0].split(":")[0].strip())
    items = list(map(int, d[1].split(":")[1].split(",")))
    operation = d[2].split("=")[-1].strip()
    test_div = int(d[3].split(" ")[-1])
    if "divisible" not in d[3]:
        raise ValueError(d)
    if_true = int(d[4].split(" ")[-1])
    if_false = int(d[5].split(" ")[-1])
    return Monkey(monkey, items, operation, test_div, if_true, if_false)


# In[198]:


parse_monkey(data[0])


# In[199]:


def execute_operation(op_str, old):
    a, op, b = op_str.split(" ")
    a = old if a == "old" else int(a)
    b = old if b == "old" else int(b)
    if op == "*":
        return a*b
    elif op == "+":
        return a+b
    else:
        ValueError("unknown operand")


# In[207]:


def evaluate_monkeys(monkeys, reduce_function):
    for m in monkeys:
        m.handle_count += len(m.items)
        for item in m.items:
            item = execute_operation(m.operation, item)
            item = reduce_function(item)
            if item % m.test_div == 0:
                monkeys[m.if_true].items.append(item)
            else:
                monkeys[m.if_false].items.append(item)
        m.items = []
    return monkeys


# In[209]:


n_rounds = 20
reduce_function = lambda x: x // 3
monkeys = [parse_monkey(d) for d in data]
for i in range(n_rounds):
    monkeys = evaluate_monkeys(monkeys, reduce_function)
    
monkeys


# In[210]:


def get_answer(monkeys):
    handle_counts = [m.handle_count for m in monkeys]
    handle_counts.sort()
    return handle_counts[-1] * handle_counts[-2]

answer = get_answer(monkeys)
answer


# In[211]:


submit(answer, year=2022, day=11, part="a")


# In[205]:


def evaluate_monkeys(monkeys, divisor):
    for m in monkeys:
        m.handle_count += len(m.items)
        for item in m.items:
            item = execute_operation(m.operation, item)
            item %= divisor
            if item % m.test_div == 0:
                monkeys[m.if_true].items.append(item)
            else:
                monkeys[m.if_false].items.append(item)
        m.items = []
    return monkeys


# In[206]:


import numpy as np 
monkeys = [parse_monkey(d) for d in data]
divs = [m.test_div for m in monkeys]
divisor = np.product(divs)
divisor


# In[192]:


n_rounds = 10000
monkeys = [parse_monkey(d) for d in data]
print_i = [1, 20, 1000, 2000]
for i in range(n_rounds):
    if i in print_i:
        print("\n")
        print(i)
        print([m.handle_count for m in monkeys])
    monkeys = evaluate_monkeys(monkeys, divisor)
    
monkeys


# In[193]:


answer = get_answer(monkeys)
answer


# In[194]:


submit(answer, year=2022, day=11, part="b")


# In[ ]:




