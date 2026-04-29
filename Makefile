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