---
name: refactoring
description: Comprehensive refactoring skill for Flutter/Dart applications with focus on performance optimization, memory safety, security hardening, and production-grade code quality. Provides systematic workflows for iterative improvements with test-driven verification.
skills: ralph-loop, caveman
---

# Refactoring Skill - Flutter/Dart

## Overview

This skill provides a systematic approach to refactoring Flutter/Dart code with a primary focus on:

- **Performance optimization**
- **User experience excellence**
- **Memory safety and leak prevention**
- **Security hardening**
- **Code maintainability**

## Core Principles

### 1. One Task at a Time

- **NEVER** batch multiple refactoring tasks
- Take one specific refactoring objective
- Complete it fully
- Review thoroughly
- Commit only when verified

### 2. Test-First Refactoring

- Ensure existing tests pass before starting
- Write tests for refactored code
- Run full test suite after each change
- Never commit if tests fail

### 3. Progressive Enhancement

- Small, incremental changes
- Each change must be independently verifiable
- Build on stable foundations
- No experimental commits to main

## Pre-Refactoring Checklist

Before starting any refactoring task, verify:

```
□ All current tests passing (flutter test)
□ Code analyzed without issues (flutter analyze)
□ Coverage baseline established
□ Performance benchmarks documented
□ Memory usage profiled (if applicable)
□ Security implications assessed
```

## Refactoring Criteria

Trigger refactoring when ANY of these conditions exist:

### Architecture & Modularity

- **Component has > 3 responsibilities** → Split into focused modules
- **File exceeds 500 lines** → Extract to smaller, cohesive units
- **Import depth > 5 levels** → Flatten dependency tree
- **Circular dependencies detected** → Introduce abstraction layer

### Performance Issues

- **Hot path has > O(log n)** → Optimize algorithms
- **Widget rebuilds on every change** → Implement `select()`, `shouldRebuild`
- **Frame drops detected** → Profile and optimize render cycles
- **Memory grows unbounded** → Implement caching with eviction strategy
- **Janky animations** → Use `PerformanceOverlay` to identify bottlenecks

### Code Quality

- **Test requires mocking > 5 dependencies** → Simplify design
- **Function complexity > 10** → Extract smaller functions
- **Nested conditionals > 3 levels** → Use early returns, strategy pattern
- **Duplicate code > 3 occurrences** → Extract to shared utility

### Security & Safety

- **Hardcoded secrets/keys** → Move to secure configuration
- **Unsafe type casts** → Implement null-safe patterns
- **Direct file I/O in widgets** → Move to services layer
- **Unvalidated user input** → Add sanitization layers

## Refactoring Workflow

### Phase 1: Analysis & Planning

```
1. Identify specific refactoring target
2. Analyze current implementation
3. Document performance/security issues
4. Plan minimal viable refactoring
5. Identify test coverage gaps
```

### Phase 2: Implementation

```
1. Create/verify test coverage for target code
2. Make minimal, focused changes
3. Apply Flutter/Dart best practices
4. Add performance optimizations
5. Implement security hardening
6. Document changes inline
```

### Phase 3: Verification

```
1. Run flutter test (all tests must pass)
2. Run flutter analyze (zero issues)
3. Profile performance (DevTools)
4. Check memory leaks ( Observatory/DevTools)
5. Verify security checklist
6. Manual testing of affected features
```

### Phase 4: Review & Commit

```
1. Self-review against refactoring goals
2. Verify performance improvements
3. Confirm memory safety
4. Validate security measures
5. Commit with detailed message
6. Only then proceed to next task
```

## Performance Optimization Strategies

### Widget-Level Optimizations

#### 1. Const Constructors

```dart
// BEFORE
class MyWidget extends StatelessWidget {
  final String title;
  MyWidget({required this.title});
}

// AFTER
class MyWidget extends StatelessWidget {
  final String title;
  const MyWidget({super.key, required this.title});
}
```

#### 2. Repaint Boundary

```dart
// Isolate expensive repaints
RepaintBoundary(
  child: ExpensiveWidget(),
)
```

#### 3. Selective Rebuilds with Bloc

```dart
// BEFORE - rebuilds on every state change
BlocBuilder<Cubit, State>(
  builder: (context, state) => Text(state.user.name),
)

// AFTER - only rebuilds when user.name changes
BlocBuilder<Cubit, State>(
  buildWhen: (previous, current) =>
    previous.user.name != current.user.name,
  builder: (context, state) => Text(state.user.name),
)
```

### Memory Management

#### 1. Resource Cleanup

```dart
// Always dispose controllers, streams, subscriptions
@override
void dispose() {
  _controller.dispose();
  _subscription.cancel();
  _timer?.cancel();
  super.dispose();
}
```

#### 2. Image Caching

```dart
// Use cached network images properly
CachedNetworkImage(
  imageUrl: url,
  memCacheWidth: 300, // Limit memory usage
  memCacheHeight: 300,
)
```

#### 3. List Optimization

```dart
// Use ListView.builder for long lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)

// Add itemExtent for performance
ListView.builder(
  itemExtent: 56, // Improves scroll performance
  itemBuilder: (context, index) => ListTile(...),
)
```

### Async Optimization

#### 1. Isolate Heavy Computations

```dart
// CPU-intensive work in isolate
final result = await compute(expensiveCalculation, data);
```

#### 2. Stream Debouncing

```dart
// Debounce rapid events
searchStream
  .debounceTime(Duration(milliseconds: 500))
  .listen((query) => performSearch(query));
```

#### 3. Lazy Loading

```dart
// Use FutureBuilder with caching
FutureBuilder<Data>(
  future: _future ??= fetchData(),
  builder: (context, snapshot) { ... },
)
```

