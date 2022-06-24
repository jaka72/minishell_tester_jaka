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

OUT="output_files"							# folder for all output files
> $OUT/all_out_cat.txt			# wipe content before start

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
			echo $line >> $OUT/all_out_cat.txt
		else
			: echo $line >> $OUT/out_else
		fi
	done < "$filename"

	echo "" >> $OUT/all_out_cat.txt

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


echo -e $YEL"\nTEST CAT"$RES

 inputlines=(
	 		"cat infile"
	 		"cat -n infile"
	 		"cat -e infile"
	 		"cat -e -n infile"
	 		"cat -en infile"
			# "cat infile > out1"			# CREATES NEW FILE, THIS IS NOT CHECKED
			# "cat infile > out1 > out2"	# CREATES NEW FILE, THIS IS NOT CHECKED
			)

nr_elements=${#inputlines[@]}

i=0
while (( $i < $nr_elements ))
do
	input=${inputlines[$i]}
	printf "  Test %3d:   %-30s   " $i "'$input'"
	> $OUT/out_temp; > $OUT/out_mini; > $OUT/out_orig; > $OUT/out_orig2 
	./minishell "$input" | cat -e > $OUT/out_temp
	eval $input | cat -e > $OUT/out_orig
	test_syntax_error "out_orig2" "out_mini" "valid"
	((i=i+1))
done

echo ""


##################################################################################






