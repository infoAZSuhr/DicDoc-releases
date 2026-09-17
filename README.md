# DicDoc Releases

Öffentliches Repo für fertige `DicDoc.exe`-Releases der lokalen Diktier-App für die
Praxis. Quellcode ist privat: [infoAZSuhr/DicDoc](https://github.com/infoAZSuhr/DicDoc).

Dieses Repo ist bewusst öffentlich, damit:
- die App ohne Login prüfen kann, ob eine neue Version verfügbar ist,
- die App ohne Login das zentrale Vokabular (`vokabular.txt`) abrufen kann.

## Zentrales Vokabular pflegen

[vokabular.txt](vokabular.txt) enthält Fachbegriffe, die jede DicDoc-Installation beim
Start automatisch abruft und lokal ergänzt (nur lesend - lokale Änderungen einzelner
PCs werden nicht hierher zurückgeschrieben).

Neuen Begriff für alle PCs verfügbar machen: Datei hier auf GitHub über das Stift-Symbol
bearbeiten, Zeile hinzufügen, committen.

## Installation auf einem Praxis-PC

**Einfachste Variante** (PowerShell, ohne Adminrechte): lädt die neueste Version herunter
und richtet den Autostart ein.

```powershell
irm https://raw.githubusercontent.com/infoAZSuhr/DicDoc-releases/main/install.ps1 | iex
```

**Manuell:** aktuelle `.exe` von [Releases](https://github.com/infoAZSuhr/DicDoc-releases/releases/latest)
herunterladen, an einen beliebigen Ort legen und starten. Fürs automatische Update ist
es wichtig, dass die Datei danach *nicht* umbenannt/verschoben wird - der Update-Mechanismus
ersetzt sie an genau diesem Pfad.
