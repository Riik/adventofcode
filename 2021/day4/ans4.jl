### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ d430def1-7d9e-4d10-972f-de8c29a0888a
using DelimitedFiles

# ╔═╡ 35912504-54f5-11ec-140b-c15f3f74e92c
data_raw = open("input.txt") do file
    split(read(file, String), "\n\n", keepempty=false)
end

# ╔═╡ b2fea430-160f-4730-a97c-ccbbd8fa5be9
drawn_numbers = parse.(Int, split(data_raw[1], ","))

# ╔═╡ d9843060-9f0e-4a37-9e1b-30cf1fc617a4
parse_bingo_board(input) = parse.(Int,
	hcat(
		split.(
			split(input, "\n"), " ", keepempty=false
		)...)
)

# ╔═╡ 43d03e78-0545-4f75-ba0b-de27ecb45213
bingo_boards = parse_bingo_board.(data_raw[2:end])

# ╔═╡ 54454e1b-c4b3-43ff-9e8b-a363982381cf
drawn_dict = Dict(zip(drawn_numbers, 1:length(drawn_numbers)))

# ╔═╡ 5ae81af3-226d-4d4c-b138-87fda0c4d3e2
boards_draw_order = map(board -> map(x -> drawn_dict[x], board), bingo_boards)

# ╔═╡ 19174e7a-dee9-424d-b6be-58d2248d74b3
length(bingo_boards)

# ╔═╡ 0d4c8333-3036-4a1a-8453-759648e324e9
get_bingo_turn(board) = minimum(hcat(maximum(board, dims=1), maximum(board, dims=2)'))

# ╔═╡ b5c5159a-118b-469f-8edb-3b6463b4d922
get_bingo_turn.(boards_draw_order)

# ╔═╡ 7e8692b6-669d-4dbd-8e37-8d5aaf8c8a95
final_turn, best_board_idx = findmin(get_bingo_turn.(boards_draw_order))

# ╔═╡ 07c6ebd3-e5cc-4344-9aea-e93fefb211d8
open_squares = boards_draw_order[best_board_idx] .> final_turn

# ╔═╡ 067efca5-1627-484b-937a-ae975e20b379
open_squares_values = bingo_boards[best_board_idx] .* open_squares

# ╔═╡ f118f06e-0382-4590-8e2d-37c777098355
ans1 = sum(open_squares_values)*drawn_numbers[final_turn]

# ╔═╡ 65b8411e-1b49-401a-a611-e655bee9be7d
final_turn_worst, best_board_idx_worst = findmax(get_bingo_turn.(boards_draw_order))

# ╔═╡ c6256e33-c3ef-4e57-9d4f-2bbbbe22305c
open_squares_worst = boards_draw_order[best_board_idx_worst] .> final_turn_worst

# ╔═╡ 65403be3-49e3-4e7b-bc8e-3507d5d25ba2
ans2 = sum(open_squares_worst.*bingo_boards[best_board_idx_worst])*drawn_numbers[final_turn_worst]

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DelimitedFiles = "8bb1440f-4735-579b-a4ab-409b98df4dab"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
"""

# ╔═╡ Cell order:
# ╠═d430def1-7d9e-4d10-972f-de8c29a0888a
# ╠═35912504-54f5-11ec-140b-c15f3f74e92c
# ╠═b2fea430-160f-4730-a97c-ccbbd8fa5be9
# ╠═d9843060-9f0e-4a37-9e1b-30cf1fc617a4
# ╠═43d03e78-0545-4f75-ba0b-de27ecb45213
# ╠═54454e1b-c4b3-43ff-9e8b-a363982381cf
# ╠═5ae81af3-226d-4d4c-b138-87fda0c4d3e2
# ╠═19174e7a-dee9-424d-b6be-58d2248d74b3
# ╠═0d4c8333-3036-4a1a-8453-759648e324e9
# ╠═b5c5159a-118b-469f-8edb-3b6463b4d922
# ╠═7e8692b6-669d-4dbd-8e37-8d5aaf8c8a95
# ╠═07c6ebd3-e5cc-4344-9aea-e93fefb211d8
# ╠═067efca5-1627-484b-937a-ae975e20b379
# ╠═f118f06e-0382-4590-8e2d-37c777098355
# ╠═65b8411e-1b49-401a-a611-e655bee9be7d
# ╠═c6256e33-c3ef-4e57-9d4f-2bbbbe22305c
# ╠═65403be3-49e3-4e7b-bc8e-3507d5d25ba2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
