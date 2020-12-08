#!/bin/bash
export LESSCHARSET=utf-8
echo $ghprbTargetBranch

echo 'Starting git diff'
cd ..
echo 'Switching to origin/master'
git checkout -f origin/master
echo 'Merging target branch (origin/CEAS-1234) into current branch (origin/master)'
git merge --no-commit --no-ff origin/CEAS-1234
echo 'Merged. Looking for conflicts'
git ls-files -u | awk '{$1=$2=$3=""; print $0}' | awk '{ sub(/^[ \t]+/, ""); print }' | sort -u > conflicts.txt
if [ -s conflicts.txt ]
then
    echo 'Conflicts found. Please resolve conflicts prior validation...'
    echo '============================================================='
    echo -e '\n\nConflicting files:\n'
    cat conflicts.txt
    exit 1
else
    echo 'Starting git diff'
    git diff origin/master origin/CEAS-1234 > diffPatch.patch
    git status -s > diff.txt
    echo 'Git diff done.'
    echo 'Clean double quotes'
    sed -i 's/\"//g' diff.txt
    echo 'Cleaned. Result:'
    cat diff.txt
fi