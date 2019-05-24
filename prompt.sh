#!/bin/bash

#Prompt to choose crypto
echo Which cryptocurrency would you like to track?
echo Enter the number that corresponds with your choice:
echo 1. Bitcoin
echo 2. Ethereum
echo 3. Litecoin
echo 4. Bitcoin Cash
echo 5. Dash
echo 6. Ripple
echo 7. Digibyte
echo 8. Stellar
echo 9. Cardano

#Parse choice: Only accept 1-9
echo Enter your choice:
read choice
echo Your choice is $choice
if [[ "$choice" =~ ^(1|2|3|4|5|6|7|8|9)$ ]]; then
    echo Good choice
else
    echo Bad choice
fi
