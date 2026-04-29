here::i_am(
  "code/00_EDA.R"
)

library(dplyr)

# load clean data
push_data <- readRDS(here::here("data/push_sim_data.rds"))

n_distinct(push_data$study_id) #168 participants

summary(push_data$sex_en) #Categorical Var (1=Male, 2=Female)
  table(push_data$sex_en)
summary(push_data$enroll_ageyrs) #Continuous Var (years)
summary(push_data$cgeduc_en) #Categorical Var (NEED VALUES)
  table(push_data$cgeduc_en)
summary(push_data$resnum_en) #Categorical Var (# of people in home)
  table(push_data$resnum_en)
summary(push_data$roomnum_en) #Categorical Var (# of rooms in home)
  table(push_data$roomnum_en)
summary(push_data$primarymother) #Dichotomous Var (primary caregiver is mother; 0-No, 1=Yes)
  table(push_data$primarymother)

summary(push_data$immbcgbirth_en) #Dichotomous Var (0=No, 1=Yes)
  table(push_data$immbcgbirth_en)
summary(push_data$priorptb) #Dichotomous Var (0=No, 1=Yes)
  table(push_data$priorptb)
summary(push_data$priorhosp_en) #Dichotomous Var (0=No, 1=Yes)
  table(push_data$priorhosp_en)
summary(push_data$priorhospnum_en) #Continuous Var (# of hospitalizations)
  table(push_data$priorhospnum_en)

summary(push_data$tbcont_en) #Dichotomous Var (0=No, 1=Yes)
  table(push_data$tbcont_en)

#tb outcomes
summary(push_data$tbclass_new) #Categorical (1=Confirmed, 2=Unconfirmed, 3=Unlikely)
  table(push_data$tbclass_new)
