SRC = 	ft_read.s\
	  	ft_strcpy.s\
	  	ft_strlen.s\
		ft_strcmp.s\
		ft_strdup.s\
		ft_write.s
BSRC =	ft_list_push_front.s\
		ft_list_size.s\
		ft_atoi_base.s\
		ft_list_remove_if.s\
		ft_list_sort.s\

MOBJ = $(SRC:.s=.o)
BOBJ = $(BSRC:.s=.o)

NAME = libasm.a

all : $(NAME)

bonus : $(MOBJ) $(BOBJ)
	ar -rc $(NAME) $?

$(NAME): $(MOBJ)
	ar -rc $(NAME) $?

%.o : %.s
	nasm -f macho64 $?

clean :
	rm -f $(MOBJ) $(BOBJ)

fclean :
	rm -f $(MOBJ) $(BOBJ) $(NAME)

re : fclean all

.PHONY : clean fclean re all
