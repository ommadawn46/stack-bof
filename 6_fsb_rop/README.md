# fsb rop

GOT is no longer writable.

```
# checksec fsb_rop
[*] '/stack-bof/6_fsb_rop/fsb_rop'
    Arch:     amd64-64-little
 -> RELRO:    Full RELRO
    Stack:    Canary found
    NX:       NX enabled
    PIE:      PIE enabled
    RUNPATH:  b'../.lib/'
```

```
python3 exploit.py
```
