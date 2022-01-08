##################################################
##						       
##       Some interesting sed scripts	         
##                                        					
##               Gian MN Benucci		              
##       gian[dot]benucci[at]gmail[dot]com	   
##						                                        
##           East Lansing, Michigan		          
##            Settember 24th, 2016 		       
##						                                      
##################################################

# filter blast output and count unique fields e.g. Kingdom per each query
sed '/OTU/s/\t/\|/g' taxids_export_Alveolata.txt | cut -f 1,7 -d "|" | sed '/OTU/s/|/\t/g' | awk '$3=$1' | head 
sed '/OTU/s/\t/\|/g' taxids_export_Alveolata.txt | cut -f 1,7 -d "|" | awk '$3=$1' | cut -f 2 -d "|" | uniq -c | head

# merge files sorted previously
sed '/OTU/s/\t/\|/g' results_Alveolata.txt | cut -f 1,4,5,9,10 -d "|" | sed '/OTU/s/|/\t/g' | sort  > res_Alve.txt
sed '/OTU/s/\t/\|/g' taxids_export_Alveolata.txt | cut -f 1,5,6,7,8,11,12,13,14 -d "|" | sed '/OTU/s/|/\t/g' | sort > ids_Alve.txt
paste res_Alve.txt ids_Alve.txt > resids_Alve.txt

# print first 10 lines of file (emulates "head")
 sed 10q

 # print first line of file (emulates "head -1")
 sed q

 # double space a file
 sed G

 # print section of file based on line numbers (lines 8-12, inclusive)
 sed -n '8,12p'               # method 1
 sed '8,12!d'                 # method 2

 # print line number 52
 sed -n '52p'                 # method 1
 sed '52!d'                   # method 2
 sed '52q;d'                  # method 3, efficient on large files

# to convert a fastq file to fasta in a single line using sed
sed '/^@/!d;s//>/;N' sample1.fq > sample1.fa

sed -n '1~4s/^@/>/p;2~4p' test.fastq > test.fasta

# replace simple characters using regexp, e.g. replacing - with _
sed '/^>/s/-/_/g' input.fasta > out.fasta

#if there is a dot "." you want to replace, you must use "\." as an escape trick.

# remove last part of a read header after a space
sed '/^@/s/\s.*$//' input.fastq > out.fastq

# this command will add some text to a sequence header of 3 words and 6 numbers
sed 's/^\(>.*\)$/\1 somem text to add/' infile

# visualize a specific line or lines between an interval
sed -n '14800132,14800155p;14800156q' infile.fasta

# change first _ with . in Illumina fastq reads files
for f in *fastq
do sed '/^@/s/_/\./' "$f" > "$f.new"  &&  mv "$f.new" "$f"
done





