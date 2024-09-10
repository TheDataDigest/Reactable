# Basic usage
reactable(iris)

# Grouping and aggregation
reactable(data = iris,
  groupBy = "Species",
  columns = list(
    Sepal.Length = colDef(aggregate = "count"),
    Sepal.Width = colDef(aggregate = "mean"),
    Petal.Length = colDef(aggregate = "sum"),
    Petal.Width = colDef(aggregate = "max")
  )
)

reactable(data = iris,
          groupBy = "Species",
          columns = list(
            Sepal.Length = colDef(aggregate = "count", name = "count N"),
            Sepal.Width = colDef(aggregate = "mean", name = "SW_mean"),
            Petal.Length = colDef(aggregate = "median", name = "PL_median"),
            Petal.Width = colDef(aggregate = "max", name = "PW_max")
          )
)

# great feature
reactable(data = iris,
          groupBy = "Species",
          columns = list(
            Sepal.Length = colDef(aggregate = "mean"),
            Sepal.Width = colDef(aggregate = "mean"),
            Petal.Length = colDef(aggregate = "mean"),
            Petal.Width = colDef(aggregate = "mean")
          )
)

# Row details
reactable(iris, details = function(index) {
  htmltools::div(
    "Details for row: ", index,
    htmltools::tags$pre(paste(capture.output(iris[index, ]), collapse = "\n"))
  )
})


# Conditional styling
reactable(sleep, columns = list(
  extra = colDef(style = function(value) {
    if (value > 0) {
      color <- "green"
    } else if (value < 0) {
      color <- "red"
    } else {
      color <- "#777"
    }
    list(color = color, fontWeight = "bold")
  })
))
