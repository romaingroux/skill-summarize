# summarize

A [Claude Code](https://claude.com/claude-code) skill that prints a three-sentence re-entry brief of the current session. Run it when you come back to a session after a break and want to know where things stand without scrolling.

## What it prints

Exactly three labelled sentences, each with at most one backticked reference:

```
1. Aim: make `fusionCaller` fetch mates in one indexed pass instead of one query per read.
2. Done: profiling harness written and run, hot spot confirmed in `arm_fetch.cpp:142`, fix design agreed.
3. Next: waiting on you to approve the diff for `fetch_mate`; then build, `make -j tests-cpp`, rerun the harness.
```

- **Aim** is the current goal. If the session drifted from the opening request, the original aim is named too.
- **Done** is what has been completed, reconciled against the state on disk.
- **Next** is the single immediate action first, then the broader remainder. When the work is finished it says so, and when the next step is yours (commit, approval, login, decision) it says `waiting on you to <action>`.

If the conversation and the disk disagree, a fourth line is added:

```
Mismatch: conversation says <A>, disk shows <B>.
```

The skill stops after the output. It asks no question and offers no follow-up.

## How it works

Inside a git repository the skill first runs three read-only commands (`git status --short`, `git log --oneline -5`, `git diff --stat`) so that the **Done** line reflects what is actually on disk, not only what the conversation claims. Outside a repository it works from context alone. A compaction summary in context is treated as ground truth.

The skill is marked `disable-model-invocation: true`, so Claude never triggers it on its own. You invoke it explicitly.

## Installation

Clone the repository anywhere and run the install target:

```bash
git clone https://github.com/romaingroux/skill-summarize
cd skill-summarize
make install
```

This copies the skill files into `~/.claude/skills/summarize`. After a `git pull`, run `make install` again to update the installed copy. To install into a single project instead, point `SKILLS_DIR` at that project's skills folder:

```bash
make install SKILLS_DIR=/path/to/project/.claude/skills
```

`make uninstall` removes the installed copy.

## Usage

In any Claude Code session:

```
/summarize
```

## Files

- `SKILL.md` contains the skill definition: frontmatter, the disk check, the output contract and two worked examples.
- `Makefile` installs and uninstalls the skill.
- `LICENSE` is the GNU GPL v3 text.

## License

This project is licensed under the GNU General Public License v3.0 or later. See `LICENSE`.
