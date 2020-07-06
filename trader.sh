#!/bin/bash
#this line is how I converted csvs to txts:
#sed "s/,/ /g" out.csv  > out.txt

echo
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo Welcome to Crypto Trader!
echo
echo This bot will test the profitability of this trading strategy:
echo --If the crypto of your choice increases x%, then buy it.
echo --Wait n minutes, then sell it.
echo You can test this strategy for any values of x and n.
echo -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
echo
echo First, enter your total initial investment:
read inv
i_inv=$inv
echo
echo Now enter the % gain that will trigger a buy:
echo Please enter in decimal format: For 5%, enter .05
read aa
a=$(echo 1 + $aa | bc -l)
echo
echo Finally, enter the minutes to wait before selling:
read nn
n=$(echo $nn \* 60 | bc -l)
echo
echo Ok! Calculating...

ip=$(awk '{if(NR==1) print $2}' out.txt)
state=0
while read x
do
if  [ $state -eq 0 ]
then
	v1=$(echo $x | awk '{print $2}')
	v2=$(echo $ip \* $a | bc -l)
	if (( $(echo "$v1 > $v2" |bc -l) ))
	then
		state=1
		buy_t=$(echo $x | awk '{print $9}')
		buy_p=$(echo $x | awk '{print $2}')
		echo Buy for $buy_p
	fi
elif [ $state -eq 1 ]
then
	z1=$(echo $x | awk '{print $9}')
	if [ $(expr $z1 - $buy_t) -ge $n ]
	then
		state=0
		sell_p=$(echo $x | awk '{print $2}')
		echo Sell for $sell_p
		c1=$(echo $sell_p - $buy_p | bc -l)
		c2=$(echo $c1 / $buy_p | bc -l)
		change=$(echo $c2 + 1 | bc -l)
		echo $change >> trades.txt
		echo Change of $(echo $c2 \* 100 | bc -l)%
		ip=$sell_p

	fi
fi
done < out.txt

while read x
do
inv=$(echo $inv \* $x | bc -l)
done < trades.txt
profit=$(echo $inv - $i_inv | bc -l)
echo Your profit is $profit.
