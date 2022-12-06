solve <- function(.file) {
  input <- lapply(strsplit(readLines(.file), ""), match, c(letters, LETTERS))
  .lengths <- lengths(input) / 2
  c(Map(\(line, ln) intersect(head(line, ln), tail(line, ln)), input, .lengths),
    tapply(input, gl(length(input) / 3, 3), \(x) Reduce(intersect, x)))
}

bench::mark(solve("data/03.txt"))
