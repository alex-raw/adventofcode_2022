parse_or_0(x) = isempty(x) ? 0 : parse(Int, x)
readinput(filename) = parse_or_0.(filter.(!isletter, eachline(filename)))
prettyprint(m::Matrix{Bool}) = foreach(x -> println(join(x)), eachrow(ifelse.(m, "█", " ")))

function solve(values::Vector{Int})::Matrix{Bool}
    X = i = j = 1
    load, grid = 0, zeros(Bool, 40, 6)
    for val in values
        for _ in 1:ifelse(iszero(val), 1, 2)
            i == 41 && (i = 1; j += 1)
            grid[i, j] = i in X:X+2
            i == 20 && (load += X * (40j - 20))
            i += 1
        end
        X += val
    end
    @show load
    return grid'
end

readinput("data/10.txt") |> solve |> prettyprint
