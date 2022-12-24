#!/usr/bin/env python
# coding: utf-8

# In[1]:


get_ipython().run_line_magic('pip', 'install sympy')


# In[2]:


from aocd import get_data, submit 
data = get_data(year=2022, day=21)
data = data.split("\n")
data = [d.split(":") for d in data]
data = {key: value.strip() for key, value in data}


# In[3]:


from functools import lru_cache

def do_maths(a, operand, b):
    if operand == "*":
        return a * b
    if operand == "/":
        return a / b
    if operand == "+":
        return a + b
    if operand == "-":
        return a - b

@lru_cache(None)
def resolve(key: str):
    value = data[key]
    if key == "humn":
        return (int(value), "humn")
    try:
        value = int(value)
        return (value, "")
    except ValueError:
        a, operand, b = value.split(" ")

        a = resolve(a)
        b = resolve(b)
        
        if key == "root":
            if a[1]:
                return (do_maths(a[0], operand, b[0]), f"({a[1]}) == {b[0]}")
            else:
                return (do_maths(a[0], operand, b[0]), f"({b[1]}) == {a[0]}")
        
        if a[1]:
            return(do_maths(a[0], operand, b[0]), f"({a[1]}) {operand} {b[0]}")
        if b[1]:
            return(do_maths(a[0], operand, b[0]), f"{a[0]} {operand} ({b[1]})")
        
        return (do_maths(a[0], operand, b[0]), "")
        

    


# In[4]:


value, expr = resolve("root")
answer = int(value)
answer


# In[5]:


submit(answer, year=2022, day=21, part="a")


# In[6]:


import sympy as sym
from sympy.solvers import solve
humn = sym.Symbol('humn')
left_side, right_side = expr.split("==")
zero_expr = f"{left_side} - {right_side}"
sym_expr = eval(zero_expr)
sym_expr


# In[7]:


answer = int(list(sym.solveset(zero_expr))[0])
answer


# In[8]:


submit(answer, year=2022, day=21, part="b")

