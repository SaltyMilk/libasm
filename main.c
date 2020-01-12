#include <stdio.h>
#include <string.h>
extern size_t ft_strlen(char *str);
extern char *ft_strcpy(char *dst, char *src);
extern int ft_strcmp(char *dst, char *src);
int main()
{
	char dst[] = "\200Allo";
	char src[] = "\0";

//	printf("Return={%s}\n", ft_strcpy(dst, src));
	printf("Dest={%d}\n", ft_strcmp(dst,src));
	printf("Dest={%d}\n", strcmp(dst,src));
}
