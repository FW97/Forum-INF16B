# Forum-INF16B

## ER-Schema

![ER-Schema](https://i.imgur.com/5pgEunI.png) 

## MySQL Dump
Die Datenbank wurde mit MySQL Community Sever version 5.6.37 exportiert, diese kann von der
[offiziellen MySQL-Seite heruntergeladen werden](https://dev.mysql.com/downloads/mysql/5.6.html#downloads).

## Installation und Kompilierung
Um das Forum des Kurses INF16B starten zu können, wird ein funktionsfähiger Apache Tomcat (Version irrelevant)
vorausgesetzt. Das Projekt kann über GitHub oder mithilfe des Befehls

```text
$ git clone git@github.com:FW97/Forum-INF16B.git [$TOMCAT_HOME/webapps/ROOT]
```

heruntergeladen werden und muss anschließend als ROOT-Projekt in das Verzeichnis `webapps/` der Tomcat-Installation
verschoben werden. Hierbei ist anzumerken, dass der bestehende Ordner `ROOT` (in `$TOMCAT_HOME/webapps`) überschrieben
werden sollte, da es ansonsten zu Konflikten mit Pfadangaben und URLs kommen könnte.

Nun müssen die Java-Klassen unter `WEB-INF/src` kompiliert werden und die Paketstruktur in `WEB-INF/classes`
abgelegt werden. Falls es letzteren Ordner noch nicht gibt, muss er dort erstellt werden. Am einfachsten kann
die Kompilierung mit dem Kommando

```text
.../WEB-INF:$ javac -cp lib -d classes src/*.java
```

abgeschlossen werden, während unter `classes` gleichzeitig automatisch die Paketstruktur vom `javac` angelegt wird.
Für den Befehl wird vorausgesetzt, dass man sich auf der Kommandozeile im Verzeichnis `WEB-INF` befindet.

Das Verzeichnis `WEB-INF/classes` wird selbst nicht im Versionskontrollsystem registriert.


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
- README.md        # Die Beschreibung des Projektes
- forum.sql        # SQL-Skript zur Initialisierung der Datenbank
- index.jsp        # Startseite
```

Nach Möglichkeit sollte diese Ordnerorganisation von jedem Projektteilnehmer weitgehend eingehalten werden, damit
alle auf demselben Stand mit den gleichen Bedingungen arbeiten können. Dies trägt auch wesentlich dazu bei, Serverfehler
zu vermeiden oder bei anderen auszulösen.

Bitte nicht den Ordner `WEB-INF/classes` hier hochladen, da dort lediglich der Bytecode der Java-Klassen liegt,
welcher nur lokal benutzt werden muss.
