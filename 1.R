max_n_weight <- function(.file, n = 1) {
  calories <- scan(.file, integer(), blank.lines.skip = FALSE, quiet = TRUE)
  calories[is.na(calories)] <- 0L
  csums <- cumsum(calories)
  sums <- diff(c(csums[1L], csums[duplicated(csums)]))
  if (n == 1L) return(max(sums))
  sort(sums, decreasing = TRUE)[seq_len(n)] |>
    sum()
}

c(part1 = max_n_weight("data/1.txt"),
  part2 = max_n_weight("data/1.txt", 3))
