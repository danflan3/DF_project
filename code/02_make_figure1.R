here::i_am(
  "code/02_make_figure1.R"
)

library(ggplot2)
library(dplyr)

# load clean data
push_data <- readRDS(here::here("data/push_sim_data.rds"))

##assign factor labels to tbclass_new for legend display
push_data$tbclass_new <- factor(push_data$tbclass_new, levels = c(1, 2, 3), 
                                labels = c("Confirmed", "Unconfirmed", "Unlikely"))

## Plot age distribution of PUSH study participants, stratified by TB disease status
figure1 <- ggplot(push_data, aes(x = enroll_ageyrs, fill = tbclass_new)) +
  geom_histogram(binwidth = 1, boundary = 0, color = "white", position = "stack") +
  labs(
    title = "Age Distribution of Study Participants by TB Disease Status",
    x = "Age (years)",
    y = "Count",
    fill = "TB Disease Status"
  ) +
  theme_minimal()

# save figure1 as .rds object
saveRDS(figure1, file = here::here("output/figure1.rds"))
