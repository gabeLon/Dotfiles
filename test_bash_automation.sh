#! /bin/bash
echo "write your name"
read name
if [ $name ]; then
    echo "your name is $name"
else 
    echo "you didn't say your name. wanna try again?"
    read retry
    if [ $retry=='yes' ]; then
        . test_bash_automation.sh
    else
        echo "then dont worry, bye"
    fi
fi
