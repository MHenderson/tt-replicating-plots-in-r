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
       name = disease_rates,
    command = { diseases |>      
      mutate(rate = count / population * 100000 * 52 / weeks_reporting) |>
      mutate(state = reorder(state, desc(state)))
    }
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
       name = diseases_plot,
    command = {
      
      colours <- colorRampPalette(c("#F0FFFF", "cyan", "#007FFF", "yellow", "#FFBF00", "orange", "red", "#7F0000"), bias = 2.25)

      vermont_1936_rate <- disease_rates |> filter(disease == "Measles", year == 1936, state == "Vermont") |> pull(rate)
      vermont_1936_label <- paste("In Vermont in 1936\n the rate was ", round(vermont_1936_rate, 0), "\n per 100,000 people.")

      utah_1942_rate <- disease_rates |> filter(disease == "Measles", year == 1942, state == "Utah") |> pull(rate)
      utah_1942_label <- paste("In Utah in 1942\n the rate was ", round(utah_1942_rate, 0), "\n per 100,000 people.")

      disease_rates |>
	filter(disease %in% c("Measles")) |>
	  ggplot(aes(year, state, fill = rate)) +
	    geom_tile(colour = "white", size = 0.5) +
	    geom_vline(xintercept = 1963, col = "black", size = 2, alpha = .5) +
	    scale_x_continuous(breaks = seq(1930, 2010, 10), expand = c(0,0)) +
	    scale_fill_gradientn(colors = colours(16), na.value = 'white') +
	    coord_equal(clip = "off", ylim = c(1, 50)) +
	    labs(
	             x = "",
	             y = "",
	         title = "Battling Infectious Diseases in the 20th Century:\nThe Impact of Vaccines",
	      subtitle = "Measles cases per 100,000 people measured over seventy years\nacross all fifty states and the District of Columbia.",
	       caption = "Note: CDC data from 2003-2012 comes from its Summary of Notifiable Diseases, which\n publishes yearly rather than weekly and counts confirmed cases as opposed to provisional ones."
	    ) +
	    theme_ipsum_rc() +
	    theme(
	      legend.position = "bottom",
	         legend.title = element_blank(),
	           plot.title = element_text(size = 32, margin = margin(0, 0, 20, 0)),
	        plot.subtitle = element_text(size = 22, margin = margin(0, 0, 50, 0))
	    ) +
	    annotate(geom = "text", x = 1968, y = 54, label = "Vaccine introduced in 1963", size = 4, hjust = -.2, family = "Roboto Condensed") +
	    annotate("curve", x = 1970, y = 54, xend = 1963, yend = "Alabama", color = "grey40", curvature = 0.3, size = 1) +
	    annotate(geom = "text", x = 1945, y = -8, label = utah_1942_label, size = 4, hjust = 1, family = "Roboto Condensed") +
	    annotate("curve", x = 1945, y = -5, xend = 1942, yend = "Utah", color = "grey40", curvature = 0.4, size = 1) +
	    annotate(geom = "text", x = 1930, y = -8, label = vermont_1936_label, size = 4, hjust = 1, family = "Roboto Condensed") +
	    annotate("curve", x = 1930, y = -5, xend = 1936, yend = "Vermont", color = "grey40", curvature = 0.4, size = 1)
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
  ),
  tar_target(
       name = save_diseases_plot,
    command = ggsave(
          plot = diseases_plot,
      filename = "plots/diseases.png",
            bg = "white",
        height = 4000,
         width = 4000,
         units = "px"
    )
  )
)
