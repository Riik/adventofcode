### A Pluto.jl notebook ###
# v0.17.3

using Markdown
using InteractiveUtils

# ╔═╡ 47736e76-5e43-11ec-3c97-a7711bb0135b
data = open("test1.txt") do f
	strip(read(f, String))
end

# ╔═╡ e7c8f836-a598-433c-b867-5d964de2c307
from_bits(bits) = parse(Int, bits, base=2)

# ╔═╡ 3be08e64-ae09-4b5e-a600-826bd0966de8
bits = join(map(x -> x[5:8], bitstring.(parse.(Int8, collect(data), base=16))))

# ╔═╡ 432d48a2-f51e-4391-aff2-39e4c3ce68c7
parse(Int, "111", base = 2)

# ╔═╡ 3649965a-38b5-4110-a59c-7b795db3de0a
function parse_literal(data)
	N = length(data)
	p = 1
	literal_str = ""
	start_bit = '1'
	while(start_bit == '1' && p <= N - 5 + 1)
		start_bit = data[p]
		literal_str *= data[p+1:p+4]
		p += 5
	end
	if literal_str != ""
		return from_bits(literal_str), data[p:end]
	else
		return "", data[p:end]
	end
end	

# ╔═╡ ab28a1ba-61ab-4d5a-b23e-39b8ced8ba77
parse_literal("000")

# ╔═╡ 0eca1b0a-53fe-49de-92f1-5113c23536e3
# TODO 
# - make parse_packet return remainder of string
# - think of unpacking structure 
# - recursive unpacking of packets 
# - 

function parse_packet(packet)
	p = 1
	pver = from_bits(packet[p:p+2])
	p += 3
	ptype = from_bits(packet[p:p+2])
	p += 3
	if ptype == 4
		literal, remaining_data = parse_literal(packet[p:end])
		return pver, literal
	else
		plentype = from_bits(packet[p])
		p += 1
		if plentype == 0
			plen = from_bits(packet[p:p+14])
			p += 15
		else
			plen = from_bits(packet[p:p+10])
			p += 11
			# d = data[p:end]
			# return d
			# for i=1:plen
			# 	v, t, d = parse_packet(d)
			# end
		end
		return pver, ptype, packet[p:end]
	end
end

# ╔═╡ feef4dbf-850e-4eda-a0cd-b2ac7a0ca30a
y = 3

# ╔═╡ e7108b94-28e9-4dc7-86af-48521de3daf7
y

# ╔═╡ 34c3f2ca-8617-481d-8f04-2b3618a768eb
pver, ptype, pdata = parse_packet(bits)

# ╔═╡ de99e4bc-402b-4d27-b516-c643decfcb3b
_, _, p2data = parse_packet(pdata)

# ╔═╡ e1a58223-1973-475a-b94e-13f870832253
_, _, p3 = parse_packet(p2data)

# ╔═╡ f13c81ff-ae5e-47b8-9d62-538b96b7c9dc
parse_packet(p3)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╠═47736e76-5e43-11ec-3c97-a7711bb0135b
# ╠═e7c8f836-a598-433c-b867-5d964de2c307
# ╠═3be08e64-ae09-4b5e-a600-826bd0966de8
# ╠═432d48a2-f51e-4391-aff2-39e4c3ce68c7
# ╠═3649965a-38b5-4110-a59c-7b795db3de0a
# ╠═ab28a1ba-61ab-4d5a-b23e-39b8ced8ba77
# ╠═0eca1b0a-53fe-49de-92f1-5113c23536e3
# ╠═feef4dbf-850e-4eda-a0cd-b2ac7a0ca30a
# ╠═e7108b94-28e9-4dc7-86af-48521de3daf7
# ╠═34c3f2ca-8617-481d-8f04-2b3618a768eb
# ╠═de99e4bc-402b-4d27-b516-c643decfcb3b
# ╠═e1a58223-1973-475a-b94e-13f870832253
# ╠═f13c81ff-ae5e-47b8-9d62-538b96b7c9dc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
