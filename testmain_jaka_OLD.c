#include "minishell.h"
#include <readline/readline.h>
#include <readline/history.h>

/*
// NOTES, ISSUES ////////////////////////////////////////////////////
***************************************************************************
SAMPLE TEST:
	make && valgrind ./minishell "<< here cat | < infile < main.c cat | grep a > outfile | ls -l -a | wc -c  > outfile > out1 > out2"
<< here cat | < infile < main.c cat | grep a > outfile | ls -l -a | wc -c  > outfile > out1 > out2
make && valgrind valgrind --leak-check=full --show-reachable=yes   ./minishell 2> outfile
*/

t_global	g_gl;

void	free_and_read(t_source *src, int history)
{
	if (history == 1)
		add_history(src->inputline);	
	if (src->inputline != NULL)
		free(src->inputline);
	src->inputline = readline(g_gl.prompt);
}

// ORIGINAL FROM testmain.c
int	main(int argc, char *argv[], char *envp[])
{
//	printf("\n");
	t_source	src;
//	t_cmd		*cmd_list;
	//char		*line;

	(void) argc;
	(void) argv;
	// src.inputline = NULL;
	ms_init(envp);
	//free_and_read(&src, 0);

	//line = readline(g_gl.prompt);

	if (argc == 2)	// JUST FOR TESTING ////////////////////////
	{
		//printf(GRN"tester mode:\n"RES);
		src.inputline = argv[1];
		src.inputline_size = strlen(src.inputline);
		if (check_syntax_errors(&src) != 0)
		{
			return (258);
		}
		g_gl.start_cmd = make_commands(&src);
		g_gl.g_status = run_cmd();
		free_tcmd();
		clean_data(g_gl.g_status, NULL);
		//printf(GRN"\nexit! (tester mode)\n\n"RES);
		return (0);
	}
	else
	{
		printf("Tester mode, needs 1 argument!\n\n");
		exit (0);
/*		// printf(GRN"Real mode:\n"RES);
		//line = readline(gl.prompt);
		src.inputline = NULL;
		free_and_read(&src, 0);
		while (src.inputline)
		{
			if (ft_strlen(src.inputline) > 0)
			{
				if (check_syntax_errors(&src) != 0)
				{
					//add_history(line);				// ADDED JAKA: IN CASE OF ERROR MUST NOT EXIT, BUT LOOP AGAIN
					//free(line);
					//line = readline(g_gl.prompt);
					free_and_read(&src, 1);
					continue ;
				}
				add_history(src.inputline);
				// cmd_list = make_commands(&src);
				cmd_list = make_commands(&src);
				g_gl.g_status = run_cmd();
				free_commands_list(cmd_list);	
			}
			free_and_read(&src, 0);
			//free(line);
			//line = readline(g_gl.prompt);
		}
*/
	}

	//system("leaks minishell");
	return (clean_data(g_gl.g_status, "exit\n"));
}

/*
New issues in cleaned main (had no wifi today)
	builtins/export.c , complaining about minishell.h, no such file
	int	open_file_fd(t_cmd *str)		int j is not used
	- To check for external functions, to find forbidden:
		nm -u minishell   OR 	onjdump -t
	Check exit asdsdfg, exit code linux 255, Mac 2 ??? Is it really so?
	echo $USER'$USER'text oui oui     oui  oui $USER oui      $USER ''
	echo $USER'$USER'text oui 
	jmurovec$USERtext oui oui oui oui jmurovec oui jmurovec$
	jmurovec$USERtext oui oui oui oui jmurovec oui jmurovec 
	
	abc  qwe
	abc qwe 
	aaa aaa
	aaa aaa 
	jmurovec$USERabcd$
	echo '$USER'
	echo ''$USER''
	echo ''''''''''$USER'''''''''' 
	echo '$USER'"$USER"'$USER' 
	echo '"$USER"' '$USER'"""$USER" 
 echo $USER'   '
*/