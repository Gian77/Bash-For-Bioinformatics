##################################################
##						       
##       Some interesting awk scripts	         
##                                        					
##               Gian MN Benucci		              
##       gian[dot]benucci[at]gmail[dot]com	   
##						                                        
##           East Lansing, Michigan		          
##            July 1th, 2017 		       
##						                                      
##################################################

# determine sequence length
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen += length($0)}END{print seqlen}' file.fa

awk '/^>/ {$0=$0 "some random text"}1' input.fasta > output.fasta


