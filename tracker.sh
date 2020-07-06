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

#Parse choice: Loop until 1-9 is entered as choice
z=0
while [ $z -eq 0 ]
do
echo Enter your choice:
read choice
if [[ "$choice" =~ ^(1|2|3|4|5|6|7|8|9)$ ]]; then
	echo Writing to out.txt....; z=1
else
	echo Invalid choice, please try again.; z=0
fi
done

#There are 3 lines before the coin output, so choice 1 for BTC should refer to Line 4 (1+3)
a=$((choice+3))

#Perpetually write to out.txt until cancelled.
while [ 1 -eq 1 ]
do
cryptowatch |
sed  "s/|//g; s/\[92m//g; s/\[39m//g" |
awk -v a=$a -v d="$(date)" '{if(NR==a) print($2,$3,d)}' >> out.txt
done
