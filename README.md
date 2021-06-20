# Stack Buffer Overflow - Protection Bypass Techniques

**[Stack_Buffer_Overflow_Exploit.pdf](Stack_Buffer_Overflow_Exploit.pdf)**


## Quick Start

```
docker build -t stack-bof .
docker run \
  --rm \
  -v $(PWD):/stack-bof \
  --cap-add=SYS_PTRACE \
  --security-opt="seccomp=unconfined" \
  -it stack-bof \
  tmux
```

```
cd /stack-bof
```


## Run an exploit with ASLR enabled

```
python3 exploit.py
```


## Run an exploit with ASLR temporarily disabled

```
python3 exploit.py NOASLR
```


## Run an exploit with GDB

```
python3 exploit.py NOASLR GDB
```


## Run tests

```
python3 -m unittest discover .test/
```
