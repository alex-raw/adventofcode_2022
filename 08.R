is_visible <- \(x) x > cummax(c(0L, x[-length(x)]))

sum_visible <- function(m) {
  nr <- nrow(m)
  nc <- ncol(m)
  visible <- t(apply(m,          1L, is_visible)) |
             t(apply(m[, nc:1L], 1L, is_visible))[, nc:1L] |
               apply(m,          2L, is_visible) |
               apply(m[nr:1L, ], 2L, is_visible)[nr:1L, ]
  visible[c(1L, nr), ] <- TRUE
  visible[, c(1L, nc)] <- TRUE
  sum(visible)
}

los_1d <- function(vec) {
  sapply(seq_along(vec), function(i) {
      ln <- length(vec)
      x <- vec[i]
      vec[i] <- x - 1L
      losl <- which(vec[i:1] >= x)[1L] - 1L
      losr <- which(vec[i:ln] >= x)[1L] - 1L
      losl[is.na(losl)] <- i - 1L
      losr[is.na(losr)] <- ln - i
      losr * losl
  })
}

.solve <- function(filename) {
  width <- nchar(readLines(filename, n = 1))
  input <- as.matrix(read.fwf(filename, rep_len(1L, width)))
  score <- t(apply(input, 1L, los_1d)) * apply(input, 2L, los_1d)
  c(part1 = sum_visible(input), part2 = max(score))
}

.solve("data/08.txt")
