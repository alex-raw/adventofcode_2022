using DelimitedFiles

function headmoves(filename)
    Δ = Dict("R" => [1, 0], "U" => [0, 1], "L" => [-1, 0], "D" => [0, -1])
    inds = [repeat([Δ[row[1]]], row[2]) for row in eachrow(readdlm(filename))]
    return reduce(vcat, inds, init = [[0, 0]]) |> cumsum
end

function pullrope!(moves)
    for (i, head) in enumerate(moves[2:end])
        moves[i + 1] = moves[i]
        Δhead = head - moves[i]
        if any(>(1), abs.(Δhead))
            moves[i + 1] += sign.(Δhead)
        end
    end
    return moves
end

function solve(filename)
    moves = headmoves(filename)
    pt1 = pullrope!(moves) |> unique |> length
    pt2 = reduce((_, _) -> pullrope!(moves), 1:8) |> unique |> length
    println("part1 = $(pt1), part2 = $(pt2)")
end

solve("data/09.txt")
