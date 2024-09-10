
## Function arguments


# columnGroups ----.
# Define column groups 
column_groups <- list(
  colGroup(name = "Engine", columns = c("disp", "cyl", "carb", "vs")),
  colGroup(name = "Performance", columns = c("mpg", "hp", "qsec")),
  colGroup(name = "Transmission", columns = c("am", "gear"))
)

# Create a reactable table with column groups
reactable(data = mtcars,
  columnGroups = column_groups,
  columns = list(
    disp = colDef(name = "Displacement (in³)"),
    mpg = colDef(name = "Miles per Gallon"),
    hp = colDef(name = "Horse Power"),
    cyl = colDef(name = "Cylinders"),
    vs = colDef(name = "V-shaped/ Straight"),
    gear = colDef(name = "Gears"),
    carb = colDef(name = "Carburetors"),
    am = colDef(name = "Automatic/Manual"),
    qsec = colDef(name = "1/4 mile time (sec)")
  )
)

# rownames ----
reactable(data = mtcars)
reactable(data = mtcars, rownames = FALSE)

# groupBy ----
# Create a reactable table with grouping and renaming
mtcars %>% 
  mutate(transmission = recode(am, `0` = "Automatic", `1` = "Manual"))

reactable(data = mtcars %>% 
            mutate(transmission = recode(am, `0` = "Automatic", `1` = "Manual")),
  groupBy = "transmission",
  defaultSorted = "mpg",
  defaultSortOrder = "asc")


# rename values ----
rename_values <- function(x) {
  dplyr::recode(x, `0` = "V-shaped", `1` = "Straight")
}

# Create a reactable table with customized column values
reactable(
  mtcars,
  columns = list(
    vs = colDef(
      name = "Engine Shape",
      cell = function(x) rename_values(x)
    )
  ),
  defaultPageSize = 10
)


# Sorting ----
mtcars %>% 
  mutate(transmission = recode(am, `0` = "Automatic", `1` = "Manual"))

reactable(data = mtcars %>% 
            mutate(transmission = recode(am, `0` = "Automatic", `1` = "Manual")),
          groupBy = "transmission",
          defaultSorted = "mpg",
#          defaultSortOrder = "asc")
          defaultSortOrder = "desc")


reactable(
  mtcars %>% 
    mutate(transmission = recode(am, `0` = "Automatic", `1` = "Manual")),
  groupBy = "transmission",
  defaultSorted = "mpg",
  defaultSortOrder = "desc",
  columns = list(
    transmission = colDef(
      width = 150  # Increase the width of the 'transmission' column
    )
  )
)

# resizable, filterable, searchable ----
reactable(data = mtcars,
          resizable = TRUE,
          filterable = TRUE,
          searchable = TRUE)

reactable(
  mtcars %>% 
    mutate(transmission = recode(am, `0` = "Automatic", `1` = "Manual")),
  resizable = TRUE, 
  groupBy = "transmission",
  defaultSorted = "mpg",
  defaultSortOrder = "asc")

# searchMethod ----

library(htmlwidgets)

# Custom search method (JavaScript)
customSearch <- JS(
  "function(rows, columnIds, filterValue) {
    return rows.filter(function(row) {
      // Case-sensitive search on the 'mpg' column only
      const mpg = row['mpg'];
      return mpg && mpg.toString().indexOf(filterValue) !== -1;
    });
  }"
)

# Create the reactable with custom search
reactable(
  mtcars,
  searchable = TRUE,  # Enable global search bar
  searchMethod = customSearch,  # Use the custom search method
  columns = list(
    mpg = colDef(name = "Miles per Gallon", searchable = TRUE),
    cyl = colDef(name = "Cylinders", searchable = FALSE),
    hp = colDef(name = "Horsepower", searchable = FALSE)
  )
)


# defaultColDef, defaultColGroup ----
  
  


