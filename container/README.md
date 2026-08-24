# T3 Code + Codex container sandbox

This reference setup runs the T3 server and Codex CLI inside one hardened
container. Only the selected project is bind-mounted from the host.

## 0. Start the hardened Colima profile on macOS

The dedicated profile exposes only this project directory to the Linux VM.
Supplying an explicit mount replaces Colima's default writable home mount:

```sh
colima start --profile t3-code \
  --runtime docker \
  --vm-type vz \
  --mount /Users/goonaa/Projects/ai/learnt3code:w \
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

The second command must list exactly
`/Users/goonaa/Projects/ai/learnt3code`. Do not add the host home directory or
forward the host SSH agent to this profile.

## 1. Build

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

## 3. Start T3 Code

The default project is the directory containing `compose.yaml`. To expose a
different project, pass one explicit absolute path:

```sh
T3_PROJECT_PATH=/absolute/path/to/project docker compose up -d
docker compose logs -f t3-codex
```

The logs print the pairing information. The server is published only on
`http://127.0.0.1:3774` by default. Port 3773 is intentionally avoided on the
host because the T3 Code desktop app uses it for its own local backend.

## 4. Verify isolation

```sh
./scripts/verify-container.sh
```

The script checks the mount allowlist, non-root execution, read-only root
filesystem, dropped capabilities, absent Docker socket, project write access,
and an inaccessible host-only canary.

## 5. Stop

```sh
docker compose down
```

Named volumes intentionally survive `down`. Removing them logs Codex out and
deletes T3 state, so do that only when you explicitly want to reset both.
