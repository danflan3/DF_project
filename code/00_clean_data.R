here::i_am(
  "code/00_clean_data.R"
)

# load packages
packages <- c("tidyverse","dplyr","here","table1","ggplot2")

for (package in packages) {
  library(package, character.only=T)
}


# load SIM-DATA
push <- read.csv(here::here("data/simulated_push_data.csv"), header = TRUE)

## add sex variable -- MOVE TO SIM SCRIPT LATER
set.seed(123)
push$sex_en <- rbinom(nrow(push), 1, 0.5) + 1 # generates 1s and 2s with 50/50 probability

table(push$sex_en)  # verify distribution

## restrict sample to those with microbiologic evaluation for TB disease
table(push$microtb)

push_noeval <- push %>% filter(microtb == 0)
# 0 children in SIM-DATA not evaluated for TB

#count of participants started anti-TB trt prior to enrollment (attpriorenr<0)
push %>%
  filter(attpriorenr < 0) %>%
  count()
# 0 children in SIM-DATA started TB treatment prior to enrollment


## export data
saveRDS(
  push,
  file = here::here("data/push_sim_data.rds")
)
