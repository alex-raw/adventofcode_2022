per_elf = [parse.(Int, split(x, '\n')) for x in split(readchomp("data/1.txt"), "\n\n")]
maximum(sum, per_elf) |> println
partialsort!(sum.(per_elf), 1:3, rev=true) |> sum |> println
