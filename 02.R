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

solve("data/02.txt")



# alternative
solve2 <- function(.file) {
  input <- sapply(read.table(.file, stringsAsFactors = TRUE), as.integer)
  multiplier <- matrix(c(1, 0, 2, 2, 1, 0, 0, 2, 1), 3)
  score <- \(inds) sum((multiplier * 3)[inds] + inds[, 2])
  me <- apply(multiplier[input[, 1], ] + 1 == input[, 2], 1, which)
  c(part1 = score(input), part2 = score(cbind(input[, 1], me)))
}

solve2("data/02.txt")



# minimal
solve3 <- function(.file) {
  with(lapply(read.table(.file, stringsAsFactors = TRUE), as.integer),
    c(part1 = sum(V2 + (1 + V2 - V1) %% 3 * 3),
      part2 = sum((V1 + V2) %% 3 + 1 + 3 * (V2 - 1))))
}

solve3("data/02.txt")
