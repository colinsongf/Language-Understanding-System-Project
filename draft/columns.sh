line_to_write=1
rm -f output.txt
cat ../data/NLSPARQL.train.data | cut -f 2 > tmp
while read line
do
	N=$(echo $line | wc -w)
	if [ "$N" -gt "1" ]; then
		take_line=$(sed "${line_to_write}q;d" tmp)
        echo "$line\t$take_line" >> output.txt
	else 
        echo "\n" >> output.txt
	fi
	line_to_write=$((line_to_write + 1))
done < "../data/NLSPARQL.train.feats.txt"

rm tmp
