library(targets)

tar_option_set(
  packages = c("readr", "tibble")
)

list(
  tar_target(
       name = diseases,
    command = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")
  ),
  tar_target(
       name = gun_murders,
    command = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/gun_murders.csv")
  )
)
