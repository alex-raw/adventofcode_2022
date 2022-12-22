function rotate(vec::Vector, Δ::AbstractString)::Vector{Int64}
    x, y = vec
    Δ == "R" && return [ y, -x]
    Δ == "L" && return [-y,  x]
end

function parse_directions(facing::AbstractString; init = [0, 1])::Tuple{Int,Vector}
    times = parse.(Int, split(facing, isletter))
    face = split(facing, isdigit, keepempty=false)
    face = [[init]; accumulate(rotate, face; init)]
    score = Dict([0, 1] => 0, [1, 0] => 1, [0, -1] => 2, [-1, 0] => 3)[last(face)]
    score, times .* face
end

function parse_map(input::AbstractString)::Matrix{Char}
    vec = collect.(split(input, '\n'))
    width = maximum(length.(vec))
    for i in eachindex(vec)
        d = width - length(vec[i])
        if d > 0
            vec[i] = [vec[i]; fill(' ', d)]
        end
    end
    reduce(hcat, vec) |> permutedims
end

function walk(map::Matrix{Char}, facing::Vector{Vector{Int}}, me_x::Int, me_y::Int)
    nr, nc = size(map)
    for (x, y) in facing
        for _ in 1:abs(x)
            me_next = mod1(me_x + sign(x), nr)
            next = map[me_next, me_y]
            while next == ' '
                me_next = mod1(me_next + sign(x), nr)
                next = map[me_next, me_y]
            end
            next == '#' && break
            me_x = me_next
        end
        for _ in 1:abs(y)
            me_next = mod1(me_y + sign(y), nc)
            next = map[me_x, me_next]
            while next == ' '
                me_next = mod1(me_next + sign(y), nc)
                next = map[me_x, me_next]
            end
            next == '#' && break
            me_y = me_next
        end
    end
    return me_x, me_y
end

function solve(file::String)
    map, facing = split(readchomp(file), "\n\n")
    map = parse_map(map)
    face_score, facing = parse_directions(facing)
    start = findfirst(isspace, map[1, :])
    x, y = walk(map, facing, 1, start)
    1000x + 4y + face_score
end

@show solve("data/22.txt")
