---
description: Start work on a new feature by creating a git worktree + branch, then open a PR when done
argument-hint: Short description of the task (used as branch slug)
---

# Branch: Worktree + Branch + PR Workflow

You are starting development work. **Before writing any code**, create a git worktree on a new branch. All edits must happen inside that worktree, never in the primary checkout.

## Rules

- Never commit or stage files in the primary worktree (the repo root you were invoked from).
- Every task gets its own worktree + branch.
- Work ends with a PR. Summarize the PR URL to the user when done.

## Steps

### 1. Determine the branch name

Use `$ARGUMENTS` as the slug if provided. Otherwise, derive a short kebab-case slug from the user's last message (3–5 words max). Branch name format: `<slug>`.

### 2. Create the worktree

```sh
git worktree add ../<repo-basename>-<slug> <slug>
```

Where `<repo-basename>` is the last path component of the current working directory. If the branch already exists, append `-2`, `-3`, etc. to the slug until it is unique.

### 3. Do all work inside the worktree

All file reads, edits, and shell commands that modify code must target `../<repo-basename>-<slug>/`. Never edit files in the primary checkout.

### 4. Commit in the worktree

```sh
git -C ../<repo-basename>-<slug> add <files>
git -C ../<repo-basename>-<slug> commit -m "<message>"
```

### 5. Push and open a PR

```sh
git -C ../<repo-basename>-<slug> push -u origin <slug>
gh pr create --title "<concise title>" --body "..." 
```

Run `gh pr create` from inside `../<repo-basename>-<slug>/`.

### 6. Report back

Tell the user the PR URL and the worktree path. Mention they can remove the worktree after merge:

```sh
git worktree remove ../<repo-basename>-<slug>
git branch -d <slug>
```

---

Now begin: figure out what task the user wants, create the worktree, do the work, and open the PR.

Task: $ARGUMENTS
