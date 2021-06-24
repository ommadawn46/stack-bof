# libc leak

ASLR and PIE have been enabled.

```
# checksec libc_leak
[*] '/stack-bof/4_libc_leak/libc_leak'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
 -> PIE:      PIE enabled
    RUNPATH:  b'../.lib/'
```

```
python3 exploit.py
```
