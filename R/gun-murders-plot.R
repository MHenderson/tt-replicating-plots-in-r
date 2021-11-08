library(dplyr)
library(ggplot2)
library(here)
library(hrbrthemes)
library(readr)

gun_murders <- read_csv(here("data-raw", "gun_murders.csv"))

gun_murders %>%
  mutate(
    country = reorder(country, count)
  ) %>%
  ggplot(aes(country, count)) +
  geom_point() +
  labs(
    title = "Homicide in the G8",
    subtitle = "Rates of homicide in G8 member countries.",
    caption = "source: United Nations Office on Drugs and Crime",
    x = "",
    y = "Gun-related homicides\nper 100,000 people"
  ) +
  coord_flip() +
  theme_ipsum_rc()

ggsave(here("plots", "gun-murders.png"), bg = "white", height = 2000, width = 2000, units = "px")
