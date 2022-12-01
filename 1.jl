per_elf(file) = map(x -> sum(parse.(Int, split(x))), split(readchomp(file), "\n\n"))
sum_max_n(file, k) = sum(partialsort!(per_elf(file), k, rev=true))
println(sum_max_n("data/1.txt", 1), '\n', sum_max_n("data/1.txt", 1:3))
