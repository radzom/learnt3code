# T3 Code + Codex container sandbox

This reference setup runs the T3 server and Codex CLI inside one hardened
container. Git repositories are cloned into a dedicated Docker volume; no host
project directory, host SSH key, SSH agent, or Docker socket is mounted.

## 0. Start the hardened Colima profile on macOS

The dedicated profile does not expose the macOS home directory to the Linux VM.
An empty mount list replaces Colima's default writable home mount:

```sh
colima start --profile t3-code \
  --runtime docker \
  --vm-type vz \
  --mount none \
  --cpus 4 \
  --memory 8 \
  --disk 60 \
  --ssh-config=false
docker context use colima-t3-code
```

Verify the VM boundary before using it:

```sh
colima status --profile t3-code
colima ssh --profile t3-code -- findmnt -t virtiofs
```

The second command must not list the host home directory. Do not add host paths
or forward the host SSH agent to this profile.

## 1. Build

The image installs GitHub CLI from GitHub's official Debian repository because
T3 Code requires version 2.81.0 or newer.

```sh
docker compose build
```

## 2. Authenticate Codex

The login is stored in the dedicated `codex-state` volume. Device-code login is
suited to the headless container:

```sh
docker compose run --rm --no-deps t3-codex codex login --device-auth
docker compose run --rm --no-deps t3-codex codex login status
```

Treat this volume like a password store. Do not export or share it.

## 3. Authenticate GitHub

The GitHub CLI login is stored in the dedicated `github-state` volume. It is
separate from the SSH key used by Git on the macOS host. Authenticate the
dedicated agent account and configure Git to use the GitHub CLI credential:

```sh
docker compose run --rm --no-deps t3-codex gh auth login \
  --hostname github.com \
  --git-protocol https \
  --web
docker compose run --rm --no-deps t3-codex gh auth setup-git
docker compose run --rm --no-deps t3-codex gh auth status --hostname github.com
docker compose run --rm --no-deps t3-codex \
  git config --global 'url.https://github.com/.insteadOf' 'git@github.com:'
```

The URL rewrite is intentional: T3 Code currently chooses the SSH clone URL
when its clone protocol is `auto`, while this sandbox deliberately does not
mount an SSH key. Git transparently rewrites GitHub SSH URLs to HTTPS and uses
the `gh` credential helper stored in `github-state`.

Configure the commit identity for the dedicated account:

```sh
docker compose run --rm --no-deps t3-codex \
  git config --global user.name "t3code-agent"
docker compose run --rm --no-deps t3-codex \
  git config --global user.email "YOUR_GITHUB_EMAIL"
```

Treat `github-state` like a password store. Do not export or share it.

## 4. Start T3 Code

Start the server without passing a host project path:

```sh
docker compose up -d
docker compose logs -f t3-codex
```

The logs print the pairing information. The server is published only on
`http://127.0.0.1:3774` by default. Port 3773 is intentionally avoided on the
host because the T3 Code desktop app uses it for its own local backend. In T3,
use Source Control to clone repositories below `/workspace`.

## 5. Verify isolation

```sh
./scripts/verify-container.sh
```

The script checks the mount allowlist, non-root execution, read-only root
filesystem, dropped capabilities, absent Docker socket, writable named volumes,
and an inaccessible host-only canary.

## 6. Stop

```sh
docker compose down
```

Named volumes intentionally survive `down`. Running `docker compose down -v`
also deletes cloned repositories, logs Codex and GitHub out, and deletes T3
state, so use it only for an intentional full reset.
