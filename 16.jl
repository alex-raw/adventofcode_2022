mutable struct Valve
    rate::Int
    children::Dict{String,Int}
    seen::Bool
end

function getvalves(file::String)::Dict{String,Valve}
    valves = Dict{String,Valve}()
    for line in eachline(file)
        _, valve, rate, children... = split(line, r"[^0-9A-Z]", keepempty = false)
        valves[valve] = Valve(parse(Int, rate), Dict(children .=> 0), false)
    end
    return valves
end

function getdistances!(valves::Dict{String, Valve}, id::String)
    queue = [id => 1]
    valves[id].seen = true
    while !isempty(queue)
        node, distance = pop!(queue)
        for child in keys(valves[node].children)
            if !valves[child].seen
                valves[child].seen = true
                valves[id].children[child] = distance
                pushfirst!(queue, child => distance + 1)
            end
        end
    end
    foreach(v -> setfield!(v, :seen, false), values(valves))
end

function solve(file::String; time = 30)
    valves = getvalves(file)
    for valve in keys(valves)
        getdistances!(valves, valve)
    end
    foreach(println, valves)
    valves
end

solve("examples/16.txt")
# gg wp; didn't manage to write the proper bfs
