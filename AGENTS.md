# Neuralwire Status — Agentic Development Guidelines & Invariants

This file defines the persistent rules, verification protocols, and coding standards for all AI coding agents working on the `neuralwire-status` codebase.

---

## 1. Project Identity & Domain Invariants (MANDATORY)

### 1.1 Canonical Identity & Production Domain
- **Official Production Domain**: `neuralwire.info` (Canonical base URL: `https://neuralwire.info`).
- **Official Status Subdomain**: `status.neuralwire.info` (Canonical status URL: `https://status.neuralwire.info`).
- **Official Organization**: `neuralwire-media` (`https://github.com/neuralwire-media/neuralwire-status`).
- **Strict Domain Invariant**:
  - NEVER hallucinate, guess, or substitute alternative domains (e.g. `.org`, `.com`, `.net`, `.io`, `.dev`).
  - ALL monitor targets, canonical links, SEO meta tags, and alert references MUST strictly use `neuralwire.info` or `status.neuralwire.info`.

---

## 2. Infrastructure & Monitoring Invariants

### 2.1 Core Target Endpoints
All monitoring configurations, healthcheck scripts, and integration tests MUST target the verified Neuralwire services:
- **Web Frontend**: `https://neuralwire.info` (Expected: HTTP 200 OK)
- **Backend API Health**: `https://neuralwire.info/api/health` (Expected: HTTP 200 OK + JSON payload)
- **RSS Feed**: `https://neuralwire.info/feed.xml` (Expected: HTTP 200 OK + XML payload)
- **TLS / SSL Certificate**: `neuralwire.info` (Alert threshold: < 14 days before expiry)

### 2.2 Container & Data Safety
- **Data Persistence**: Never delete, wipe, or rename the `uptime-kuma-data` Docker volume without explicit user instruction.
- **Port Management**: Default dashboard port is `3001` (configured via `.env` as `UPTIME_KUMA_PORT`).
- **Backup Verification**: All changes to the backup script (`scripts/backup.sh`) must ensure strict permission handling (`chmod +x`) and safe SQLite database copying without locking the live container.

---

## 3. Developer & Git Guardrails

### 3.1 Feature Branching Strategy (MANDATORY)
1. **Base & Target Branch**:
   - `main` is the single source of truth for stable production configurations.
   - All tasks (features, infrastructure changes, docs, CI) MUST branch off the latest `main`.
2. **Branch Naming Standard (Kebab-Case)**:
   - Features: `feat/<feature-name>`
   - Bug fixes: `fix/<bug-name>`
   - Infrastructure & Docker: `infra/<scope>`
   - Documentation & Rules: `docs/<topic>`
   - CI & Tooling: `ci/<pipeline>`
3. **Workflow Lifecycle**:
   1. `git checkout main && git pull origin main`
   2. `git checkout -b <type>/<kebab-case-name>`
   3. Make changes and verify Docker Compose syntax (`docker compose config`).
   4. Obtain explicit user confirmation before committing.
   5. `git push origin <type>/<kebab-case-name>`
   6. Open Pull Request with target `base: main`.
   7. Hand over the PR URL to the user immediately. Do NOT poll or monitor CI.

### 3.2 Mandatory GPG-Signed Commits Invariant (STRICT)
1. **Zero Unsigned Commits**:
   - ALL commits in this repository MUST be cryptographically signed with GPG (`commit.gpgsign=true`).
   - **STRICT PROHIBITION**: NEVER bypass, suppress, or disable GPG signing using `--no-gpg-sign` under any circumstances.

### 3.3 Permissions & Scope Lock
1. **Explicit Permission Required**:
   - NEVER execute `git commit`, `git push`, or create a Pull Request without explicit confirmation from the user.
2. **Scope Lock Invariant**:
   - Limit modifications strictly to the task requested. Avoid speculative refactoring outside the infrastructure scope.
