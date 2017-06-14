#!/usr/bin/env bash

declare -A array
# Add key value pairs for programs in other languages
# array[language]='program call'

array[Python]='python cli-python.py'
array[Python3]='python3 cli-python.py'

# Run the tests
for lang in ${!array[@]}; do
    command=${array[$lang]}
    
    echo $command > tmpcmd
    echo "Running test for $lang:"
    
    bats clitic.bats
    
    echo ""
done

# Clean up
rm tmpcmd
