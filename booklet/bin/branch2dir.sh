#!/bin/bash

B=`git branch --list --all | grep article`
BRANCHES=`for i in $B; do echo ${i##remotes/origin/}; done | sort -u`

N=1
for i in $BRANCHES; do
    echo N=$N $i
    git checkout -q $i
    if [ -f ../articles/$i.md ]; then
      # rm -rf articles/$N
      mkdir -p articles/$N
      cp ../articles/$i.md articles/$N/txt.md
      cp ../images/image${i##article}.* articles/$N
      ./_md2tex.sh articles/$N
      N=$[$N + 1]
    else
        echo "  skipping $i"
        continue
    fi

#    if [ $N -ge 4 ]; then
#       break
#    fi
done

git checkout booklet
