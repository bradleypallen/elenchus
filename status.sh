#!/bin/bash
# Review current dialectical state
# Usage: ./status.sh owner/repo-name
# Example: ./status.sh myuser/alignment-positions

if [ -z "$1" ]; then
    echo "Usage: ./status.sh owner/repo-name"
    exit 1
fi

REPO="$1"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║              DIALECTICAL STATUS: $REPO"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

echo "▸ OPEN CHALLENGES (demands response)"
echo "────────────────────────────────────"
gh issue list --repo "$REPO" --label challenge --state open --limit 10 || echo "  (none)"
echo ""

echo "▸ OPEN TENSIONS (inconsistencies to resolve)"
echo "─────────────────────────────────────────────"
gh issue list --repo "$REPO" --label tension --state open --limit 10 || echo "  (none)"
echo ""

echo "▸ OPEN QUESTIONS (research agenda)"
echo "───────────────────────────────────"
gh issue list --repo "$REPO" --label question --state open --limit 10 || echo "  (none)"
echo ""

echo "▸ RECENT COMMITMENTS"
echo "────────────────────"
gh issue list --repo "$REPO" --label commitment --state open --limit 10 || echo "  (none)"
echo ""

echo "────────────────────────────────────────────────────────────────"
echo "Totals:"
echo "  Commitments: $(gh issue list --repo "$REPO" --label commitment --state open --json number --jq 'length' 2>/dev/null || echo 0)"
echo "  Questions:   $(gh issue list --repo "$REPO" --label question --state open --json number --jq 'length' 2>/dev/null || echo 0)"
echo "  Tensions:    $(gh issue list --repo "$REPO" --label tension --state open --json number --jq 'length' 2>/dev/null || echo 0)"
echo "  Challenges:  $(gh issue list --repo "$REPO" --label challenge --state open --json number --jq 'length' 2>/dev/null || echo 0)"
