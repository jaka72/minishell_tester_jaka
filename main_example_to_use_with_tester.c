/* ************************************************************************** */
/*                                                                            */
/*                                                        ::::::::            */
/*   main.c                                             :+:    :+:            */
/*                                                     +:+                    */
/*   By: J&K(Jaka and Kito)                           +#+                     */
/*                                                   +#+                      */
/*   Created: 2022/06/22 12:10:44 by kito          #+#    #+#                 */
/*   Updated: 2022/10/10 15:27:33 by jmurovec      ########   odam.nl         */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"
#include <readline/readline.h>
#include <readline/history.h>

// t_global	st_base;
struct termios	g_termios_saved;

// static void	free_and_read(t_source *src, int history)
// {
// 	if (history == 1)
// 		add_history(src->inputline);
// 	if (src->inputline != NULL)
// 		free(src->inputline);
// 	src->inputline = readline("minishell > ");
// }

static	void	unused_arg(int argc, char *argv[])
{
	(void) argc;
	(void) argv;
}




// MAIN FOR THE TESTER
//		Must comment out the free_and_read() function
int	main(int argc, char *argv[], char *envp[])
{
	t_source	src;
	int			ex_stat;
	t_util		st_base;

	unused_arg(argc, argv);
	ms_init(envp, &ex_stat, &st_base, &src);
//	free_and_read(&src, 0);


////////// Just for Tester //////////////////////////
	// 1. Replace your readline() section with this:

		if (argc == 1)
			src.inputline = readline("minishell: ");
		else if (argc == 2)
			src.inputline = argv[1];

//////////////////////////////////////////////////////

	//printf("A)\n");

	while (src.inputline)
	{
		if (ft_strlen(src.inputline) > 0)
		{
			if (check_syntax_errors(&src, &ex_stat) != 0)
			{
				//free_and_read(&src, 1);
				//free( src.inputline );
				exit (0);
				continue ;
			}
			add_history(src.inputline);
			st_base.start_cmd = make_commands(&src);
			ex_stat = run_cmd(&ex_stat, &st_base);
			free_tcmd(&st_base);
		}
//		free_and_read(&src, 0);
		if (argc == 2)
		{
			//free( src.inputline );
			exit(0);
		} 
	}
	return (clean_data(ex_stat, "exit\n", &st_base));
}




// int	main(int argc, char *argv[], char *envp[])
// {
// 	t_source	src;
// 	int			ex_stat;
// 	t_util		st_base;

// 	unused_arg(argc, argv);
// 	ms_init(envp, &ex_stat, &st_base, &src);
// 	free_and_read(&src, 0);

// 	while (src.inputline)
// 	{
// 		if (ft_strlen(src.inputline) > 0)
// 		{
// 			if (check_syntax_errors(&src, &ex_stat) != 0)
// 			{
// 				free_and_read(&src, 1);
// 				continue ;
// 			}
// 			add_history(src.inputline);
// 			st_base.start_cmd = make_commands(&src);
// 			ex_stat = run_cmd(&ex_stat, &st_base);
// 			free_tcmd(&st_base);
// 		}
// 		free_and_read(&src, 0);
// 	}
// 	return (clean_data(ex_stat, "exit\n", &st_base));
// }
