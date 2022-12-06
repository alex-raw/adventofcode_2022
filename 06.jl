function solve(input::String, n::Int)
    for w in (range(i, length = n) for i in eachindex(input))
        allunique(input[w]) && return last(w)
    end
end

input = readline("data/06.txt")
println("part1 = $(solve(input, 4)), part2 $(solve(input, 14))")
