# shellcode

`win()` no longer exists.

```
# checksec shellcode
[*] '/stack-bof/1_shellcode/shellcode'
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
