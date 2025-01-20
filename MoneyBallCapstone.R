library(data.table)
library(dplyr)

file.copy(
  from = "C:\\Users\\New\\Desktop\\R-Course-HTML-Notes\\R-Course-HTML-Notes\\R-for-Data-Science-and-Machine-Learning\\Training Exercises\\Capstone and Data Viz Projects\\Capstone Project\\Batting.csv",
  to = getwd()
)

file.copy(
  from = "C:\\Users\\New\\Desktop\\R-Course-HTML-Notes\\R-Course-HTML-Notes\\R-for-Data-Science-and-Machine-Learning\\Training Exercises\\Capstone and Data Viz Projects\\Capstone Project\\Salaries.csv",
  to = getwd()
)

Batting <- fread("Batting.csv")
Batting <- Batting %>%
  mutate(
    BattingAvg = H / AB,
    OnBasePercentage = (H + BB + HBP) / (AB + BB + HBP + SF),
    `1B` = H - `2B` - `3B` - HR,
    SluggingPercentage = (`1B` + (2 * `2B`) + (3 * `3B`) + (4 * HR)) / AB
  )

Sal <- fread("Salaries.csv")
Batting <- filter(Batting, yearID >= 1985)

combo <- merge(Batting, Sal, by = c("playerID", "yearID"))

lost_players <- combo %>%
  filter(playerID %in% c('giambja01', 'damonjo01', 'saenzol01')) %>%
  filter(yearID == 2001) %>%
  select(playerID, H, `2B`, `3B`, HR, OnBasePercentage, SluggingPercentage, BattingAvg, AB)

combo <- combo %>% filter(!playerID %in% lost_players$playerID) 
  
set.seed(42)

find_replacement_players <- function(data, salary_limit, AtBats_limit, meanOBP_limit, max_attempts = 1000) {
  data <- filter(data, !is.na(salary) & !is.na(AB) & !is.na(OnBasePercentage))
  attempts <- 0
  
  repeat {
    sampled_players <- sample_n(data, 3)
    
    combined_salary <- sum(sampled_players$salary)
    combined_AB <- sum(sampled_players$AB)
    mean_OBP <- mean(sampled_players$OnBasePercentage)
    
    if (combined_salary <= salary_limit &&
        combined_AB >= AtBats_limit &&
        mean_OBP >= meanOBP_limit) {
      return(sampled_players)
    }
    
    attempts <- attempts + 1
    if (attempts >= max_attempts) {
      stop("Unable to find suitable players after ", max_attempts, " attempts.")
    }
  }
}

replacement_players <- find_replacement_players(
  data = filter(combo, yearID == 2001),
  salary_limit = 15000000,
  AtBats_limit = sum(lost_players$AB),
  meanOBP_limit = mean(lost_players$OnBasePercentage)
)

library(ggplot2)
library(plotly)

pl4 <- ggplot(replacement_players, aes(x = salary, y = SluggingPercentage)) +
  geom_point(size = 4, color = "green") +
  geom_text(aes(label = playerID), hjust = 1.2, vjust = 1.2) +
  labs(
    title = "Performance Efficiency of Replacement Players") +
  theme_minimal()

print(ggplotly(pl4))

library(knitr)
library(kableExtra)

lost_table <- kable(lost_players , caption = "Summary of Lost Players (2001)") %>%
  kable_styling(bootstrap_options = c("striped", "hover"))

print(lost_table)

repl_table <- kable(replacement_players , caption = "Replacement Players") %>%
  kable_styling(bootstrap_options = c("striped","hover"))

print(repl_table)



replacement_players <- select(replacement_players, playerID, H, `2B`, `3B`, HR, OnBasePercentage, SluggingPercentage, BattingAvg, AB)

comparison.table <- rbind(
  lost_players %>% mutate(Group = "Lost"),
  replacement_players %>% mutate(Group = "Replacement")
)

pl <- comparison.table %>% ggplot(aes(x = Group , y = OnBasePercentage)) +
  geom_boxplot(aes(fill = Group)) +
  labs(title = "On-Base Percentage: Lost vs Replacement Players", y = "On-Base Percentage", x = "") +
  theme_minimal()
print(ggplotly(pl))

pl2 <- comparison.table %>% ggplot(aes(x = Group , y = BattingAvg)) +
  geom_boxplot(aes(fill = Group)) +
  labs(title = "Batting Average: Lost vs Replacement Players", y = "Batting Average", x = "") +
  theme_minimal()
print(ggplotly(pl2))

pl3 <- comparison.table %>% ggplot(aes(x = Group , y = SluggingPercentage)) +
  geom_boxplot(aes(fill = Group)) +
  labs(title = "Slugging Percentage: Lost vs Replacement Players", y = "Slugging Percentage", x = "") +
  theme_minimal()
print(ggplotly(pl3))















