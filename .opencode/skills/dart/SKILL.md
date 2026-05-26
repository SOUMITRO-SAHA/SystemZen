---
name: dart
description: Write ultra-fast, memory-efficient, and production-grade Dart code with strict focus on performance, scalability, and code quality.
---

## Core Principles

- **Performance is non-negotiable** — every line must justify its cost.
- Prefer **predictable, simple, and fast code** over clever abstractions.
- Minimise allocations, copies, and unnecessary work.
- Keep code **readable but efficient**.

## Data Structures

- Choose the right structure:
  - `List` → ordered, fast iteration
  - `Set` → O(1) lookup
  - `Map` → key-value access
- Avoid repeated transformations (`map → toList → map` chains).
- Prefer **in-place operations** when safe.

## Memory Optimisation

- Avoid excessive object creation inside loops.
- Reuse objects where possible.
- Prefer `const` constructors (compile-time optimisation).
- Use `final` instead of `var` whenever possible.
- Avoid large temporary objects.

## Functions

- Keep functions:
  - small
  - single responsibility
- Avoid deep call stacks.
- Inline trivial functions when performance-critical.

## Async & Concurrency

- Use `async/await` carefully — avoid unnecessary awaits.
- Prefer **parallel execution**:

  ```dart
  final results = await Future.wait([task1(), task2()]);
  ```

- Offload heavy work using:
  - `Isolate` for CPU-intensive tasks

- Avoid blocking the main isolate.

## Collections & Iteration

- Prefer `for` loops in hot paths (faster than chained methods).
- Avoid nested loops (reduce time complexity).
- Cache computed values instead of recalculating.

## String & JSON Handling

- Use `StringBuffer` for heavy concatenation.
- Avoid repeated JSON encode/decode.
- Parse once, reuse structured data.

## Null Safety

- Fully leverage null safety:
  - avoid nullable types unless required

- Remove unnecessary null checks.

## Error Handling

- Avoid exceptions in hot paths (expensive).
- Use:
  - guards
  - validation checks

- Throw only for truly exceptional cases.

## Code Quality

- Follow Dart style guide.
- Naming:
  - clear, intention-revealing

- Avoid large files and classes.
- Keep logic testable and modular.

## Performance Patterns

- Cache results (memoisation) when applicable.
- Avoid redundant computations.
- Use lazy evaluation where beneficial.

## Profiling & Benchmarking

- Always measure:
  - use Dart DevTools

- Identify:
  - CPU bottlenecks
  - memory leaks

- Optimise based on data, not assumptions.

## I/O & Networking

- Batch operations where possible.
- Avoid frequent small I/O calls.
- Use streaming for large data.

## Interop & Native Calls

- Minimise platform channel calls (expensive).
- Batch data when communicating with native layers.

## Scalability

- Design for:
  - large datasets
  - high concurrency

- Avoid global mutable state.

## Testing

- Benchmark critical paths.
- Test edge cases and large inputs.

## Anti-Patterns (Avoid)

- Excessive object allocation
- Deeply nested loops
- Unnecessary async/await usage
- Recomputing same values
- Large monolithic classes

## Golden Rule

- Every millisecond matters.
- Write code that is **fast by design, not optimised later**.
