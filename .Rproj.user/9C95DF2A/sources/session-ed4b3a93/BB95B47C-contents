
# load packages
library(tidyverse)
#library(reactable)
library(reactablefmtr) #Streamlined Table Styling and Formatting for Reactable (dependency)
library(janitor)
library(sysfonts)
library(showtext)
library(showtextdb)
library(htmltools)
library(htmlwidgets)
install.packages("ggflags", repos = c(
  "https://jimjam-slam.r-universe.dev",
  "https://cloud.r-project.org"))
library(ggflags)

# load euro2024 data and prepare it
euro2024_BU <- readRDS(file = "euro24.rds")

euro2024 <- euro2024_BU %>% 
  select(country, group, Name, Number, Position_basic, Age, Value, Height_m, Foot, International_matches, Goals, Debut, Birth_date) %>% 
  rename("Games" = "International_matches") %>% 
  clean_names(case = "title")


# 0.1 - First try, smallest code (fewest lines) necessary ---- 

#! main question is how the country values are combined with the nested data, summarize, join?

# country summary (before nesting)
teams <- euro2024 %>% 
  group_by(Country) %>% 
  summarize(Players = n(),
            Total_Value = sum(Value),
            Total_Games = sum(Games, na.rm = T),
            Total_Goals = sum(Goals, na.rm = T),
            Age_average = mean(Age)) %>% 
  ungroup() %>% 
  mutate(Rank = row_number()) %>% 
  select(Rank, everything())


#Create Reactable
pal_strive<-c('#50C4AA', '#B6C95C', '#FACB3E', '#FC800F', '#FF4759')

table <- reactable(data = teams, 
                   theme = reactableTheme(
                     style=list(fontFamily="Roboto"),
                     searchInputStyle = list(background="black"),
                     pageButtonStyle = list(fontSize=14),
                     backgroundColor="black",
                     color="white",
                     footerStyle = list(color="white", fontSize=11),
                     borderColor="#3D3D3D",
                     borderWidth=0.019
                   ),
                   defaultColDef = colDef(vAlign="center", align="center", headerVAlign="center"),
                   columns = list(
                     rank = colDef(name="", style=list(fontSize=13), maxWidth=50, align="right"),
                     image_path = colDef(show=FALSE),
                     Country = colDef(name="COUNTRY", align="left", vAlign="center", width=220, cell = function(value) {
                       image <- img(src = flag_url, style = "height: 33px;", alt = value)
                       tagList(
                         div(style = "display: inline-block;vertical-align:middle;width:50px", image),
                         div(style = "display: inline-block;vertical-align:middle;", value)
                       )
                     },
                     #Country = colDef(name="COUNTRY", align="left", vAlign="center", width=220),
                     Players = colDef(name="# PLAYERS", maxWidth=130, align="left"),
                     Total_Value = colDef(name="TOTAL VALUE", minWidth=160, 
                                          cell=data_bars(data = teams, 
                                                         bar_height=8,
                                                         text_size=11,
                                                         text_color="white",
                                                         text_position = "outside-end", 
                                                         background = "transparent", 
                                                         round_edges = TRUE, 
                                                         fill_color=c("#FFBC51",'#FF3A3A'), 
                                                         fill_gradient = TRUE)),
                     Total_Games = colDef(name="TOTAL GAMES", maxWidth=130, align="right"),
                     Total_Goals  = colDef(name="TOTAL GOALS", maxWidth=130, align="right"),
                     Age_average = colDef(name="AVG AGE", align="center", maxWidth=120, 
                                          footer="Mean age of players",
                                          cell=color_tiles(data = teams, bias= 0.4, colors=pal_strive))
                   )) %>%
  google_font(font_family="Roboto", font_weight = 300)



#use html widgest to prepend an dappend header and footer
html_object <- table 


saveWidget(html_object, "02_teams_flags.html", selfcontained = TRUE)

#### round age
Age_average = colDef(name = "AVG AGE", align = "center", maxWidth = 120, 
                     footer = "Mean age of players",
                     cell = function(value) {
                       round(value, 1)  # Round to 1 decimal place
                     },
                     cell = color_tiles(teams, bias = 0.4, colors = pal_strive))



#### fix labels (2 options)
# option A)
teams <- teams %>%
  mutate(Total_Value_Label = scales::label_dollar(scale = 1/1e6, suffix = " million")(Total_Value))

reactable(data = teams, 
          columns = list(
            Total_Value = colDef(name = "TOTAL VALUE", 
                                 cell = data_bars(teams, 
                                                  bar_height = 8,
                                                  text_size = 11,
                                                  text_color = "white",
                                                  text_position = "outside-end", 
                                                  background = "transparent", 
                                                  round_edges = TRUE, 
                                                  fill_color = c("#FFBC51", '#FF3A3A'), 
                                                  fill_gradient = TRUE,
                                                  label = teams$Total_Value_Label))
          )
)


#option B)
text_formatter = scales::label_dollar(scale = 1/1e6, suffix = " million")

#### merge group info
teams <- teams %>% left_join(euro2024 %>% select(Country, Group) %>% distinct()) %>% 
  select(Rank, Group, everything())

# 1.1 - set filters

# 2.1 - group by teams vs positions

positions <- euro2024 %>% 
  group_by(Country) %>% 
  summarize(Players = n(),
            Total_Value = sum(Value),
            Total_Games = sum(Games),
            Total_Goals = sum(Goals),
            Age_average = mean(Age))




# 0.2 - adding flags later
# 2 letter code needed
# https://github.com/jimjam-slam/ggflags

euro2024$flag <- countrycode::countrycode(sourcevar = euro2024$Country, 
                                          origin = 'country.name', 
                                          destination = 'iso2c')

euro2024$flag[is.na(euro2024$flag)] <- "GB"

# I think I need a flag url anyway
euro2024$flag_url <- paste0("https://en.wikipedia.org/wiki/File:Flag_of_", euro2024$Country, ".svg")






##



# after making it work, explain the different cell formats
?colDef # so that other users can learn something
# also with the different arguments and options (align center/right/left)

# show other YT tutorials as well for people that want some special solutions
# also use ChatGPT for details
# good combo, some understanding 1-2h video, some hands on experience 1-2h
# plus chatGPT support, unbeatable

# I wanted to learn that skill for my next video, turn notifications on to see what results I am producing



