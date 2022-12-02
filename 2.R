score1 <- function(opponent, me) {
  results <- opponent - me
  draws <- results == 0
  wins <- results == -1 | results == 2
  sum(me) + 3 * sum(draws) + 6 * sum(wins)
}

score2 <- function(player1, player2) {
  losses <- player1[player2 == 1] - 1
  losses[losses == 0] <- 3
  draws <- player1[player2 == 2]
  wins <- player1[player2 == 3] + 1
  wins[wins == 4] <- 1

  me <- c(wins, losses, draws)
  sum(me) + 3 * length(draws) + 6 * length(wins)
}

solve <- function(.file) {
  input <- read.table(.file)
  opponent <- match(input[, 1], c("A", "B", "C"))
  me <- match(input[, 2], c("X", "Y", "Z"))
  c(part1 = score1(opponent, me),
    part2 = score2(opponent, me))
}

solve("data/2.txt")


# fun alternative
solve <- function(.file) {
  input <- sapply(read.table("data/2.txt", stringsAsFactors = TRUE), as.integer)
  multiplier <- matrix(c(1, 0, 2, 2, 1, 0, 0, 2, 1), 3) # 0 loss, 1 draw, 2 win
  input2 <- input
  input2[, 2] <- apply(multiplier[input2[, 1], ] == input2[, 2] - 1, 1, which)
  c(part1 = sum((multiplier * 3)[input] + input[, 2]),
    part2 = sum((multiplier * 3)[input2] + input2[, 2]))
}
