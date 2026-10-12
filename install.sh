#!/usr/bin/env bash
# Install this Neovim config + nvim-agent + Handy/Herdr helpers + agent skills.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"

SKILL_TARGETS=(
  "${HOME}/.cursor/skills"
  "${HOME}/.codex/skills"
  "${HOME}/.agents/skills"
)

BIN_LINKS=(
  nvim-agent
  handy-to-herdr
  handy-target
)

echo "==> Neovim config: ${REPO_DIR}"

if [[ ! -f "${REPO_DIR}/init.lua" ]]; then
  echo "error: run this from a checkout of the nvim config repo" >&2
  exit 1
fi

# Expected location for Neovim
TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [[ "${REPO_DIR}" != "${TARGET}" ]]; then
  if [[ -e "${TARGET}" && ! -L "${TARGET}" ]]; then
    echo "error: ${TARGET} already exists and is not this repo." >&2
    echo "  Move it aside, then: git clone <url> ${TARGET} && ${TARGET}/install.sh" >&2
    exit 1
  fi
  mkdir -p "$(dirname "${TARGET}")"
  ln -sfn "${REPO_DIR}" "${TARGET}"
  echo "==> Linked ${TARGET} -> ${REPO_DIR}"
fi

mkdir -p "${BIN_DIR}"
for name in "${BIN_LINKS[@]}"; do
  src="${REPO_DIR}/bin/${name}"
  if [[ -f "$src" ]]; then
    chmod +x "$src"
    ln -sfn "$src" "${BIN_DIR}/${name}"
    echo "==> Linked ${BIN_DIR}/${name}"
  fi
done

for skills_dir in "${SKILL_TARGETS[@]}"; do
  parent="$(dirname "${skills_dir}")"
  if [[ -d "${parent}" ]]; then
    mkdir -p "${skills_dir}"
    ln -sfn "${REPO_DIR}/skills/nvim-agent" "${skills_dir}/nvim-agent"
    echo "==> Linked ${skills_dir}/nvim-agent"
  else
    echo "==> Skipped ${skills_dir} (no $(basename "${parent}") install)"
  fi
done

# Optional: point Handy at handy-to-herdr if Handy is installed
HANDY_SETTINGS="${HOME}/Library/Application Support/com.pais.handy/settings_store.json"
if [[ -f "$HANDY_SETTINGS" ]]; then
  /usr/bin/python3 - "$HANDY_SETTINGS" "${BIN_DIR}/handy-to-herdr" <<'PY' && echo "==> Configured Handy external paste → handy-to-herdr" || true
import json, sys
from pathlib import Path
path, script = Path(sys.argv[1]), sys.argv[2]
data = json.loads(path.read_text())
settings = data.setdefault("settings", {})
settings["paste_method"] = "external_script"
settings["external_script_path"] = script
path.write_text(json.dumps(data, indent=2) + "\n")
PY
  echo "    (Quit/reopen Handy if it was running)"
else
  echo "==> Skipped Handy config (app settings not found)"
fi

mkdir -p "${HOME}/.config/herdr"
if [[ ! -f "${HOME}/.config/herdr/handy-mode" ]]; then
  printf 'herdr\n' >"${HOME}/.config/herdr/handy-mode"
  echo "==> Default Handy mode: herdr (run handy-target to change)"
fi

case ":$PATH:" in
  *":${BIN_DIR}:"*) ;;
  *)
    echo "==> Note: add ${BIN_DIR} to PATH (e.g. in ~/.zshrc):"
    echo "    export PATH=\"${BIN_DIR}:\$PATH\""
    ;;
esac

echo
echo "Done. Next:"
echo "  1. Install Neovim 0.11+"
echo "  2. Open nvim once (plugins bootstrap)"
echo "  3. nvim-agent status"
echo "  4. handy-target   # choose Herdr pane vs native Handy paste"
echo "  5. In Neovim: :NvimAgentStatus"
