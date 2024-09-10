# Install reactable if you haven't
# install.packages("reactable")

library(reactable)

# Sample data
data <- data.frame(
  Name = c("Alice", "Bob", "Carol", "David", "Eve"),
  Age = c(25, 30, 35, 40, 45),
  Score = c(88, 95, 85, 92, 78),
  Category = c("A", "B", "A", "C", "B"),
  Details = c("Details about Alice", "Bob's additional info", "Carol's notes", 
              "David's details", "Eve's information"),
  stringsAsFactors = FALSE
)

# Showcase of reactable with various column types
reactable(
  data,
  columns = list(
    # Basic text column with sorting enabled
    Name = colDef(
      name = "Full Name", 
      sortable = TRUE, 
      filterable = TRUE
    ),
    
    # Numeric column with custom alignment and formatting
    Age = colDef(
      name = "Age (years)", 
      align = "right", 
      format = colFormat(digits = 0),
      sortable = TRUE
    ),
    
    # Custom cell rendering and aggregation
    Score = colDef(
      name = "Score (%)", 
      format = colFormat(percent = TRUE, digits = 1),
      sortable = TRUE,
      cell = function(value) {
        if (value >= 90) {
          paste0(value, " 💯")
        } else if (value < 80) {
          paste0(value, " 😟")
        } else {
          paste0(value, " 😐")
        }
      },
      aggregated = "mean"
    ),
    
    # Grouping column with custom alignment and rendering
    Category = colDef(
      name = "Category",
      align = "center",
      sortable = TRUE,
      filterable = TRUE,
      group = TRUE
    ),
    
    # HTML content within a cell
    Details = colDef(
      name = "Additional Details",
      html = TRUE,
      cell = function(value) {
        paste("<b>", value, "</b>")
      }
    )
  ),
  
  # Group by category, with aggregation on score
  groupBy = "Category",
  
  # Enable pagination
  pagination = TRUE,
  
  # Enable default sorting and show total rows per page
  defaultSorted = "Age",
  showPageSizeOptions = TRUE,
  pageSizeOptions = c(2, 5, 10)
)
