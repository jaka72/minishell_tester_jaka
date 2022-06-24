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
OUT="output_files"				# folder for all output files
> $OUT/all_out_pipes_sintax_err.txt			# wipe content before start

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
		if [[ $line != ^[[* ]] && [[ $line != $ ]]   ;
		then
			echo $line >> $OUT/out_mini
			echo $line >> $OUT/all_out_pipes_sintax_err.txt
			 # echo "$line" >> out_mini		$line VS "$line"  ???
			# printf '%b\n' "${line}" >> out_mini
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


echo -e $YEL"\nTEST PIPES: syntax error"$RES
echo -e "\n--- Test syntax error PIPES -------------------------" >> $OUT/all_out_pipes_syntax_err.txt

 inputlines=(
	 		"|"
			"||"
			"<|"
			">|"
			"|>"
			"|<"
			"| |"
			" | | "
			" || "
			"| > "
			" |>"
			)

nr_elements=${#inputlines[@]}

i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf "  Test %3d:   %-30s   " $i "'$input'"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig
	# ./minishell "$input" | cat -e > $OUT/out_temp
	# echo $error_message | cat -e > $OUT/out_orig


	./minishell "$input" 2> $OUT/out_temppre ; cat -e $OUT/out_temppre > $OUT/out_temp
	echo $error_message > $OUT/out_origpre ; cat -e $OUT/out_origpre > $OUT/out_orig

	test_syntax_error "out_orig" "out_mini" "error"
	((i=i+1))
done


# ######################################################################

echo -e $YEL"\nTEST PIPES syntax error: pipes with words"$RES
echo -e "\n--- Test syntax error PIPES with words -------------------------" >> $OUT/all_out_pipes_syntax_err.txt


 inputlines=(
	 		"< infile cat | | < outfile"
			"< infile cat < | | outfile"
			"< infile cat < | | outfile |"
			"| cat infile | wc > outfile"
			"ls||wc"	# TWO PIPES || APPARENTLY ALLOWED. LINUX ???
			"ls|||wc"	# Issue, now this is stil valid, should be error.
			"ls || wc"	# TWO PIPES || APPARENTLY ALLOWED. LINUX ???
			"ls ||| wc"	# Issue, now this is stil valid, should be error.
			)

nr_elements=${#inputlines[@]}

i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf "  Test %3d:   %-30s   " $i "'$input'"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig
	./minishell "$input" 2> $OUT/out_temppre ; cat -e $OUT/out_temppre > $OUT/out_temp
	echo $error_message > $OUT/out_origpre ; cat -e $OUT/out_origpre > $OUT/out_orig
	test_syntax_error "out_orig" "out_mini" "error"
	((i=i+1))
done




##############################################################################


echo -e $YEL"\nTEST PIPES: valid input"$RES
echo -e $BLU"  ( valid input with wc is KO, because tabs are displayed differently _??"$RES
echo -e "\n--- TEST PIPES, VALID INPUT -------------------------" >> $OUT/all_out_pipes_syntax_err.txt


 inputlines=(
	 		"ls|wc"
	 		"ls | wc"
	 		"   ls | wc   "
			"ls | grep a"
			"ls | grep a | wc"
			"ls | wc"
			"ls | ls | ls"

			## NO OUTPUT EXAMPLES
	 		"< infile cat | < readme"
			
			# ## HEREDOC not handled yet
			# # "<< here cat | wc > outfile"
			# # "<< here cat | wc | > outfile"
			# "<< here | cat infile"
			)

nr_elements=${#inputlines[@]}


i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf "  Test %3d:   %-30s   " $i "'$input'"
	> $OUT/out_temp; >$OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2
	./minishell "$input" | cat -e > $OUT/out_temp
	#echo "syntax error from initial check: pipes; exit" | cat -e > out_orig

	# eval "$input" | cat -e > out_orig
	eval $input | cat -e > $OUT/out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done


echo ""




##################################################################################






