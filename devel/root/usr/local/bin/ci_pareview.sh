#!/bin/bash

export PATH="$PATH:/home/gitlab-runner/.config/composer/vendor/bin"

function gettestDirs () {
  local a b c d ignore DIRS result

result=''

DIRS=`find $1 -maxdepth 2 -type d`
DIRS=$(echo $DIRS | grep -v .git | cut -d " " -f3-)
ignore=`echo $2 |sed -e "s/,/ /g"`

for d in $DIRS; do
  contains=1
  nb=0
  a=`echo $d |sed -e "s/\// /g"`

  for b in $a; do
    let nb+=1
    for c in $ignore; do
      if [ $b = $c ]; then
        contains=0
      fi
    done
  done
  if [ "$contains" == "1" ]; then
    result="$result $d"
  fi
done

echo "$result"
}

TEST_DIRS=`echo $INCLUDE_TEST_DIRS |sed -e "s/,/ /g"`

INCLUDE_DIRS=''
for a in $TEST_DIRS; do
  INCLUDE_DIRS="$INCLUDE_DIRS $(gettestDirs $a $IGNORE_PAREVIEW_DIRS)"
done

cat <<EOF
<html lang="en">
<head><title>PAREVIEW.sh</title></head>
<body>
EOF

for d in $INCLUDE_DIRS; do
  echo -e "\n\n++++++++++++++++++++++  pareviewsh directory $d  ++++++++++++++++++++++\n\n"
  pareview.sh $d
done

echo -e "\n\n++++++++++++++++++++++  pareviewsh ended  ++++++++++++++++++++++\n\n"

cat <<EOF2
</body>
</html>
EOF2
