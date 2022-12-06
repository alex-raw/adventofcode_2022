function solve(filename::String)
    sum1 = sum2 = 0
    for line in eachline(filename)
        a, b, c, d = parse.(Int, split(line, !isdigit))
        sum1 += (a:b ⊆ c:d) || (a:b ⊇ c:d)
        sum2 += !isdisjoint(a:b, c:d)
    end
    return sum1, sum2
end

@show solve("data/04.txt")
