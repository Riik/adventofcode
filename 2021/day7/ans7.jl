### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 934a24e0-572d-11ec-1b99-3b3209e25e5b
using Statistics

# ╔═╡ b0b49dac-e4b3-4548-8616-e4440764d409
data = open("input.txt", "r") do f
	read(f, String)
end

# ╔═╡ 47b16d41-0e06-40b5-a1a0-6824872aa2a3
input = parse.(Int, split(data, ",", keepempty=false))

# ╔═╡ a55a3b5c-8847-4c25-a80e-21301d8b7922
ans1 = sum(abs.(input .- median(input)))

# ╔═╡ 6a1f0957-2463-46e6-a9fd-9fb6d2d0584f
cost(n) = div(n*n+abs(n), 2)

# ╔═╡ fd70fec9-b64e-4d02-b18e-04edd0b706c9
total_cost(x, a) = sum(cost.(x.-a))

# ╔═╡ 32460b3f-7e88-4c25-9bf8-123ee85ace5e
cost_sweep = map(a -> total_cost(input, a), 1:1000)

# ╔═╡ c76a4cc4-58f0-40b5-b7bd-cecb8d5b880d
ans2, best_pos = findmin(cost_sweep)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ Cell order:
# ╠═934a24e0-572d-11ec-1b99-3b3209e25e5b
# ╠═b0b49dac-e4b3-4548-8616-e4440764d409
# ╠═47b16d41-0e06-40b5-a1a0-6824872aa2a3
# ╠═a55a3b5c-8847-4c25-a80e-21301d8b7922
# ╠═6a1f0957-2463-46e6-a9fd-9fb6d2d0584f
# ╠═fd70fec9-b64e-4d02-b18e-04edd0b706c9
# ╠═32460b3f-7e88-4c25-9bf8-123ee85ace5e
# ╠═c76a4cc4-58f0-40b5-b7bd-cecb8d5b880d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
