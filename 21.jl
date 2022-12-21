const ops = Dict("*" => (*), "/" => (/), "+" => (+), "-" => (-))

function traverse(monkeys::Dict, from::AbstractString)::Number
    action = monkeys[from]
    return @something tryparse(Float64, action) begin
        a, op, b = split(action)
        ops[op](traverse(monkeys, a), traverse(monkeys, b))
    end
end

function inbranch(monkeys::Dict, id::String, init)::Bool
    init == id && return true
    a, b... = split(monkeys[init])
    isempty(b) && return false
    return inbranch(monkeys, id, a) || inbranch(monkeys, id, last(b))
end

function find_solution(f::Function, val::Number)::Number
    init, step = 0, 10^14
    while true
        for n in Iterators.countfrom(init, step)
            solution = f(string(n))
            solution == val && return n
            if solution < val
                init = n - step
                step /= 10
                break
            end
        end
    end
end

function solve(file::String)::Tuple{Int,Int}
    monkeys = split.(eachline(file), ": ") .|> Tuple |> Dict
    part1 = traverse(monkeys, "root")
    a, _, b = split(monkeys["root"])
    if inbranch(monkeys, "humn", b)
        a, b = b, a
    end
    part2 = find_solution(traverse(monkeys, b)) do x
        monkeys["humn"] = x
        traverse(monkeys, a)
    end
    part1, part2
end

@show solve("data/21.txt")
