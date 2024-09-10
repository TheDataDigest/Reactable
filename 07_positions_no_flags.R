library(dplyr)
library(reactable)
library(htmltools)

# Sample data
teams <- data.frame(
  rank = 1:5,
  Country = c("USA", "Germany", "Brazil", "France", "Argentina"),
  Players = c(23, 22, 21, 23, 22),
  Total_Value = c(1234000000, 987000000, 876000000, 789000000, 654000000),
  flag_url = c(
    "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg",
    "https://upload.wikimedia.org/wikipedia/en/b/ba/Flag_of_Germany.svg",
    "https://upload.wikimedia.org/wikipedia/en/0/05/Flag_of_Brazil.svg",
    "https://upload.wikimedia.org/wikipedia/en/c/c3/Flag_of_France.svg",
    "https://upload.wikimedia.org/wikipedia/commons/1/1a/Flag_of_Argentina.svg"
  )
)


# unique flag column
temp_flag <- reactable(
  data = teams,
  columns = list(
    rank = colDef(name = "Rank"),
    flag_url = colDef(
      name = "",
      cell = function(value) {
        img(src = value, height = "20px")
      },
      maxWidth = 50
    ),
    Country = colDef(name = "Country", align = "left"),
    Players = colDef(name = "# Players"),
    Total_Value = colDef(name = "Total Value")
  )
)

saveWidget(temp_flag, "temp_flag1.html", selfcontained = TRUE)

# interesting problem found, url being at the end of the data means end of html file
columnOrder = c("rank", "flag_url", "Country", "Players", "Total_Value")  # Define the column order

# chatGPT halucination again. columnOrder does not exist.
#https://github.com/glin/reactable/issues/172



temp_flag <- reactable(
  data = teams,
  columns = list(
    rank = colDef(name = "Rank"),
    flag_url = colDef(
      name = "Flag",
      cell = function(value) {
        img(src = value, height = "20px")
      },
      maxWidth = 50
    ),
    Country = colDef(name = "Country", align = "left"),
    Players = colDef(name = "# Players"),
    Total_Value = colDef(name = "Total Value")
  )
) # teams column order is key. Use select to bring into right shape

saveWidget(temp_flag, "temp_flag4.html", selfcontained = TRUE)


# Create the reactable with a custom cell function for the country column
temp_flag <- reactable(
  data = teams,
  columns = list(
    rank = colDef(name = "Rank"),
    Country = colDef(
      name = "Country",
      cell = function(value, index) {
        # Create the flag image element
        flag <- img(src = teams$flag_url[index], height = "20px", style = "margin-right: 8px;")
        # Combine the flag image and country name
        tagList(flag, value)
      },
      align = "left"
    ),
    Players = colDef(name = "# Players"),
    Total_Value = colDef(name = "Total Value")
  )
)


saveWidget(temp_flag, "temp_flag3.html", selfcontained = TRUE)
