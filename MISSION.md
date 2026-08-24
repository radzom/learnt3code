# Mission: Isolierter Agentic-Development-Workflow mit T3 Code

## Why
Ich möchte T3 Code als zentrale Arbeitsoberfläche für einen agentischen Entwicklungsworkflow einsetzen. T3-Server und Coding-Agenten sollen in Docker-Containern laufen, damit sie Apps bauen, Code untersuchen und Aufgaben automatisieren können, ohne unberechtigt auf andere Hostdateien zuzugreifen.

## Success looks like
- Ein T3-Client kann einen containerisierten T3-Server samt Coding-Agent erreichen und bedienen.
- Der Agent kann im freigegebenen Projekt entwickeln, Tests ausführen und Git-Diffs erzeugen.
- Negative Tests belegen, dass Hostdateien außerhalb der erlaubten Mounts weder gelesen noch verändert werden können.
- Die Containerkonfiguration ist reproduzierbar, minimal privilegiert und ohne eingebundenen Docker-Socket.
- Der Workflow unterstützt App-Entwicklung, Codeverständnis, Automatisierung und professionelle Reviews.

## Constraints
- Kurze, praktische Lektionen mit jeweils einem direkt sichtbaren Ergebnis.
- Sicherheit wird durch beobachtbare Positiv- und Negativtests belegt, nicht nur durch Konfiguration angenommen.
- Nur ausdrücklich erlaubte Projekt-, Zustands- und Credential-Speicher dürfen schreibbar sein.
- Die Übungen und die erste Referenzimplementierung entstehen in diesem Workspace.

## Out of scope
- Formale Absicherung gegen Kernel- oder Container-Runtime-Schwachstellen.
- Kubernetes, Multi-Host-Orchestrierung und mehrere Agent-Provider in der ersten Ausbaustufe.
