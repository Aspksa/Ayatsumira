# Ayatsumira

Windows-first portable AI workspace integration project.

## Status

This branch contains a **safe integration foundation**, not a working Hermes WebUI distribution. Hermes WebUI, Hermes Agent, Cloud.ru, MemOS and PostgreSQL are **not yet installed or integrated**.

## Startup

`Start.bat` uses paths relative to the external drive and local-only host 127.0.0.1. It intentionally refuses to start unless `runtime\python\python.exe` and `app\hermes-webui\server.py` are present. It does not install global dependencies, download code, overwrite existing data or change system settings.

## Architecture

Hermes WebUI -> Hermes Agent -> server-side Cloud.ru provider adapter. Separate memory service -> MemOS + PostgreSQL/pgvector, with source-linked knowledge graph. Intended deployment: no Docker and no local LLM.

Read [integration plan](docs/INTEGRATION.md) and [security requirements](docs/SECURITY.md).

Upstream: https://github.com/nesquena/hermes-webui (MIT) and https://github.com/NousResearch/hermes-agent (verify license and compatibility before importing).

## Progress

- [x] Non-destructive Windows launcher and isolated directory layout
- [x] Security and integration documentation
- [x] Static Windows CI workflow (execution pending)
- [ ] Pinned upstream import and license notices
- [ ] Native Windows Hermes runtime and functional smoke tests
- [ ] Live Cloud.ru integration
- [ ] MemOS/PostgreSQL/pgvector and verified backups
- [ ] End-to-end Windows portability tests

Never commit credentials, personal files or runtime data.
