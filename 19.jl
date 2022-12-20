mutable struct Inventory
    robots::Vector{Int}
    stock::Vector{Int}
    prices::Vector{Vector{Int}}
end

function waiting_time(inv::Inventory, res::Int)
    need = inv.prices[res] .- inv.stock
    d = ceil.(need ./ inv.robots)
    replace!(d, NaN => -Inf)
end

function trybuy(inv::Inventory, res::Int, time::Int; want = Int[])::Union{Nothing,Int}
    if any(inv.stock .< inv.prices[res])
        next = findmax(waiting_time(inv, res))[2]
        next == res && return
        return trybuy(inv, next, time; want = [want; res])
    end
    if !isempty(want)
        for w in want
            maybe_inv = Inventory(copy(inv.robots), inv.stock .- inv.prices[res], inv.prices)
            maybe_inv.robots[res] += 1
            time_if_buy = waiting_time(maybe_inv, w) |> maximum
            time_if_wait = waiting_time(inv, w) |> maximum
            all(time_if_buy .> time_if_wait .&& time_if_wait .< time) && return
        end
    end
    return res
end

function assessquality(prices::Vector{Vector{Int}}; n = 24)::Int
    inv = Inventory([1, 0, 0, 0], [0, 0, 0, 0], prices)
    for i in 1:n
        buy_id = trybuy(inv, 4, i)  # geode = 4
        inv.stock += inv.robots
        if !isnothing(buy_id)
            inv.robots[buy_id] += 1
            inv.stock -= inv.prices[buy_id]
        end
    end
    return inv.stock[4]
end

function solve(file::String)
    input = [parse.(Int, split(line, !isdigit, keepempty = false)) for line in eachline(file)]
    costs = [[
        [bp[2], 0,     0,     0], # ore
        [bp[3], 0,     0,     0], # clay
        [bp[4], bp[5], 0,     0], # obsidian
        [bp[6], 0,     bp[7], 0], # geode
    ] for bp in input]

    sum(assessquality, costs)
end


@show solve("data/19.txt")  # wrong, gg wp
