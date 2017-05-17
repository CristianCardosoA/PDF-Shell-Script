#!/bin/bash

counter=1;
FILES=directory/*
mkdir extracted;

for file in $FILES;
         do echo "Removing additional pages from file" $counter;
	 pdfseparate -f 1 -l 1 "$file" ecop1/file-$counter-%d.pdf;
	((counter++));
done;

for file in extracted/*.pdf;
        do echo "Converting pdf to text ... ";
	pdftotext "$file";
done;

for file in extracted/*.txt;
	do 
	newFile=$(sed -n '17,20p;' "$file" | awk '{print}' ORS=' ' | awk '{print "27#"$5"#"$1".pdf"}'); 
	#echo $newFile;
	#echo $file;
	fileName=$(echo "$file" | cut -f 1 -d '.')".pdf";
	echo "Renaming "$file;
	mv "$fileName" extracted/$newFile;
	rm "$file";
done;


