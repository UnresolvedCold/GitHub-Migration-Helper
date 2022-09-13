echo "This script helps you to migrate your local commits from old (bitbucket) repo to new (github) repo and raise a pull request."
echo "Make sure you don't have any un-commited changes before using this utility."

BITBUCKET_REPO_ADDRESS=
GITHUB_REPO_ADDRESS=
FEATURE_BRANCH=
BITBUCKET_PR_BRANCH=platform
GITHUB_PR_BRANCH=develop

unset input
while [ -z ${input} ]; do
    read -p "Enter the location of bitbucket repo (/home/..../workspace/wms-oms): " input
    BITBUCKET_REPO_ADDRESS=$input
done

unset input
while [ -z ${input} ]; do
    read -p "Enter the location of the new GitHub repo (/home/.../platform): " input
    GITHUB_REPO_ADDRESS=$input
done

unset input
while [ -z ${input} ]; do
    read -p "Feature Branch Name: " input
    FEATURE_BRANCH=$input
done

unset input
read -p "Branch to raise PR as per Bitbucket repo (platform): " input

if [ ! -z ${input} ]; then
    BITBUCKET_PR_BRANCH=$input
fi

unset input
read -p "Branch to raise PR as per Github repo (develop): " input

if [ ! -z ${input} ]; then
    GITHUB_PR_BRANCH=$input
fi

cd $BITBUCKET_REPO_ADDRESS
REPO_NAME=${PWD##*/}

# Create a patch file from old repo
git checkout $FEATURE_BRANCH
git format-patch $BITBUCKET_PR_BRANCH --stdout > ~/gor-gitpatch

# Apply the patch to new repo
cd $GITHUB_REPO_ADDRESS
git checkout -b $FEATURE_BRANCH
git am --directory $REPO_NAME ~/gor-gitpatch

# Push the changes to Github
git push --set-upstream origin $FEATURE_BRANCH 

# Create a pull request
gh pr create -B $GITHUB_PR_BRANCH
