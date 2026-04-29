here::i_am(
  "code/01_make_table1.R"
)

library(dplyr)
library(tidyverse)
library(table1)

# load clean data
push_data <- readRDS(here::here("data/push_sim_data.rds"))

##assign factor labels to categorical/dichotomous variables of interest
push_data$sex_en <- factor(push_data$sex_en, levels = c(1, 2), labels = c("Male", "Female"))
push_data$tbclass_new <- factor(push_data$tbclass_new, levels = c(1, 2, 3), labels = c("Confirmed", "Unconfirmed", "Unlikely"))

##label variable headings for table1
label(push_data$sex_en) <- "Participant Sex"
label(push_data$enroll_ageyrs) <- "Age at Enrollment"
units(push_data$enroll_ageyrs) <- "years"
label(push_data$tbclass_new) <- "TB Disease"
strata <- c(list(Overall = push_data), split(push_data, push_data$tbclass_new))
labels <- list(
  variables = list(
    sex_en = render.varlabel(push_data$sex_en),
    enroll_ageyrs = render.varlabel(push_data$enroll_ageyrs)
  ),
  groups = list("", "TB Disease")
)

my.render.cont <- function(x) {
  with(stats.default(x), c("",
    "Mean (SD)" = sprintf("%0.1f (%0.1f)", MEAN, SD)
  ))
}

my.render.cat <- function(x) {
  c("", sapply(stats.default(x), function(y) with(y,
    sprintf("%d (%0.0f%%)", FREQ, PCT)
  )))
}

caption <- "Table 1. Basic demographics of PUSH trial participants (n=133) by TB Disease Status"
footnote <- c(
  "Continuous variables reported as Mean (SD).",
  "Categorical variables reported as n (%). Values may not sum to total (N) due to missing data."
)

table1_obj <- table1(strata, labels, groupspan = c(1, 3), render.missing = NULL,
  render.continuous = my.render.cont,
  render.categorical = my.render.cat,
  caption = caption,
  footnote = footnote
)

# save table1 as .rds object
saveRDS(table1_obj, file = here::here("output/table1.rds"))
