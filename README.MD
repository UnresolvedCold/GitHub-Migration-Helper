# GitHub Platform Migration Helper

These scripts will help you to migrate your recent pull requests from bitbucket to Github.

## Requirements

The tool depends on `git` for everything anf `github cli` for pull requests.

## How to use?

1. Run the `migratepr.sh` script from anywhere.
1. It will ask you for certain details. 
1. Fill them.

![How to use](https://i.imgur.com/Yq48BqK.png)

## What to do on failures?

1. Remove any commits that were incorporated in the new repo.

1. `git am --abort` just to ensure the process is not in the resuem state.

1. Delete the feature branch if it's been created in the Guthub repo.

1. If you are facing any problem contact [Shubham Kumar](shubham.kumar@greyorange.com), [Guruvardhan Kancharla](kancharla.g@greyorange.com) or [Srijan Choudhary](srijan.c@greyorange.com).
