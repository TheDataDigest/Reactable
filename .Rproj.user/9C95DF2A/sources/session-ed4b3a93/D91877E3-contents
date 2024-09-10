
teams <- data.frame(
  Rank = 1:5,
  Country = c("USA", "Germany", "Brazil", "France", "Argentina"),
  Players = c(23, 22, 21, 23, 22),
  Total_Value = c(1234000000, 987000000, 876000000, 789000000, 654000000),
  Total_Games = c(3, 4, 3, 5, 4),
  Total_Goals = c(5, 8, 6, 7, 4),
  Age_average = c(25.4, 26.1, 27.3, 25.9, 28.0)
)

# Preprocess data to create a formatted text column
teams <- teams %>%
  mutate(
    Total_Value_Text = scales::label_dollar(scale = 1/1e6, suffix = " million")(Total_Value)
  )

# Create the reactable with a custom cell function
t1 <- reactable(data = teams, 
          columns = list(
            Rank = colDef(name = "", maxWidth = 50, align = "right"),
            Country = colDef(name = "COUNTRY", align = "left"),
            Players = colDef(name = "# PLAYERS", maxWidth = 130, align = "left"),
            Total_Value = colDef(
              name = "TOTAL VALUE",
              cell = function(value, index) {
                bar <- data_bars(
                  data = teams,
                  column = "Total_Value",
                  bar_height = 8,
                  text_size = 11,
                  fill_color = c("#FFBC51", '#FF3A3A'),
                  fill_gradient = TRUE
                )
                # Return the bar plus the formatted label
                htmltools::div(
                  bar[[index]], # Bar component
                  htmltools::span(teams$Total_Value_Text[index], 
                                  style = "margin-left: 8px; 
                                  color: white; 
                                  font-size: 11px;") # Text component
                )
              }
            ),
            Total_Games = colDef(name = "TOTAL GAMES", maxWidth = 130, align = "right"),
            Total_Goals = colDef(name = "TOTAL GOALS", maxWidth = 130, align = "right"),
            Age_average = colDef(name = "AVG AGE", align = "center", maxWidth = 120)
          )
)
