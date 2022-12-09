using DelimitedFiles

function headmoves(filename)
    Δ = Dict("R" => [1, 0], "U" => [0, 1], "L" => [-1, 0], "D" => [0, -1])
    inds = [repeat([Δ[row[1]]], row[2]) for row in eachrow(readdlm(filename))]
    return cumsum(Iterators.flatten(inds))
end

function pullrope!(moves; n = 1)
    for _ in 1:n
        for (i, head) in enumerate(moves[2:end])
            moves[i + 1] = moves[i]
            Δhead = head - moves[i]
            any(>(1), abs.(Δhead)) && (moves[i + 1] += sign.(Δhead))
        end
    end
    return length(unique(moves))
end

moves = headmoves("data/09.txt")
println("part1 = $(pullrope!(moves, n = 1)), part2 = $(pullrope!(moves, n = 8))")
