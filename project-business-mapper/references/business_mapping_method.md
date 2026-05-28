# Business Mapping Method

## Extract Business Goals

Start with README, docs, examples, UI entry points, API routes, CLI commands, and tests. Look for:

- Who uses the system.
- What problem the system solves.
- What would fail or become manual without it.
- The main business closed loop from trigger to outcome.

Prefer direct evidence from docs and source. If the goal is inferred from structure, label it `根据目录结构推断`.

## Identify Business Objects

Good business-object sources:

- `models`, `entities`, `schemas`, `domain`, `dto`, `messages`, `events`.
- Database models and API payloads.
- State enums and lifecycle fields.
- Tests and example data.

Classify objects:

- Core business object: central to the project outcome.
- Supporting business object: helps the core process work.
- Technical helper object: exists mainly for implementation, transport, framework, or persistence convenience.

Do not treat every class or file as a domain object.

## Separate Business Logic from Technical Details

Business logic answers:

- Can this action happen?
- Who can do it?
- When can it happen?
- What state must exist before and after?
- What happens on failure?
- What user/system value is protected?

Technical details answer:

- How data is transported.
- Which framework hook is used.
- How files are built, cached, logged, formatted, retried, or deployed.

Technical implementation can still matter if it changes business behavior, such as timeouts, quotas, permissions, feature flags, routing, callback ordering, or persistence guarantees.

## Extract Rules from Code

From controllers/routes:

- Identify operations exposed to users or systems.
- Extract preconditions, validation, permissions, and error responses.

From services/use cases/workflows:

- Identify steps, branching, transaction boundaries, retries, state transitions, side effects, and external calls.

From models/entities/schemas:

- Identify required fields, uniqueness, ownership, lifecycle fields, and constraints.

From enums/states/constants:

- Identify allowed values, transition rules, terminal states, and dangerous defaults.

From tests/examples:

- Identify expected behavior, edge cases, and business-invariant assertions.

## Handle Uncertainty

Use explicit certainty labels:

- `已由源码确认`: supported by concrete source lines or tests.
- `根据目录结构推断`: inferred from names and layout.
- `需要进一步阅读源码确认`: likely but insufficiently verified.
- `需要运行项目确认`: behavior depends on runtime, environment, or integration.
- `需要业务方确认`: product intent or policy is not knowable from code.

Never invent missing business context. Put unresolved questions in `open_questions.md`.
