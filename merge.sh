#!/bin/bash

git clone https://github.com/rnpgp/homebrew-rnp.git ~/rnp-worker
cd ~/rnp-worker
git remote rm origin
git filter-branch --subdirectory-filter Formula -- --all
#mkdir Formula
#mv * Formula
#git add .
#git commit

git clone https://github.com/rnpgp/homebrew-core.git ~/core-worker
cd ~/core-worker
git remote add rnp-master ~/rnp-worker
git pull ~/rnp-worker master --allow-unrelated-histories
git remote rm rnp-master
