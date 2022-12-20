function solve(nums::Vector{Int}; k = 1)::Integer
    new = collect(enumerate(copy(nums)))
    for _ in 1:k, original in enumerate(nums)
        i = findfirst(==(original), new)
        _, offset = popat!(new, i)
        insert!(new, mod1(i + offset, length(nums) - 1), original)
    end
    decrypted = last.(new)
    positions = findfirst(iszero, decrypted) .+ [1000, 2000, 3000]
    return sum(decrypted[mod1.(positions, length(nums))])
end

solve(nums::Vector{Int}, key::Int) = solve(nums .* key, k = 10)

nums = parse.(Int, readlines("data/20.txt"))
@show solve(nums)
@show solve(nums, 811589153)
