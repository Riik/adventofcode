### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 632bf944-8983-4a34-b02c-2510c731d2b6
using IterTools

# ╔═╡ 556b2728-b4d9-41ad-b04d-dd42a5e6a0eb
N_max = 1000 # would be better to get this from the data

# ╔═╡ 6767cb97-723d-4a0d-872b-e49096d84a43
string_to_tuple(text) = parse.(Int, split(text, ",")) .+ 1 # .+1 is there because Julia is 1-indexed at coordinates start from 0

# ╔═╡ ead83724-0bbe-4849-a456-4f9d192cf4d3
order_range(a, b) = if a > b a:-1:b else a:b end

# ╔═╡ f58cf40e-427b-4bba-aa91-d3e789b2b1ac
get_line(p) = product(order_range(p[1][1],p[2][1]), order_range(p[1][2],p[2][2]))

# ╔═╡ 4dabfa53-36a3-47ad-976b-6f8e5c503544
get_diagonal(p) = zip(order_range(p[1][1],p[2][1]), order_range(p[1][2],p[2][2]))

# ╔═╡ 4a7a62f4-10eb-40fe-ab05-ba810c365a23
is_orthogonal_line(p) = p[1][1] == p[2][1] || p[1][2] == p[2][2]

# ╔═╡ cd99521b-915a-4d60-b7d7-97ee41135512
is_diagonal(p) = abs(p[1][1] - p[2][1]) == abs(p[1][2] - p[2][2])

# ╔═╡ 1a80a373-c355-4f11-9021-c8367ce58b36
draw_line(field, line) = foreach(point -> field[point...] += 1, line)

# ╔═╡ 68b80cf5-f27b-4143-992f-2a244ef35b5c
draw_diagonal(field, diagonal) = foreach(point -> field[point...] += 1, line)

# ╔═╡ f66adb91-6a0e-4b42-9dde-d1cbd44c39d1
test_text = """0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"""

# ╔═╡ 61b2b778-e4f8-4c66-9596-34287c453a68
parse_raw_text(text) = split.(split(text, "\n", keepempty=false), " -> ")

# ╔═╡ 238caf4c-5606-11ec-0977-49e21ea8b69c
data_raw = open("input.txt") do file
	data_text = parse_raw_text(read(file, String))
end
# data_raw = parse_raw_text(test_text)

# ╔═╡ 944f2b1b-adab-426b-81ac-766ac83dbf17
parsed_data = map(x -> string_to_tuple.(x), data_raw)

# ╔═╡ dd45e68e-2678-44f1-87c9-4330d762fc0e
lines_to_mark = get_line.(filter(is_orthogonal_line, parsed_data))

# ╔═╡ 1390ccb5-0851-46d5-8091-b0faf8a276ca
function draw_field(lines_to_mark, diagonals=nothing)
	field = zeros(N_max, N_max)
	foreach(line -> draw_line(field, line), lines_to_mark)
	if diagonals !== nothing
		foreach(line -> draw_line(field, line), diagonals)
	end
	return field
end

# ╔═╡ a3a62d39-94b0-4aa8-8703-1a6425df0a5d
field = draw_field(lines_to_mark)

# ╔═╡ 4242c0cb-6fab-4a58-9c34-eebbd75528f3
ans1 = sum(field .> 1)

# ╔═╡ 6a20489f-9728-46dc-81c3-0d079c69e1a8
diagonals_to_mark = get_diagonal.(filter(is_diagonal, parsed_data))

# ╔═╡ 40a795db-1e36-4ed9-9752-d0dfc01ec54e
field_with_diagonals = draw_field(lines_to_mark, diagonals_to_mark)

# ╔═╡ ed67e9ff-a9b0-4ebd-b59c-1ae7389a0513
ans2 = sum(field_with_diagonals .> 1)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
IterTools = "c8e1da08-722c-5040-9ed9-7db0dc04731e"

[compat]
IterTools = "~1.3.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[IterTools]]
git-tree-sha1 = "05110a2ab1fc5f932622ffea2a003221f4782c18"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.3.0"
"""

# ╔═╡ Cell order:
# ╠═632bf944-8983-4a34-b02c-2510c731d2b6
# ╠═556b2728-b4d9-41ad-b04d-dd42a5e6a0eb
# ╠═6767cb97-723d-4a0d-872b-e49096d84a43
# ╠═ead83724-0bbe-4849-a456-4f9d192cf4d3
# ╠═f58cf40e-427b-4bba-aa91-d3e789b2b1ac
# ╠═4dabfa53-36a3-47ad-976b-6f8e5c503544
# ╠═4a7a62f4-10eb-40fe-ab05-ba810c365a23
# ╠═cd99521b-915a-4d60-b7d7-97ee41135512
# ╠═1a80a373-c355-4f11-9021-c8367ce58b36
# ╠═68b80cf5-f27b-4143-992f-2a244ef35b5c
# ╠═f66adb91-6a0e-4b42-9dde-d1cbd44c39d1
# ╠═61b2b778-e4f8-4c66-9596-34287c453a68
# ╠═238caf4c-5606-11ec-0977-49e21ea8b69c
# ╠═944f2b1b-adab-426b-81ac-766ac83dbf17
# ╠═dd45e68e-2678-44f1-87c9-4330d762fc0e
# ╠═1390ccb5-0851-46d5-8091-b0faf8a276ca
# ╠═a3a62d39-94b0-4aa8-8703-1a6425df0a5d
# ╠═4242c0cb-6fab-4a58-9c34-eebbd75528f3
# ╠═6a20489f-9728-46dc-81c3-0d079c69e1a8
# ╠═40a795db-1e36-4ed9-9752-d0dfc01ec54e
# ╠═ed67e9ff-a9b0-4ebd-b59c-1ae7389a0513
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
