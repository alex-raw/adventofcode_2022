function solve(file::String)
    per_elf = map(x -> sum(parse.(Int, split(x))), split(readchomp(file), "\n\n"))
    top3 = partialsort!(per_elf, 1:3, rev=true)
    println("part1: $(top3[1])\npart2: $(sum(top3))")
end

solve("data/01.txt")
