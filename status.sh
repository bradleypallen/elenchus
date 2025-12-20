#!/bin/bash
# Review current dialectical state (Bilateral version)
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

echo "▸ CURRENT STATE [Commitments : Denials]"
echo "────────────────────────────────────────"
echo ""
echo "  Commitments (assertions):"
gh issue list --repo "$REPO" --label commitment --state open --limit 15 --json number,title --jq '.[] | "    #\(.number): \(.title)"' 2>/dev/null || echo "    (none)"
echo ""
echo "  Denials (rejections):"
gh issue list --repo "$REPO" --label denial --state open --limit 15 --json number,title --jq '.[] | "    #\(.number): \(.title)"' 2>/dev/null || echo "    (none)"
echo ""

echo "▸ OPEN CHALLENGES (demands response)"
echo "────────────────────────────────────"
gh issue list --repo "$REPO" --label challenge --state open --limit 10 || echo "  (none)"
echo ""

echo "▸ OPEN TENSIONS (incoherences to resolve)"
echo "──────────────────────────────────────────"
gh issue list --repo "$REPO" --label tension --state open --limit 10 || echo "  (none)"
echo ""

echo "▸ OPEN QUESTIONS (research agenda)"
echo "───────────────────────────────────"
gh issue list --repo "$REPO" --label question --state open --limit 10 || echo "  (none)"
echo ""

echo "────────────────────────────────────────────────────────────────"
echo "Totals:"
COMMITS=$(gh issue list --repo "$REPO" --label commitment --state open --json number --jq 'length' 2>/dev/null || echo 0)
DENIALS=$(gh issue list --repo "$REPO" --label denial --state open --json number --jq 'length' 2>/dev/null || echo 0)
QUESTIONS=$(gh issue list --repo "$REPO" --label question --state open --json number --jq 'length' 2>/dev/null || echo 0)
TENSIONS=$(gh issue list --repo "$REPO" --label tension --state open --json number --jq 'length' 2>/dev/null || echo 0)
CHALLENGES=$(gh issue list --repo "$REPO" --label challenge --state open --json number --jq 'length' 2>/dev/null || echo 0)

echo "  Commitments: $COMMITS"
echo "  Denials:     $DENIALS"
echo "  Questions:   $QUESTIONS"
echo "  Tensions:    $TENSIONS"
echo "  Challenges:  $CHALLENGES"
echo ""
echo "  State: [$COMMITS assertions : $DENIALS rejections]"
