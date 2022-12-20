function getrocks()
    rocks = BitArray[
        [1 1 1 1],
        [0 1 0; 1 1 1; 0 1 0],
        rotl90([0 0 1; 0 0 1; 1 1 1]), # hmm
        [1; 1; 1; 1;;],
        [1 1; 1 1],
    ] .|> findall .|> rock -> map(x -> x[1] + x[2]im, rock)
    Iterators.cycle(rocks) |> Iterators.Stateful
end

function solve(file::String; n = 2022)::Int
    directions = map(x -> x - (Int('<') + 1), collect.(Int, readchomp(file))) |>
        Iterators.cycle |> Iterators.Stateful
    rocks = getrocks()
    fallen = Set()
    height = 0
    for i in 1:n
        i % 1_000_00 == 0 && println(i)
        rock = popfirst!(rocks)
        position = rock .+ (height + 1 + 3 + 2im)

        while true
            next = position .- (1 + 0im)
            if any(real.(next) .== 0) || !isdisjoint(next, fallen)
                union!(fallen, position)
                height = max(height, maximum(real.(position)))
                break
            end
            position = next
            next = position .+ (0 + popfirst!(directions)im)
            if all(imag(i) ∈ 1:7 for i in next) && isdisjoint(next, fallen)
                position = next
            end
        end
    end
    return height
end

@show solve("data/17.txt")
# part2: gg wp, didn't realize there is a repeating pattern
