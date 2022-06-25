#!/bin/bash

RED="\033[0;31m"
CYN="\033[0;36m"
GRN="\033[0;32m"
BLU="\033[0;34m"
YEL="\033[0;33m"
GRE="\033[0;38m"
RES="\033[0m"



############################################################

error_message="minishell: Syntax error"

############################################################


#make

OUT="output_files"							# folder for all output files
> $OUT/all_out_quotes_syntax_err.txt			# wipe content before start

test_syntax_error()
{
	filename=$OUT/"out_temp"
	while read -r line; do
		if [[ $line != ^[[* ]] && [[ $line != $ ]]   ;
		then
			echo $line >> $OUT/out_mini
			echo $line >> $OUT/all_out_quotes_syntax_err.txt
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





##############################################################################

check_error_message()
{
	found_orig=0
	found_mini=0
	err_msg="command not found"

	if grep -i -q "$err_msg" $OUT/out_orig ; then
		found_orig=1
	fi
	if grep -i -q "$err_msg" $OUT/out_temp ; then
		found_mini=1
	fi

	msg=$3
	
	if [ $found_orig = 1 ] && [ $found_mini = 1 ] ; then
		echo -e $GRN"[ OK ] " $GRE $msg $RES		
	else
		echo -e $RED"[ KO ]"$RES 
	fi
}


##############################################################################


echo -e $YEL"\nTEST QUOTES: valid input, no error message"$RES
# echo -e $YEL"\n ( Not handled yet )"$RES

 inputlines=(
	 		'cat in""file'
			'ca""t infile'
			'cat in"f"ile'
			)

nr_elements=${#inputlines[@]}
# TURN ON/OFF 
#nr_elements=0


i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf $CYN"  Test %3d:   %-30s   "$GRE $i "'$input'"
	> $OUT/out_temp; > $OUT/out_mini; > $OUT/out_orig

	./minishell "$input" > $OUT/out_temppre ; cat -e $OUT/out_temppre > $OUT/out_temp
	eval $input > $OUT/out_origpre ; cat -e $OUT/out_origpre > $OUT/out_orig
	
	test_syntax_error "out_orig" "out_mini" "valid"
	((i=i+1))
done

echo ""





##############################################################################


echo -e $YEL"\nTEST QUOTES: valid input, with error msg stderr: Command not found"$RES
# echo -e $YEL"\n ( Not handled yet )"$RES

 inputlines=(
	 		'abc""efg'
	 		'abc " " efg'
	 		'abc"x"efg'
	 		'abc"d"e"f"g'
			'abc "" efg'
			# 'cat "" infile'		# prints both stderror and output content into outfile
			)						#  		err: No such file ...

nr_elements=${#inputlines[@]}
# TURN ON/OFF 
#nr_elements=0


i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf $CYN"  Test %3d:   %-30s   "$GRE $i "'$input'"
	> $OUT/out_temp; > $OUT/out_mini; > $OUT/out_orig

	./minishell "$input" 2> $OUT/out_temppre ; cat -e $OUT/out_temppre > $OUT/out_temp
	eval $input 2> $OUT/out_origpre ; cat -e $OUT/out_origpre > $OUT/out_orig
	
	# test_syntax_error "out_orig" "out_mini" "valid"
	check_error_message "out_orig" "out_mini" "valid"
	((i=i+1))
done

echo ""

#############################################################################


echo -e $YEL"\nTEST QUOTES, syntax error"$RES

 inputlines=(
	 		'abc"efg'
	 		'abc"""""efg'
	 		'abc"e"fg   "'
	 		 "abc'efg"
	 		"abc'''efg"
	 		"abc'e'f'g"
	 		"  ' abc efg"
	 		"  abc '  efg "
	 		"  abc ' ' '  efg "
			)

nr_elements=${#inputlines[@]}

i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf "  Test %3d:   %-30s   " $i "[$input]"
	> $OUT/out_temp; > $OUT/out_mini; > $OUT/out_orig
	# ./minishell "$input" | cat -e > out_temp
	# echo $error_message | cat -e > out_orig

	./minishell "$input" 2> $OUT/out_temppre ; cat -e $OUT/out_temppre > $OUT/out_temp
	echo $error_message > $OUT/out_origpre ; cat -e $OUT/out_origpre > $OUT/out_orig

	test_syntax_error "out_orig" "out_mini" "error"
	((i=i+1))
done

echo

