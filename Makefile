all: png

png:
	Rscript -e "targets::tar_make()"
