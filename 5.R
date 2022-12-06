get_warehouse <- function(.file, n) {
  crates <- read.fwf(.file, c(3, rep(4, 8)), n = n) |>
    sapply(\(x) gsub("[^A-Z]", "", x))
  crates[seq(nrow(crates), 1), ] |>
    rbind(matrix("", length(crates), ncol(crates)))
}

stack_crates <- function(warehouse, instructions, heights, part2 = FALSE) {
  mapply(function(k, from, to) {
    xfrom <- seq(heights[from], by = -1, length.out = k)
    xto <- seq(heights[to] + 1, length.out = k)
    f <- if (part2) rev else identity
    warehouse[xto, to] <<- f(warehouse[xfrom, from])
    warehouse[xfrom, from] <<- ""
    heights[from] <<- heights[from] - k
    heights[to] <<- heights[to] + k
  }, instructions[[1]], instructions[[2]], instructions[[3]])

  apply(warehouse, 2, \(x) tail(x[nzchar(x)], 1)) |>
    paste(collapse = "")
}

.solve <- function(.file) {
  .lines <- readLines(.file)
  bottom <- which(!nzchar(.lines))
  warehouse <- get_warehouse(.file, bottom - 2)
  instructions <- read.table(
    text = .lines[-seq_len(bottom)],
    colClasses = rep(list(NULL, "integer"), 3)
  )
  heights <- colSums(warehouse != "")
  c(part1 = stack_crates(warehouse, instructions, heights),
    part2 = stack_crates(warehouse, instructions, heights, part2 = TRUE))
}

.solve("data/05.txt")
