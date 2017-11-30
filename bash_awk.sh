
# terminal scripts with awk


# determine sequence length
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen += length($0)}END{print seqlen}' file.fa

