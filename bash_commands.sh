##################################################
##						##
##    Useful bash scripts for bioinformatics	##
## 						##
##               Gian MN Benucci		##
##       gian[dot]benucci[at]gmail[dot]com	##
##						##
##           East Lansing, Michigan		##
##            Settember 24th, 2016 		##
##						##
##################################################



## BASIC COMMANDS
#*******************************************#

 # count lines (emulates "wc -l")
 sed -n '$='

# count sequencs in fasta file
grep -c "^>" sample1.fasta

# count sequences in a fastq file
grep -c "^@" example.fastq
cat example.fastq | echo $(("wc -l"/4))

Number of reads in multiple fastq.gz files 
zcat *.fastq | echo $((`wc -l`/4))

## MORE ADVANCED COMMANDS
#*******************************************#

## Convert a .fastq file to .fasta (NOTE: this assumes that each FASTQ entry spans only four lines as is customary)
sed -n '1~4s/^@/>/p;2~4p' imputfilename.fastq > outputfilename.fasta

## extract sequences that are longer from 21 to 25 bp from a dataset
cat your.fastq | paste - - - - | awk 'length($2)  >= 21 && length($2) <= 25' | sed 's/\t/\n/g' > filtered.fastq

awk 'BEGIN {OFS = "\n"} {header = $0 ; getline seq ; getline qheader ; getline qseq ; if (length(seq) >= 21 && length(seq) <= 25) {print header, seq, qheader, qseq}}' < your.fastq > filtered.fastq

## get the first 400 lines of a file
sed -n -e "1,400p" ITS_R1_otus_numbered.fasta > otus_NCBI.fasta 

## Count the total number of bases in a FASTA file
grep -v ">" imputfile.fasta | wc | awk '{print $3 - $1}'

## Count sequences length inside a .fastq file 
cat imputfile.fastq | awk '{if(NR%4==2) print length($1)}' > seqsfastq_length.txt
cat imputfile.fasta | awk '{if(NR%4==0) print length($1)}' > seqsfasta_length.txt
cat imputfile.fasta | awk '{if(NR%%4==2) print length(\$1)}' | sort -c

## Count the total number of sequences present in each different read files 
for i in $(ls *.fasta); do grep -c "^>" $i; done
for i in `ls *.fastq.gz`; do echo $(zcat ${i} | wc -l)/4|bc; done

## give the mean of the lenght of the seqs contained in a .fasta file
awk '{/>/&&++a||b+=length()}END{print b/a}' seqs.fna 

## Convert .fasta and .qual to .fastq 
for i in $(ls *.fasta);
do convert_fastaqual_fastq.py -f R -q seqs.qual -o fastq_files/
done

## Creating a md5 report for a series of file
md5sum *.fastq > md5.txt

## analyse content of entire folders 
find -s somedir -type f -exec md5sum {} \; | md5sum
tar -cf - somedir | md5sum

## Get a histogram of sequence lengths from FASTA/Q files 
cat imputfile.fastq | awk '{if(NR%4==2) print length($1)}' | sort -n | uniq -c
cat imputfile.fasta | awk '{if(NR%4==0) print length($1)}' | sort -n | uniq -c

## Do arithmetic operations on the bash command line
echo $((1 + 1))
echo $((1 - 1))
echo $((1 * 1))
echo $((1 / 1))
echo $(((1+3) / (1+1)))

echo "scale=1; 1/2" | bc ## this is for floating numbers

## Replace spaces in file names with underscore
rename ' ' '_' *

## Rename sequence header using awk
awk '/^>/{print ">whateveryouwant" ++i; next}{print}' < file.fasta

## add something to end of all header lines
sed 's/>.*/>whateveryouwant/' file.fasta > outfile.fasta
find SRA_R2_ITS/ -name '*.fastq' | wc -l

## add something after > of all header lines
sed "s/>/>whateveryouwant/" input.fasta > output.fasta
sed 's/^>/>SampleA/g' INFILE.fasta>OUTFILE.fasta

## clean up a fasta file so only first column of the header is outputted
awk '{print $1}' inputfile.fasta > outputfile.fasta

### check identical sequences with bash script and collapse them
grep -v '>\|^$'  inputfile.fasta | sort -u > Sequence
while read SEQUENCE; do
grep -w -m 1 -B1 $SEQUENCE inputfile.fasta >> outputfile.fasta
done < Sequence

## To remove duplicated sequences
sed -e '/^>/s/$/@/' -e 's/^>/#/' file.fasta | tr -d '\n' | tr "#" "\n" | tr "@" "\t" | sort -u -t $'\t' -f -k 2,2  | sed -e 's/^/>/' -e 's/\t/\n/'

## To extract ids from a sequence file
grep -o -E "^>\w+" file.fasta | tr -d ">"
find SRA_R2_ITS/ -name '*.fastq' | wc -l

## Linearize your sequences i.e. remove the sequence wrapping
sed -e 's/\(^>.*$\)/#\1#/' file.fasta | tr -d "\r" | tr -d "\n" | sed -e 's/$/#/' | tr "#" "\n" | sed -e '/^$/d'

## convert tab-delimited to csv
tr "\\t" "," < otu_table.txt > otu_table.csv

## counting reads among .fastq and fastq.gz files
for fastq in *assembled.fastq; do echo "$fastq : `grep -c "^+$" $fastq`"; done > assembled_reads.counts
for gz in *R1_001.fastq.gz; do echo "$gz : `gunzip -c $gz | grep -c "^+$"`"; done > raw_reads_R1.counts

# remove column 3 of a .txt file
awk '!($3="")' file1 > file2.txt
cut -f1,1,3- file1.txt > file2.txt 

# rearragne columns and invert postions, using tab as a comun delimiter 
awk 'BEGIN {OFS="\t"}; '{ print $1,$2,$3,$4,$15 " " $14}' file1.txt > file2.txt

# primtimg linearizied fzcat *R1_ITS.fastq | echo $((`wc -l`/4))
astq
zcat raw_data.fastq.gz | paste - - - - | head

# rename part of a file name across several files
rename 's/test-this/REPLACESTRING/g' *

# If you don't have rename use a for loop as shown below:
for i in test-this*
do
mv "$i" "${i/test-this/foo}"
done

# count the number of fastq files in a repsitory 
find YOUR_PATH/ -name '*.fastq' | wc -l

# Rename files inside a directory
# adding R1 at the end of the file name before the extension .fastq
for f in *fastq ; do NEW=${f%.fastq}R1.fastq; mv ${f} "${NEW}"; done









