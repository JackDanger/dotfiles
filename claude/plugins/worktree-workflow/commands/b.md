---
description: Start work in an isolated git worktree + branch + PR. Handles single tasks or batches of parallel/sequential work.
argument-hint: Task description — or multiple tasks to parallelize
---

# /b — Worktree + Branch + PR

**Before writing any code**, analyze the request and set up the right worktree structure. Never touch the primary checkout.

---

## Step 0: Analyze the request

Read `$ARGUMENTS` carefully and decide:

**Single task** → one worktree, one branch, one PR → go to Single-task flow.

**Multiple tasks** → first determine dependency structure:
- Tasks that are *independent* of each other: create all branches from `main` and work in parallel (spawn agents).
- Tasks where B *builds on* A: chain them — A branches from `main`, B branches from A's branch (not from `main`), so B's PR can be based on A's PR and reviewed/merged in order.
- Mixed: independent clusters branch from `main`; dependent tasks chain within each cluster.

When in doubt about dependencies, ask one clarifying question before creating worktrees.

---

## Single-task flow

### 1. Name the branch

Derive a short kebab-case slug from the task (3–5 words). Use `$ARGUMENTS` directly if it's already slug-shaped. If the branch already exists locally, append `-2`, `-3`, etc.

### 2. Create the worktree

```sh
git worktree add ../<repo>-<slug> <slug>
```

`<repo>` = last path component of the current working directory.

### 3. Do all work inside the worktree

All reads, edits, and shell commands that modify code target `../<repo>-<slug>/`. Never edit files in the primary checkout.

### 4. Commit

```sh
git -C ../<repo>-<slug> add <files>
git -C ../<repo>-<slug> commit -m "<message>"
```

### 5. Push and open a PR

```sh
git -C ../<repo>-<slug> push -u origin <slug>
gh -C ../<repo>-<slug> pr create --title "..." --body "..."
```

### 6. Report back

Tell the user the PR URL. Include the cleanup commands:

```sh
git worktree remove ../<repo>-<slug>
git branch -d <slug>
```

---

## Multi-task flow

### 1. Plan the dependency graph

List each task with its base branch:
```
task-a  →  base: main        (independent)
task-b  →  base: main        (independent)
task-c  →  base: task-a      (depends on task-a)
task-d  →  base: main        (independent)
```

Show this plan to the user as a numbered list before creating anything. If any dependency assumptions are non-obvious, explain them in one sentence each.

### 2. Create all worktrees

For each task:
```sh
git worktree add ../<repo>-<slug> -b <slug> <base-branch>
```

Tasks that are independent of each other can be created in any order. Tasks that depend on another must be created after their base branch exists.

### 3. Spawn agents in parallel (for independent tasks)

For tasks that don't depend on each other, spawn one agent per task. Each agent receives:
- Its worktree path
- Its branch name
- Its base branch
- The specific task description
- The instruction: work only inside its worktree, commit, push, and open a PR with the correct `--base` flag

For dependent tasks, run agents sequentially (or hand off after each PR so the next can branch from a known state).

### 4. Each agent's PR must set the right base

```sh
gh pr create --base <base-branch> --title "..." --body "..."
```

Independent tasks: `--base main`
Dependent tasks: `--base <parent-branch>` so the PR diff is scoped to just its changes.

### 5. Report back

Give the user a table of all PRs:
```
task-a  →  PR #N  (base: main)
task-b  →  PR #N  (base: main)
task-c  →  PR #N  (base: task-a)  ← merge task-a first
...
```

Flag any merge ordering constraints clearly.

---

## Hard rules (apply always)

- Never commit or stage in the primary checkout.
- Every task gets its own worktree + branch.
- PRs for dependent tasks must target the parent branch, not `main`, until the parent merges.
- Work ends when every task has an open PR and the user has all the URLs.

---

Task: $ARGUMENTS
