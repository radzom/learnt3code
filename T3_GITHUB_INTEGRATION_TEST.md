# T3 GitHub Integration Test

This file verifies that the containerized T3 Code workflow can:

- write to its isolated repository volume;
- create a Git commit as the dedicated agent identity;
- push through the isolated GitHub CLI credential volume; and
- open a pull request without mounting the host project or host SSH key.
