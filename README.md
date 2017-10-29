<!-- @author Niklas Portmann -->
# Forum-INF16B

## ER-Schema

![ER-Schema](https://i.imgur.com/BoJxF6s.png) 

<!-- @author Carsten Hagemann, Morten Terhart -->
## MySQL Dump
Die Datenbank wurde mit MySQL Community Sever Version 5.6.37 exportiert, diese kann von der
[offiziellen MySQL-Seite heruntergeladen werden](https://dev.mysql.com/downloads/mysql/5.6.html#downloads).
Der MySQL JDBC Connector Version 5.1.44 wird auch benötigt und kann
[hier](https://dev.mysql.com/downloads/connector/j/5.1.html) heruntergeladen werden.

<!-- @author Morten Terhart -->
## Installation und Kompilierung

### Voraussetzungen
Um das Forum des Kurses INF16B starten zu können, wird ein funktionsfähiger Apache Tomcat (Version 8.0
oder neuer) vorausgesetzt. Außerdem wird eine Java 8 Laufzeitumgebung erfordert.

### Installation
Das Projekt kann über GitHub oder mithilfe des Befehls

```text
$ git clone git@github.com:FW97/Forum-INF16B.git [$TOMCAT_HOME/webapps/Forum-INF16B]
```

heruntergeladen werden und muss anschließend als weiterer Ordner in das Verzeichnis `webapps/`
der Tomcat-Installation verschoben werden. Dies kann auch direkt mit dem Clone-Befehl erreicht
werden, indem man das zu erstellende Verzeichnis direkt hinter der URL angibt (z.B.
`$ git clone git@github.com:FW97/Forum-INF16B.git webapps/Forum-INF16B`). Das zusätzliche
Argument bewirkt, dass das Verzeichnis erstellt und das Git-Repository dort hinein heruntergeladen
wird.

### Kompilierung
Nun müssen die Java-Klassen unter `WEB-INF/src` kompiliert werden und die Paketstruktur in `WEB-INF/classes`
abgelegt werden. Aus diesem Grund befinden sich im Hauptverzeichnis zwei Kompilierungsskripte, die dies
einfach übernehmen können.

#### Windows
Falls Sie einen Windows-Rechner benutzen, verwenden sie das Batch-Skript `BuildForum.bat`. Öffnen Sie
zuerst das Kommandozeilenprompt `cmd.exe` oder die Windows Powershell (beide können nach einer einfachen
Suche vom Startmenü aus gestartet werden (oder fragen Sie Cortana danach)). Dann wechseln Sie in
dieses Projektverzeichnis und führen

```batch
C:\...\Forum-INF16B> BuildForum.bat [-h | --help]
```

auf der Befehlszeile aus. Nun wird das Skript sämtliche Dateien, die sich in `WEB-INF/src` befinden,
kompilieren und als Paketstruktur in `WEB-INF/classes` ablegen. Außerdem zeigt es die Fehler an
und gibt eine Zusammenfassung mit den Ergebnissen aus.
Über die Option `--help` können Sie eine kurze Erklärung des Skriptes abrufen, sollten Sie Hilfe brauchen.

#### Linux / MacOS
Falls Sie hingegen Linux oder MacOS benutzen, ist das Shell-Skript `BuildForum.sh` für Sie geeignet.
Öffnen Sie Ihre Shell und wechseln Sie auf der Befehlszeile in das Verzeichnis mit diesem Projekt.
Geben Sie dann den Befehl

```bash
$ ./BuildForum.sh [-h | --help]
```

ein und führen ihn aus, um das Skript zu starten. Es wird die Quelldateien automatisch kompilieren
und in den Ordner `WEB-INF/classes` legen und zuletzt eine Zusammenfassung über die Ergebnisse liefern.
Über die Option `--help` können Sie eine kurze Erklärung des Skriptes abrufen, sollten Sie Hilfe brauchen.


## Manuelle Kompilierung

Falls erforderlich, kann die manuelle Kompilierung mit dem Kommando

```text
.../WEB-INF:$ javac -cp "lib/*:classes" -encoding "UTF-8" -d classes -Xlint:static src/*.java
```

abgeschlossen werden, während unter `classes` gleichzeitig automatisch die Paketstruktur vom `javac` angelegt wird.
Für den Befehl wird vorausgesetzt, dass man sich auf der Kommandozeile im Verzeichnis `WEB-INF` befindet.

---

**HINWEIS**

Das Verzeichnis `WEB-INF/classes` wird selbst nicht im Versionskontrollsystem registriert.

---


## Verzeichnisstruktur
Die Ordnerstruktur ist zum Teil vom Apache Tomcat für Projekte vorgeschrieben (z.B. `META-INF` und `WEB-INF`)
und notwendig, um Klassen zu finden und Bibliotheken einzubinden. In unserem Projekt sieht sie wie folgt aus:

```text
- META-INF/        # Ordner für Manifestdatei (allgemeine Informationen zum Java-Projekt und Ausführung)
- WEB-INF/         # Quelldateien und Bibliotheken
   \
    - classes/     # kompilierte Java-Klassen in Paketstruktur (automatisch vom javac angelegt)
    - lib/         # externe importierbare Bibliotheken
    - src/         # Verzeichnis für Java-Quellcode (Klassen)
- css/             # Sämtliche Style-Definitionen als CSS
- img/             # Bilder für die Website
- jsp/             # JSP-Seiten und Services
   \
    - services/    # Ort für Web-Services in JSP
- test/            # Testprogramme
- .gitignore       # Projektweite Ignorierliste für Git
- BuildForum.bat   # Batch-Skript zur automatischen Kompilierung für Windows
- BuildForum.sh    # Shell-Skript zur automatischen Kompilierung für Linux/MacOS
- README.md        # Die Beschreibung des Projektes
- forum.sql        # SQL-Skript zur Initialisierung der Datenbank
- index.jsp        # Startseite
```

Nach Möglichkeit sollte diese Ordnerorganisation von jedem Projektteilnehmer weitgehend eingehalten werden, damit
alle auf demselben Stand mit den gleichen Bedingungen arbeiten können. Dies trägt auch wesentlich dazu bei, Serverfehler
zu vermeiden oder bei anderen auszulösen.

Bitte nicht den Ordner `WEB-INF/classes` hier hochladen, da dort lediglich der Bytecode der Java-Klassen liegt,
welcher nur lokal benutzt werden muss.

**Autoren: Niklas Portmann, Carsten Hagemann, Morten Terhart**