## Security Hardening Checklist

### Data Security

- □ No sensitive data in logs
- □ Secure storage for tokens/keys (flutter_secure_storage)
- □ Input validation on all user inputs
- □ SQL injection prevention (parameterized queries)
- □ XSS prevention in web rendering
- □ Certificate pinning for API calls

### Code Security

- □ No hardcoded secrets
- □ Obfuscate release builds
- □ Runtime integrity checks
- □ Root/jailbreak detection (if needed)
- □ Secure communication (TLS only)
- □ Proper error handling (no sensitive data in exceptions)

### Platform Security

- □ Permissions minimization
- □ Background execution limits
- □ File access sandboxing
- □ Inter-process communication security

## Flutter/Dart Best Practices

### 1. Effective Dart Guidelines

- Use `final` for all declarations that don't need reassignment
- Prefer `const` constructors and literals
- Use `??` and `?.` operators for null safety
- Prefer cascade notation `..` for method chaining
- Use extension methods for utility functions

### 2. Widget Composition

```dart
// Prefer composition over inheritance
class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        UserAvatar(),
        UserName(),
        UserStats(),
      ],
    );
  }
}
```

### 3. State Management

```dart
// Keep BLoCs focused on single responsibility
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
  }
  // Single responsibility: manage user state only
}
```

### 4. Error Handling

```dart
// Never let exceptions escape silently
try {
  await riskyOperation();
} on SpecificException catch (e) {
  // Handle expected exceptions
  logger.error('Specific error occurred', e);
} catch (e) {
  // Catch-all for unexpected errors
  logger.error('Unexpected error', e);
  rethrow; // Or handle gracefully
}
```

## Memory Safety Measures

### 1. Memory Leak Prevention

```dart
// Timer cleanup
Timer? _timer;

void startTimer() {
  _timer?.cancel(); // Prevent multiple timers
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    // Update logic
  });
}

@override
void dispose() {
  _timer?.cancel();
  super.dispose();
}
```

### 2. Stream Management

```dart
// Use StreamSubscription properly
StreamSubscription? _subscription;

void listenToStream() {
  _subscription?.cancel(); // Prevent multiple subscriptions
  _subscription = myStream.listen((data) {
    // Handle data
  });
}

@override
void dispose() {
  _subscription?.cancel();
  super.dispose();
}
```

### 3. Image Memory Management

```dart
// Optimize image loading
Image.network(
  url,
  width: 100, // Constrain dimensions
  height: 100,
  fit: BoxFit.cover,
  loadingBuilder: (context, child, progress) {
    return progress == null ? child : CircularProgressIndicator();
  },
  errorBuilder: (context, error, stack) {
    return Icon(Icons.error); // Graceful fallback
  },
)
```

## Performance Profiling Workflow

### 1. Use DevTools

```bash
# Run app with profiling
flutter run --profile

# Connect DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

### 2. Performance Overlay

```dart
// Enable performance overlay in debug
MaterialApp(
  showPerformanceOverlay: true,
  debugShowMaterialGrid: true,
)
```

### 3. Frame Timing

```dart
// Monitor frame performance
void _reportFrameTiming() {
  SchedulerBinding.instance.addTimingsCallback((timings) {
    for (final frame in timings) {
      if (frame.duration.inMicroseconds > 16000) {
        // Frame took > 16ms (60fps threshold)
        logger.warn('Slow frame: ${frame.duration}');
      }
    }
  });
}
```

## Code Review Criteria

Before committing any refactoring, verify:

### Architecture

- □ Separation of concerns maintained
- □ Dependency direction correct (ui → data, not reverse)
- □ No circular dependencies
- □ Single responsibility principle followed

### Performance

- □ No unnecessary rebuilds
- □ Proper use of const constructors
- □ Efficient data structures (e.g., Map vs List for lookups)
- □ Lazy loading where appropriate
- □ Memory usage optimized

### Security

- □ Input validation present
- □ Sensitive data protected
- □ No hardcoded secrets
- □ Proper error handling (no info leakage)
- □ Secure communication

### Memory Safety

- □ All disposables properly disposed
- □ No memory leaks detected
- □ Proper resource cleanup
- □ Stream subscriptions canceled
- □ Timers canceled

### Code Quality

- □ Flutter analyze passes
- □ All tests pass
- □ Code formatted (dart format)
- □ Comments added for complex logic
- □ No deprecated APIs used

## Post-Refactoring Commit Standards

Commit messages must follow this format:

```
refactor(module): brief description

- Specific change 1
- Specific change 2
- Performance improvement: X% faster
- Memory improvement: Reduced by Y MB
- Security: Added Z protection

Tests: All passing, coverage maintained
Profiling: Verified with DevTools
```

## Monitoring & Validation

After each refactor commit:

```
1. Run application in profile mode for 5 minutes
2. Monitor memory usage (should be stable)
3. Check frame rate (should be 60fps)
4. Verify all features still work
5. Check logs for new warnings/errors
6. Validate security measures still effective
```

## Emergency Rollback Procedure

If refactoring causes issues:

```
1. Immediately revert the commit
2. Document what went wrong
3. Root cause analysis
4. Create tests for the issue
5. Refactor again with proper testing
6. More thorough validation before re-commit
```

## Continuous Improvement

### Weekly Refactoring Goals

- Address 1-2 performance bottlenecks
- Fix memory leaks if any found
- Improve code modularity
- Enhance security measures

### Monthly Review

- Comprehensive performance audit
- Memory usage analysis
- Security vulnerability scan
- Architecture assessment
- Technical debt prioritization

---

**Remember**: Quality > Speed. One perfect refactor is better than 10 half-baked ones. Always prioritize user experience, performance, memory safety, and security.
