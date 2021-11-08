library(dplyr)
library(ggplot2)
library(here)
library(hrbrthemes)
library(readr)

diseases <- read_csv(here("data-raw", "diseases.csv"))

X <- diseases %>%
  mutate(rate = count / population * 100000 * 52 / weeks_reporting) %>%
  mutate(state = reorder(state, desc(state)))

colours <- colorRampPalette(c("royalblue", "green", "yellow", "orange", "red"), bias = 3.5)

X %>%
  filter(disease %in% c("Pertussis", "Measles", "Polio")) %>%
  ggplot(aes(year, state, fill = rate)) +
  geom_tile(color = "white", size = 0.35) +
  scale_x_continuous(expand = c(0,0)) +
  scale_fill_gradientn(colors = colours(20), na.value = 'grey95') +
  labs(
    x = "",
    y = "",
    title = "Battling Measles in the 20th Century",
    subtitle = "The Impact of Vaccines",
    caption = ""
  ) +
  theme_ipsum_rc() +
  theme(
    legend.position = "bottom"
  ) +
  facet_wrap(~disease, ncol = 1, scales = "free_x")

ggsave(here("plots", "diseases.png"), bg = "white", height = 9000, width = 3000, units = "px")
