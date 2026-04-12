DF_report.html: DF_report.Rmd data/push_sim_data.rds
	Rscript code/03_render_report.R

# creates output/table1.rds
.table1: code/01_make_table1.R data/push_sim_data.rds
	Rscript code/01_make_table1.R
	
# creates output/figure1.rds
.figure1: code/02_make_figure1.R data/push_sim_data.rds
	Rscript code/02_make_figure1.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html && rm -f .random_numbers

.PHONY: install
install: 
	Rscript -e "renv::restore(prompt = FALSE)"