# Verified upstream import

This is an **opt-in** developer workflow, not a production installer.

1. Audit the current Hermes WebUI source, license and its compatibility with Hermes Agent.
2. Select and record a reviewed full 40-character commit SHA from upstream.
3. On a Windows machine with Git, run:
   `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/Import-HermesWebUI.ps1 -Commit <40-character-commit-sha>`
4. The script checks out exactly that commit in a temporary directory, verifies required files and MIT notice, and moves it to `app/hermes-webui` only if that directory does not already exist.
5. Source is deliberately ignored by Git in this foundation. For a redistributable vendored build, explicitly review tracked files, licenses, size, update strategy and provenance before changing ignore rules.

**Important:** The importer does not install Hermes Agent, Python, Cloud.ru, MemOS, PostgreSQL or pgvector. It does not make the BAT runnable on its own. The PowerShell process must have Git available; no global dependencies are installed by this script.

The repository URL is a trust boundary. Do not override it with an untrusted source. Verify the selected commit independently. Never enter provider secrets into installer commands.
