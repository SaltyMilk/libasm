#include <stdio.h>
#include <string.h>
extern size_t ft_strlen(char *str);
extern char *ft_strcpy(char *dst, char *src);
int main()
{
	char dst[] = "Hello";
	char src[] = "Worldsssssssssssssssssss";

	printf("Return={%s}\n", ft_strcpy(dst, src));
	printf("Dest={%s}\n", dst);
}
