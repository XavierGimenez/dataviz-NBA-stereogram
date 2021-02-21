# datasets downloaded from https://www.kaggle.com/drgilermo/nba-players-stats

library("dplyr")
library("tidyr")

df_seasons <- read.csv('dataset/Seasons_Stats.csv', sep = ',', header = TRUE) %>%
  select(Year, Player, Age)

df_players <- read.csv('dataset/Players.csv', sep = ',', header = TRUE) %>%
  select(Player, weight, height)

## add height and weight of players to the seasons
df_seasons_players <- left_join(df_seasons, df_players, by='Player') %>%
  select(Year, Player, Age, height, weight) %>%
  mutate(
    Year = as.factor(Year),
    Player = as.factor(Player),
    #Age = as.factor(Age),
    #height = as.factor(height),
    #weight = as.factor(weight)
  )



#################
###### AGE ######

# count players by season and age
age_by_season <- df_seasons_players %>% 
  group_by(Year, Age) %>% 
  summarise(total = n()) %>%
  ungroup()

# generate combinations of <season,age> so we have all possible
# ages present in all seasons
all_ages_by_season <- age_by_season %>% 
  expand(Year, Age) %>%
  # expand should not contain duplicates, but...
  distinct(Year, Age) %>%
  drop_na()

# make missing values explicit (those ages not present in a given season)
age_by_season_complete <- right_join(
    age_by_season, 
    all_ages_by_season, 
    by=c("Year", "Age")
  ) %>% 
  replace_na(list(total = 0)) %>%
  arrange(Year, Age) %>%
  # although we have created all possibles combinations of
  # the year and the mesure, we would like to have continuous
  # values (a complete sequence without gaps), so fill the missing
  # values
  group_by(Year) %>%
  complete(
    age = min(age):max(age),
    fill = list(total = 0)
  ) %>%
  ungroup()

# save
colnames(age_by_season_complete) <- c('season', 'age', 'total')
write.csv(age_by_season_complete, file="dataset/summaries_all_seasons_age.csv", row.names=FALSE, sep=",")



####################
###### weight ######

# count players by season and weight
weight_by_season <- df_seasons_players %>% 
  group_by(Year, weight) %>% 
  summarise(total = n()) %>%
  ungroup()

# generate combinations of <season,age> so we have all possible
# ages present in all seasons
all_weights_by_season <- weight_by_season %>% 
  expand(Year, weight) %>%
  # expand should not contain duplicates, but...
  distinct(Year, weight) %>%
  drop_na()

# make missing values explicit (those ages not present in a given season)
weight_by_season_complete <- right_join(
  weight_by_season, 
  all_weights_by_season, 
  by=c("Year", "weight")
) %>% 
  replace_na(list(total = 0)) %>%
  arrange(Year, weight) %>%
  # although we have created all possibles combinations of
  # the year and the mesure, we would like to have continuous
  # values (a complete sequence without gaps), so fill the missing
  # values
  group_by(Year) %>%
  complete(
    weight = min(weight):max(weight),
    fill = list(total = 0)
  ) %>%
  ungroup()

colnames(weight_by_season_complete) <- c('season', 'weight', 'total')

# bin variables so we try to avoid holes in the data visualization
step <- 3
weight_by_season_complete <- weight_by_season_complete %>% 
  mutate(window = weight %/% step) %>% 
  group_by(season,window) %>% summarise(total_bin = sum(total)) %>%
  mutate(start = window*step, stop=(window+1)*step) %>%
  select(-window, -stop) %>%
  rename(
    weight = start,
    total = total_bin
  )

write.csv(weight_by_season_complete, file="dataset/summaries_all_seasons_weight.csv", row.names=FALSE, sep=",")



####################
###### height ######

# count players by season and height
height_by_season <- df_seasons_players %>% 
  group_by(Year, height) %>% 
  summarise(total = n()) %>%
  ungroup()

# generate combinations of <season,age> so we have all possible
# ages present in all seasons
all_heights_by_season <- height_by_season %>% 
  expand(Year, height) %>%
  # expand should not contain duplicates, but...
  distinct(Year, height) %>%
  drop_na()

# make missing values explicit (those ages not present in a given season)
height_by_season_complete <- right_join(
    height_by_season, 
    all_heights_by_season, 
    by=c("Year", "height")
  ) %>% 
  replace_na(list(total = 0)) %>%
  arrange(Year, height) %>%
  # although we have created all possibles combinations of
  # the year and the mesure, we would like to have continuous
  # values (a complete sequence without gaps), so fill the missing
  # values
  group_by(Year) %>%
  complete(
    height = min(height):max(height),
    fill = list(total = 0)
  ) %>%
  ungroup()

# save
colnames(height_by_season_complete) <- c('season', 'height', 'total')

# bin variables so we try to avoid holes in the data visualization
step <- 3
height_by_season_complete <- height_by_season_complete %>% 
  mutate(window = height %/% step) %>% 
  group_by(season,window) %>% summarise(total_bin = sum(total)) %>%
  mutate(start = window*step, stop=(window+1)*step) %>%
  select(-window, -stop) %>%
  rename(
    height = start,
    total = total_bin
  )

write.csv(height_by_season_complete, file="dataset/summaries_all_seasons_height.csv", row.names=FALSE, sep=",")