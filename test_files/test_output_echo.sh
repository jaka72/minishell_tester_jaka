#!/bin/bash

RED="\033[0;31m"
CYN="\033[0;36m"
GRN="\033[0;32m"
BLU="\033[0;34m"
YEL="\033[0;33m"
GRE="\033[0;38m"
RES="\033[0m"



############################################################

# error_message="Minishell: Syntax error: found char unsupported by Minishell"

############################################################


#make
OUT="output_files"				# folder for all output files
> $OUT/all_out_echo.txt.txt			# wipe content before start

test_syntax_error()
{
	filename=$OUT/"out_orig"
	while read -r line; do
		# if [[ $line != ^[[* ]] && [[ $line != $ ]]   ;
		if [[ $line != ^[[* ]] && [[ $line != $ ]]   ;
		then
			echo $line >> $OUT/out_orig2
		else
			: echo $line >> $OUT/out_else
		fi
	done < "$filename"


	filename=$OUT/"out_temp"
	while read -r line; do
		# if [[ $line != ^[[* ]] && [[ $line != $ ]]   ;
		if [[ $line != ^[[* ]] && [[ $line != $ ]]   ;
		then
			echo $line >> $OUT/out_mini
			echo $line >> $OUT/all_out_echo.txt.txt
		else
			: echo $line >> $OUT/out_else
		fi
	done < "$filename"
	msg=$3
	DIFF=$(diff $OUT/$1 $OUT/$2)
	if [ "$DIFF" == "" ] 
	then
		echo -e $GRN"[ OK ] " $GRE $msg $RES 
	else
		echo -e $RED"[ KO ]"$RES 
	fi
}


#############################################################################


echo -e $YEL"\nTEST ECHO - SOME EXAMPLES"$RES
echo -e "\n--- TEST ECHO - SOME EXAMPLES -------------------------" >> $OUT/all_out_echo.txt.txt

### STORE LINES FROM FILE INTO ARRAY ###################
FILE="input_files_echo/input_for_echo"
i=0
while read line; do
  ARRAY01[$i]=$line
  i=$((i+1))
done < $FILE


i=0
nr_elements=${#ARRAY01[@]}
while (( $i < $nr_elements ))
do
	printf "  Test %3d:   [%-30s]   " $i "${ARRAY01[$i]}"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2 
	./minishell "${ARRAY01[$i]}" | cat -e > $OUT/out_temp
	eval "${ARRAY01[$i]}" | cat -e > $OUT/out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done
echo ""

#############################################################################


echo -e $YEL"\nTEST ECHO, WITH OPTION -n"$RES
echo -e "\n--- TEST ECHO, WITH OPTION -n  -------------------------" >> $OUT/all_out_echo.txt.txt
echo -e $RED"   Incorrect output from tester !!!"$RES

### STORE LINES FROM FILE INTO ARRAY ###################
FILE="input_files_echo/input_for_echo_option_n"
i=0
while read line; do
  ARRAY02[$i]=$line
  i=$((i+1))
done < $FILE

i=0
nr_elements=${#ARRAY02[@]}
while (( $i < $nr_elements ))
do
	printf "  Test %3d:   [%-30s]   " $i "${ARRAY02[$i]}"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2 
	./minishell "${ARRAY02[$i]}" | cat -e > $OUT/out_temp
	eval "${ARRAY02[$i]}" | cat -e > $OUT/out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done
echo ""

##################################################################################


echo -e $YEL"\nTEST ECHO - TILDA AND DOLLAR"$RES
echo -e "\n\n--- TEST ECHO - TILDA AND DOLLAR  -------------------------" >> $OUT/all_out_echo.txt.txt


### STORE LINES FROM FILE INTO ARRAY ###################
FILE="input_files_echo/input_for_echo_tilda_and_dollar"
i=0
while read line; do
  ARRAY03[$i]=$line
  i=$((i+1))
done < $FILE

i=0
nr_elements=${#ARRAY03[@]}
while (( $i < $nr_elements ))
do
	printf "  Test %3d:   [%-66s]   " $i "${ARRAY03[$i]}"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2 
	./minishell "${ARRAY03[$i]}" | cat -e > $OUT/out_temp
	eval "${ARRAY03[$i]}" | cat -e > $OUT/out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done
echo ""

##################################################################################



echo -e $YEL"\nTEST ECHO - ESCAPE CHARACTER"$RES
echo -e     "\n--- TEST ECHO - ESCAPE CHARACTER  -------------------------" >> $OUT/all_out_echo.txt.txt
echo -e $RED"   Incorrect output from tester !!!"$RES

### NOT WORKING CASES
	# echo '\" ' " \"\""



### STORE LINES FROM FILE INTO ARRAY ###################
FILE="input_files_echo/input_for_echo_escape_char"
i=0
while read line; do
  ARRAY04[$i]=$line
  i=$((i+1))
done < $FILE

i=0
# nr_elements=${#ARRAY04[@]}
nr_elements=0
while (( $i < $nr_elements ))
do
	printf "  Test %3d:   [%-30s]   " $i "${ARRAY04[$i]}"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2 
	./minishell "${ARRAY04[$i]}" | cat -e > $OUT/out_temp
	eval "${ARRAY04[$i]}" | cat -e > $OUT/out_orig
	# "${ARRAY04[$i]}" | cat -e > out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done
echo ""


##################################################################################



echo -e $YEL"\nTEST ECHO - WITH QUOTES"$RES
echo -e     "\n--- Test ECHO - WITH QUOTES  -------------------------" >> $OUT/all_out_echo.txt.txt


### STORE LINES FROM FILE INTO ARRAY ###################
FILE="input_files_echo/input_for_echo_with_quotes"
i=0
while read line; do
 ARRAY04[$i]=$line
  i=$((i+1))
done < $FILE

i=0
nr_elements=${#ARRAY04[@]}
while (( $i < $nr_elements ))
do
	printf "  Test %3d:   [%-30s]   " $i "${ARRAY04[$i]}"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2 
	./minishell "${ARRAY04[$i]}" | cat -e > $OUT/out_temp
	eval "${ARRAY04[$i]}" | cat -e > $OUT/out_orig
	# "${ARRAY04[$i]}" | cat -e > out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done
echo ""
