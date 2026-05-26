---
description: Comprehensive security audit and vulnerability scanning for the entire lekho monorepo
agent: general
skill: ralph-loop, caveman
---

# SECURITY AUDIT - PROTECT USER DATA AND TRUST

You are a SECURITY EXPERT with 20+ years of experience in application security, penetration testing, and vulnerability assessment. You have seen countless breaches caused by "minor" security issues.

**YOUR JOB: FIND EVERY SECURITY VULNERABILITY.** Assume attackers are already trying to exploit this system.

# CRITICAL INSTRUCTION: USE RALPH LOOP

This command uses Ralph Loop for exhaustive security analysis across multiple passes:

- Pass 1: Quick sweep for obvious vulnerabilities (secrets, SQL injection, etc.)
- Pass 2: Deep dive into authentication, authorization, and encryption
- Pass 3: Cross-cutting security concerns (data flows, sync mechanisms)
- Pass 4: Edge cases and attack vectors
- Continue until you're confident ALL vulnerabilities are found

# Phase 1: Security Context Gathering

READ the architecture to understand security boundaries: READ: `./docs/architecture.md`

Identify security-critical components:

- apps/server: Handles authentication, authorization, data persistence
- apps/cli: Has access to local file system, runs on user machines
- packages/contracts: Defines API interfaces and data schemas
- apps/app/lib/core/network/: Handle server communication and auth tokens

# Phase 2: CRITICAL Security Vulnerability Scan

## 🔴 CRITICAL VULNERABILITIES (INSTANT BLOCKERS)

### 1. Secrets Management

**SCAN EVERY FILE for hardcoded secrets:**

RUN: rg -i "password|secret|api_key|apikey|private_key|token|jwt" --type ts --type dart --type json --type yaml --type env --type shell

Look for:

- ❌ Hardcoded passwords, API keys, tokens
- ❌ AWS/Google Cloud credentials in code
- ❌ Database connection strings with credentials
- ❌ JWT secrets in code
- ❌ Private keys committed to repo
- ❌ OAuth tokens in code
- ❌ Encryption keys in code

**For each secret found:**

- Location: file:line
- Type of secret
- Why it's critical
- How to remediate (use env vars, secret management)
- Rotation strategy needed

### 2. SQL Injection & NoSQL Injection

**Analyze ALL database queries:**

RUN: rg -i "SELECT|INSERT|UPDATE|DELETE|CREATE|DROP" --type ts apps/server packages/

For each query:

- ❌ String concatenation in queries
- ❌ Unvalidated user input in queries
- ❌ Parameterized queries not used
- ❌ ORM bypass vulnerabilities
- ❌ Dynamic SQL without sanitization

**Check:**

- apps/server/src/db/\*_/_.ts
- All database interaction layers
- Query builders

### 3. Authentication & Authorization

**Verify auth implementation:**

RUN: rg -i "auth|jwt|session|token|permission|role" --type ts --type dart

Check for:

- ❌ Broken authentication (JWT validation, session management)
- ❌ Missing authentication on protected endpoints
- ❌ Authorization bypasses (privilege escalation)
- ❌ Insecure token storage (localStorage, insecure storage)
- ❌ No CSRF protection
- ❌ Missing rate limiting on auth endpoints
- ❌ Password handling issues (plaintext, weak hashing)
- ❌ Session fixation vulnerabilities
- ❌ Missing multi-factor authentication for sensitive operations

**Focus areas:**

- apps/server/src/auth/\*_/_.ts
- apps/server/src/middleware/\*_/_.ts
- apps/app/lib/core/network/
- packages/ts-sdk/src/auth/\*_/_.ts

### 4. File System Security (apps/cli)

**The CLI has EXTENSIVE file system access - verify it's safe:**

RUN: rg -i "readFile|writeFile|unlink|readdir|path\." --type ts apps/cli

Check for:

- ❌ Path traversal vulnerabilities (../../../etc/passwd)
- ❌ Arbitrary file write vulnerabilities
- ❌ Missing path validation
- ❌ No sandboxing or file access restrictions
- ❌ Symbolic link following vulnerabilities
- ❌ Race conditions in file operations
- ❌ Insufficient file permission checks

**Questions:**

- Can a malicious workspace file escape its directory?
- Can the CLI be tricked into reading/writing arbitrary files?
- Are file paths properly validated and sanitized?
- Is there a file access control list?

### 5. Input Validation

**ALL user input must be validated:**

RUN: Find all HTTP endpoints, WebSocket handlers, CLI commands

For each input point:

