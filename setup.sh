#!/bin/bash
# Initialize dialectical opponent labels in a GitHub repository
# Usage: ./setup.sh owner/repo-name
# Example: ./setup.sh myuser/alignment-positions

set -e

if [ -z "$1" ]; then
    echo "Usage: ./setup.sh owner/repo-name"
    echo "Example: ./setup.sh myuser/alignment-positions"
    exit 1
fi

REPO="$1"

echo "Initializing Elenchus labels in $REPO..."

# Check if repo exists
if ! gh repo view "$REPO" --json name > /dev/null 2>&1; then
    echo "Repository $REPO not found."
    read -p "Create it as a private repo? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        gh repo create "$REPO" --private --description "Dialectical state tracking"
        echo "Created $REPO"
    else
        echo "Aborting."
        exit 1
    fi
fi

echo "Creating dialectical labels..."

gh label create commitment --repo "$REPO" --color 0E8A16 --description "An assented proposition" 2>/dev/null && echo "✓ commitment" || echo "· commitment (exists)"
gh label create question --repo "$REPO" --color 1D76DB --description "An open research question (QUD)" 2>/dev/null && echo "✓ question" || echo "· question (exists)"
gh label create tension --repo "$REPO" --color D93F0B --description "Detected inconsistency between commitments" 2>/dev/null && echo "✓ tension" || echo "· tension (exists)"
gh label create challenge --repo "$REPO" --color FBCA04 --description "Socratic challenge awaiting response" 2>/dev/null && echo "✓ challenge" || echo "· challenge (exists)"
gh label create resolved --repo "$REPO" --color 5319E7 --description "Addressed and closed" 2>/dev/null && echo "✓ resolved" || echo "· resolved (exists)"
gh label create retracted --repo "$REPO" --color 000000 --description "Commitment withdrawn" 2>/dev/null && echo "✓ retracted" || echo "· retracted (exists)"
gh label create background --repo "$REPO" --color C5DEF5 --description "Methodological or framework commitment" 2>/dev/null && echo "✓ background" || echo "· background (exists)"
gh label create empirical --repo "$REPO" --color BFD4F2 --description "Empirical claim" 2>/dev/null && echo "✓ empirical" || echo "· empirical (exists)"
gh label create normative --repo "$REPO" --color D4C5F9 --description "Normative or values claim" 2>/dev/null && echo "✓ normative" || echo "· normative (exists)"
gh label create literature-grounded --repo "$REPO" --color 1D8348 --description "Commitment with literature support/engagement" 2>/dev/null && echo "✓ literature-grounded" || echo "· literature-grounded (exists)"

echo ""
echo "Done. Repository $REPO is ready for dialectical engagement."
echo ""
echo "To use with Claude Code, start a session and say:"
echo "  \"Use $REPO for dialectical tracking\""
