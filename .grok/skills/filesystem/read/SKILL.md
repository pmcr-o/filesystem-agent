---
name: read
description: Read one text file inside the granted workspace, capped at 4096 bytes. Use for a filesystem read.
---
# read
## Inputs
Require a workspace, a relative file path, and a maximum byte count no higher than 4096.
## Workflow
1. Run scripts/read.ps1.
2. Return only the capped text.
3. Stop when the path is rooted, escapes the workspace, or is not a file.
## Failure
Do not raise the byte cap inside the skill.
