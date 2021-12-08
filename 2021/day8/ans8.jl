### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ dfaac0a0-581e-11ec-3c6f-970710233bb5
data = open("input.txt") do f
	split.(split(read(f, String), "\n", keepempty=false), "|")
end

# ╔═╡ 4dbc5a85-d951-480a-9f6f-a97d8188d016
segments = Dict(
	0 => "abcefg", 
	1 => "cf",
	2 => "acdeg",
	3 => "acdfg",
	4 => "bcdf",
	5 => "abdfg",
	6 => "abdefg",
	7 => "acf",
	8 => "abcdefg",
	9 => "abcdfg",
)

# ╔═╡ 3c061a7f-a50d-46e3-983d-dc6c71b494c3
segment_length = Dict(zip(0:9, length.(map(x->segments[x], 0:9))))

# ╔═╡ a8357acf-6933-47b9-9b14-c912398bfa76
patterns = map(x -> Set.(split(x[1], " ", keepempty=false)), data)

# ╔═╡ 59e59c6e-acca-4227-9127-9cf90b1f4a93
outputs = map(x -> Set.(split(x[2], " ", keepempty=false)), data)

# ╔═╡ 5aa4fddb-b266-48b6-b55a-1db85bcc4f2f
unique_digit_lenghts = Set([2,3,4,7])

# ╔═╡ 8ece944b-1a07-42fe-8c25-c38b8add2940
is_unique_length(d) = d in unique_digit_lenghts

# ╔═╡ 78ae20b7-fe7a-4733-b199-a2cd7a8839a7
ans1 = sum(length.(map(o -> filter(is_unique_length, length.(o)), outputs)))

# ╔═╡ 57626540-104b-4609-aa31-eed54d4caa06
function get_conversion(s) 
	charmap = Dict()
	s_len_5 = s[length.(s).==5]
	s_len_6 = s[length.(s).==6]
	
	charmap[1] = s[(length.(s) .== 2)][1]
	charmap[7] = s[(length.(s) .== 3)][1]
	charmap[4] = s[(length.(s) .== 4)][1]
	charmap[8] = s[(length.(s) .== 7)][1]
	charmap[5] = s_len_5[map(c -> issubset(setdiff(charmap[4], charmap[1]), c), s_len_5)][1]
	charmap[3] = s_len_5[map(c -> issubset(charmap[7], c), s_len_5)][1]
	charmap[2] = setdiff(s_len_5, [charmap[5], charmap[3]])[1]
	charmap[6] = s_len_6[map(c -> !issubset(charmap[1], c), s_len_6)][1]
	charmap[9] = union(charmap[4], charmap[5])
	charmap[0] = setdiff(s, values(charmap))[1]
	lookup_table = Dict(zip(values(charmap), string.(keys(charmap))))
end

# ╔═╡ 8e0830a3-0074-4ece-8f0b-2b5d2fe4fbc1
convert_output(conversion, output) = join(map(c -> conversion[c], output))

# ╔═╡ d66f4be9-0a0e-4a70-9bf3-0fc302291c38
ans2 = sum(parse.(Int, map((conversion, out) -> convert_output(conversion, out), get_conversion.(patterns), outputs)))

# ╔═╡ Cell order:
# ╠═dfaac0a0-581e-11ec-3c6f-970710233bb5
# ╠═4dbc5a85-d951-480a-9f6f-a97d8188d016
# ╠═3c061a7f-a50d-46e3-983d-dc6c71b494c3
# ╠═a8357acf-6933-47b9-9b14-c912398bfa76
# ╠═59e59c6e-acca-4227-9127-9cf90b1f4a93
# ╠═5aa4fddb-b266-48b6-b55a-1db85bcc4f2f
# ╠═8ece944b-1a07-42fe-8c25-c38b8add2940
# ╠═78ae20b7-fe7a-4733-b199-a2cd7a8839a7
# ╠═57626540-104b-4609-aa31-eed54d4caa06
# ╠═8e0830a3-0074-4ece-8f0b-2b5d2fe4fbc1
# ╠═d66f4be9-0a0e-4a70-9bf3-0fc302291c38
