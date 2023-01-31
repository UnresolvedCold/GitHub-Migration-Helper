echo "Just a test"
[[ -d mocks ]] && rm -rf mocks
unzip mocks.zip
cd mocks/r1 
git checkout -b "feature-branch-r1" 
echo "some modifications" >> r1-file.txt 
git add . 
git commit -m "Commit 1 on feature branch" 
echo "some addition" > r1-file-2.txt 
git add . 
git commit -m "Commit 2 on feature branch"
cd ../..
pwd
export CONFIG_DIR=.; bash ../migratepr.sh 
# rm -rf mocks
unset CONFIG_DIR
