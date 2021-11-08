library(here)
library(readr)

diseases <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")

write_csv(diseases, file = here("data-raw", "diseases.csv"))
