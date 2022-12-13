mutable struct Dir
    parents::Vector{Int}
    size::Int
end

function get_sizes!(filesystem::Vector{Dir})::Vector{Int}
    for dir in filesystem
        for i in dir.parents
            filesystem[i].size += dir.size
        end
    end
    return [dir.size for dir in filesystem]
end

function getfiles(iter)::Vector{Dir}
    tree, path, parent = Dir[], [], 1
    for d in iter
        (cwd = first(d)) == ".." && (pop!(path); continue)
        size = sum(x -> isempty(x) ? 0 : parse(Int, x), filter.(isdigit, d))
        push!(tree, Dir(path, size))
        push!(path, parent)
        parent += 1
    end
    tree
end

function solve(filename::String)
    input = read(filename, String)
    filesystem = getfiles(eachsplit.(eachsplit(input, "\$ cd "), "\n"))
    sizes = get_sizes!(filesystem)
    part1 = sum(filter(<=(100_000), sizes))

    required = maximum(sizes) - 40_000_000
    part2 = minimum(sizes[sizes .> required])
    println("part1 = $part1, part2 = $part2")
end

solve("data/07.txt")
