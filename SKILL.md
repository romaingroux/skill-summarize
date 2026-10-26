---
name: summarize
description: Three-sentence re-entry brief of the current session after an idle gap.
disable-model-invocation: true
---

Print a re-entry brief of this session for the user, who has been away and is picking the same session back up.

## Disk check

When the working directory is inside a git repository, run these read-only commands first:

```bash
git status --short
git log --oneline -5
git diff --stat
```

Outside a repository, skip them and work from context alone. A compaction summary in context counts as ground truth.

## Output contract

Exactly three sentences, one per labelled line. No bullets, no lists, no extra lines. Content that does not fit is dropped. Each sentence carries at most one backticked reference (a `path:line`, a branch, a command).

1. `Aim:` the current goal. When the session has drifted from the request that opened it, name the original aim in the same sentence.
2. `Done:` what has been completed, reconciled against the disk check.
3. `Next:` the single immediate action first, then the broader remainder if it fits. When the work is complete: "nothing, session goal reached". When the next step belongs to the user (commit, approval, login, decision): "waiting on you to <action>".

A fourth line is allowed only when the conversation and the disk disagree:

```
Mismatch: conversation says <A>, disk shows <B>.
```

Stop after the output: no question, no offer to continue.

## Examples

Normal:

```
1. Aim: make `fusionCaller` fetch mates in one indexed pass instead of one query per read.
2. Done: profiling harness written and run, hot spot confirmed in `arm_fetch.cpp:142`, fix design agreed.
3. Next: waiting on you to approve the diff for `fetch_mate`; then build, `make -j tests-cpp`, rerun the harness.
```

With a mismatch:

```
1. Aim: add the supporting-fragment count feature to the feature store, a detour from the original aim of retraining v9.
2. Done: feature computed in `features.py:88` and unit test added.
3. Next: run `make test`, then return to the retraining plan.
Mismatch: conversation says the test file was added, disk shows no new file under tests/.
```
