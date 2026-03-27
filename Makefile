report.html: report.Rmd code/02_render_report.R .random_numbers
	Rscript code/02_render_report.R

# creates output/random_numbers[1-3].rds
.random_numbers: code/01_make_output.R
	Rscript code/01_make_output.R && touch .random_numbers

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html && rm -f .random_numbers