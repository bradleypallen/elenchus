# Elenchus: Dialectical Opponent for Research

A Claude Code protocol that implements a Socratic dialectical opponent using GitHub issues as persistent state.

## What This Is

This system turns Claude Code into a structured intellectual sparring partner. It:

- **Tracks your commitments**: Claims you make become issues, searchable and persistent
- **Detects tensions**: When your claims conflict, it notices and demands resolution
- **Generates challenges**: Socratic questions that probe assumptions, implications, and boundaries
- **Maintains research questions**: Your open questions form a hierarchy (QUD stack)
- **Enforces consistency**: You can't just slide past contradictions

The dialectical structure draws from medieval *obligationes* (formal disputation games) and Roberts' Questions Under Discussion framework from linguistics.

## Requirements

- **Claude Code**: Install from [Anthropic's documentation](https://docs.anthropic.com/en/docs/claude-code)
- **GitHub account**: With permissions to create repositories and issues
- **GitHub CLI (`gh`)**: Authenticated and configured — the setup script uses this for repo creation and label management

## Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/elenchus.git
   cd elenchus
   ```

2. Create and initialize a dialectical repo for your research:
   ```bash
   ./setup.sh yourusername/yourresearchtopic
   ```
   
   This creates the repo if needed and sets up the labels. You can have multiple repos for different research domains.

3. Start Claude Code:
   ```bash
   claude
   ```
   Then tell Claude:
   ```
   Use yourusername/yourresearchtopic for dialectical tracking
   ```

Claude Code will read `CLAUDE.md`, recover all state from the issues, and begin operating as your opponent.

## Usage

### Just talk about your research

Claude will automatically:
- Extract commitments from your claims
- Search for conflicts with prior commitments
- Create issues for tensions and challenges
- Remind you of unresolved challenges

### Check your status

```bash
./status.sh yourusername/yourresearchtopic
```

Or ask Claude: "What challenges and tensions are open?"

### Multiple projects

You can maintain separate dialectical states for different research areas:

```bash
./setup.sh yourusername/yourresearchtopic-1
./setup.sh yourusername/yourresearchtopic-2
./setup.sh yourusername/yourresearchtopic-3
```

Tell Claude which one to use at session start.

### Address a challenge

Either:
- Respond in conversation: "Regarding challenge #12, I think..."
- Comment directly on the issue in GitHub
- Ask Claude to help you work through it

### Seed initial positions

Start a session with: "Let me lay out my current positions on X" and state your views. Claude will create commitment issues and immediately start probing.

### Review and refine

Periodically: "Let's review my commitments on [topic]" — Claude will list them and look for tensions or gaps.

## The Issue Ontology

| Label | Color | Meaning |
|-------|-------|---------|
| `commitment` | Green | A proposition you've assented to |
| `question` | Blue | An open research question |
| `tension` | Red | Detected conflict between commitments |
| `challenge` | Yellow | Socratic question awaiting your response |
| `resolved` | Purple | Successfully addressed |
| `retracted` | Black | Withdrawn commitment |
| `background` | Light blue | Methodological/framework commitment |
| `empirical` | Pale blue | Empirical claim |
| `normative` | Lavender | Values/normative claim |
| `literature-grounded` | Dark green | Commitment with literature engagement |

## Literature Integration

Elenchus can ground your commitments in the scholarly literature:

- **When you make a commitment**, Claude searches for supporting and challenging sources
- **Challenges cite known objections** from published work, not just conceptual probes
- **Commitment issues include** Supporting Literature, Challenging Literature, and your Engagement with challenges
- **Citations are validated** where possible; uncertainty is flagged

This means your dialectical trace becomes a literature review built through genuine engagement, not post-hoc citation gathering.

Example commitment structure:

```markdown
## Commitment
Grounding is constituted by linguistic competence, not sensorimotor connection

## Supporting Literature
- Brandom (1994): Making It Explicit — inferentialist semantics
- Sellars (1956): "Empiricism and the Philosophy of Mind" — space of reasons

## Challenging Literature  
- Harnad (1990): "The Symbol Grounding Problem" — sensorimotor requirement
- Barsalou (1999): "Perceptual symbol systems" — embodied cognition

## Engagement with Challenges
Harnad's requirement is addressed by distinguishing original from derivative grounding...
```

## Tips

- **Be explicit**: "I commit to X" is clearer than hedged statements
- **Embrace tensions**: They're features, not bugs—they show where your thinking needs work
- **Close the loop**: When you resolve something, make sure Claude closes the issue with documentation
- **Use it for papers**: Before writing, dump your argument and let Claude find the holes
- **Revisit periodically**: Your open challenges and tensions are a todo list for your thinking

## Limitations

- Search depends on good keywords in issue titles/bodies
- Claude may miss subtle tensions that require deep domain knowledge
- You have to actually engage with the challenges for this to work

## Session Continuity

Claude Code recovers full dialectical state from GitHub at each session start. The issues *are* the memory—there's no separate state to lose. When you start a session, Claude will:

1. Load all open challenges and tensions
2. Load your current research questions (QUD stack)
3. Load recent commitments
4. Brief you on what needs attention

This means you can close your laptop, come back a week later, and Claude will know exactly what positions you hold, what questions are open, and what challenges are still waiting for your response.

## Philosophy

The system assumes:
1. Intellectual progress requires confronting discomfort
2. Consistency is a virtue (though not the only one)
3. Unstated assumptions are where errors hide
4. Questions are more powerful than assertions
5. Writing things down changes how you think about them