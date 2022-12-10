.solve <- function(input, nr = 6L, nc = 40L) {
  input[is.na(input)] <- 0L
  input[1] <- 1L
  x <- cumsum(input)
  n <- nr * nc
  checkpoints <- seq(nc %/% 2, n, by = nc)
  part1 <- sum(x[checkpoints - 1L] * checkpoints)
  part2 <- matrix(abs((seq_len(n) - 1L) %% nc - c(1L, x[-n])) <= 1L, nc)
  message("part 1: ", part1, "\npart 2: ")
  apply(ifelse(part2, "#", " "), 2L, message)
}

.solve(scan("data/10.txt", na.string= c("addx", "noop"), quiet = TRUE))
