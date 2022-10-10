
README

![alt text](https://github.com/jaka72/minishell_tester_jaka/master/screenschot.png?raw=true)

A) The Tester folder should be in the same folder where you have 
	your executable file ./minishell  


B) The Tester reads each input from the argument **argv string:
	for example: ./minishell "ls | wc"

	Therefore you need to insert the following two blocks of code into your main():

	////////// Just for Tester //////////////////////////
	// 1. Replace your readline() section with this:

		if (argc == 1)
			/*your inputline*/ = readline("minishell: ");
		else if (argc == 2)
			/*your inputline*/ = argv[1];
	

	// 2. Insert this at the end of your loop
		if (argc == 2)
		{
			free( /*your inputline*/ );
			exit(0);
		} 
	//////////////////////////////////////////////////////




C) You need to change the 2 error messages, according to your minishell messages.
	Each message is in the variable 'error_message' at the top of each file:

		test_syntax_pipes.sh:		"Minishell: Syntax error with PIPES"
		test_syntax_redirs.sh:		"Minishell: Syntax error with REDIRECTS"


D) The tester creates 3 text files:
	- out_orig	(message from Bash or from Tester)
	- out_temp	(all output from Minishell)
	- out_mini	(from out_temp, but removed lines with color codes)


E) To start the Tester: run_tester.c
	First the tester will copy your executable file into the Tester folder.
	It will compare the 2 files: out_orig vs out_mini

