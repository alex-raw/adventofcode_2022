function shortest(m::Matrix, start::CartesianIndex, iswalkable::Function, isgoal::Function)::Int
    queue, visited = [start], zeros(Int, size(m))
    while !isempty(queue)
        this = pop!(queue)
        isgoal(this) && return visited[this]
        for Δ in CartesianIndex.(((1, 0), (0, 1), (-1, 0), (0, -1)))
            next = this + Δ
            checkbounds(Bool, m, next) || continue
            if iswalkable(m[next] - m[this]) && visited[next] == 0
                visited[next] = visited[this] + 1
                pushfirst!(queue, next)
            end
        end
    end
end

function solve(filename::String)
    m = reduce(hcat, collect(Int, line) for line in eachline(filename))
    S = findfirst(==(Int('S')), m)
    E = findfirst(==(Int('E')), m)
    m[[S, E]] = [Int('a'), Int('z')]
    return shortest(m, S, <=(1), ==(E)), shortest(m, E, >=(-1), x -> m[x] == Int('a'))
end


@show solve("data/12.txt")
