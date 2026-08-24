# Host-Projektmount durch GitHub-Repository-Volume ersetzt

Der Nutzer hat den anfänglichen Host-Bind-Mount bewusst verworfen: T3 soll
Repositories von GitHub in ein eigenes Docker-Volume klonen und Pull Requests
über einen dedizierten GitHub-Account erstellen. Der macOS-SSH-Schlüssel dient
nur dem Git-Zugriff auf dem Host und wird nicht in den Container eingebunden.
Im Container erhalten Repository-Arbeitskopien und GitHub-CLI-Credentials
getrennte, gezielt schreibbare Volumes.

T3 Code wählt beim Clone-Protokoll `auto` derzeit die SSH-URL. Weil der
Container absichtlich keinen Host-SSH-Schlüssel erhält, schreibt seine isolierte
globale Git-Konfiguration `git@github.com:` transparent auf
`https://github.com/` um. Damit bleiben Clone und Push mit T3 kompatibel und
verwenden weiterhin den GitHub-CLI-Credential-Helper.

## Evidence

Der dedizierte Account `t3code-agent` wurde als Collaborator eingeladen. Der
lokale `main`-Commit wurde über SSH nach `radzom/learnt3code` gepusht und sein
Commit-Hash mit `origin/main` abgeglichen.
