here::i_am(
  "code/01_make_table1.R"
)

library(dplyr)
library(gtsummary)
library(gt)

# load clean data
push_data <- readRDS(here::here("data/push_sim_data.rds"))

# assign factor labels
push_data$sex_en <- factor(push_data$sex_en, levels = c(1, 2), labels = c("Male", "Female"))
push_data$tbclass_new <- factor(push_data$tbclass_new, levels = c(1, 2, 3), labels = c("Confirmed", "Unconfirmed", "Unlikely"))

table1_obj <- push_data |>
  select(sex_en, enroll_ageyrs, tbclass_new) |>
  tbl_summary(
    by = tbclass_new,
    label = list(
      sex_en ~ "Participant Sex",
      enroll_ageyrs ~ "Age at Enrollment (years)"
    ),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"
    ),
    digits = list(all_continuous() ~ 1),
    missing = "no"
  ) |>
  add_overall(last = FALSE) |>
  modify_spanning_header(
    c(stat_1, stat_2, stat_3) ~ "**TB Disease**"
  ) |>
  modify_caption(
    "Table 1. Basic demographics of PUSH trial participants (n=133) by TB Disease Status"
  ) |>
  as_gt() |>
  tab_footnote(
    footnote = "Continuous variables reported as Mean (SD). Categorical variables reported as n (%)."
  )

# save as PNG image and .rds object
saveRDS(table1_obj, file = here::here("output/table1.rds"))
