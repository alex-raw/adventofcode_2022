priority = [indexin(line, ['a':'z'; 'A':'Z']) for line in eachline("data/03.txt")]
pt1 = sum(x -> ∩(x...), map(el -> Iterators.partition(el,&  length(el) ÷ 2), priority))
pt1 = sum(x -> ∩(x...), Iterators.partition(priority, 3))
println("part1 = $pt1, part2 = $pt2")
