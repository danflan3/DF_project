# REPORT ASSOCIATED RULES (run within docker container)
DF_report.html: DF_report.Rmd data/push_sim_data.rds output/table1.rds output/figure1.rds
	Rscript code/03_render_report.R

output/table1.rds: code/01_make_table1.R data/push_sim_data.rds
	Rscript code/01_make_table1.R

output/figure1.rds: code/02_make_figure1.R data/push_sim_data.rds
	Rscript code/02_make_figure1.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f DF_report.html && rm -f report/*.html

.PHONY: install
install: 
	Rscript -e "renv::restore(prompt = FALSE)"


# DOCKER ASSOCIATED RULES (run on local machine)
PROJECTFILES  = DF_report.Rmd code/00_clean_data.R code/01_make_table1.R code/02_make_figure1.R code/03_render_report.R data/push_sim_data.rds Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

# rule to build the Docker image
df_project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t df_project_image .
	touch $@

# rule to run the docker hub container and automatically create DF_report.html;
# set default OS_TYPE to mac (or linux) if not provided by user; user can override this variable when running the make command to specify windows if they are using a windows machine 
OS_TYPE ?= mac

# allows user to simply run the container to automatically generate report and save to the report/ directory on their local machine (via volume mounting)
# Usage: make report/DF_report.html (Mac/Linux default)
#        make report/DF_report.html OS_TYPE=windows
report/DF_report.html:
ifeq ($(OS_TYPE),windows)
	docker run -v "/$$(pwd)"/report:/home/rstudio/project/report danflan3/df_project_image
else
	docker run -v "$$(pwd)"/report:/home/rstudio/project/report danflan3/df_project_image
endif
