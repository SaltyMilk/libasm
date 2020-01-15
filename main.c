#include <stdio.h>
#include <string.h>
extern size_t ft_strlen(char *str);
extern char *ft_strcpy(char *dst, char *src);
extern int ft_strcmp(const char *dst, const char *src);
extern int ft_write(int fd, const void *buff, size_t bsize);
extern int ft_read(int fd, void *buff, size_t bsize);
extern char *ft_strdup(const char *str);
extern int ft_atoi_base(const char *str, const char *base);
#include <fcntl.h>
int main()
{
	char s[] = "12";
	char d[] = "4";
	char a[] = "984";
	printf("%d\n", ft_atoi_base(s,"0123456789ABCDEF"));
	printf("%d\n", ft_atoi_base(d,"0123456789ABCDEF"));
	printf("%d\n", ft_atoi_base(a,"0123456789ABCDEF"));
	printf("%d\n", ft_atoi_base("     ++-6","0123456789ABCDEF"));
	printf("%d\n", ft_atoi_base("     -6","0123456789ABCDEF"));
	printf("%d\n", ft_atoi_base("","0123456789ABCDEF"));
	printf("%d\n", ft_atoi_base("    --F","0123456789ABCDEF"));
	
}
