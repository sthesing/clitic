#!/usr/bin/env bash

declare -A array
# Add key value pairs for programs in other languages
# array[language]='program call', relative to the directory templates

array[Python]='python cli-python.py'
array[Python3]='python3 cli-python.py'
array[DocoptsPy3]='python3 cli-python-docopt.py'

# Run the tests
for lang in ${!array[@]}; do
    command=${array[$lang]}
    
    echo $command > tmpcmd
    echo "Running test for $lang:"
    
    bats tests/clitic.bats
    
    echo ""
done

# Clean up
rm tmpcmd
