# The Playground

[Chinese](README.zh-CN.md)

> **For the agent.** Read this when the person says "open the playground", "show me what this can do", or has never opened a system and does not know what to ask. This folder ships with OpenXSys: the installer copies it into the skill folder, and in a source checkout it is at the repository root.
> **For people.** This is where you try, combine and learn at no risk before using OpenXSys on your own work. Say **"Open the playground."**

People who have never opened a system do not know what to ask, what it can do, which methods exist or how they combine. The Playground answers those four questions by letting them do it.

Everything in `SKILL.md` applies here unchanged: full power, the signature, honest sources, the guardrails. The Playground changes only two things: the subjects come with their materials, and the system offers more guidance about what can be tried next.

## Opening it

Say the Ding line, then offer the six parts as choices, with one recommendation. For a newcomer the recommendation is the guided tour.

> Ding. System online. This is the Playground. You can:
> ① **Take the ten-minute tour** on a ready subject (recommended if this is your first time)
> ② **Try** a ready subject
> ③ **Combine** methods on a subject and see what each one changes
> ④ Run a **master route**: Musk's algorithm, the Toyota way, Munger's checklist and others
> ⑤ **Compare** two ways of thinking on the same subject
> ⑥ **Watch** a replay of a real run, or **explore** a complete example system

Use the host's selection interface if it has one. Proceed on the recommendation if the person says "go" or says nothing specific.

## The six parts

| Part | What the person does | What you do | Materials |
|---|---|---|---|
| **Try** | Picks a ready subject | Open a system for it with the route *Understand it*, from the materials | `subjects/` |
| **Combine** | Picks a subject and stacks two to five method cards | Run exactly that stack in order, carry findings forward, and show what each card added. Offer to save the stack as a personal route | `cards/methods.md` |
| **Master routes** | Names a master route and a subject, ready or their own | Run its steps in its own order, with its source and where OpenXSys simplifies it | `skills/open-x-sys/routes/masters/` |
| **Compare** | Picks one subject and two routes or methods | Run both on the same evidence and put them side by side: what each reveals that the other does not | `compare/README.md` |
| **Watch** | Picks a replay | Walk through a real run: the sentence typed, findings as they arrived, the route chosen, the deliverable, the system left behind | `replays/` |
| **Explore** | Picks an example system | Open it and show how it is built: its core, code, data, practices and deliverables, and why it has that shape | `examples/` |

## Ready subjects

Each ready subject is a folder or a file of **materials**: sourced facts, numbers with dates, and pointers to primary sources. Materials let a run work offline and give consistent quality. They are raw material and deliberately contain **no conclusions**: the reveal is found by the run, never read out of the pack.

| Subject | Kind | Materials | Good first methods |
|---|---|---|---|
| **The shipping container** | A technology shift | `subjects/shipping-container.md` | Trace, Flow, Connect |
| **Southwest Airlines' early model** | A famous company | `subjects/southwest-airlines.md` | Open, Loops, First Principles |
| **Why wider roads fill up** | A city's traffic | `subjects/road-congestion.md` | X-ray, Loops, What-if |
| **The beer game** | A classic problem | `subjects/beer-game.md` | Loops, Incentives, Leverage |
| **A small order service** | A sample codebase | `subjects/sample-codebase/` | Open, Flow, Bottleneck |
| **A weekly newsletter** | A sample creative project | `subjects/sample-creative/` | Open(me)-style reading, Best Practice, Review |

Rules for using materials:

- **Use them as evidence, with their stated confidence.** Each pack marks what is well established and what needs checking. Carry those marks into the deliverable's provenance strip.
- **Materials were written from published sources and are awaiting verification against the primary sources** (see the note at the top of each pack). Say so once when delivering. If the host can search, check the key figures and update the dates.
- **Do not pad a pack with invented detail.** If a run needs something the pack lacks, look it up if possible, or say it is not in the materials.
- **The person's own subject is always welcome.** Every part works on something of theirs; then there are no materials and the run researches as usual.

If the materials are missing (the Playground was not installed), run the same parts with live research and say so once.

## Combine

Show the method cards (`cards/methods.md`): all 23 methods and 7 lenses, each with its one-line prompt. The person picks a subject and stacks two to five.

- Run the stack **in the order given**. It is the person's route.
- After each card, say in one or two lines **what this card added** that the previous ones did not show. This is the point of Combine.
- If the stack skips something its result depends on, say so in one line and supply the minimum (see `use.md`).
- At the end, show the route strip, deliver the result with the signature, and offer once to **save the stack as a personal route**.
- Invite a swap: "replace one card and see what changes".

## Compare

Same subject, same evidence, two routes side by side. Good first pairs are in `compare/README.md`, for example First Principles against Incentives on the cost of something, or Trace against Loops on why something persists.

A good comparison shows **what each way of thinking reveals that the other cannot**, and where they agree. It does not declare a winner. Lay it out in two columns on the dimensions that differ, then one short paragraph on when to reach for which.

## Watch

Replays are records of **real runs**. Each has the sentence typed, the findings in the order they arrived, the route chosen and why, the deliverable, and the system entry that was left behind.

`replays/` holds them. **In this Alpha Preview there are none yet**: replays are added only from real runs, never written to look like one. When the folder is empty, say so plainly and offer the tour or Try instead.

## Explore

`examples/` holds complete example systems to open and read. They are **constructed examples**, labelled as such, built to show what a well-kept system looks like after a few weeks. They are not records of real people.

When showing one: read its `SYSTEM.md` first, then show how the understanding, the practice record, the data and the code relate, and point out what makes its shape fit its purpose (see `skills/open-x-sys/system/shapes.md`). The lesson is the shape and the habits, never the specific contents.

## The guided tour

Ten minutes along the journey on one ready subject. The full description is in `tour.md`. In short: see how it works, ask why, ask what if, find where to push, get a fitting practice, make a deliverable, see how review works, then swap one method and see what changes. It ends with:

> Now open a system for something of your own.

## Leaving the Playground

The Playground is a way in, not a place to stay. Whenever the person brings something of their own, switch to it. The first time they do, the usual location choice applies (`skills/open-x-sys/system/location.md`).

Playground runs on ready subjects are not saved into the person's system unless they ask. What is worth keeping from a Playground session is what the person learned: note in the root, once it exists, which methods they used and which they predicted correctly in learn mode.

## Adding to the Playground

New ready subjects, comparisons and example systems join through the contribution ladder (`CONTRIBUTING.md`). A ready subject needs sourced materials with dates and stated confidence, and no conclusions. A replay needs a real run and the person's consent to publish it.
