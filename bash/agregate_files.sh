#!/bin/bash

mkdir -p ./tmp/html

for dir in $( find tmp/{analysis_result,images} -type f | rev | cut -d'/' -f2- | rev | sort -u | cut -d'/' -f3-) ; do
	mkdir -p "tmp/html/$dir"

	mv -r "tmp/analysis_result/$dir"	"tmp/html/$dir"
	mv -r "tmp/images/$dir"				"tmp/html/$dir"



done

