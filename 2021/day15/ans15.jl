### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 866453aa-5d7b-11ec-1198-552991a51eb5
data = open("fenno.txt") do f 
	parse.(Int, hcat(collect.(split(read(f, String), "\n", keepempty=false))...))
end

# ╔═╡ a0a7a1d5-223c-42f8-bc8a-954288afdfc5
mod1(d, m) = (d-1)%m + 1

# ╔═╡ 458d6709-022f-4407-a0c5-699b027fcd3c
function get_lowest_cost_path(data)
	cost_matrix = zeros(Int, size(data))
	cost_matrix[:,1] = cumsum(data[:, 1])
	cost_matrix[1,:] = cumsum(data[1,:])
	cost_matrix .-= data[1,1]
	for i = 2:size(data)[1]
		for j = 2:size(data)[2]
			cost_matrix[i,j] = data[i,j] + minimum([cost_matrix[i-1, j], cost_matrix[i, j-1]])
		end
	end
	return cost_matrix[end,end]
end	

# ╔═╡ 5b941930-d08c-458b-805f-ffbbc40f44d7
ans1 = get_lowest_cost_path(data)

# ╔═╡ b6f2d2fb-ec89-4d56-8a50-5e2b02f89e6a
tile_costs = [0 1 2 3 4;  1 2 3 4 5; 2 3 4 5 6; 3 4 5 6 7; 4 5 6 7 8]

# ╔═╡ f94e21a1-9e40-4d34-a45b-2bcfc738dd10
tiled_data = mod1.(repeat(data, 5, 5) + repeat(tile_costs, inner=size(data)), 9)

# ╔═╡ 14ceca88-d739-4324-943c-c241647960a6
ans2 = get_lowest_cost_path(tiled_data)

# ╔═╡ Cell order:
# ╠═866453aa-5d7b-11ec-1198-552991a51eb5
# ╠═a0a7a1d5-223c-42f8-bc8a-954288afdfc5
# ╠═458d6709-022f-4407-a0c5-699b027fcd3c
# ╠═5b941930-d08c-458b-805f-ffbbc40f44d7
# ╠═b6f2d2fb-ec89-4d56-8a50-5e2b02f89e6a
# ╠═f94e21a1-9e40-4d34-a45b-2bcfc738dd10
# ╠═14ceca88-d739-4324-943c-c241647960a6
