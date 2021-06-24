# ret2win

Can you call `win()`?

```
# checksec ret2win
[*] '/stack-bof/0_ret2win/ret2win'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    No canary found
    NX:       NX disabled
    PIE:      No PIE (0x3ff000)
    RWX:      Has RWX segments
    RUNPATH:  b'../.lib/'
```

```
python3 exploit.py NOASLR
```
