# Schreibbares Codex-Credential-Volume begründet

Der Nutzer versteht, warum das isolierte `CODEX_HOME`-Volume trotz sensibler Anmeldedaten schreibbar sein muss: Codex aktualisiert seine Tokens automatisch und muss die erneuerten Credentials dauerhaft speichern können. Damit kann die Containerkonfiguration zwischen unnötig breiten Hostfreigaben und einem gezielt schreibbaren, isolierten Credential-Speicher unterscheiden.

## Evidence

Der Nutzer hat die Begründung ohne Nachschlagen korrekt wiedergegeben.
