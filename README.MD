# GitHub Migration Helper

These scripts will help you to migrate your feature branch/branches from old repo to new one.

## Dependencies

* git
* githubcli
* jq

## How to use?

1. You can run these scripts from anywhere.
2. Clone this repository anywhere on your local environment.
3. Configure the `config.json` file as required. See [Configurations](#configurations) for more details.
4. Run the `migratepr.sh`.

## Configurations

The script can be configured using `config.json` file present within this repositories.

Below are the details,

| Attribute | Details |
| -- | -- |
| old_repo_directory | This is the old working directory. Only absolute paths are accepted. |
| new_repo_directory | This is the new working directory. Only absolute paths are accepted. |
| feature_branches | These are the feature branches you like to migrate to new repo |
| push_changes | if `true`, will migrate the feature branches and pusht them to origin |
| raise_pr | if `true`, will raise a PR after migration |
| old_pr_branch | This is the branch on which pr was raised in the old repo |
| new_pr_branch | This is the branch on which you want to raise the PR in new repo |

### Exapmle

Below example shows you the configurations for the migration of feature-branch-r1 of r1 which was migrated as a subdirectory to workspace/r1.

```json
{
    "old_repo_directory": "/Users/shubham.kumar/Documents/Projects/GreyOrange/GitHub-Platform-Migration-Helper/test/mocks/r1",
    "new_repo_directory": "/Users/shubham.kumar/Documents/Projects/GreyOrange/GitHub-Platform-Migration-Helper/test/mocks/workspace",
    "feature_branches": [
        "feature-branch-r1"
    ],
    "push_changes": false,
    "raise_pr": false,
    "old_pr_branch": "master",
    "new_pr_branch": "master"
}
```

> Note: Only absolute paths will be accepted for `old_repo_directory` and `new_repo_directory`. The script will not recognize `~` as the `HOME` directory.

## What to do on failures?

1. Remove any commits that were incorporated in the new repo.

1. `git am --abort` just to ensure the process is not in the resuem state.

1. Delete the feature branch from the new repo if it's been created in the Guthub repo.
    ```bash
    # How to delete?
    cd <new-repo>
    # Switch to any other branch 
    git checkout develop
    # Delete a feature branch 
    git branch -D <feature-branch-name>

1. In case of any questions/difficulties, feel free to ping [Shubham Kumar](shubham.kumar@greyorange.com), [Guruvardhan Kancharla](kancharla.g@greyorange.com) or [Srijan Choudhary](srijan.c@greyorange.com) on Slack.
