.solve <- function(x, ln)
  for (i in seq_along(x))
    if (!anyDuplicated(x[seq(i, offset <- i + ln - 1)]))
      return(offset)

.data <- strsplit(readLines("data/06.txt"), "")[[1]]
c(part1 = .solve(.data, 4), part2 = .solve(.data, 14))