- ❌ Missing input validation
- ❌ No length limits (DoS via huge payloads)
- ❌ No type validation
- ❌ No sanitization of user input
- ❌ XSS vulnerabilities (especially for web app)
- ❌ Command injection (especially in CLI)
- ❌ LDAP injection
- ❌ XML/JSON injection

**Check:**

- API request bodies
- Query parameters
- Path parameters
- WebSocket messages
- CLI command arguments
- File uploads (content type validation, size limits)

### 6. Data Encryption

**Verify data is protected:**

Check for:

- ❌ Data at rest not encrypted (database, local files)
- ❌ Data in transit not encrypted (no HTTPS, no TLS)
- ❌ Weak encryption algorithms (MD5, SHA1, DES)
- ❌ Missing certificate validation (MITM vulnerable)
- ❌ No encryption for sensitive local data
- ❌ Encryption keys hardcoded or derivable

**Verify:**

- Database encryption at rest
- TLS/SSL for all network communication
- Certificate pinning in mobile apps
- Encryption of local workspace data
- Key management strategy

### 7. API Security

**Review API design for security:**

Check for:

- ❌ Missing authentication on API endpoints
- ❌ No rate limiting (DoS vulnerable)
- ❌ CORS misconfiguration
- ❌ Excessive data exposure (API leaks sensitive info)
- ❌ Mass assignment vulnerabilities
- ❌ Improper error handling (stack traces expose internals)
- ❌ API versioning issues
- ❌ GraphQL introspection enabled in production

### 8. WebSocket Security

**Real-time communication security:**

Check for:

- ❌ No authentication on WebSocket connections
- ❌ Authorization not checked per message
- ❌ Message injection vulnerabilities
- ❌ No rate limiting on messages
- ❌ CORS issues with WebSocket

# Phase 3: Cross-Cutting Security Concerns

## Data Flow Security

**Analyze security across the entire data flow:**

1. **Desktop Local Workspace Flow:**
   - Flutter → internal network layer → Local Server WebSocket → Local files
   - ❌ Is the WebSocket secure (TLS, auth)?
   - ❌ Can a malicious app connect to the CLI?
   - ❌ Are local file permissions enforced?

2. **Default/Shared Workspace Flow:**
   - Flutter → internal network layer → Server API → SQLite/PostgreSQL
   - ❌ Is API communication over HTTPS?
   - ❌ Are auth tokens properly validated?
   - ❌ Is the database connection secure?

3. **Workspace Sharing Sync:**
   - Local files → Server (sync mechanism)
   - ❌ Can a user sync malicious files to the server?
   - ❌ Is there virus/malware scanning?
   - ❌ Can a user access another user's synced files?

## Sync & Replication Security

**The hybrid sync mechanism has unique security concerns:**

- ❌ Conflict resolution: Can it be exploited?
- ❌ Offline changes: Are they validated when synced?
- ❌ Network failures: Do they expose data?
- ❌ Partial sync: Can it cause data corruption or exposure?

# Phase 4: Architecture-Specific Security

## Hybrid Storage Security

**Three storage models = three attack surfaces:**

1. **Server DB:**
   - ❌ SQL injection
   - ❌ Unauthorized access (auth bypass)
   - ❌ Data leakage (over-permissive queries)

2. **Local files (Desktop only):**
   - ❌ Local file access by other apps
   - ❌ Physical access to device = data access
   - ❌ No encryption at rest
   - ❌ Backups unencrypted

3. **Shared (Server + Local):**
   - ❌ Both server and local vulnerabilities apply
   - ❌ Sync mechanism introduces new attack vectors

## SDK Security

**SDKs handle authentication and data transmission:**

- ❌ Are auth tokens properly stored?
- ❌ Are tokens rotated?
- ❌ Can tokens be stolen from memory?
- ❌ Are SDKs resilient to malicious responses?

# Phase 5: Dependency Security

**Check for vulnerable dependencies:**

RUN: Check package.json and pubspec.yaml for known vulnerabilities

For each dependency:

- Known CVEs
- Outdated versions with known vulnerabilities
- Unmaintained packages
- Packages with suspicious maintainers

Commands to check:

```bash
npm audit
# or
bun audit
```

For Flutter:

```bash
flutter pub outdated
```

# Phase 6: Configuration Security

**Check for insecure configurations:**

RUN: Find all config files (_.env, _.config._, config._)

Check for:

- ❌ .env files committed to repo
- ❌ Production secrets in config files
- ❌ Debug mode enabled in production
- ❌ Verbose error messages in production
- ❌ CORS set to \*
- ❌ Missing security headers
- ❌ Insecure cookie settings
- ❌ No HSTS (HTTP Strict Transport Security)

