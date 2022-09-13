echo "This script helps you to migrate your local commits from old (bitbucket) repo to new (github) repo."
echo "Make sure you don't have any un-commited changes before using this utility."

read -p "Enter the location of bitbucket repo you want to generate PR for (/home/..../workspace/wms-oms): " BITBUCKET_REPO_ADDRESS
read -p "Enter the location of the new GitHub repo (/home/.../platform): " GITHUB_REPO_ADDRESS
read -p "Working branch name (feature branch): " FEATURE_BRANCH
read -p "Branch to raise PR: " PR_BRANCH

cd $BITBUCKET_REPO_ADDRESS
REPO_NAME=${PWD##*/}

echo $BITBUCKET_REPO_ADDRESS
echo $GITHUB_REPO_ADDRESS
echo $FEATURE_BRANCH
echo $PR_BRANCH
echo $REPO_NAME

# Create a patch file from old repo
git checkout $FEATURE_BRANCH
git format-patch $PR_BRANCH --stdout > ~/gor-gitpatch

# Apply the patch to new repo
git checkout -b $FEATURE_BRANCH
cd $GITHUB_REPO_ADDRESS
git am --directory $REPO_NAME ~/gor-gitpatch