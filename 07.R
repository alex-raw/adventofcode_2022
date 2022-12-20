.data <- readLines("data/07.txt")
.data <- .data[.data != "$ ls" & !startsWith(.data, "dir ")]
.data <- gsub("\\$ cd |(\\d+) .*", "\\1", .data)
is_dir <- is.na(as.integer(.data)) |> suppressWarnings()
is_dots <- .data == ".."

dirs <- unique(.data[is_dir & !is_dots])
current_dirs <- character()
sums <- numeric(length(dirs))
names(sums) <- dirs

for (i in seq_along(.data)) {
  if (is_dots[i]) {
    current_dirs <- current_dirs[-length(current_dirs)]
  } else if (is_dir[i]) {
    current_dirs <- c(current_dirs, .data[i])
  } else {
    for (.dir in current_dirs) {
      sums[.dir] <- sums[.dir] + as.numeric(.data[i])
    }
  }
}

sum(sums[sums <= 100000])

# abandoned and moved to julia
