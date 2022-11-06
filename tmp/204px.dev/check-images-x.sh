
cat images.txt | while read i
do
  n=$(docker images $i | wc -l)
  if [ $n -lt 2 ];then
    echo "$i not exists"
  fi
done
