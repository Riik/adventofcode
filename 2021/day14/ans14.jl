### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ b89f6397-e31c-4f95-9dab-245785adac7d
using IterTools, DataStructures

# ╔═╡ 82714780-5cae-11ec-3a33-4d7682ea9c93
data = open("input.txt") do f 
	split(read(f, String), "\n\n")
end

# ╔═╡ 3030afb3-b9c1-443e-8418-2420b2e1baad
expand_insertion(a, b) = [string(a[1], b), string(b, a[2])]

# ╔═╡ ee23aead-219a-4b16-a7cf-922a47d7065d
reactions = split.(split(data[2], "\n", keepempty=false), " -> ")

# ╔═╡ 0ef37045-01fc-459c-af77-b3d09df4c5c0
translation = Dict(map(a -> (a[1], expand_insertion(a...)), reactions))

# ╔═╡ 955a3f11-6e21-408a-8314-a8b9eedaf4d7
translate(pair, value) = Dict(zip(translation[pair], value*ones(Int, 2)))

# ╔═╡ 95e0db13-0cf3-4683-87ff-fde1510bedca
window(x) = view.(Ref(x), (:).(1:length(x)-1,2:length(x)))

# ╔═╡ 64e0dcb9-eb53-4433-a563-d4a5b777bcdc
input = counter(window(data[1]))

# ╔═╡ ecdd4274-fea3-4839-ac99-13a229b00c7f
react(pair_counts) = merge(+, [translate(k,v) for (k,v) in pair_counts]...)

# ╔═╡ ddd33307-870f-4e6a-a706-0d217f871bac
get_char_counts(p, v) = p[1] == p[2] ? Dict(p[1] => 2*v) : Dict(zip(collect(p),v*ones(Int,2)))

# ╔═╡ b9398c55-c298-43b4-8270-335b5d599f6a
function synthesize(input, steps)
	result = nth(iterated(react, input), steps+1)
	doubled_char_counts = merge(+, [get_char_counts(k,v) for (k,v) in result]...)
	char_counts = convert.(Int, ceil.(values(doubled_char_counts) ./ 2))
	return char_counts
end

# ╔═╡ 73c2f3a8-2c76-4061-b082-6a976b53451a
let steps = 10
	char_counts = synthesize(input, steps)
	ans1 = maximum(values(char_counts)) - minimum(values(char_counts))
end

# ╔═╡ 26e835b5-715a-4c4e-b175-45420d091417
let steps = 40
	char_counts = synthesize(input, steps)
	ans1 = maximum(values(char_counts)) - minimum(values(char_counts))
end

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
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

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
# ╠═b89f6397-e31c-4f95-9dab-245785adac7d
# ╠═82714780-5cae-11ec-3a33-4d7682ea9c93
# ╠═64e0dcb9-eb53-4433-a563-d4a5b777bcdc
# ╠═3030afb3-b9c1-443e-8418-2420b2e1baad
# ╠═ee23aead-219a-4b16-a7cf-922a47d7065d
# ╠═0ef37045-01fc-459c-af77-b3d09df4c5c0
# ╠═955a3f11-6e21-408a-8314-a8b9eedaf4d7
# ╠═95e0db13-0cf3-4683-87ff-fde1510bedca
# ╠═ecdd4274-fea3-4839-ac99-13a229b00c7f
# ╠═ddd33307-870f-4e6a-a706-0d217f871bac
# ╠═b9398c55-c298-43b4-8270-335b5d599f6a
# ╠═73c2f3a8-2c76-4061-b082-6a976b53451a
# ╠═26e835b5-715a-4c4e-b175-45420d091417
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
