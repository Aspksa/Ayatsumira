# Security boundaries

- Bind to 127.0.0.1 by default. Do not expose externally without authentication and TLS.
- Provider credentials are server-only, never browser localStorage, git or logs.
- Reject workspace paths escaping allowed roots, including via symlinks or junctions.
- Treat retrieved documents, web pages and agent outputs as untrusted instructions.
- Require human confirmation for shell execution with destructive effects, writes outside approved roots, network publication and secret access.
- Keep third-party WebUI extensions disabled until their code is reviewed; they inherit session authority.
- Pin dependencies and upstream commits. Record SBOM and verify licenses.
- Use least-privilege service identities, bounded requests, timeouts and concurrency.
- Encrypt backups containing credentials; test restore before claiming recoverability.
- No telemetry or external synchronization without explicit opt-in.
