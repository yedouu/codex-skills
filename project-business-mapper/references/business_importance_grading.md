# Business Importance Grading

## A: Core Business Mainline

Analyze deeply and include in the lead summary.

Examples:
- Core business closed loop.
- Most important domain objects.
- Main flows.
- State machines.
- Key rules.
- Constraints that affect correctness.

## B: Important Supporting Business

Explain clearly, but with less depth than A.

Examples:
- Auxiliary flows.
- Exception handling.
- Config that changes business behavior.
- Permission, validation, fallback, and persistence behavior.

## C: Technical Implementation Details

Map but do not deep dive unless they contain business rules.

Examples:
- Utility functions.
- Framework glue.
- Build config.
- General wrappers.
- UI style details.

## D: Engineering Enhancements

Mention briefly or defer.

Examples:
- Performance optimization.
- Cache.
- Deployment automation.
- Multi-platform compatibility.
- Logging and monitoring.

## E: Skip for Business Understanding

Skip unless explicitly requested.

Examples:
- Generated code.
- Build artifacts.
- Third-party library internals.
- Irrelevant test snapshots.
- Large style files.
- Historical code unrelated to the current business goal.

## Output Rule

Every report should say:

- Which parts are business core.
- Which parts are technical implementation.
- Which parts can be skipped at first.
