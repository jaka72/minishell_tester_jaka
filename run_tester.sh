#!/bin/bash

RED="\033[0;31m"
GRE="\033[0;38m"
CYN="\033[0;36m"
GRN="\033[0;32m"
BLU="\033[0;34m"
YEL="\033[0;33m"
RES="\033[0m"

cd ../
make

cp minishell ./tester/minishell
cd ./tester

bash ./test_files/test_output_echo.sh			# OK OK

bash ./test_files/test_syntax_quotes.sh			# OK OK

bash ./test_files/test_syntax_pipes.sh 			# OK OK

bash ./test_files/test_syntax_redirs.sh			# OK OK

bash  ./test_files/test_output_cat.sh			# OK OK

bash  ./test_files/test_output_various.sh		# OK OK

