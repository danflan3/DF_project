# DATA 550 Final Project README

> Author: Dan Flanagan

------------------------------------------------------------------------
## Getting Started

Clone the repository to a target directory on your local machine and navigate into the project folder before running any `make` or Docker commands:

```bash
git clone git@github.com:danflan3/DF_project.git
cd DF_project
```

All subsequent `make` commands must be run in terminal from within the `DF_project/` directory.

------------------------------------------------------------------------
## Docker Container Environment

The project includes an associated Docker image that is publically available on Dockerhub and provides a fully reproducible R environment with all required packages pre-installed.

**Link to DockerHub Image:** https://hub.docker.com/r/danflan3/df_project_image

Users must have Docker Desktop installed on their local machine and be signed into a Docker account in order to execute the project code. 

## Automatically Build Final Report within Docker Container

The `report/DF_report.html` Makefile rule pulls the pre-built image from DockerHub, runs the analysis inside the container, and saves the rendered html report (`DF_report.html`) to the `report/` directory on your local machine via volume mounting. 

The `report/DF_report.html` Makefile rule includes an option variable `OS_TYPE` for specifying the operating system of the user's local machine. Mac/Linux-based systems are considered the default (`OS_TYPE=mac`) and does not need to be specified when running the make command. Windows users should specify `OS_TYPE=windows` to ensure proper mounting of the local `report/` directory. 

**Mac/Linux users (Default):**
```bash
make report/DF_report.html
```

**Windows users:**
```bash
make report/DF_report.html OS_TYPE=windows
```

## Building the Docker Image Locally

To build the image locally from the `Dockerfile` in the project root repository, run:

```bash
make df_project_image
```

This will build the Docker image and tag it as `df_project_image`. Note: The rule also creates a blank text file `df_project_image.txt` in the project root directory to prevent re-building the Docker image if none of the dependencies have been updated since the last build. 

## Package Management using renv()
Project code written using `R version 4.5.2`. 
Package environment captured in the `renv.lock` file using `renv()` version 1.2.0.

Running the command `make install` will restore package environment via `renv::restore()`

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

  - renders `DF_report.Rmd` as html document within the project root directory

`DF_report.Rmd`

  - compiles table1 and figure1 into .html report
  - outputs html document with description of data set, table 1, and histogram

`Makefile`

  - contains rules for building the report
  - `make DF_report.html` will compile the report and output DF_report.html within the project root (local machine or within docker container)
  - `make install` will restore package environment used to generate the project
  - `make report/DF_report.html` will automatically run the analysis within a Docker container environment and output the final report to the `report` sub-directory on the user's local machine
  - `make df_project_image` will build the Docker image locally from the Dockerfile in the project root directory
  - `make clean` will remove any previously generated versions of html report in both the project root directory and `report/` subdirectory; as well as remove any previously saved .rds objects (e.g. `table1.rds`, `figure1.rds`) within the `output/` subdirectory. 