Base.isless(a::Int, b::Vector) = [a] < b
Base.isless(a::Vector, b::Int) = a < [b]
Base.isequal(a::Int, b::Vector) = [a] == b
Base.isequal(a::Vector, b::Int) = a == [b]

function solve(filename)
    input = readchomp(filename)
    all(in("[],1234567890\n "), input) || error("don't eval that, silly!")
    pairs = "[[" * replace(input, "\n\n" => "],[", '\n' => ",") * "]]" |>
        Meta.parse |> eval
    part1 = sum(findall(isless(x...) for x in pairs))
    part2 = prod(findall(<=(2), sortperm([2; 6; reduce(vcat, pairs)])))
    return part1, part2
end

@show solve("data/13.txt")
