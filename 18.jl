using DelimitedFiles

const Δ = ( [ 1, 0, 0], [ 0,  1, 0], [ 0, 0,  1],
            [-1, 0, 0], [ 0, -1, 0], [ 0, 0, -1], )

function getsurface(grid::BitArray{3})::Int
    dim = axes(grid)
    surface = sum(grid) * 6
    for x in dim[1], y in dim[2], z in dim[3], (dx, dy, dz) in Δ
        grid[x, y, z] || continue
        neighbor = [x, y, z] + [dx, dy, dz]
        surface -= checkbounds(Bool, grid, neighbor...) && grid[neighbor...]
    end
    return surface
end

function fillpockets!(grid::BitArray)
    dim = axes(grid)
    for x in dim[1], y in dim[2], z in dim[3]
        grid[x, y, z] && continue
        queue = [[x, y, z]]
        visited = Set([[x, y, z]])
        while true
            cell = pop!(queue)
            neighbors = map(x -> x + cell, Δ)
            all(checkbounds(Bool, grid, i...) for i in neighbors) || break
            for next in neighbors
                if next ∉ visited && !grid[next...]
                    push!(visited, next)
                    pushfirst!(queue, next)
                end
            end
            if isempty(queue)
                foreach(cell -> setindex!(grid, true, cell...), visited)
                break
            end
        end
    end
end

function solve(file::String; part2 = false)
    input = readdlm(file, ',', Int) .+ 1
    grid = falses(maximum(input, dims = 1)...)
    foreach(row -> setindex!(grid, true, row...), eachrow(input))
    part2 && fillpockets!(grid)
    getsurface(grid)
end

@show solve("data/18.txt")
@show solve("data/18.txt", part2 = true)
