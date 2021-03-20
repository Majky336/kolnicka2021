#!/bin/bash

checkpoint=$1;
control_branch='control'
branch_status=null
search_term="Checkpoint ${checkpoint}"

if test "x$control_branch" = x; then
    control_branch=`git branch -a | grep "*" | cut -d ' ' -f2`
fi

if [[ $(git diff --stat) != '' ]]; then
  branch_status='dirty'
  echo "Branch dirty. Resetting changes and creating temp branch"
  git checkout .
  echo "Cleaned git tree"  
else
  branch_status='clean'
  echo "Branch clean."
fi

temp_branch=`git branch -a | grep "temp"`
if test "y$temp_branch" = y; then
    git checkout -b "temp"
    echo "Set up temporal branch complete"
else
    git checkout "temp"
    echo "Temporal branch already set up. Switching"
fi

target_SHA=`git log --abbrev-commit --pretty=oneline --grep="${search_term}" | cut -d ' ' -f1` 

echo $target_SHA

git cherry-pick $target_SHA