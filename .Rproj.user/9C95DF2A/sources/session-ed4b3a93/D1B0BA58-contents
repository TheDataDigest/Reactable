library(reactable)

# Sample data with more column types
data <- data.frame(
  Name = c("Alice", "Bob", "Carol", "David", "Eve"),
  Age = c(25, 30, 35, 40, 45),
  Category = c("A", "B", "A", "C", "B"),
  Score = c(0.88, 0.95, 0.85, 0.92, 0.78),
  Joined = as.Date(c("2020-01-15", "2019-06-22", "2021-04-10", "2020-11-05", "2019-09-23")),
  Active = c(TRUE, TRUE, FALSE, TRUE, FALSE),
  stringsAsFactors = FALSE
)

# Reactable table with different column types
reactable(
  data,
  columns = list(
    Name = colDef(name = "Full Name", align = "left", sortable = TRUE, filterable = TRUE),
    Age = colDef(name = "Age", align = "center", filterable = TRUE, sortable = TRUE, 
                 cell = function(value) { paste0(value, " years") }),  # Custom cell rendering
    Score = colDef(name = "Score (%)", align = "right", format = colFormat(percent = TRUE, digits = 1)),  # Percent format
    Joined = colDef(name = "Join Date", format = colFormat(date = TRUE, locales = "en-US")),  # Date formatting
    Active = colDef(name = "Active Member", align = "center", 
                    cell = function(value) { if (value) "✅" else "❌" },  # Custom rendering (Check/Uncheck)
                    filterable = TRUE)  # Enable filtering for TRUE/FALSE
  ),
  pagination = TRUE,
  defaultPageSize = 5,
  highlight = TRUE,  # Highlight rows on hover
  searchable = TRUE  # Global search box for the table
)
