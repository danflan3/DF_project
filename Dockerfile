###### STAGE 1 OF MULTI-STAGE BUILD ######
# starting container image
FROM rocker/tidyverse:4.5.1 AS base

#RUN apt-get update && apt-get install pandoc -y
RUN apt-get update && apt-get install -y libuv1 cmake libnode-dev

# create and set a project directory as working directory within image
RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

# mirror project directory structure in container & copy necessary files into container
RUN mkdir code data output
COPY code code
COPY data data
COPY DF_report.Rmd .
COPY Makefile .

# create a folder called renv in working directory for renv-associated files
# NOTE: DO NOT copy renv package library
RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv
COPY renv/settings.json renv

# change default location of renv cache to be within project directory
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE=renv/.cache

# restore renv package environment within container
RUN Rscript -e "renv::restore(prompt = FALSE)"

###### DO NOT EDIT STAGE 1 BUILD LINES ABOVE ######

###### STAGE 2 OF MULTI-STAGE BUILD ######
FROM rocker/tidyverse:4.5.1
RUN apt-get update && apt-get install -y libuv1 cmake libnode-dev

RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project
ENV RENV_PATHS_CACHE=renv/.cache
COPY --from=base /home/rstudio/project .

### AT THIS STAGE MAKE DF_report.html RUNS SUCCESSFULLY WITHIN THE CONTAINER ###
### NEXT: CREATE report/ DIRECTORY IN BOTH LOCAL AND CONTAINER PROJ DIRECTORIES; WRITE MAKEFILE RULE TO MOUNT report/ DIRECTORY AND AUTOMATICALLY CREATE DF_report.html WITHIN report/ WHEN CONTAINER IS RUN LOCALLY ###