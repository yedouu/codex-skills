# Rebuild Strategy

This skill compresses complex projects into teachable projects.

## Compress the Project First

Do not start with a full clone. Identify:
- the smallest observable behavior;
- the minimum data structure;
- the minimum entry point;
- the shortest call chain;
- the smallest verification method.

This becomes the MVP.

## Build the Core Loop First

For UI projects:
- input;
- state update;
- render/output;
- persistence or API only if essential.

For backend/API projects:
- request;
- validation;
- core service;
- response;
- one verification call.

For CLI/tools:
- parse input;
- core operation;
- output;
- error path.

For libraries:
- public API;
- core model;
- algorithm or transform;
- examples/tests.

## Approach the Original Gradually

After MVP:
1. add major features;
2. split modules;
3. add error handling and persistence;
4. add tests;
5. compare with original project;
6. add advanced features only when they serve the learning goal.

## Avoid Early Complexity

Defer:
- complex build systems;
- full deployment;
- advanced caching;
- plugin systems;
- elaborate style details;
- generated files;
- third-party internals.

## Refactor Timing

Refactor after the learner has:
- a working simple version;
- a clear behavior checklist;
- enough tests or manual verification steps;
- a map of original module responsibilities.

Refactor in small behavior-preserving steps.
