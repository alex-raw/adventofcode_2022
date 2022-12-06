solve <- function(.file) {
  input <- lapply(match, strsplit(readLines(.file), ""), c(letters, LETTERS))
  .lengths <- lengths(input) / 2
  c(Map(\(line, ln) intersect(head(line, ln), tail(line, ln)), input, .lengths),
    tapply(input, gl(length(input) / 3, 3), \(x) Reduce(intersect)))
}
