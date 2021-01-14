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
