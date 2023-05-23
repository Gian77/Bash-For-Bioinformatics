
## **A series of "real life" bash coding examples**

#### Copyright © 2023 Gian M.N. Benucci, Ph.D.
#### email: benucci[at]msu[dot]edu URL: https://github.com/Gian77

Filter blast output and count unique fields e.g. Kingdom per each query
```
sed '/OTU/s/\t/\|/g' taxids_export_Alveolata.txt | cut -f 1,7 -d "|" | sed '/OTU/s/|/\t/g' | awk '$3=$1' | head 
sed '/OTU/s/\t/\|/g' taxids_export_Alveolata.txt | cut -f 1,7 -d "|" | awk '$3=$1' | cut -f 2 -d "|" | uniq -c | head
```

Merge files sorted previously
```
sed '/OTU/s/\t/\|/g' results_Alveolata.txt | cut -f 1,4,5,9,10 -d "|" | sed '/OTU/s/|/\t/g' | sort  > res_Alve.txt
sed '/OTU/s/\t/\|/g' taxids_export_Alveolata.txt | cut -f 1,5,6,7,8,11,12,13,14 -d "|" | sed '/OTU/s/|/\t/g' | sort > ids_Alve.txt
paste res_Alve.txt ids_Alve.txt > resids_Alve.txt
```



