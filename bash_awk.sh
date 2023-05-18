##################################################
##						       
##       Some interesting bash scripts	         
##                                        					
##               Gian MN Benucci		              
##       gian[dot]benucci[at]gmail[dot]com	   	       
##						                                      
##################################################

# Determine sequence length for each sequence in the file
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen += length($0)}END{print seqlen}' file.fasta

# Calculate mean length of the seqs contained in a .fasta file
awk '{/>/&&++a||b+=length()}END{print b/a}' input.fasta > output.fasta

# Replace the header with numerical sequence 1 to N number of reads in the file.fasta 
awk '/^>/{print ">" ++i; next}{print}' input.fasta > output.fasta

# Add a string after the original sequence header
awk '/^>/ {$0=$0 "some random text"}1' input.fasta > output.fasta

# Replace the sequence header names with a string
awk '/^>/{print ">whateveryouwant" ++i; next}{print}' input.fasta > output.fasta

# remove column 3 of a file.txt 
awk '!($3="")' input.txt  > output.txt 

# Rearragne columns postions, using tab as a comun delimiter, in .txt file
awk 'BEGIN {OFS="\t"}; { print $1,$2,$3,$4,$15 " " $14}'  input.txt  > output.txt



