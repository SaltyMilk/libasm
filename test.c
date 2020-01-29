typedef struct	s_list
{
	void *data;
	struct s_list *next;
} 				t_list;

int ok(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
{
	if (begin_list)
		return (0);
	if (data_ref)
		return (1);
	if (cmp)
		return (2);
	if (free_fct)
		return (3);
	return (4);
}

int main()
{
	ok(0, 0, 0, 0);	
}
