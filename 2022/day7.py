#!/usr/bin/env python
# coding: utf-8

# In[1]:


from aocd import get_data, submit
data = get_data(year=2022, day=7).splitlines()


# In[16]:


tree = {}
pwd = []
make_pwd = lambda pwd: "/" + "/".join(pwd)


for line in data:
    if line.startswith("$ cd"):
        if line == "$ cd /":
            pwd = []
            continue
        new_dir = line.split(" ")[2]
        if new_dir == "..":
            pwd.pop()
        else: 
            pwd.append(new_dir)        
    elif line.startswith("$ ls"):
        pass
    elif line.startswith("dir"):
        p = make_pwd(pwd)
        dir_name = line.split(" ")[1]
        dir_name = make_pwd(pwd + [dir_name])
        if p in tree:
            tree[p].append(dir_name)
        else: 
            tree[p] = [dir_name]
    else: 
        file_size, file_name = line.split(" ")
        file_size = int(file_size)
        if (p := make_pwd(pwd)) in tree:
            tree[p].append(file_size)
        else:
            tree[p] = [file_size]

import json
json.dumps(tree)


# In[17]:


folder_sizes = {}
def find_size_recursive(path):
    size = 0
    for file in tree[path]:
        if isinstance(file, str):
            size += find_size_recursive(file)
        else: 
            size += file
    folder_sizes[path] = size
    return size
find_size_recursive("/")

folder_sizes


# In[8]:


threshold = 100000
get_answer = lambda folder_sizes: sum(f for f in folder_sizes.values() if f <= 100000)
answer = get_answer(folder_sizes)
answer


# In[9]:


submit(answer, year=2022, day=7, part="a")


# In[12]:


used = folder_sizes["/"]
available_space = 70000000
needed_free =    30000000
target = available_space - needed_free
to_delete = used - target
to_delete


# In[13]:


size_list = list(zip(folder_sizes.keys(), folder_sizes.values()))
smallest = 1e9
best_dir = ""
for dir_name, size in size_list:
    if (size > to_delete) and (size < smallest):
        best_dir = dir_name
        smallest = size
best_dir, smallest


# In[18]:


folder_sizes


# In[14]:


submit(smallest, year=2022, day=7, part="b")


# In[19]:


sum = 3
sum([1,2,3,4])


# In[ ]:




