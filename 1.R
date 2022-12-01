solve <- function(.file) {
  calories <- scan(.file, integer(), blank.lines.skip = FALSE, quiet = TRUE)
  calories[is.na(calories)] <- 0L
  csums <- cumsum(calories)
  sums <- c(csums[1L], diff(csums[duplicated(csums)]))
  c(part1 = max(sums),
    part2 = sum(sort(sums, decreasing = TRUE)[1:3]))
}

solve("data/1.txt")
