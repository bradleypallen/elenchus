# Elenchus: Dialectical Opponent for Research

A Claude Code protocol that implements a Socratic dialectical opponent using GitHub issues as persistent state.

## What This Is

This system turns Claude Code into a structured intellectual sparring partner. It:

- **Tracks your commitments and denials**: Both assertions and rejections become issues, searchable and persistent
- **Detects incoherence**: When your positions conflict, it notices and demands resolution
- **Generates challenges**: Socratic questions that probe assumptions, implications, and boundaries
- **Maintains research questions**: Your open questions form a hierarchy (a QUD tree)
- **Enforces coherence**: You can't assert and deny the same thing, or hold contrary positions

The dialectical structure draws from medieval *obligationes* (formal disputation games), Roberts' Questions Under Discussion framework from linguistics, and Restall's bilateral sequent calculus from "Multiple Conclusions" (2004).

## Requirements

- **Claude Code**: Install from [Anthropic's documentation](https://docs.anthropic.com/en/docs/claude-code)
- **GitHub account**: With permissions to create repositories and issues
- **GitHub CLI (`gh`)**: Authenticated and configured — the setup script uses this for repo creation and label management

## Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/bradleypallen/elenchus.git
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
   or if you wish the flow of the dialogue to go with as few interruptions as possible:
   ```bash
   claude --dangerously-skip-permissions
   ```
   This bypasses the confirmation prompts for tool calls (bash, file operations, etc.). Claude will execute without asking. For Elenchus, where the operations are presumably well-understood (git commands, file writes to a known repo), this is reasonable.
   Then tell Claude:
   ```
   Use yourusername/yourresearchtopic for dialectical tracking
   ```

Claude Code will read `CLAUDE.md`, recover all state from the issues, and begin operating as your opponent.

## Usage

### Just talk about your research

Claude will automatically:
- Extract commitments and denials from your claims
- Search for incoherence with prior positions
- Create issues for tensions and challenges
- Remind you of unresolved challenges

### Check your status

```bash
./status.sh yourusername/yourresearchtopic
```

Or ask Claude: "What's my current dialectical state?"

The status shows your positions as a state: `[N assertions : M rejections]`

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

Start a session with: "Let me lay out my current positions on X" and state your views. You can both commit to claims and deny others. Claude will create issues and immediately start probing.

Example:
> "I commit to meaning being constituted by inferential role. I deny that sensorimotor grounding is constitutively necessary for understanding."

### Review and refine

Periodically: "Let's review my positions on [topic]" — Claude will list commitments and denials, and look for tensions or gaps.

## The Issue Ontology

### Position Labels (Bilateral)

| Label | Color | Meaning |
|-------|-------|---------|
| `commitment` | Green | A proposition you assert (left side of state) |
| `denial` | Red | A proposition you reject (right side of state) |

### Dialectical Status Labels

| Label | Color | Meaning |
|-------|-------|---------|
| `question` | Blue | An open research question |
| `tension` | Red-orange | Detected incoherence in dialectical state |
| `challenge` | Yellow | Socratic question awaiting your response |
| `resolved` | Purple | Successfully addressed |
| `retracted` | Black | Withdrawn position |

### Position Type Labels

| Label | Color | Meaning |
|-------|-------|---------|
| `background` | Light blue | Methodological/framework position |
| `empirical` | Pale blue | Empirical claim |
| `normative` | Lavender | Values/normative claim |
| `literature-grounded` | Dark green | Position with literature engagement |

## Types of Incoherence

The bilateral structure allows detection of four types of incoherence. When incoherence is detected, it is expressed as a **sequent** `X ⊢ Y`, which asserts that the **state** `[X : Y]` is incoherent.

| Type | Sequent | Meaning |
|------|---------|---------|
| **Consistency violation** | `A ⊢ A` | You both assert and deny A |
| **Contrary commitments** | `A, B ⊢` | A and B cannot both be asserted |
| **Subcontrary denials** | `⊢ A, B` | A and B cannot both be denied |
| **Cross-side incoherence** | `X ⊢ Y` | Your commitments conflict with your denials |

Example tension:
```markdown
## Tension: Inferential role + LLM meaning denial

Incoherence claim (sequent): Meaning-is-inferential-role ⊢ LLMs-cannot-understand

This asserts that the state [Meaning-is-inferential-role : LLMs-cannot-understand] 
is incoherent.

Commitment #12: "+ Meaning is constituted by inferential role"
Denial #15: "− Language models can understand meaning"

If meaning is constituted by inferential role, and LLMs engage in 
inference-like operations, on what grounds do you deny they understand?
```

## Literature Integration

Elenchus can ground your positions in the scholarly literature:

- **When you make a commitment or denial**, Claude searches for supporting and challenging sources
- **Challenges cite known objections** from published work, not just conceptual probes
- **Position issues include** Supporting Literature, Challenging Literature, and your Engagement with challenges
- **Citations are validated** where possible; uncertainty is flagged

This means your dialectical trace becomes a literature review built through genuine engagement, not post-hoc citation gathering.

Example commitment structure:

```markdown
## Position
+ Grounding is constituted by linguistic competence, not sensorimotor connection

## Supporting Literature
- Brandom (1994): Making It Explicit — inferentialist semantics
- Sellars (1956): "Empiricism and the Philosophy of Mind" — space of reasons

## Challenging Literature  
- Harnad (1990): "The Symbol Grounding Problem" — sensorimotor requirement
- Barsalou (1999): "Perceptual symbol systems" — embodied cognition

## Engagement with Challenges
Harnad's requirement is addressed by distinguishing original from derivative grounding...
```

Example denial structure:

```markdown
## Position
− Sensorimotor experience is constitutively necessary for meaning

## Justification
The success of LLMs demonstrates that systems without sensorimotor 
experience can achieve pragmatically successful interpretability.

## Challenging Literature
- Harnad (1990): "The Symbol Grounding Problem" — argues for constitutive requirement

## Engagement with Challenges
Harnad's examples presuppose that grounding must be original rather than 
derivative. But derivative grounding through causal connection to grounded 
linguistic communities may suffice...
```

## Tips

- **Be explicit**: "I commit to X" or "I deny Y" is clearer than hedged statements
- **Distinguish commitment from denial**: Saying "I don't think X" could be denial of X or mere non-commitment—clarify which
- **Embrace tensions**: They're features, not bugs—they show where your thinking needs work
- **Close the loop**: When you resolve something, make sure Claude closes the issue with documentation
- **Use it for papers**: Before writing, dump your argument and let Claude find the holes
- **Revisit periodically**: Your open challenges and tensions are a todo list for your thinking
- **Use prefixes**: `+` for commitments, `−` for denials helps visual scanning

## Limitations

- Search depends on good keywords in issue titles/bodies
- Claude may miss subtle tensions that require deep domain knowledge
- You have to actually engage with the challenges for this to work
- Detection of cross-side incoherence (`X ⊢ Y`) requires Claude to recognize logical relationships

## Session Continuity

Claude Code recovers full dialectical state from GitHub at each session start. The issues *are* the memory—there's no separate state to lose. When you start a session, Claude will:

1. Load all open challenges and tensions
2. Load your current research questions (the QUD tree)
3. Load recent commitments and denials
4. Present your current state: `[Commitments : Denials]`
5. Brief you on what needs attention

This means you can close your laptop, come back a week later, and Claude will know exactly what positions you hold, what you reject, what questions are open, and what challenges are still waiting for your response.

## Philosophy

The system assumes:

1. Intellectual progress requires confronting discomfort
2. Coherence is a virtue (though not the only one)
3. Unstated assumptions are where errors hide
4. Questions are more powerful than assertions
5. Writing things down changes how you think about them
6. **Denial is primitive**: Rejection is a fundamental cognitive act, not reducible to asserting negation

## Bilateral Structure

Unlike systems that track only assertions, Elenchus implements a **bilateral** approach. Your dialectical **state** is a pair:

```
[Commitments : Denials]
```

This matters because **denial is not the same as asserting a negation**. Following Restall's arguments:

- You can deny A without committing to ¬A (e.g., agnosticism, truth-value gaps)
- You can commit to ¬A without denying A (e.g., paraconsistent reasoning)
- The ability to deny is conceptually prior to the ability to negate

### State vs. Sequent (Following Restall)

Elenchus uses two related but distinct notations from Restall's "Multiple Conclusions":

| Term | Notation | Meaning |
|------|----------|---------|
| **State** | `[X : Y]` | A description of what you assert (X) and deny (Y) |
| **Sequent** | `X ⊢ Y` | A *claim* that the state `[X : Y]` is incoherent |

Your **state** describes your current positions. A **sequent** asserts that a particular combination of assertions and denials is self-defeating.

When Elenchus displays your positions as `[5 assertions : 3 rejections]`, that's your **state**. When Elenchus creates a tension issue claiming `A, B ⊢ C`, that's a **sequent** asserting that the state `[A, B : C]` is incoherent.

## Claude as Derivability Oracle

In a formal sequent calculus, derivability is defined by explicit rules. In Elenchus, **Claude serves as the derivability oracle**—determining when a combination of commitments and denials is incoherent.

```
Γ ⊢ Δ  iff  Claude judges that asserting all of Γ 
            while denying all of Δ is incoherent
```

This means:

- **The logic is implicit**: Claude applies classical logic by default, but the respondent can reject specific inference patterns
- **Judgments are defeasible**: If Claude flags a tension, you can contest it by rejecting the rule Claude relied on
- **Rejected rules become commitments**: If you say "I don't accept modus ponens here," this becomes a methodological commitment that constrains future derivations

When Claude flags a tension, it should make the derivation explicit:

```markdown
## Tension: Conditional commitment conflicts with denial of consequent

Commitments: #12 (A → B), #15 (A)  
Denials: #18 (B)

Incoherence claim (sequent): (A → B), A ⊢ B

This asserts: the state [(A → B), A : B] is incoherent.

By modus ponens, committing to a conditional and its antecedent 
while denying the consequent is incoherent.
```

You can then accept this, or push back: "I reject that modus ponens applies here because..." This contestability is a feature, not a bug—it surfaces your methodological assumptions.

## Theoretical Background

Elenchus draws on three theoretical traditions:

### Obligationes as Logical Games

The medieval tradition of *obligationes* provides the opponent/respondent structure and the core mechanics of commitment tracking. Following Catarina Dutilh Novaes' formalization (2007), we treat obligationes as **logical games of consistency maintenance**. The respondent must use logical skills to keep their commitments coherent as the opponent probes with challenges.

Dutilh Novaes (2011) further analyzes obligationes as a theory of **discursive commitment management**—tracking what one is committed to asserting or denying given prior moves in the dialogue. This is precisely what Elenchus implements via GitHub issues.

### Bilateral Sequent Calculus

The bilateral approach follows Greg Restall's "Multiple Conclusions" (2005), which argues:

1. **Denial is not assertion of negation**: The ability to deny can precede the ability to negate; supervaluationists and dialetheists show the concepts come apart
2. **Consequence constrains states**: Valid inference rules out combinations of assertion and denial, not just non-preservation of truth
3. **Multiple conclusions are meaningful**: The sequent `X ⊢ Y` has a clear reading: it asserts that the state `[X : Y]` is incoherent

This framework is neutral between realist and anti-realist semantics, and can accommodate non-classical logicians (intuitionists, dialetheists, supervaluationists) without begging questions about the logic of negation.

### Questions Under Discussion

The QUD framework from Roberts (2012) provides the structure for tracking open research questions as a hierarchy. Questions organize inquiry; sub-questions must be resolved before parent questions can be addressed.

## Example Dialectics

To provide concrete examples of the use of Elenchus, here are three dialectics generated in dialogue with the system:

- **An argument that the Beatles are overrated**: [bradleypallen/the-beatles-are-overrated](https://github.com/bradleypallen/the-beatles-are-overrated)
- **An argument for a reconceptualization of knowledge engineering**, "produced using exactly the methodology it advocates for knowledge engineering": [bradleypallen/social-externalism-and-knowledge-engineering](https://github.com/bradleypallen/social-externalism-and-knowledge-engineering)
- **A dialectic-in-progress around the design assumptions of the PROV-O ontology**: [bradleypallen/prov-o](https://github.com/bradleypallen/prov-o)

## References

- Dutilh Novaes, C. (2005). "Medieval Obligationes as Logical Games of Consistency Maintenance." *Synthese*, 145(3), 371–395.
- Dutilh Novaes, C. (2007). *Formalizing Medieval Logical Theories: Suppositio, Consequentiae and Obligationes*. Springer.
- Dutilh Novaes, C. (2011). "Medieval Obligationes as a Theory of Discursive Commitment Management." *Vivarium*, 49, 240–257.
- Restall, G. (2005). "Multiple Conclusions." In *Logic, Methodology and Philosophy of Science: Proceedings of the Twelfth International Congress*. Kings' College Publications.
- Brandom, R. (1994). *Making It Explicit*. Harvard University Press.
- Roberts, C. (2012). "Information structure in discourse: Towards a unified theory of formal pragmatics." *Semantics and Pragmatics*, 5(6), 1-69.
