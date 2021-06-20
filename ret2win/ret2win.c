#include <stdio.h>

void vuln()
{
    char buf[32];
    gets(buf);
}

void win()
{
    puts("You Win!\n");
    execve("/bin/sh", NULL, NULL);
}

int main(void)
{
    vuln();
    return 0;
}
