---
name: list
description: List entry names in one directory inside the granted workspace. Use for a filesystem catalog listing.
---
# list
## Inputs
Require a workspace and a relative path.
## Workflow
1. Run scripts/list.ps1 with that workspace and path.
2. Return entry names. Do not return file contents.
3. Stop when the script rejects a rooted path or a path that leaves the workspace.
## Failure
A rejected path is a failed capability call. Do not retry it outside the workspace.
