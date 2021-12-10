### A Pluto.jl notebook ###
# v0.17.2

using Markdown
using InteractiveUtils

# ╔═╡ 71827028-598b-11ec-3b6b-4fd9c8a68279
data = open("input.txt") do f
	split(read(f, String), "\n")
end

# ╔═╡ bd8402f0-96a5-4872-9962-4f27c12111d4
d = data[1]

# ╔═╡ 1d097669-0910-40c4-966f-f1b65beb0063
closing = "]}>)"

# ╔═╡ a8253fa6-17c1-4ff1-b7da-9f0b416fb379
matching_pair(l,r) = Dict('[' => ']', '(' => ')', '{' => '}', '<'=>'>')[l] == r

# ╔═╡ 9292c70d-f2aa-4e0b-ad09-9e80e6c754a9
is_closing(c) = c in closing

# ╔═╡ edeaf571-31b3-4935-a5bf-88cdfd9de02c
function handle_input(c, hist)
	if isa(hist, Char)
		return hist
	end
	if is_closing(c)
		if matching_pair(hist[end], c)
			pop!(hist)
		else
			return c
		end
	else
		push!(hist, c)
	end
	return hist
end

# ╔═╡ f130b9ae-199d-42ec-91d7-a94de19d0d9e
find_breaking_character(text) = reduce((m,x) -> handle_input(x, m), text, init=[])

# ╔═╡ 8af7d2e4-389f-4b66-ac02-6189583d9118
breaking_chars = filter(x -> isa(x, Char), find_breaking_character.(data))

# ╔═╡ d22be098-0c49-45f6-86d0-68133802a406
scoring = Dict(
    ')'=> 3,
    ']'=> 57,
    '}'=> 1197,
    '>'=> 25137)

# ╔═╡ c20cb606-1961-4130-810d-ed4bfed63542
ans1 = sum(map(c -> scoring[c], breaking_chars))

# ╔═╡ 483e12d6-a749-46e7-80f4-4b631216b9fd
uncompleted_chars = filter(x -> length(x) > 1, filter(x -> isa(x, Array), find_breaking_character.(data)))

# ╔═╡ a0f588aa-d80e-4d2e-9f32-83a11f8b17ad
scoring_uncompleted = Dict('('=>1, '['=>2, '{'=>3, '<'=>4)

# ╔═╡ 73f32cdb-a827-406d-b441-e863cb901461
compute_score(text) = reduce((m,x) -> m*5+scoring_uncompleted[x], reverse(text), init=0)

# ╔═╡ 627cfcf8-8848-484e-9a42-d04fb21b10e8
sort(compute_score.(uncompleted_chars))

# ╔═╡ c52b8077-216e-4a88-81c3-12f27ce55be1
middle = div(length(uncompleted_chars), 2)+1

# ╔═╡ 76df800b-48fe-4db9-95a4-c3a6e6b36c3e
ans2 = sort(compute_score.(uncompleted_chars))[middle]

# ╔═╡ Cell order:
# ╠═71827028-598b-11ec-3b6b-4fd9c8a68279
# ╠═bd8402f0-96a5-4872-9962-4f27c12111d4
# ╠═1d097669-0910-40c4-966f-f1b65beb0063
# ╠═a8253fa6-17c1-4ff1-b7da-9f0b416fb379
# ╠═9292c70d-f2aa-4e0b-ad09-9e80e6c754a9
# ╠═edeaf571-31b3-4935-a5bf-88cdfd9de02c
# ╠═f130b9ae-199d-42ec-91d7-a94de19d0d9e
# ╠═8af7d2e4-389f-4b66-ac02-6189583d9118
# ╠═d22be098-0c49-45f6-86d0-68133802a406
# ╠═c20cb606-1961-4130-810d-ed4bfed63542
# ╠═483e12d6-a749-46e7-80f4-4b631216b9fd
# ╠═a0f588aa-d80e-4d2e-9f32-83a11f8b17ad
# ╠═73f32cdb-a827-406d-b441-e863cb901461
# ╠═627cfcf8-8848-484e-9a42-d04fb21b10e8
# ╠═c52b8077-216e-4a88-81c3-12f27ce55be1
# ╠═76df800b-48fe-4db9-95a4-c3a6e6b36c3e
