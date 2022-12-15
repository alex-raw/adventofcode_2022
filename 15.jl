struct Sensor
    x::Int
    y::Int
    d::Int
    Sensor(x, y, x2, y2) = new(x, y, abs(x - x2) + abs(y - y2))
end

parsesensor(line) = Sensor(parse.(Int, split(line, r"[^-\d]", keepempty = false))...)

fuserange(a::Int, b::UnitRange)::Int = a

function fuserange(a::UnitRange, b::UnitRange)::Union{Int,UnitRange}
    b ⊆ a && return a
    adjacent = a.stop + 1
    adjacent < b.start && return adjacent
    return a.start:b.stop
end

function coverage(sensors::Vector{Sensor}, y::Int)::Union{Int,UnitRange}
    covered = UnitRange[]
    for sensor in sensors
        Δy = sensor.d - abs(y - sensor.y)
        Δy >= 0 && push!(covered, (-Δy:Δy) .+ sensor.x)
    end
    reduce(fuserange, sort(covered))
end

function solve(file::String; col = 2_000_000, n = 4_000_000)
    sensors = map(parsesensor, eachline(file))
    println("part1 = $(length(coverage(sensors, col)) - 1)")
    for y in 1:n
        range = coverage(sensors, y)
        if isone(length(range))
            println("part2 = $(first(range) * 4_000_000 + y)")
            return
        end
    end
end

solve("data/15.txt")
