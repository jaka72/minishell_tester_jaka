

# THIS LOOKS FOR THE ERROR MESSAGE STRING IN BOTH FILES
#	AND PRINTS OK, IF IT IS FOUND IN BOTH FILES

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