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




