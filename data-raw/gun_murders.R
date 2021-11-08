library(here)
library(readr)

gun_murders <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/gun_murders.csv")

write_csv(gun_murders, file = here("data-raw", "gun_murders.csv"))
