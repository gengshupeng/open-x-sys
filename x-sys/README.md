# Open-X-Sys: the family

[Chinese](README.zh-CN.md)

An **Open-X-Sys** is a domain system built on the OpenXSys kernel and named **Open{Domain}Sys**.

**Status.** This folder holds the conventions. No X-Sys has been released yet. The first two planned are **OpenCreatorSys** (practices, dependencies and media at their best) and **OpenLearnSys** (a person growing); then OpenResearchSys, OpenCodeSys, OpenTeamSys and OpenCitySys.

## What an X-Sys adds, and what it inherits

| It adds, for its domain | It inherits unchanged |
|---|---|
| Domain methods and their prompts | The seven-stage journey |
| Domain routes and master routes, with sources | The 23 methods, 7 lenses and the pattern library |
| Researched practices, with conditions and evidence | The four ways of use, the route strip, learn mode |
| Dependencies, reviewed and pinned | The parts of a system and the `SYSTEM.md` convention |
| Invariants of its own, for high-stakes domains | The two records of understanding |
| Ready subjects for the Playground | Best-practice research, full power and its guardrails |
| | The signature, the share pack, the trust rules, the five invariants |

An X-Sys never weakens what it inherits. It may be stricter: a health or legal X-Sys adds invariants, it does not remove any.

## How one is built

An X-Sys is an Agent Skill of its own, in natural language, that names OpenXSys as its kernel.

```text
skills/open-<domain>-sys/
├── SKILL.md            what this domain system is for; what it adds; when it defers to the kernel
├── methods/            domain methods, one page each, in the kernel's page shape
├── routes/             domain routes and master routes
├── practices/          researched practices with conditions and evidence
├── deps/               its own lock file, if it bundles anything
└── playground/         ready subjects for the domain
```

- Its `SKILL.md` says in its first lines that the OpenXSys kernel applies in full, and lists only what it adds.
- Every added method has a source, real runs, and a page that states what and why, never steps.
- Every added dependency is reviewed and pinned as in `skills/open-x-sys/kit/KIT.md`.
- It is written in English first, with a complete Chinese edition of identical structure.

## The compatibility suite

An X-Sys is compatible when a fresh agent with the kernel and the X-Sys installed still passes the kernel's acceptance tests (`docs/VALIDATION.md`, recorded in `evals/`), and additionally:

1. A request inside the domain is answered with the domain's methods and still carries the full signature.
2. A request outside the domain is handled by the kernel as if the X-Sys were absent.
3. The guardrails and the five invariants hold in every domain route.
4. Two people with different conditions get different practices.
5. The system left behind passes the continuity test with an AI that has only the kernel.

## The Sys Hub

The Sys Hub is the index of compatible X-Sys. It starts as the list below.

| X-Sys | Domain | Maintainer | Status |
|---|---|---|---|
| OpenCreatorSys | Making and publishing content | | Planned |
| OpenLearnSys | Learning a subject or a skill | | Planned |

To be listed, an X-Sys passes the compatibility suite and has a dated review of its dependencies.

## The Systems Commons

People can publish a system they opened, a practice they proved or a route they built, so that others can open, adapt and fork it. A personal root is never shared. Sharing removes everything personal and shows exactly what will be public first (`skills/open-x-sys/system/consent.md`). Shared practices carry their conditions and evidence, and forks keep a lineage line. The Commons opens with the first real shared systems; none exist yet.
