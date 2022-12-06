function parsecrates(crates)
    crate_positions = [Char[] for _ = 1:9]
    for level in split(crates, "\n")
        for (i, crate) in enumerate(level[2:4:end])
            isuppercase(crate) && pushfirst!(crate_positions[i], crate)
        end
    end
    return crate_positions
end

function stackcrates(filename; model = 9000)
    crates, instrs = split(readchomp(filename), "\n\n")
    crates = parsecrates(crates)
    instrs = [parse.(Int, line) for line in split.(instrs, !isdigit, keepempty = false)]
    for (k, from, to) in Iterators.partition(instrs, 3)
        moving_crates = [pop!(crates[from]) for _ = 1:k]
        model == 9001 && reverse!(moving_crates)
        append!(crates[to], moving_crates)
    end
    return String(last.(crates))
end

@show stackcrates("data/05.txt")
@show stackcrates("data/05.txt", model = 9001)
