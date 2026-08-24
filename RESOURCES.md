# T3 Code Resources

## Knowledge

- [T3 Code: README und Einstieg](https://github.com/pingdotgg/t3code)
  Primärquelle für Zweck, unterstützte Coding-Agenten und den aktuellen Einstieg. Verwenden für: grundlegendes Produktverständnis und Installation.
- [T3 Code: Benutzerdokumentation](https://github.com/pingdotgg/t3code/blob/main/docs/README.md)
  Offizieller Index der Nutzerdokumentation. Verwenden für: Bedienung, Remote-Zugriff, Tastenkürzel und Integrationen.
- [T3 Code: Berechtigungsmodi](https://github.com/pingdotgg/t3code/blob/main/docs/user/permission-modes.md)
  Erklärt, wann der Agent selbstständig handelt oder nachfragt. Verwenden für: sichere Wahl zwischen Supervised, Auto-accept edits, Auto und Full access.
- [T3 Code: Source-Control-Integrationen](https://github.com/pingdotgg/t3code/blob/main/docs/user/source-control.md)
  Offizielle Anleitung für GitHub, GitLab, Bitbucket und Azure DevOps. Verwenden für: Branches, Reviews und Pull Requests.
- [T3 Code: Tastenkürzel](https://github.com/pingdotgg/t3code/blob/main/docs/user/keybindings.md)
  Referenz für Navigation, Datei- und Projektsuche sowie eigene Shortcuts. Verwenden für: flüssigeres Arbeiten.
- [T3 Code: Architekturüberblick](https://github.com/pingdotgg/t3code/blob/main/docs/internals/overview.md)
  Beschreibt den T3-Server als Ausführungsgrenze für Agenten, Terminal, Git und Dateizugriffe. Verwenden für: Containergrenze und Komponentenplatzierung.
- [Docker: Container Security FAQ](https://docs.docker.com/security/faqs/containers/)
  Offizielle Übersicht darüber, welche Hostdateien Container sehen können. Verwenden für: Bedrohungsmodell und erwartete Isolation.
- [Docker: Bind Mounts](https://docs.docker.com/engine/storage/bind-mounts/)
  Erklärt Freigaben von Hostpfaden und deren Schreib-/Leserechte. Verwenden für: minimale Mount-Liste und Nur-Lese-Freigaben.
- [Docker: Engine Security](https://docs.docker.com/engine/security/)
  Beschreibt Namespaces, Capabilities und die Angriffsfläche des Docker-Daemons. Verwenden für: Härtung und Vermeidung des Docker-Sockets.
- [Docker Compose: Services](https://docs.docker.com/reference/compose-file/services/)
  Referenz für `read_only`, `cap_drop`, `security_opt`, Limits und weitere Service-Einstellungen. Verwenden für: reproduzierbare Compose-Konfiguration.
- [OpenAI Docs: Codex authentication](https://learn.chatgpt.com/docs/auth)
  Offizielle Beschreibung von `CODEX_HOME`, Credential-Speichern, Token-Aktualisierung und Device-Code-Login. Verwenden für: isolierte, dauerhafte Codex-Anmeldung im Container.
- [OpenAI Docs: Codex CLI commands](https://learn.chatgpt.com/docs/developer-commands?surface=cli)
  Aktuelle Referenz für `codex login`, `--device-auth` und `codex login status`. Verwenden für: Einrichtung und automatisierbare Login-Prüfung.
- [T3 Code: Remote access](https://github.com/pingdotgg/t3code/blob/main/docs/user/remote-access.md)
  Offizielle Anleitung für `t3 serve`, Pairing und den Headless-Betrieb. Verwenden für: Verbindung vom Host-Client zum containerisierten Server.
- [Colima: README](https://github.com/abiosoft/colima)
  Offizielle Übersicht zu Docker-Runtime, Compose-Ökosystem, Apple Silicon und Installation. Verwenden für: schlanke Docker-VM ohne Desktop-Anwendung.
- [Colima: Standardkonfiguration](https://github.com/abiosoft/colima/blob/main/embedded/defaults/colima.yaml)
  Dokumentiert insbesondere den standardmäßigen Home-Mount und dessen Abschaltung. Verwenden für: gehärtetes Colima-Profil mit minimaler Hostfreigabe.
- [Podman: `podman machine init`](https://docs.podman.io/en/stable/markdown/podman-machine-init.1.html)
  Offizielle Referenz für die macOS-VM, Rootless-Modus und Host-Volumes. Verwenden für: Podmans tatsächliche Isolationsgrenze auf macOS.
- [Podman: Compose](https://docs.podman.io/en/latest/markdown/podman-compose.1.html)
  Erklärt `podman compose` als Wrapper um einen externen Compose-Provider. Verwenden für: Einschätzung der Docker-Compose-Kompatibilität.
- [Rancher Desktop: Container Engine](https://docs.rancherdesktop.io/ui/preferences/container-engine/general/)
  Beschreibt die Wahl zwischen `containerd` und `dockerd (moby)`. Verwenden für: Docker-API-kompatiblen Rancher-Betrieb.
- [Rancher Desktop: Kubernetes](https://docs.rancherdesktop.io/ui/preferences/kubernetes/)
  Dokumentiert das standardmäßig aktive Kubernetes und dessen Abschaltung. Verwenden für: ressourcenschonenden Einstieg ohne Kubernetes.
- [OrbStack: Docker](https://docs.orbstack.dev/docker/)
  Offizielle Angaben zu Docker Engine, Compose, Bind Mounts und Apple-Silicon-Unterstützung. Verwenden für: komfortorientierte Docker-Alternative.
- [OrbStack: Preise](https://orbstack.dev/pricing)
  Aktuelle Nutzungs- und Lizenzbedingungen. Verwenden für: Entscheidung zwischen persönlicher und geschäftlicher Nutzung.
- [Docker Desktop: Lizenz](https://docs.docker.com/subscription/desktop-license/)
  Offizielle Bedingungen für kostenlose und kostenpflichtige Nutzung. Verwenden für: Docker Desktop als Kompatibilitäts-Baseline.

## Wisdom (Communities)

- [T3 Code: GitHub Discussions](https://github.com/pingdotgg/t3code/discussions)
  Projektnahe Community für Fragen und Erfahrungsaustausch. Verwenden für: reale Workflows und offene Fragen, die die Dokumentation nicht beantwortet.
- [T3 Code: GitHub Issues](https://github.com/pingdotgg/t3code/issues)
  Aktuelle Fehlerberichte und Funktionsdiskussionen. Verwenden für: bekannte Einschränkungen prüfen, bevor lange nach einem lokalen Fehler gesucht wird.

## Gaps

- Eine offizielle, vollständige T3-Code-Anleitung für den Betrieb des Servers und der Agenten in einem gehärteten Docker-Container fehlt derzeit. Die Referenzimplementierung muss deshalb aus der dokumentierten T3-Ausführungsgrenze und den offiziellen Docker-Sicherheitsmechanismen abgeleitet und durch eigene Negativtests validiert werden.
- Apples `container` besitzt derzeit keinen gleichwertigen, offiziell unterstützten Ersatz für den vorhandenen Docker-Compose-Workflow; es bleibt deshalb außerhalb der ersten Implementierung.
