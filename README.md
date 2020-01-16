# Umsatzprognose
### Software für die Umsatzprognose eines ambulanten Pflegedienstes

Kurzbeschreibung: Das Programm nutzt Kennzahlen aus der Konfigurations-Datei und Verknüpft diese mit einer Verlaufstabelle. 

## 1. Konfiguration
### 1.1 Verlaufstabelle
Die Verlaufstabelle sieht ungefähr so aus:

DATUM	| ANZAHL
---|---
01.08.2020 | 14
01.09.2020 | 24
01.10.2020	| 26

Anzahl meint die Anzahl der Kunden des jeweiligen Monats.

### 1.2 Kennzahlen
Kennzahlen (z.B. Punktwert) werden in der Konfigurationsdatei config/config.rb definiert, z.B.
```ruby
module Pflegedienst
  PUNKTWERT=0.049
  PUNKTWERTSTEIGERUNG=0.02
  INVESTITIONSPAUSCHALE=0.025
  AUSBILDUNGSUMLAGE=0.02
  VERLAUF= CSV.parse(File.read("./config/verlauf.csv"), headers: true)
  #...
end
```
### 1.3 Kundenprofile
Kunden werden automatisch anhand der Verlaufstabelle generiert. Dabei werden die Kunden per gewichteten Zufall mit Kundenprofilen verknüpft, die in der Datei config/profile.yaml definiert werden. Ein Eintrag sähe z.B. so aus:
```yaml
1:
  name: Einfach
  leistungen:
  - id: 1
    schema: [0,1,2,3,4,5,6]
  - id: 17
    schema: [0,1,2,3,4,5,6]
  - id: 30
    anzahl: 1
  - id: 20
    schema: [0,1,2,3,4,5,6]
```
Schema meint hier das Wochenschema einer Pflege, mit Sonntag=0. Das Schema [1,6] definiert z.B. die Wochentage Montag und Samstag.

### 1.4 Leistungskatalog
Definitionen von Leistungen werden im Unterverzeichnis leistungen/ definiert. Beispiel eines Eintrages:
```yaml
1:
  leistungskomplex: 1
  name: Kleine Körperpflege 
  punktzahl: 260
```

## 2. Ausführung
Das Programm wird als Ruby-Skript mit dem Befehl
```bash
ruby start.rb
```
gestartet. Dabei wird der Unterordner export/ mit Tabellendaten gefüllt. In der Datei umsatz.csv steht der Umsatz etc.

Die Datei app.rb enthält die Ablaufroutine.

Mit 
```console
local/dadimo:~$ ./startcli
```
kann eine interaktive Konsole gestartet werden.

