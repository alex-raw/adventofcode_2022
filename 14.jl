const Δ = (
    up = CartesianIndex(-1, 0),
    down = CartesianIndex(1, 0),
    left = CartesianIndex(0, -1),
    right = CartesianIndex(0, 1),
)

function getcoordinates(filename::String)::Vector{CartesianIndices}
    inds = []
    for line in eachline(filename)
        start = CartesianIndex(0, 0)
        for xy in eachsplit(line, " -> ")
            stop = CartesianIndex(parse.(Int, split(xy, ","))...)
            if !iszero(start)
                start < stop ? push!(inds, start:stop) : push!(inds, stop:start)
            end
            start = stop
        end
    end
    return inds
end

function getgrid(inds::Vector{CartesianIndices}; floor = false)::Matrix{Bool}
    maxy = inds |> Iterators.flatten .|> Tuple .|> last |> maximum
    m = falses(700, maxy + 2)
    for segment in inds
        m[segment] .= true
    end
    floor && (m[:,end] .= true)
    return m'
end

function solve(m::Matrix{Bool})::Int
    start = CartesianIndex(1, 500)
    for sand in Iterators.countfrom(0, 1)
        impact = findnext(m, start) + Δ.up
        while true
            left = impact + Δ.down + Δ.left
            right = impact + Δ.down + Δ.right
            m[left] && m[right] && break
            next = !m[left] ? findnext(m, left) : findnext(m, right)
            if isnothing(next) || next[2] == impact[2]
                return sand
            end
            impact = next + Δ.up
        end
        checkbounds(Bool, m, impact) || return sand + 1
        m[impact] = true
    end
end

@show getgrid(getcoordinates("data/14.txt")) |> solve
@show getgrid(getcoordinates("data/14.txt"), floor = true) |> solve
