

#	this will probably not be possible, because it means more commands need to be executed
#	within same session of minishell, without first exiting,
#	unless variblaes can be exported so that minishell sees them ???

export orig=out_orig
export mini=out_mini
export trash="/dev/null" 

compare_both_files()
{
	DIFF=$(diff $orig $mini)
	if [ "$DIFF" == "" ] 
	then
		echo -e $GRN"[ OK ] " $GRE $msg $RES 
	else
		echo -e $RED"[ KO ]"$RES 
	fi
}

#####################################################

# TEST cd ..
echo -en "Test cd ..   "
mypwd=$(pwd)
./minishell "ls" #; ./minishell "pwd > $mypwd/$orig" ; ./minishell "cd - >$trash" ; ./minishell "pwd >> $orig"
#cd .. ; pwd > $mypwd/$mini ; cd - >$trash; pwd >> $mini
#compare_both_files



# # TEST cd ~
# echo -en "Test cd ~   "
# cd ~ ; pwd > $mypwd/$orig ; cd - >$trash ; pwd >> $orig
# cd ~ ; pwd > $mypwd/$mini ; cd - >$trash ; pwd >> $mini
# compare_both_files


# # TEST cd
# echo -en "Test cd   "
# cd ~ ; pwd > $mypwd/$orig ; cd - >$trash ; pwd >> $orig
# cd ~ ; pwd > $mypwd/$mini ; cd - >$trash ; pwd >> $mini
# compare_both_files



# # TEST cd /
# echo -en "Test cd /   "
# cd / ; pwd > $mypwd/$orig ; cd - >$trash ; pwd >> $orig
# cd / ; pwd > $mypwd/$mini ; cd - >$trash ; pwd >> $mini
# compare_both_files


# # TEST cd /dev
# echo -en "Test cd /   "
# cd / ; pwd > $mypwd/$orig ; cd - >$trash ; pwd >> $orig
# cd / ; pwd > $mypwd/$mini ; cd - >$trash ; pwd >> $mini
# compare_both_files



# # TEST cd ~/
# echo -en "Test cd ~/   "
# cd / ; pwd > $mypwd/$orig ; cd - >$trash ; pwd >> $orig
# cd / ; pwd > $mypwd/$mini ; cd - >$trash ; pwd >> $mini
# compare_both_files


# # TEST cd ~/Desktop
# echo -en "Test cd ~/Desktop   "
# cd / ; pwd > $mypwd/$orig ; cd - >$trash ; pwd >> $orig
# cd / ; pwd > $mypwd/$mini ; cd - >$trash ; pwd >> $mini
# compare_both_files


