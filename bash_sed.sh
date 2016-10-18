# Some interesting sed scripts
# Compiled by Gian MN Benucci
# gian.benucci[at]gmail[dot]com

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
