#include<stdio.h>

int main()
{
	int i, sum = 0;
	int n = 10;

	for(i = 0;i <= n; i++)
	{
		sum+=i;
	}
	printf("Sum from 1 to %d = %d\n", n, sum);
	return 0;
}
