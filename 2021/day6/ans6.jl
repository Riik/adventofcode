### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 8c0552e5-4713-4054-92d9-cc59012801a6
using IterTools, PlutoUI

# ╔═╡ 1b173192-be44-450b-9995-8d55af4555d5
parse_input(text) = parse.(Int, split(text, ","))

# ╔═╡ ee9b9bcc-5684-11ec-268f-09e7de0e01e3
data = "5,1,1,4,1,1,4,1,1,1,1,1,1,1,1,1,1,1,4,2,1,1,1,3,5,1,1,1,5,4,1,1,1,2,2,1,1,1,2,1,1,1,2,5,2,1,2,2,3,1,1,1,1,1,1,1,1,5,1,1,4,1,1,1,5,4,1,1,3,3,2,1,1,1,5,1,1,4,1,1,5,1,1,5,1,2,3,1,5,1,3,2,1,3,1,1,4,1,1,1,1,2,1,2,1,1,2,1,1,1,4,4,1,5,1,1,3,5,1,1,5,1,4,1,1,1,1,1,1,1,1,1,2,2,3,1,1,1,1,1,2,1,1,1,1,1,1,2,1,1,1,5,1,1,1,1,4,1,1,1,1,4,1,1,1,1,3,1,2,1,2,1,3,1,3,4,1,1,1,1,1,1,1,5,1,1,1,1,1,1,1,1,4,1,1,2,2,1,2,4,1,1,3,1,1,1,5,1,3,1,1,1,5,5,1,1,1,1,2,3,4,1,1,1,1,1,1,1,1,1,1,1,1,5,1,4,3,1,1,1,2,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,3,3,1,2,2,1,4,1,5,1,5,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,5,1,1,1,4,3,1,1,4"

# ╔═╡ dd95fe22-7d35-4688-913f-7b1dc4185997
test_data = "3,4,3,1,2"

# ╔═╡ 2bc462ce-fa83-4de9-943a-e187366ae00b
input = parse_input(data)

# ╔═╡ 81ff1cc2-e0ee-4863-9f0c-44fb98072a4e
@bind lifetime_days Slider(4:25)

# ╔═╡ 2453412c-2482-4726-8098-b75d12f701d1
function init_age_count(input)
	age_count = zeros(Int, lifetime_days+2)
	foreach(x -> age_count[x+1] += 1, input)
	return age_count
end

# ╔═╡ 9975c2ba-ce42-48ac-a3fd-4a52e25ff28c
@bind total_days Slider(2: 256)

# ╔═╡ b8aca0fa-af66-43fd-9b34-2f13aa2efcf8
function update_day(age_count)
	N = lifetime_days + 2
	old_age_count = copy(age_count)
	age_count[1:N-1] = old_age_count[2:N]
	age_count[lifetime_days] += old_age_count[1]
	age_count[lifetime_days+2] = old_age_count[1]
	return age_count
end

# ╔═╡ d3c86de6-894d-47dc-b875-bbd826ee9f0d
population = nth(iterated(update_day, init_age_count(input)), total_days+1)

# ╔═╡ f339be40-656a-4c70-a7dd-7af3ec2d7d5e
ans = sum(values(population))

# ╔═╡ b857f15d-4ece-4cf9-b445-c931b68022af
md"""
### Lifespan of $lifetime_days and simulating $total_days days 🚀 

### Population total: $ans
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
IterTools = "~1.3.0"
PlutoUI = "~0.7.21"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "abb72771fd8895a7ebd83d5632dc4b989b022b5b"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.2"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
git-tree-sha1 = "2b078b5a615c6c0396c77810d92ee8c6f470d238"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.3"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "8076680b162ada2a031f707ac7b4953e30667a37"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.2"

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

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "ae4bbcadb2906ccc085cf52ac286dc1377dceccc"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.1.2"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "b68904528fd538f1cb6a3fbc44d2abdc498f9e8e"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.21"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

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
# ╠═8c0552e5-4713-4054-92d9-cc59012801a6
# ╠═1b173192-be44-450b-9995-8d55af4555d5
# ╠═ee9b9bcc-5684-11ec-268f-09e7de0e01e3
# ╠═dd95fe22-7d35-4688-913f-7b1dc4185997
# ╠═2453412c-2482-4726-8098-b75d12f701d1
# ╠═2bc462ce-fa83-4de9-943a-e187366ae00b
# ╠═81ff1cc2-e0ee-4863-9f0c-44fb98072a4e
# ╠═9975c2ba-ce42-48ac-a3fd-4a52e25ff28c
# ╟─b857f15d-4ece-4cf9-b445-c931b68022af
# ╠═b8aca0fa-af66-43fd-9b34-2f13aa2efcf8
# ╠═d3c86de6-894d-47dc-b875-bbd826ee9f0d
# ╠═f339be40-656a-4c70-a7dd-7af3ec2d7d5e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
