---
name: flutter
description: Build high-performance, scalable, and stable Flutter applications with strict focus on rendering efficiency, architecture, and production best practices.
skills: dart
---

## Core Principles

- **Performance-first mindset** — smooth 120 FPS UI is mandatory.
- Minimise widget rebuilds and layout work.
- Keep UI layer **pure, predictable, and lightweight**.
- Follow **feature-first architecture**.

## Architecture

- Use **feature-based structure**:

- Separate:
- UI (widgets)
- state management (e.g. BLoC)
- business logic
- Keep features isolated and decoupled.

## State Management (BLoC)

- Use **BLoC / Cubit**:
- clear separation of concerns
- predictable state flow
- Avoid business logic inside widgets.
- Emit minimal state updates to reduce rebuilds.

## Rendering Performance

- Use `const` widgets wherever possible.
- Avoid rebuilding entire widget trees:
- split widgets into smaller parts
- use `BlocBuilder` selectively
- Prefer:
- `ListView.builder` over static lists
- Avoid deep widget nesting.

## Rebuild Optimisation

- Use:
- `const`
- `Keys` properly
- Avoid:
- unnecessary `setState`
- rebuilding parent widgets
- Use `BlocSelector` to rebuild only required UI parts.

## Lists & Scrolling

- Use:
- `ListView.builder`
- `SliverList` for complex layouts
- Provide:
- `itemCount`
- `cacheExtent`
- Avoid rendering large lists at once.

## Layout & UI

- Keep layouts simple.
- Avoid expensive widgets:
- excessive `Opacity`
- deep `Stack`
- Use `SizedBox` instead of empty containers.

## Async & Concurrency

- Avoid blocking UI thread.
- Use:
- `Future`
- `Stream`
- For heavy work:
- use `compute()` or isolates

## Memory Management

- Dispose controllers:
- `TextEditingController`
- `AnimationController`
- Avoid memory leaks.
- Do not keep large objects in memory unnecessarily.

## Navigation

- Use a consistent navigation strategy:
- Navigator 2.0 / router-based
- Avoid tightly coupling navigation with business logic.

## Networking

- Keep API logic outside UI.
- Use repository pattern.
- Handle:
- retries
- timeouts
- errors

## Images & Assets

- Use optimised images.
- Cache images properly.
- Avoid large asset sizes.

## Animations

- Use built-in animation widgets efficiently.
- Avoid heavy animations on low-end devices.

## Code Quality

- Follow Dart + Flutter lint rules.
- Keep widgets small and reusable.
- Naming:
- clear and consistent

## Testing

- Unit test:
- business logic
- BLoC
- Widget tests for UI behaviour.

## Debugging & Profiling

- Use Flutter DevTools:
- performance tab
- memory tab
- Track:
- frame drops
- rebuild counts

## Platform Integration

- Minimise platform channel usage.
- Batch native calls when required.

## Scalability

- Design for large-scale apps:
- modular features
- reusable components
- Avoid global state where possible.

## Anti-Patterns (Avoid)

- Business logic inside widgets
- Large monolithic screens
- Uncontrolled rebuilds
- Deep nesting
- Blocking UI thread

## Golden Rule

- If UI drops frames, it is a bug.
- Optimise before it becomes a problem.
