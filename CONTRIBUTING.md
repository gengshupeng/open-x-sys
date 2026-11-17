# Contributing to OpenXSys

[Chinese](CONTRIBUTING.zh-CN.md)

The most valuable contribution is **a real result**: something you made with OpenXSys that surprised you, shared with the sentence that produced it, and an honest note on where it fell short.

## The contribution ladder

Start anywhere. Each rung is a complete contribution.

| Rung | What you add | Where it goes |
|---|---|---|
| **Share a deliverable** | A real deliverable, its share pack, the sentence that produced it, the model and host, the date | `gallery/` |
| **Report a miss** | A run that went wrong: what you asked, what you got, what you expected | `evals/misses/` or an issue |
| **Translate** | A page of the runtime or the docs, with identical structure and function IDs | `skills/open-x-sys.<lang>/` |
| **Write a lesson or a profile** | One method explained in plain words, with a famous real case, the person behind it, the primary source and an exercise | `academy/` |
| **Share a practice with its evidence** | A practice that worked for you, with its conditions, cost, results and switching conditions | `practices/` |
| **Review a dependency or a Kit provider** | A dated review record following `skills/open-x-sys/kit/KIT.md` | `evals/reviews/` |
| **Publish an ability or a personal route** | A capability or a route you built, with everything personal removed | `practices/` |
| **Add a pattern** | A pattern with its source, how to recognize it, where it breaks, and real cases | `skills/open-x-sys/patterns/` |
| **Make a style** | A style page that changes names, wording and sound only | `skills/open-x-sys/styles/` |
| **Propose a method or a master route** | A Method Proposal (below) | an issue, then `skills/open-x-sys/methods/` or `routes/masters/` |
| **Build an Open-X-Sys** | A domain system on the kernel | `x-sys/` |
| **Improve the kernel** | A change to the runtime, with before-and-after runs | `skills/open-x-sys/` |

## Method Proposals

The library is deliberately small. A new method or master route joins when it earns its place.

A proposal contains:

1. **Name**, in plain words a newcomer understands at first sight, and a function ID.
2. **Prompts**: the natural sentences people would say.
3. **What it reveals or produces**, and which stage of the journey it belongs to.
4. **Its source**: the person and the work, checked against a primary source. Say where the proposal simplifies it.
5. **Why the existing methods do not already cover it.**
6. **Three real runs** on different subjects, with their deliverables.

For a master route, also: the steps in the practitioner's own order, and how each maps to OpenXSys methods.

## Rules for every contribution

- **Real outputs only.** No mock-ups, no reconstructed runs, no invented examples presented as real.
- **Sources and dates.** Every factual claim has them. Uncertain attributions are marked until verified. No invented quotations.
- **Natural language, purpose and quality bars.** Runtime pages state what and why. They never list steps to execute, and they contain no template to fill in.
- **Plain, scientific wording.** No metaphors in the runtime. "[OpenXSys] Ding. System activated." is the only flourish.
- **Every important document has a Chinese version.** The runtime is written in English first, then in a complete Chinese edition with identical structure and function IDs; a change to one edition comes with the same change to the other. Other important documents (README, this guide, the Playground, each folder's README) exist as `X.md` and `X.zh-CN.md`, linked to each other at the top.
- **Each edition reads naturally on its own.** English documents use English throughout, including prompts, examples, navigation and labels. Translate Chinese-language source material into English for the English edition. Chinese documents use Chinese prose, with English terms or annotations where they help. Label links to records in another language clearly.
- **Nothing personal.** Remove anything about a person before sharing. A personal root system is never shared.
- **Neutral wording for people**: "the person", "they".
- **Before changing the runtime**, read the project overview: `docs/OVERVIEW.md`. Run the release checks in docs/VALIDATION.md and include before-and-after examples for behavioral changes.

## Reporting a problem with a dependency

Open an issue naming the dependency and what you saw. A reported item is pulled from the bundled set or the Kit pending review.

## License

By contributing you agree that your contribution is licensed under the MIT License of this repository.
