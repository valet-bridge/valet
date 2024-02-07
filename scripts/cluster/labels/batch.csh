#!/bin/tcsh

# Check if an argument is provided
if ( "$#argv" == 0 ) then
    echo "No argument provided."
    exit 1
endif

# Assign the argument to a variable
set arg = $argv[1]

perl statnames.pl names_full.txt > b

echo "Uses in lin files"
echo "-----------------"

grep -i "$arg" b

echo
echo "Content of name file"
echo "--------------------"

grep -i "$arg" pnames.txt
# grep -i "$arg" newnames.txt
# grep -i "$arg" ../../Euro-and-World/pnames_augmented.txt

echo
echo "Partners"
echo "--------"
perl partners.pl "$arg"
