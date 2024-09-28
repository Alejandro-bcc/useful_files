read -p "Insira o nome do arquivo zip: " arqzip

unzip $arqzip

read -p "Insira o nome da pasta: " dir

read -p "Insira o nome do programa: " codeName

#code="./"$codeName
code=$(find -name $codeName)
touch teste.txt
touch sol.txt

typeset -l ext

for file in $dir/*; do
	for file2 in $file/*; do
		ext=$(echo $file2 | rev | cut -c 1-3 | rev)
		if [ "$ext" == ".in" ]; then
			python3 $code < $file2 > teste.txt
		else 
			cat $file2 > sol.txt
			if cmp -s teste.txt sol.txt; then	
				echo "ok"
			else
				echo "error $file2"
			fi
		fi
	done
done

rm teste.txt
rm sol.txt
read -p "Deseja excluir o arquivo e a pasta "$arqzip" ? [y/n] " conf
if [ "$conf" == "y" ]; then
	rm -rf $dir
	rm $arqzip
fi
