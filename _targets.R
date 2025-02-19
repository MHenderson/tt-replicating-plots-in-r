library(targets)

tar_option_set(
  packages = c("dplyr", "ggplot2", "hrbrthemes", "readr", "tibble")
)

list(
  tar_target(
       name = diseases,
    command = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/diseases.csv")
  ),
  tar_target(
       name = gun_murders,
    command = read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-12-10/gun_murders.csv")
  ),
  tar_target(
       name = gun_murders_plot,
    command = {
      gun_murders |>
	mutate(
	  country = reorder(country, count)
	) |>
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
    }
  ),
  tar_target(
       name = save_gun_murders_plot,
    command = ggsave(
          plot = gun_murders_plot,
      filename = "plots/gun-murders.png",
            bg = "white",
        height = 2000,
         width = 2000,
         units = "px"
    )
  )
)
