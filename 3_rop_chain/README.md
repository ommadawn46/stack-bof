# rop chain

NX has been enabled.

```
# checksec rop_chain
[*] '/stack-bof/3_rop_chain/rop_chain'
    Arch:     amd64-64-little
    RELRO:    Partial RELRO
    Stack:    Canary found
 -> NX:       NX enabled
    PIE:      No PIE (0x3ff000)
    RUNPATH:  b'../.lib/'
```

```
python3 exploit.py NOASLR
```
