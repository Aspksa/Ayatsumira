# Windows runtime preflight

The runtime preflight is an **offline validation**, not an installer. Run `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/Test-Runtime.ps1`.

It checks that the isolated Python executable and Hermes WebUI entrypoint exist, verifies Python 3.11+ and imports the two core WebUI packages, PyYAML and cryptography. It does not validate Hermes Agent, Cloud.ru, database connections, streaming, memory, authentication or end-to-end functionality.

Missing dependencies cause an explicit failure, never an automatic global installation. No API keys are read or logged. The portable runtime and vendored source remain ignored by Git and must be independently installed and reviewed.

For a complete release, add a clean-machine Windows launch test and actual Hermes Agent compatibility tests before claiming readiness.
