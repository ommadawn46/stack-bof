#include <stdio.h>

void vuln()
{
    char buf[32];
    gets(buf);
    printf(buf);
    puts("\n");
    gets(buf);
}

int main(void)
{
    vuln();
    return 0;
}
