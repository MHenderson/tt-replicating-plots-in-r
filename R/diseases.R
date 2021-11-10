library(dplyr)
library(ggplot2)
library(here)
library(hrbrthemes)
library(readr)

diseases <- read_csv(here("data-raw", "diseases.csv"))

X <- diseases %>%
  mutate(rate = count / population * 100000 * 52 / weeks_reporting) %>%
  mutate(state = reorder(state, desc(state)))

colours <- colorRampPalette(c("#F0FFFF", "cyan", "#007FFF", "yellow", "#FFBF00", "orange", "red", "#7F0000"), bias = 2.25)

X %>%
  filter(disease %in% c("Measles")) %>%
  ggplot(aes(year, state, fill = rate)) +
  geom_tile(colour = "white", size = 0.5) +
  geom_vline(xintercept = 1963, col = "black", size = 2, alpha = .5) +
  scale_x_continuous(breaks = seq(1930, 2010, 10), expand = c(0,0)) +
  scale_fill_gradientn(colors = colours(16), na.value = 'white') +
  coord_equal() +
  labs(
    x = "",
    y = "",
    title = "Measles",
    subtitle = "Number of cases per 100,000 people.",
    caption = "Note: CDC data from 2003-2012 comes from its Summary of Notifiable Diseases, which\n publishes yearly rather than weekly and counts confirmed cases as opposed to provisional ones."
  ) +
  theme_ipsum_rc() +
  theme(
    legend.position = "bottom",
    legend.title = element_blank()
  ) +
  annotate(geom = "text", x = 1963, y = 42, label = "Vaccine introduced in 1963", size = 6, hjust = -.1)

ggsave(here("plots", "diseases.png"), bg = "white", height = 4000, width = 4000, units = "px")
