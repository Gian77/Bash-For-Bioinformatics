## **A series of interesting bash scripts**

#### Copyright © 2023 Gian M.N. Benucci, Ph.D.
#### email: benucci[at]msu[dot]edu URL: https://github.com/Gian77

Determine sequence length for each sequence in the file
```
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen += length($0)}END{print seqlen}' input.fasta > output.fasta
awk '/^>/{if (l!="") print l; print; l=0; next}{l+=length($0)}END{print l}' input.fasta > output.fasta
cat input.fastq | awk '{if(NR%4==2) print length($1)}' > length.txt
cat input.fasta | awk '{if(NR%4==0) print length($1)}' > length.txt
cat input.fasta | awk '{if(NR%%4==2) print length(\$1)}' | sort -c > length.txt

```

Get a histogram of sequence lengths from FASTA/Q files 
```
cat input.fastq | awk '{if(NR%4==2) print length($1)}' | sort -n | uniq -c > output.fasta
cat input.fasta | awk '{if(NR%4==0) print length($1)}' | sort -n | uniq -c > output.fasta
```

Calculate mean length of the seqs contained in a .fasta file
```
awk '{/>/&&++a||b+=length()}END{print b/a}' input.fasta > output.fasta
```

Replace the header with numerical sequence 1 to N number of reads in the file.fasta 
```
awk '/^>/{print ">" ++i; next}{print}' input.fasta > output.fasta
```

Add a string after the original sequence header
```
awk '/^>/ {$0=$0 "some random text"}1' input.fasta > output.fasta
sed "s/>/>whateveryouwant/" input.fasta > output.fasta
sed 's/^>/>SampleA/g' input.fasta > output.fasta

```

Replace the sequence header names with a string
```
awk '/^>/{print ">whateveryouwant" ++i; next}{print}' input.fasta > output.fasta
sed 's/>.*/>whateveryouwant/' input.fasta > output.fasta
sed 's/^\(>.*\)$/\1 somem text to add/' input.fasta > output.fasta
```

Remove column 3 of a file.txt 
```
awk '!($3="")' input.txt  > output.txt 
```

Remove duplicated sequences
```
sed -e '/^>/s/$/@/' -e 's/^>/#/' input.fasta | tr -d '\n' | tr "#" "\n" | tr "@" "\t" | sort -u -t $'\t' -f -k 2,2  | sed -e 's/^/>/' -e 's/\t/\n/' > output.fasta
```

Remove evrything before or after the | pipe character in each line
```
sed 's/^.*|//' ids.txt 
sed 's/|.*//' ids.txt
```

Remove last part of a read header after a space
```
sed '/^@/s/\s.*$//' input.fastq > output.fastq
```

Re-arrange columns postions, using tab as a comun delimiter, in .txt file
```
awk 'BEGIN {OFS="\t"}; { print $1,$2,$3,$4,$15 " " $14}' input.txt  > output.txt
```

Count lines of a file
```
cat input.fasta | wc -l
cat input.fasta | sed -n '$='
```

Count sequencs in .fasta/.fastq or .gz file
```
grep -c "^>" input.fasta
grep -c "^@" input.fasta
cat input.fasta | echo $(("wc -l"/4))
zcat *.fastq.gz | echo $((`wc -l`/4))
```

Count the total number of sequences present in each different read files 
```
for i in *.fasta; do 
	grep -c "^>" $i; 
done

for i in *.fastq; do 
	grep -c "^+$" $i; 
done

for i in *.fastq.gz; do 
	echo $(zcat ${i} | wc -l)/4|bc;
done
```

Convert a .fastq file to .fasta 
__NOTE__ This assumes that each FASTQ entry spans only four lines as is customary)
```
sed -n '1~4s/^@/>/p;2~4p' input.fasta > output.fasta
sed '/^@/!d;s//>/;N' input.fasta > output.fasta
```

Extract sequences that are longer from 21 to 25 bp from a dataset
```
cat input.fasta | paste - - - - | awk 'length($2)  >= 21 && length($2) <= 25' | sed 's/\t/\n/g' > output.fasta
awk 'BEGIN {OFS = "\n"} {header = $0 ; getline seq ; getline qheader ; getline qseq ; if (length(seq) >= 21 && length(seq) <= 25) {print header, seq, qheader, qseq}}' input.fasta > output.fasta
```

Extract sequences the first e.g. 400 lines of a .fasta file
```
sed -n -e "1,400p" input.fasta > output.fasta
```

Count the total number of bases in a FASTA file
```
grep -v ">" input.fasta | wc | awk '{print $3 - $1}' > output.fasta

```

Do arithmetic operations on the bash command line
```
echo $((1 + 1))
echo $((1 - 1))
echo $((1 * 1))
echo $((1 / 1))
echo $(((1+3) / (1+1)))
echo "scale=1; 1/2" | bc 
```

Rename delimiters or headers
```
rename ' ' '_' *
rename 's/test-this/REPLACESTRING/g' *
```

Rename file names
```
for f in *.fastq ; do 
	NEW=${f%.fastq}R1.fastq; mv ${f} "${NEW}"; 
done

for i in *.fastq; do 
	mv "$i" "ITS_R1_$i"; # adding something
done

for i in *.fastq; do 
	mv $i ${i//ITS_R1_/}; # removing something
done

for file in *\ *; do
	mv "$file" "${file// /_}"
done

```

Modify seqeunce header by separating columns
```
cut -d '|' -f 1 < file.fastq 
```

Check identical sequences with bash script and collapse them
__NOTE__ make sure you remove the output.fasta before you run the script twice!
```
grep -v '>\|^$'  inputfile.fasta | sort -u > Sequence
while read SEQUENCE; do
	grep -w -m 1 -B1 $SEQUENCE input.fasta >> output.fasta
done < Sequence
```

Substitute first _ with . in Illumina fastq reads files
```for f in *fastq; do 
	sed '/^@/s/_/\./' "$f" > "$f.new"  &&  mv "$f.new" "$f"
done
```























