#!/bin/bash

checkpoint=$1;
control_branch='control'
branch_status=null

if [[ $(git diff --stat) != '' ]]; then
  branch_status='dirty'
else
  branch_status='clean'
fi

echo $branch_status

# git diff --quiet
# git checkout $control_branch