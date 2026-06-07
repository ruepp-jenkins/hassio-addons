# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

Home Assistant add-ons repository. Each add-on lives in its own subdirectory (e.g. `databasus/`) and uses a pre-built Docker image — there is no build step on the HA server itself.

## Add-on structure

Each add-on directory contains:
- `config.yaml` — HA add-on manifest; the `version` field here is what HA displays and must be `{upstream_image_version}-{addon_wrapper_version}`, and the `image` tag must match the upstream version alone
- `version.txt` — the addon wrapper version (e.g. `1.0.0`); increment this when changing HA-specific config, not when the upstream image changes
- `CHANGELOG.md`, `DOCS.md`, `translations/`, `icon.png`, `logo.png`

## Automation

Jenkins runs the pipeline daily (03:00 UTC) and on every new upstream image version (URLTrigger polling every 30 min). Pipeline stages:

1. **Pre Cleanup** — `cleanWs()`
2. **Checkout** — git checkout via `ruepp-jenkins` credential
3. **Ensure Scripts are Runnable** — `chmod +x` on root and `scripts/` scripts
4. **Setup Git** — `setup_git.sh` sets `user.name`/`user.email` for subsequent commits
5. **Check Addons** — `run_scripts.sh` runs all `scripts/*.sh` in sorted filename order; each script updates its addon and creates its own commit
6. **Commit Changes** — `commit_changes.sh` pushes any unpushed commits using the `github.com-ssh` credential

### Adding a new version-update script

Create `scripts/NN_update_<addon>_version.sh` (numeric prefix controls execution order). Each script is responsible for fetching the upstream version, writing it into `config.yaml`, and **creating its own git commit**. Do not push — `commit_changes.sh` pushes everything at the end.

Pattern (see `scripts/10_update_databasus_version.sh`):
1. `curl -sf <latest_version_url> | tr -d '[:space:]'` → upstream version
2. `cat <addon>/version.txt | tr -d '[:space:]'` → wrapper version
3. Update `config.yaml` `version` field to `${UPSTREAM}-${LOCAL}` and `image` tag to `${UPSTREAM}`
4. `git diff --quiet <addon>/config.yaml` — if changed, `git add` and `git commit -m "ci: update <addon> to ${UPSTREAM} (${LOCAL})"`

Scripts run from the repo root, so use relative paths like `databasus/config.yaml`.

## Key files

| File | Purpose |
|---|---|
| `run_scripts.sh` | Finds and runs all `scripts/*.sh` in sorted order |
| `setup_git.sh` | Configures git `user.name` and `user.email` for the Jenkins workspace |
| `commit_changes.sh` | Pushes any commits not yet on the remote (`git log @{u}..HEAD`) |
| `Jenkinsfile` | Jenkins pipeline definition |
| `repository.json` | HA repository metadata |
