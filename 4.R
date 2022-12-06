readLines("data/4.txt") |>
  strsplit(",|-") |>
  sapply(\(line) {
    (line[1] >= line[3] & line[2] <= line[4]) ||
    (line[3] >= line[1] & line[4] <= line[2])
  }) |> sum()
