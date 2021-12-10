### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ b0530be7-f27e-43f7-9f6c-712e60ae297a
using IterTools, DataStructures

# ╔═╡ f911b408-58ce-11ec-179a-f7e15bda51ec
data = open("input.txt") do f
	parse.(Int, hcat(collect.(split(read(f, String), "\n", keepempty=false))...))
end

# ╔═╡ 551dc511-98db-42b0-b5e8-d0377199bd8e
w, h = size(data)

# ╔═╡ c73a6f7c-deee-434a-a6d8-09b49a4a3e75
begin
	down = vcat(data[2:end, :], 100*ones(1,h))
	up = vcat(100*ones(1,h), data[1:end-1, :])
	right = hcat(data[:, 2:end], 100*ones(w,1))
	left = hcat(100*ones(w,1), data[:, 1:end-1])
end

# ╔═╡ c3cdc857-5b25-4630-ae79-9e3830e190b7
neighbours = [up, down, left, right]

# ╔═╡ 96495c3d-7a78-4c88-9420-6a83c4a9d67c
locations, minima = findmin(cat(neighbours..., dims=3), dims=3)

# ╔═╡ 87729d99-9c1e-4d0f-aba8-5f8dc7ad81a2
lowest_neighbours = dropdims(locations, dims=3)

# ╔═╡ 010f8e3f-0313-4680-874a-0b6ab875994d
ans1 = sum((data .< lowest_neighbours).*(data.+1))

# ╔═╡ a4fc8b12-4a82-4410-9a78-38a6482ed310
low_points = map(c -> (c[1], c[2]), findall(data .< lowest_neighbours))

# ╔═╡ 04ed0d18-fbd3-4ffc-b3a1-53806e9d11ee
lowest_neighbor_directions = map(c -> c[3], dropdims(minima, dims=3))

# ╔═╡ fe6086d1-c052-40f2-9579-1ca2fc0cc5d6
directions = Dict(1=>(-1,0), 2=>(1, 0), 3=>(0,-1), 4=>(0,1))

# ╔═╡ 42924da4-bd53-4999-8016-fac19c4f3494
function flow_down(y,x)
	if data[y,x] == 9
		return (0,0)
	end
	dir = directions[lowest_neighbor_directions[y,x]]
	if (y,x) in low_points
		return (y,x)
	else
		x+=dir[2]
		y+=dir[1]
		flow_down(y,x)
	end
end

# ╔═╡ 8074c8eb-82b0-46a5-bf1c-325c07b66fc6
begin
	basin_sizes = Dict(zip(low_points, zeros(length(low_points))))
	basin_sizes[(0,0)] = 0
end

# ╔═╡ f022dd5c-bd36-4912-99f7-632a21f3fa4b
basins = map(x -> flow_down(x[1], x[2]), collect(product(1:w, 1:h)))

# ╔═╡ 9f969c6e-3845-4f90-b986-0a9ebadb1e7f
basin_counts = counter(basins)

# ╔═╡ 0fb5755b-8f82-4cf9-8642-fdede742c12d
real_basin_sizes = map(c -> basin_counts[c], low_points)

# ╔═╡ dc9efc9d-ed9d-4177-80c0-509f761380cc
ans2 = prod(sort(real_basin_sizes, rev=true)[1:3])

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataStructures = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"

[compat]
DataStructures = "~0.18.11"
IterTools = "~1.4.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "dce3e3fea680869eaa0b774b2e8343e9ff442313"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.40.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═b0530be7-f27e-43f7-9f6c-712e60ae297a
# ╠═f911b408-58ce-11ec-179a-f7e15bda51ec
# ╠═551dc511-98db-42b0-b5e8-d0377199bd8e
# ╠═c73a6f7c-deee-434a-a6d8-09b49a4a3e75
# ╠═c3cdc857-5b25-4630-ae79-9e3830e190b7
# ╠═96495c3d-7a78-4c88-9420-6a83c4a9d67c
# ╠═87729d99-9c1e-4d0f-aba8-5f8dc7ad81a2
# ╠═010f8e3f-0313-4680-874a-0b6ab875994d
# ╠═a4fc8b12-4a82-4410-9a78-38a6482ed310
# ╠═04ed0d18-fbd3-4ffc-b3a1-53806e9d11ee
# ╠═fe6086d1-c052-40f2-9579-1ca2fc0cc5d6
# ╠═42924da4-bd53-4999-8016-fac19c4f3494
# ╠═8074c8eb-82b0-46a5-bf1c-325c07b66fc6
# ╠═f022dd5c-bd36-4912-99f7-632a21f3fa4b
# ╠═9f969c6e-3845-4f90-b986-0a9ebadb1e7f
# ╠═0fb5755b-8f82-4cf9-8642-fdede742c12d
# ╠═dc9efc9d-ed9d-4177-80c0-509f761380cc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
