#!/bin/bash
# Defensive checklist for an authorized Linux lab VM.
# This script only prints checks; it does not make system changes.

echo "=== System Hardening Review ==="
echo
echo "[1] Kernel / OS"
uname -a
echo
echo "[2] Current user"
id
echo
echo "[3] Listening services"
ss -tulpen 2>/dev/null || true
echo
echo "[4] Firewall status (if available)"
if command -v ufw >/dev/null 2>&1; then
    sudo ufw status || true
else
    echo "ufw is not installed."
fi
echo
echo "[5] Failed-login summary (if available)"
if command -v journalctl >/dev/null 2>&1; then
    sudo journalctl --since "24 hours ago" 2>/dev/null | grep -Ei "failed|authentication failure" | tail -20 || true
fi
echo
echo "Review the output and apply changes manually according to your lab requirements."
