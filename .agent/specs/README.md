# Scolair Specs

Use this folder to track meaningful features, refactors, and setup tasks.

Specs help future agents understand:

- what was planned
- what was completed
- what is blocked
- what validation was done
- why important decisions were made

## When To Create A Spec

Create one spec for:

- a new feature
- a major screen or flow
- a cross-cutting refactor
- a new architecture or tooling setup
- any task that will take multiple steps or affect multiple files

Do not create a spec for very small edits unless the change needs handoff context.

## Status Values

Use only these status values:

- `planned`: the work is defined but not started
- `in_progress`: the work has started and is not complete
- `blocked`: the work cannot continue without a decision or external change
- `done`: the work and required validation are complete

## Required Agent Behavior

- Read `.agent/project-rules.md` before working.
- Read `.agent/project-memory.md` before working.
- Read the related spec before changing files.
- Update task status as work progresses.
- Record skipped validation with a clear reason.
- Do not mark a task `done` unless it is actually complete.
- Add completion notes when finishing a spec.

## Naming

Use lowercase `kebab-case` names:

```text
.agent/specs/login-flow.md
.agent/specs/home-dashboard.md
.agent/specs/network-layer-setup.md
```

Start new specs from `spec-template.md`.
