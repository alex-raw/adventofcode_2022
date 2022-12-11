struct Monkey
    items::Vector{Int}
    op::Function
    val::Union{Nothing,Int}
    by::Int
    yes::Int
    no::Int
end

function parsemonkey(m)::Monkey
    _, items, op, test... = m
    f, val = match(r"([*+]) (.*)", op).captures
    return Monkey(
        filter!(!isnothing, tryparse.(Int, split(items, r",|: "))),
        f == "*" ? (*) : (+),
        tryparse(Int, val),
        parse.(Int, filter.(isdigit, test))...
    )
end

function monkeybusiness(filename::String; k = 20, relief = 3)::Int
    monkeys = parsemonkey.(split.(split(readchomp(filename), "\n\n"), '\n'))
    scores = zeros(Int, length(monkeys))
    lcd = prod(monkey.by for monkey in monkeys)
    for _ in 1:k, (i, monkey) in enumerate(monkeys)
        scores[i] += length(monkey.items)
        while !isempty(monkey.items)
            item = pop!(monkey.items)
            level = monkey.op(item, something(monkey.val, item))
            relief > 1 && (level ÷= relief)
            next = level % monkey.by == 0 ? monkey.yes : monkey.no
            push!(monkeys[next + 1].items, level % lcd)
        end
    end
    return prod(partialsort(scores, 1:2, rev = true))
end

@show monkeybusiness("data/11.txt")
@show monkeybusiness("data/11.txt", k = 10_000, relief = 1)
