#include <stdio.h>
#include <stdlib.h>

void vuln()
{
    char buf[32];
    gets(buf);
}

void win()
{
    puts("You Win!\n");
    system("/bin/sh");
}

int main(void)
{
    vuln();
    return 0;
}
