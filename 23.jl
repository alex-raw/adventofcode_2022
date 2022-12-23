const Δ = (
    n  = -1 + 0im,  s = 1 + 0im, w  =  0 + -1im,  e = 0 +  1im,
    ne = -1 + 1im, se = 1 + 1im, nw = -1 + -1im, sw = 1 + -1im,
)

function elfmove(elves::Vector; rounds = Iterators.countfrom(1, 1))
    moves = [
        Δ.n => (Δ.n, Δ.ne, Δ.nw),
        Δ.s => (Δ.s, Δ.se, Δ.sw),
        Δ.w => (Δ.w, Δ.nw, Δ.sw),
        Δ.e => (Δ.e, Δ.ne, Δ.se),
    ]
    no_move = Int[]
    elves_next = copy(elves)
    for round in rounds
        for (i, elf) in enumerate(elves)
            any(elf + neighbor ∈ elves for neighbor in Δ) || continue
            for (move, neighbors) in moves
                any(elf + neighbor ∈ elves for neighbor in neighbors) && continue
                next = elf + move
                same = findfirst(==(next), elves_next)
                if isnothing(same)
                    elves_next[i] = next
                else
                    push!(no_move, same)
                end
                break
            end
        end
        elves_next[no_move] .= elves[no_move]
        elves == elves_next && return round, elves
        elves = copy(elves_next)
        moves = circshift(moves, -1)
        empty!(no_move)
    end
    return round, elves
end

function part1(elves)
    xmin, xmax = extrema(real.(elves))
    ymin, ymax = extrema(imag.(elves))
    (xmax - (xmin - 1)) * (ymax - (ymin - 1)) - length(elves)
end

function solve(file::String)
    elves = (complex.(x, findall('#', line)) for (x, line) in enumerate(eachline(file))) |>
        Iterators.flatten |> collect
    return part1(elfmove(elves, rounds = 1:10)[2]), elfmove(elves)[1]
end

@show solve("data/23.txt")
