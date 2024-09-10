library(tidyverse)
library(reactablefmtr)
library(sysfonts)
library(showtext)
library(htmltools)
library(htmlwidgets)


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


#SUBTABLE DATA, group data by fitness discipline ----
players <- euro2024 %>% 
  select(Number, Country, Name, Value, Games, Goals, Age, `Position Basic`)


#color palette for difficulty scale
pal_strive<-c('#50C4AA', '#B6C95C', '#FACB3E', '#FC800F', '#FF4759')

#Create Reactable
table<-reactable(data = teams, 
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
                   Country = colDef(name="COUNTRY", align="left", vAlign="center", width=220),
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
                 ),
  #Sub-Table - nested reactable, when user clicks on instructor, details show aggregates by modal per instructor
  details = function(index){
    new = players[players$Country == teams$Country[index],]
    reactable(data=new,
               defaultColDef = colDef(vAlign="center", align="center", headerVAlign="center"),
               theme = reactableTheme(
                 style=list(fontFamily="Roboto"),
                 searchInputStyle = list(background="black"),
                 pageButtonStyle = list(fontSize=14),
                 backgroundColor="black",
                 color="white",
                 footerStyle = list(color="white", fontSize=11),
                 borderColor="black",
                 borderWidth=0.019
               ),
              # columns = list(
              #   instructor=colDef(show=FALSE),
              #   image_path = colDef(name="", width=265),
              #   discipline = colDef(name="", maxWidth=130, align="left", footer="Breakout by Type", footerStyle=list(color='black')),
              #   rank = colDef(name="", style=list(fontSize=13), maxWidth=50, align="right"),
              #   workouts= colDef(name="", minWidth=120),
              #   minutes=colDef(name="", minWidth=160, 
              #                  cell=data_bars(new, 
              #                                 bar_height=8,
              #                                 text_size=11,
              #                                 text_color="white",
              #                                 text_position = "outside-end", 
              #                                 background = "transparent", 
              #                                 round_edges = TRUE, 
              #                                 fill_color=c("#FFBC51",'#FF3A3A'), 
              #                                 fill_gradient = TRUE)),
              #   difficulty = colDef(name="", align="center", maxWidth=120, 
              #                       cell=color_tiles(new, bias= 0.4, colors=pal_strive)),
              #   workout_data = colDef(name="",  maxWidth=100,
              #                         cell=react_sparkline(new, labels=c("first","last"), 
              #                                              line_color = "white")
              #   ))
    )
  }
)%>%
  google_font(font_family="Roboto", font_weight = 300)



saveWidget(table, "05_nested_empty.html", selfcontained = TRUE)
