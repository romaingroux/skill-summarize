# Install this Claude Code skill into the user's skills directory.
#
#   make install                 copy the skill into $(SKILLS_DIR)/$(SKILL)
#   make uninstall               remove it
#   make install SKILLS_DIR=...  override the destination

SKILL     := summarize
SKILLS_DIR ?= $(HOME)/.claude/skills
DEST      := $(SKILLS_DIR)/$(SKILL)

# Everything in the repo except repo tooling.
EXCLUDE := --exclude .git --exclude .gitignore --exclude Makefile --exclude README.md --exclude __pycache__

.PHONY: install uninstall

install:
	mkdir -p "$(DEST)"
	rsync -a --delete $(EXCLUDE) ./ "$(DEST)/"
	@echo "installed $(SKILL) -> $(DEST)"

uninstall:
	rm -rf "$(DEST)"
	@echo "removed $(DEST)"