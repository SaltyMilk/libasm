#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>

typedef struct	s_list
{
	void *data;
	struct s_list *next;
}				t_list;

extern size_t	ft_strlen(char *str);
extern char		*ft_strcpy(char *dst, char *src);
extern int		ft_strcmp(const char *dst, const char *src);
extern int		ft_write(int fd, const void *buff, size_t bsize);
extern int		ft_read(int fd, void *buff, size_t bsize);
extern char		*ft_strdup(const char *str);

extern int		ft_atoi_base(const char *str, const char *base);
extern void		ft_list_push_front(t_list **begin_list, void *data);
extern int		ft_list_size(t_list *begin_list);
extern int		ft_list_sort(t_list **begin, int (*cmp)());
extern int		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

void	ft_list_remove_i(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
	t_list	*remove;
	t_list	*current;
	
	current = *begin_list;
	while (current && current->next)
	{
	if (current->next->next && !current->next->next->next && (*cmp)(current->next->next->data, data_ref) == 0)
		{
		printf("%s\n", current->data);
		remove = current->next->next;
		current->next->next = 0;
		free(remove);
		}
		if ((*cmp)(current->next->data, data_ref) == 0)
		{
			remove = current->next;
			current->next = current->next->next;
			free(remove);
		}
		current = current->next;
	}
/*	printf("Val=[%s]\n", current->data);
	if ((*cmp)(current->next->data, data_ref) == 0)
	{
		printf("ok\n");
		remove = current->next->next;
		current->next->next = 0;
		free(remove);
	}*/
	current = *begin_list;
	if (current && (*cmp)(current->data, data_ref) == 0)
	{
		*begin_list = current->next;
		free(current);
	}
}

int ccmp(char *a, char *b)
{
	return ((*(char *)a)-(*(char *)b));
}

int main()
{
	char a[] = "a";
	char b[] = "b";
	char c[] = "c";
	char d[] = "d";
	char e[] = "e";
	char f[] = "f";
	char g[] = "g";
	int ret = 0;
	t_list *lst = malloc(sizeof(t_list));
	t_list **blst = &lst;
	t_list *clst = *blst;
	lst->data = c;
	lst->next = NULL;
	ft_list_push_front(blst, b);
	ft_list_push_front(blst, a);
	ft_list_push_front(blst, f);
	printf("No segf before function\n");
	printf("%c\n", ft_list_remove_if(blst, f, &ccmp, &free));//));
//	printf("%d\n", ret);
	printf("No segf after function\n");
	t_list *tlst = *blst;
	t_list *rlst;
	while (tlst)
	{
		printf("[%c]", *(char *)(tlst->data));
		rlst = tlst;
		free(rlst);
		tlst = tlst->next;
	}
//free(clst);
	printf("\n");
}
/* FT_LIST_SORT TEST
int main()
{
	char a[] = "a";
	char b[] = "b";
	char c[] = "c";
	char d[] = "d";
	char e[] = "e";
	char f[] = "f";
	char g[] = "g";
	t_list *lst = malloc(sizeof(t_list));
	lst->next = NULL;
	lst->data = b;
	t_list **blst = &lst;
	ft_list_push_front(blst, g);
//	ft_list_push_front(blst, f);
//	ft_list_push_front(blst, a);
//	ft_list_push_front(blst, c);
//	ft_list_push_front(blst, b);
//	ft_list_push_front(blst, d);
	ft_list_push_front(blst, e);
	printf("No seg before funct\n");
	printf("%d\n", ft_list_sort(blst, &ccmp));
	printf("%p\n", ((*blst)->next));
	printf("No seg after funct\n");
	t_list *tlst = lst;
	while (tlst)
	{
		printf("[%c]", *(char *)(tlst->data));
		tlst = tlst->next;
	}
	printf("\n");
}

*/




/*	ft_LIST_SIZE TEST
	int	ft_lstsize(t_list *lst)
	{
	int		i;
	t_list	*clst;

	if (!lst)
	return (0);
	i = 0;
	clst = lst;
	while (clst)
	{
	clst = clst->next;
	i++;
	}
	return (i);
	}

	{
	char *a = "coucou";
	t_list **blst;
	t_list *lst = NULL; //= malloc(sizeof(t_list));
	blst = &lst;
//	lst->next = NULL;
//	ft_list_push_front(&lst, &a); 
int i = ft_lstsize(*blst);
while(tlst)
{
printf("%p\n", tlst);
tlst = tlst->next;
i++;
}
printf("Expected=[%d]\n", i);
printf("Result=[%d]\n", ft_list_size(*blst));
}*/

/*	FT_LIST_PUSH_FRONT TEST
	char *a = "hello";
	char *b = "world";
	t_list *lst = malloc(sizeof(t_list));
	lst->data = a;
	printf("%s\n", (char *)lst->data);
	char *s = (char *)ft_list_push_front(&lst, b);
	printf("%s\n", (char *)lst->data);
	printf("%p\n", (char *)lst->next);
	SHOULD PRINT 'hello\nworld' */
