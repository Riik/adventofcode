### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 7f9b30a8-5c53-11ec-12f1-3f86097a9eff
data = open("test_input.txt") do f 
	split.(split(read(f, String), "\n", keepempty=false), "-")
end

# ╔═╡ 9473bbb0-661e-4711-8393-c63b190f4641
nodes = unique(vcat(data...))

# ╔═╡ c82015cc-7fe8-4213-98c2-995700c075d4
visit_dict = Dict(zip(nodes, zeros(length(nodes))))

# ╔═╡ 1cc01c71-16c0-4886-a024-75bb478eeaa5
function create_dict(data)
	links = Dict
	for d in data
		links[d[1]] = append!([d[2]], links[d[1]])
	end
	return links
end

# ╔═╡ 9b23d665-b94d-46f0-8da1-00dbcde4e91e
create_dict(data)

# ╔═╡ Cell order:
# ╠═7f9b30a8-5c53-11ec-12f1-3f86097a9eff
# ╠═9473bbb0-661e-4711-8393-c63b190f4641
# ╠═c82015cc-7fe8-4213-98c2-995700c075d4
# ╠═1cc01c71-16c0-4886-a024-75bb478eeaa5
# ╠═9b23d665-b94d-46f0-8da1-00dbcde4e91e
