# Importance Grading

Use A/B/C/D/E to decide teaching depth and chapter placement.

## A: Core Learning Content

Must be deeply understood and implemented by hand.

Includes:
- core business logic;
- main data flow;
- core state model;
- key call chain;
- core algorithms;
- main UI/API/service loop;
- module boundary design.

Teaching depth:
- explain why it exists;
- rebuild a minimal version;
- compare with original implementation;
- add verification and self-test questions.

## B: Important Supporting Content

Needs principle-level understanding.

Includes:
- utility functions;
- middleware or wrappers;
- error handling;
- local storage;
- permission handling;
- network request wrappers;
- data model transforms.

Teaching depth:
- explain role and common failure points;
- rebuild only representative slices;
- connect it to A-level flow.

## C: Configuration and Engineering Basics

Know how to configure; do not deep dive first.

Includes:
- `package.json`;
- `tsconfig.json`;
- `vite.config.*`;
- `tauri.conf.json`;
- `Dockerfile`;
- CI config;
- lint and formatter config;
- build scripts.

Teaching depth:
- explain purpose and common fields;
- show when to change them;
- return later when engineering chapter begins.

## D: Advanced Enhancements

Learn later.

Includes:
- performance optimization;
- auto update;
- multi-platform compatibility;
- plugin systems;
- advanced caching;
- internationalization;
- complex deployment.

Teaching depth:
- mention in the map;
- defer until original comparison or expert route.

## E: Skip for Now

Temporarily skip.

Includes:
- unrelated modules;
- legacy code;
- excessive style details;
- generated files;
- third-party internals;
- test snapshots;
- build artifacts.

Teaching depth:
- list as skipped with reason;
- revisit only if the user changes goals.
