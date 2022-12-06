solve <- function(.file) {
  calories <- scan(.file, integer(), blank.lines.skip = FALSE, quiet = TRUE)
  calories[is.na(calories)] <- 0L
  csums <- cumsum(calories)
  sums <- diff(c(0L, csums[duplicated(csums)]))
  c(part1 = max(sums),
    part2 = sum(sort(sums, decreasing = TRUE)[1:3]))
}

solve("data/01.txt")

# faster, smaller
solve2 <- function(.file) {
  calories <- scan(.file, integer(), blank.lines.skip = FALSE, quiet = TRUE)
  sums <- rowsum(calories, cumsum(is.na(calories)), na.rm = TRUE)
  c(part1 = max(sums),
    part2 = sum(sort(sums, decreasing = TRUE)[1:3]))
}

solve2("data/01.txt")
