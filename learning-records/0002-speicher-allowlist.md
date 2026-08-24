# Speicherzugriffe als Allowlist definiert

Der Nutzer kann die gewünschte Containergrenze jetzt konkret formulieren: Der Projektordner ist les- und schreibbar, T3-Zustand und Agent-Anmeldung liegen in eigenen Docker-Volumes, temporäre Dateien in einem flüchtigen `tmpfs`, und alle anderen Hostpfade einschließlich Docker-Socket bleiben ungemountet. Damit ist die Speicher-Policy präzise genug, um sie im nächsten Schritt auf Docker-Compose-Ressourcen abzubilden und durch Positiv- sowie Negativtests zu prüfen.

## Evidence

Der Nutzer hat die vollständige Allowlist selbst korrekt wiedergegeben.
