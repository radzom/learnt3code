#!/bin/sh
set -eu

service_name="${T3_SERVICE_NAME:-t3-codex}"
project_root="${T3_PROJECT_PATH:-.}"
container_id="$(docker compose ps -q "$service_name")"

if [ -z "$container_id" ]; then
  echo "FAIL: service '$service_name' is not running" >&2
  exit 1
fi

pass() {
  echo "PASS: $1"
}

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

container_user="$(docker exec "$container_id" id -u)"
[ "$container_user" != "0" ] || fail "container process runs as root"
pass "container process runs as non-root UID $container_user"

privileged="$(docker inspect "$container_id" --format '{{.HostConfig.Privileged}}')"
[ "$privileged" = "false" ] || fail "container is privileged"
pass "privileged mode is disabled"

root_read_only="$(docker inspect "$container_id" --format '{{.HostConfig.ReadonlyRootfs}}')"
[ "$root_read_only" = "true" ] || fail "root filesystem is writable"
pass "root filesystem is read-only"

cap_drop="$(docker inspect "$container_id" --format '{{json .HostConfig.CapDrop}}')"
printf '%s' "$cap_drop" | grep -q 'ALL' || fail "not all Linux capabilities are dropped"
pass "all Linux capabilities are dropped"

security_options="$(docker inspect "$container_id" --format '{{json .HostConfig.SecurityOpt}}')"
printf '%s' "$security_options" | grep -q 'no-new-privileges' || fail "no-new-privileges is missing"
pass "no-new-privileges is enabled"

docker exec "$container_id" sh -lc 'test ! -S /var/run/docker.sock' \
  || fail "Docker socket is visible inside the container"
pass "Docker socket is absent"

actual_mounts="$(docker inspect "$container_id" --format '{{range .Mounts}}{{printf "%s %s\n" .Type .Destination}}{{end}}' \
  | sed '/^[[:space:]]*$/d' \
  | sort)"
expected_mounts="$(printf '%s\n' \
  'bind /workspace' \
  'volume /var/lib/codex' \
  'volume /var/lib/t3' | sort)"
[ "$actual_mounts" = "$expected_mounts" ] \
  || fail "mount allowlist differs; found:\n$actual_mounts"
pass "mount allowlist contains only workspace, T3 state, and Codex state"

tmpfs_config="$(docker inspect "$container_id" --format '{{json .HostConfig.Tmpfs}}')"
printf '%s' "$tmpfs_config" | grep -q '"/tmp"' || fail "/tmp is not a tmpfs"
pass "/tmp is backed by tmpfs"

host_canary="$(mktemp "${TMPDIR:-/tmp}/t3-host-canary.XXXXXX")"
project_probe_name=".t3-container-probe.$$"
project_probe_host="$project_root/$project_probe_name"

cleanup() {
  rm -f "$host_canary" "$project_probe_host"
  docker exec "$container_id" rm -f "/workspace/$project_probe_name" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

openssl rand -hex 24 > "$host_canary"
canary_hash_before="$(shasum -a 256 "$host_canary")"

if docker exec "$container_id" test -e "$host_canary"; then
  fail "host-only canary is visible inside the container"
fi
pass "host-only canary is invisible"

docker exec "$container_id" sh -lc "printf container-write-ok > '/workspace/$project_probe_name'" \
  || fail "container cannot write to the project"
[ "$(cat "$project_probe_host")" = "container-write-ok" ] \
  || fail "project write did not reach the host bind mount"
pass "project bind mount is writable"

canary_hash_after="$(shasum -a 256 "$host_canary")"
[ "$canary_hash_before" = "$canary_hash_after" ] \
  || fail "host-only canary changed"
pass "host-only canary is unchanged"

echo "PASS: all container-isolation checks succeeded"
