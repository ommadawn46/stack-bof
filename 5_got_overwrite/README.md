# got overwrite

Stack buffer overflow has been fixed.

```
# checksec got_overwrite
[*] '/stack-bof/5_got_overwrite/got_overwrite'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      PIE enabled
    RUNPATH:  b'../.lib/'
```

```
python3 exploit.py
```
