function play(file)
    i = Dict(zip("ABCXYZ", repeat(1:3, 2)))
    points = [3 0 6; 6 3 0; 0 6 3]
    z = Dict(zip("XYZ", 0:3:6))
    score1 = score2 = 0
    for line in eachline(file)
        x, y = only.(split(line))
        elf_move, my_move = i[x], i[y]
        my_actual_move = findfirst(==(z[y]), points[:, elf_move])
        score1 += points[my_move, elf_move] + my_move
        score2 += points[my_actual_move, elf_move] + my_actual_move
    end
    return score1, score2
end

@show play("data/02.txt")
