# DATA 550 Final Project README

> Author: Dan Flanagan

------------------------------------------------------------------------

## Code Description

`code/00_clean_data.R`

  - loads and cleans simulated PUSH cohort dataset for analysis

`code/01_make_table1.R`

  - creates Table 1 with basic descriptive statistics of the PUSH cohort
  - saves table1 as an `.rds` object in `output/` folder
  
`code/02_make_figure1.R`

  - creates Figure 1 with basic descriptive statistics of the PUSH cohort
  - saves figure1 as an `.rds` object in `output/` folder

`code/03_render_report.R`

  - renders `DF_report.Rmd`

`DF_report.Rmd`

  - compiles table1 and figure1 into .html report
  - outputs html document with description of data set, table 1, and histogram

`Makefile`

  - contains rules for building the report
  - `make .DF_report.html` will compile the report and output DF_report.html
