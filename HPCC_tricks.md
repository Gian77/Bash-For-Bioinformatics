# MSU HPCC TRICKS

To make sure your terminal do not freeze when you move out form it, create a 
file in your .ssh folder with the following

```
gian@gian-Z390-GY:~$ cat .ssh/config 
Host *
ServerAliveInterval 240
ServerAliveCountMax 3

# instead use hpcc.msu.edu
```

The ServerAliveInterval tells ssh to send a keep alive packet every 240 seconds
or 4 minutes. The ServerAliveCountMax tells ssh to do this a maximum of 3 times 
without getting a response, then to close the connection from the client side.
This will prevent the annoying lockup where the terminal freezes for a minute or
two then disconnects. Since I’ve made these changes my terminal has started to 
behave more like my good old Linux laptop.


To inspect running jobs, use 
```
[benucci@dev-intel16 biodiversity_ITS]$ sbatch constax_euk.sb 
Submitted batch job 103743735
[benucci@dev-intel16 biodiversity_ITS]$ squeue -l -u benucci
Fri Nov 12 15:35:18 2021
             JOBID PARTITION     NAME     USER    STATE       TIME TIME_LIMI  NODES NODELIST(REASON)
         103743735     colej constax_  benucci  RUNNING       0:08   1:00:00      1 css-072
[benucci@dev-intel16 biodiversity_ITS]$ 
[benucci@dev-intel16 biodiversity_ITS]$ seff 103743735
Job ID: 103743735
Cluster: msuhpcc
User/Group: benucci/psm
State: RUNNING
Nodes: 1
Cores per node: 10
CPU Utilized: 00:00:00
CPU Efficiency: 0.00% of 00:03:00 core-walltime
Job Wall-clock time: 00:00:18
Memory Utilized: 0.00 MB (estimated maximum)
Memory Efficiency: 0.00% of 32.00 GB (32.00 GB/node)
WARNING: Efficiency statistics may be misleading for RUNNING jobs.
```