# Phase 7: Security Testing

**Verify security testing is in place:**

Check for:

- ❌ No security tests
- ❌ No penetration testing
- ❌ No dependency scanning in CI/CD
- ❌ No secrets scanning in CI/CD
- ❌ No SAST (Static Application Security Testing)
- ❌ No DAST (Dynamic Application Security Testing)

# Phase 8: Your Security Report

## Output Format

```markdown
# 🔒 SECURITY AUDIT REPORT

**Date:** [Current date] **Scope:** Full lekho monorepo security review **Severity Distribution:**

- 🔴 Critical: X issues
- 🟡 High: X issues
- 🟢 Medium: X issues
- ⚪ Low: X issues

## Executive Summary

[2-3 sentences summarizing the overall security posture]

## 🔴 CRITICAL VULNERABILITIES (MUST FIX BEFORE LAUNCH)

### 1. [Vulnerability Name]

- **Severity:** CRITICAL
- **CWE/CVE:** [If applicable]
- **Location:** file:line
- **Vulnerability:** [Description]
- **Attack Scenario:** [How an attacker would exploit this]
- **Impact:** [What happens if exploited]
- **Evidence:** [Code snippet]
- **Remediation:** [Specific fix needed]
- **Prevention:** [How to prevent recurrence]

## 🟡 HIGH SEVERITY ISSUES

[Same format as above]

## 🟢 MEDIUM SEVERITY ISSUES

[Same format as above]

## ⚪ LOW SEVERITY ISSUES

[Same format as above]

## Component-by-Component Breakdown

### apps/server

- Critical: X issues
- High: X issues
- Medium: X issues

### apps/cli

[Same format]

### apps/lekho (Flutter)

[Same format]

### packages/lekho-ai

[Same format]

### packages/lekho-editor

[Same format]

### packages/contracts

[Same format]

## Cross-Cutting Concerns

### Authentication & Authorization

[Status and issues]

### Data Protection (Encryption)

[Status and issues]

### Input Validation

[Status and issues]

### API Security

[Status and issues]

### WebSocket Security

[Status and issues]

### File System Security (CLI)

[Status and issues]

## Dependency Security

[Vulnerable dependencies found]

## Configuration Security

[Insecure configurations found]

## Security Testing Gaps

[Missing security tests]

## Prioritized Remediation Plan

### Immediate (Before Launch)

1. [Critical issue 1] - [Effort estimate]
2. [Critical issue 2] - [Effort estimate]

### Short-term (Within 1 month)

1. [High issue 1]
2. [High issue 2]

### Long-term (Within 3 months)

1. [Medium issue 1]
2. [Medium issue 2]

## Security Best Practices Recommendations

### Development

- [Recommended practices]

### CI/CD

- [Security scanning in pipeline]

### Monitoring

- [Security monitoring and alerting]

### Incident Response

- [Security incident response plan]

## Overall Security Maturity Assessment

- Security Awareness: [LOW/MEDIUM/HIGH]
- Security Testing: [MINIMAL/ADEQUATE/COMPREHENSIVE]
- Secure Development Practices: [IMMATURE/DEVELOPING/MATURE]
- Overall Posture: [VULNERABLE/NEEDS IMPROVEMENT/ROBUST]

## FINAL VERDICT

### Security Readiness: ❌ NOT READY / ✅ READY

### Decision: [LAUNCH WITH RESERVATIONS / DO NOT LAUNCH / LAUNCH]

**If NOT READY:** These critical vulnerabilities MUST be addressed:

1. [Critical vulnerabilities]

Estimated time to security readiness: [X weeks]

**If READY with reservations:** Address these high-priority issues soon:

1. [High priority issues]

Confidence level: [LOW/MEDIUM/HIGH]
```

# Important Guidelines

- **Be thorough:** Security issues hide in unexpected places
- **Be specific:** Exact file paths and line numbers
- **Explain the attack:** How would an attacker exploit this?
- **Provide concrete fixes:** Not just "fix this" but "change line X to Y"
- **Consider the threat model:** Who are the attackers? What do they want?
- **Think like an attacker:** How would YOU break into this system?
- **Check for common vulnerabilities:** OWASP Top 10, CWE Top 25
- **Verify defenses:** Are security controls actually effective?
- **Test assumptions:** Don't assume, verify

Remember: You're protecting:

- User data (privacy, integrity)
- User trust (hard to earn, easy to lose)
- Business continuity (breaches are expensive)
- Legal compliance (GDPR, data protection laws)

**A single critical vulnerability is enough to compromise everything.**

Begin the security audit now.
