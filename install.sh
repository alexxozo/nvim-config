#!/usr/bin/env bash
# Install this Neovim config + nvim-agent CLI + Cursor skill on a machine.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BIN_DIR="${XDG_BIN_HOME:-$HOME/.local/bin}"
CURSOR_SKILLS="${HOME}/.cursor/skills"

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

mkdir -p "${BIN_DIR}" "${CURSOR_SKILLS}"

ln -sfn "${REPO_DIR}/bin/nvim-agent" "${BIN_DIR}/nvim-agent"
chmod +x "${REPO_DIR}/bin/nvim-agent"
echo "==> Linked ${BIN_DIR}/nvim-agent"

if [[ -d "${CURSOR_SKILLS}" ]]; then
  ln -sfn "${REPO_DIR}/skills/nvim-agent" "${CURSOR_SKILLS}/nvim-agent"
  echo "==> Linked ${CURSOR_SKILLS}/nvim-agent"
else
  echo "==> Skipped Cursor skill (${CURSOR_SKILLS} not found)"
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
echo "  2. Open nvim once (LazyVim will bootstrap plugins)"
echo "  3. nvim-agent status"
echo "  4. In Neovim: :NvimAgentStatus"
