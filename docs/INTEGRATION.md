# Hermes integration plan

## Baseline and constraints

Target: Aspksa/Ayatsumira, default branch main. Preserve existing files and user data. No Docker, no local LLM. Portable external M.2 on Windows with non-ASCII and special-character paths. All provider keys stay on the machine.

Upstream: https://github.com/nesquena/hermes-webui and https://github.com/NousResearch/hermes-agent. Verify and pin exact upstream commits before copying. Preserve upstream MIT notices and any dependency licenses. The upstream bootstrap is not a native portable-Windows solution.

## Integration boundaries

1. **UI**: import the upstream WebUI at a pinned commit into app/hermes-webui; keep upstream license, record origin and diff; prefer extension points over core edits.
2. **Agent**: install a compatible Hermes Agent build into an isolated portable Python environment; validate Windows tool adapters and subprocess handling.
3. **Provider**: server-side Cloud.ru OpenAI-compatible adapter; validate base URL, models, streaming, tool calls, cancellation, 429/5xx retries and cost reporting against actual Cloud.ru credentials without logging secrets.
4. **Memory**: isolated memory service owns immutable conversation provenance, knowledge extraction, MemOS adapter, PostgreSQL + pgvector migrations and vector dimension metadata. No direct DB coupling from browser JS.
5. **Agent execution**: concurrency budget, explicit permissions, per-task cancellation, durable queues, audit logs and human approval for destructive actions.
6. **UI design**: Russian localization, black/gold skin, agent activity panel, memory graph and mobile layout. Preserve existing upstream accessibility and streaming.
7. **Windows portability**: relative paths, isolated Python/Node if needed, native PostgreSQL/pgvector compatibility validation, no global installs, port checks, single-instance lock and safe shutdown before drive removal.
8. **Backups**: every five hours while running, atomic snapshots, retention, encrypted secret handling and restore verification. Never overwrite a working DB on failed restore.
9. **Release**: smoke, unit, integration, Windows CI, secret scan, license check, migration/rollback and clean-machine portability tests before merge.

## Data safety

Never delete or replace user `data/`, `runtime/`, `backups/` or existing Hermes homes. Migration must be opt-in and reversible, with a verified backup and checksums. Avoid writing to a global ~/.hermes by setting HERMES_HOME and HERMES_WEBUI_STATE_DIR.

## Current implementation

Only repository foundation, a conservative launcher, documentation and static CI checks are included. **Not a working Hermes distribution.** The launcher intentionally stops when portable Python or upstream sources are missing; it does not silently install or clone anything.

## Required acceptance tests

- Upstream pinned source inventory and license preservation
- Python/agent dependency resolution on clean Windows 10/11
- Cyrillic, spaces, percent, ampersand and parentheses in M.2 path
- Working streaming, cancellation, tool approval, attachments and session persistence
- Live Cloud.ru tool-call/streaming compatibility and cost accounting
- Memory provenance, duplicate handling, backup/restore and power-loss recovery
- Security review: CSRF, auth, traversal/symlinks, prompt injection, secret leakage
- Full automated test suite and clean CI before merging into main
