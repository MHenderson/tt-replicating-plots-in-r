library(dplyr)
library(ggplot2)
library(here)
library(hrbrthemes)
library(readr)

diseases <- read_csv(here("data-raw", "diseases.csv"))

diseases %>%
  filter(disease == "Measles") %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) %>%
  mutate(state = reorder(state, desc(state))) %>%
  ggplot(aes(year, state, fill = rate)) +
  geom_tile(color = "white", size = 0.35) +
  scale_x_continuous(expand = c(0,0)) +
  scale_fill_gradient(
    low = "azure2",
    high = "darkslategrey",
    na.value = 'white'
  ) +
  labs(
    x = "",
    y = "",
    title = "Battling Measles in the 20th Century",
    subtitle = "The Impact of Vaccines",
    caption = ""
  ) +
  theme_ipsum_rc()

ggsave(here("plots", "diseases.png"), bg = "white")
