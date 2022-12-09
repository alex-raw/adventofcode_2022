getgrid(filename) = reduce(hcat, collect.(Int8, eachline(filename)))
replace_none(x, val) = isnothing(x) ? val : x

@views function solve2(trees)
    score, (ni, nj) = 0, size(trees)
    for i in 1:ni, j in 1:nj
        val   = trees[i, j]
        right = replace_none(findnext(>=(val), trees[i,:], j+1), nj)
        left  = replace_none(findprev(>=(val), trees[i,:], j-1), 1)
        down  = replace_none(findnext(>=(val), trees[:,j], i+1), ni)
        up    = replace_none(findprev(>=(val), trees[:,j], i-1), 1)
        this_score = (right - j) * (j - left) * (down - i) * (i - up)
        this_score > score && (score = this_score)
    end
    return score
end

getgrid("data/08.txt") |> solve2
