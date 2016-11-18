#!/bin/bash

# first download the accessions list of the SRA archive 
# and save them into a .txt then run the script below

while read line; do
echo $line
fastq-dump -I --split-files $line
done < SraAccList_Peay.txt

while read line; do
echo $line
fastq-dump -I --split-files $line
done < SraAccList_Jump.txt



