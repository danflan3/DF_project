# REPORT ASSOCIATED RULES (run within docker container)
DF_report.html: DF_report.Rmd data/push_sim_data.rds output/table1.rds output/figure1.rds
	Rscript code/03_render_report.R

output/table1.rds: code/01_make_table1.R data/push_sim_data.rds
	Rscript code/01_make_table1.R

output/figure1.rds: code/02_make_figure1.R data/push_sim_data.rds
	Rscript code/02_make_figure1.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f DF_report.html

.PHONY: install
install: 
	Rscript -e "renv::restore(prompt = FALSE)"


# DOCKER ASSOCIATED RULES (run on local machine)
PROJECTFILES  = DF_report.Rmd code/00_clean_data.R code/01_make_table1.R code/02_make_figure1.R code/03_render_report.R data/push_sim_data.rds Makefile
RENVFILES = renv.lock renv/activate.R renv/settings.json

# rule to build the Docker image
project_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t DF_project_image .
	touch $@

# rule to run the docker hub container and automatically create DF_report.html
report/DF_report.html: 
	docker run -v "$$(pwd)/report":/DF_project/report <insert-dockerhub-user>/DF_project_image