#!/bin/bash

#Prompt to choose crypto
echo Which cryptocurrency would you like to track?
echo Enter the number that corresponds with your choice:
echo 1. \(BTC\) Bitcoin
echo 2. \(ETH\) Ethereum
echo 3. \(LTC\) Litecoin
echo 4. \(BTH\) Bitcoin Cash
echo 5. \(DSH\) Dash
echo 6. \(XRP\) Ripple
echo 7. \(DGB\) Digibyte
echo 8. \(XLM\) Stellar
echo 9. \(ADA\) Cardano

#Parse choice: Only accept 1-9
echo Enter your choice:
read choice
if [[ "$choice" =~ ^(1|2|3|4|5|6|7|8|9)$ ]]; then
    echo Valid choice
else
    echo Bad choice, please try again
fi

#There are 3 lines before the coin output, so choice 1 for BTC should refer to Line 4 (1+3)
a=$((choice+3))
cryptowatch |
sed  "s/|//g; s/\[92m//g; s/\[39m//g" |
awk -v a=$a -v d="$(date)" '{if(NR==a) print($2,$3,d)}' >> out.txt

