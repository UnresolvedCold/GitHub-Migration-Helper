set -e
echo "This script helps you to migrate your local commits from old repo to new repo and raise a pull request (if required)."
echo "Make sure you don't have any un-commited changes before using this utility."

SCRIPT_DIR=${CONFIG_DIR:-$(dirname "$0")}

OLD_REPO=$(jq -r .old_repo_directory $SCRIPT_DIR/config.json)
NEW_REPO=$(jq -r .new_repo_directory $SCRIPT_DIR/config.json)
FEATURE_BRANCHES=($(jq -r .feature_branches $SCRIPT_DIR/config.json | tr -d '[],"'))
OLD_PR_BRANCH=$(jq -r .old_pr_branch $SCRIPT_DIR/config.json)
NEW_PR_BRANCH=$(jq -r .new_pr_branch $SCRIPT_DIR/config.json)
RAISE_PR=$(jq -r .raise_pr $SCRIPT_DIR/config.json)
PUSH_CHANGES=$(jq -r .push_changes $SCRIPT_DIR/config.json)
pwd
echo OLD_REPO: $OLD_REPO
cd ${OLD_REPO}
REPO_NAME=${PWD##*/}

# Create a patch file from old repo
for FEATURE_BRANCH in ${FEATURE_BRANCHES[@]}; do
    git checkout $FEATURE_BRANCH
    git format-patch $OLD_PR_BRANCH --stdout > ~/gor-gitpatch

    # Apply the patch to new repo
    cd $NEW_REPO
    git checkout -b $FEATURE_BRANCH
    git am --directory $REPO_NAME ~/gor-gitpatch

    # Push the changes to Github
    [[ $PUSH_CHANGES == true ]] && git push --set-upstream origin $FEATURE_BRANCH 

    # Create a pull request
    [[ $RAISE_PR == true ]] && gh pr create -B $NEW_PR_BRANCH
done
