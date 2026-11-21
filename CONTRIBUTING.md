# Contributing to OpenXSys

[简体中文](CONTRIBUTING.zh-CN.md)

Thank you for building OpenXSys with us. An excellent question, a real work, a failure, a translation improvement, a new method, or a complete capability can take the system somewhere it could not reach before.

## Choose the right entry

| What you are bringing | Begin here |
| --- | --- |
| A question, idea, architecture discussion, or roadmap proposal | [GitHub Discussions](https://github.com/gengshupeng/open-x-sys/discussions) |
| A work or the story of a real run | [Discussions](https://github.com/gengshupeng/open-x-sys/discussions), using the work guide below |
| A reproducible bug or compatibility problem | [Issue forms](https://github.com/gengshupeng/open-x-sys/issues/new/choose) |
| A concrete improvement to public guidance, runtime, methods, adapters, or works | Fork the repository and open a pull request |
| An unpatched security problem | Report it privately through [Security](SECURITY.md) |

A first contribution may begin in English or Chinese. Changes to formal Skill semantics or topology become one complete architecture in both editions before merge; maintainers and the community can help complete the other language.

## Principles

- **Begin from a real failure.** State which request, subject, host, or condition exposed it.
- **Change the right level.** Repeated lower-level problems point toward higher-level structure.
- **Protect freedom.** Methods and cases strengthen judgment while open work remains free to compose its own path.
- **Protect the experience.** The interior can grow more exact while what the user meets becomes simpler, more natural, and more powerful.
- **Accept through evidence.** A capability arrives with a real sample, counterexample, or reproducible test; behavior matters.
- **Maintain one product in two complete editions.** The public name is `open-x-sys`. English lives in `skills/open-x-sys/` and Chinese in `skills/open-x-sys.zh-CN/`, with the same architecture and capability.

## Before you begin

1. Read [`SKILL.md`](skills/open-x-sys/SKILL.md), the [Skill README](skills/open-x-sys/README.md), and the [architecture](docs/ARCHITECTURE.md).
2. Reproduce the issue with a real request. Record the input, environment, actual result, and expected difference.
3. Locate the change in `core/`, `runtime/`, `system/`, `engines/`, `capabilities/`, `adapters/`, or `experience/`. Keep the main entry both complete and readable.

## Share an OpenXSys work

The next work that makes someone stop and look can come from you. It may be a discovery card, document, video, explorable page, tool, plan, or a new capability that already works in real life.

Begin in [Discussions](https://github.com/gengshupeng/open-x-sys/discussions), where the work is easiest to see, discuss, and continue. Bring these together:

- **Your original words:** how you began in ordinary language;
- **The work itself:** something people can open, watch, or use;
- **The environment:** AI tool, model, OpenXSys version, and run date;
- **The central discovery:** what changed your understanding of the subject;
- **Real feedback:** what proved useful and what still failed to reach reality;
- **The public boundary:** confirm that the work, material, and sources can be shared and contain no credentials or private information.

When a work belongs in the formal playground, open a pull request and place it under `experience/playground/replays/<work-name>/` in the corresponding language Skill, with at least a short account and a directly usable result. The project can help an exceptional work open an entry in the other language.

## After the change

When behavior changes, run at least one forward test on a real request that was not designed for the change. Inspect the final work and user experience, not only the runtime text. Describe the environment, input, result, and remaining problem in the pull request.

## Content requirements

- English and Chinese should each read as original product language and carry the same system semantics.
- Distinguish facts, inferences, simulations, and examples; date and source time-sensitive material.
- Every new runtime resource is reachable from `SKILL.md` through semantic indexes that name its entry signal, next resource, and return to the active system.
- Runtime pages describe composable responsibilities and keep sequencing in the hands of the live system.
- Directory changes preserve working content and update semantic indexes and every local link.
- Credentials, private systems, real user data, generated caches, and test-output directories stay out of commits.
- Third-party dependencies enter only with an inspectable source, license, version, purpose, and actual host availability.

Before committing, confirm that `git diff` contains only the contribution and report the commands and results used to validate it.

If you do not yet know which file should change, bring the real situation to Discussions first. OpenXSys contributions begin by seeing the real problem; the community can help find the level that should change.
