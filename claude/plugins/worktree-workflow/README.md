# worktree-workflow

A Claude Code plugin that enforces the worktree + branch + PR pattern for all development work. No changes ever land on the main checkout.

## What it does

Adds a `/branch` command. Invoke it at the start of any task and Claude will:

1. Create a `git worktree` + feature branch
2. Do all file editing inside that worktree
3. Commit, push, and open a PR
4. Return the PR URL

## Usage

```
/branch fix the audio-selection bug in gpu.rs
```

```
/branch add Intel QSV fallback
```

Or without arguments — Claude derives the slug from your last message:

```
/branch
```

## Installation

This plugin lives in the dotfiles repo. Register the dotfiles repo as a Claude Code plugin source, then install:

```sh
claude plugin add JackDanger/dotfiles --subdir claude/plugins/worktree-workflow
```

Or install directly from the local checkout:

```sh
claude plugin install ~/.dotfiles/claude/plugins/worktree-workflow
```

## Why

The main worktree should always be in a known-clean state. Working in isolated worktrees means:
- You can switch tasks without stashing
- The main branch stays clean
- Every task has a reviewable PR with a clear scope
- Accidental commits to main are impossible
