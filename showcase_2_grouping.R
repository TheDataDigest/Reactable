library(reactable)

# Sample data
data <- data.frame(
  Name = c("Alice", "Bob", "Carol", "David", "Eve"),
  Age = c(25, 30, 35, 40, 45),
  Category = c("A", "B", "A", "C", "B"),
  Score = c(88, 95, 85, 92, 78),
  stringsAsFactors = FALSE
)

# Simple reactable table
reactable(
  data,
  columns = list(
    Name = colDef(name = "Full Name", sortable = TRUE),
    Age = colDef(name = "Age", sortable = TRUE),
    Score = colDef(name = "Score", sortable = TRUE, format = colFormat(digits = 0)),
    Category = colDef(name = "Category", sortable = TRUE)
  ),
  groupBy = "Category",  # Group by the 'Category' column
  pagination = TRUE,  # Enable pagination
  defaultSorted = "Age"  # Sort by Age by default
)
