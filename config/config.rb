require 'date'
require 'yaml'
require 'csv'
module Pflegedienst
  PUNKTWERT=0.049
  PUNKTWERTSTEIGERUNG=0.02
  INVESTITIONSPAUSCHALE=0.025
  AUSBILDUNGSUMLAGE=0.02
  VERLAUF= CSV.parse(File.read("./config/verlauf.csv"), headers: true)

  #Automatisch generierte Werte von Verlaufstabelle
  STARTDATUM=DateTime.parse(VERLAUF.to_a[1][0])
  LAUFZEIT=VERLAUF.to_a.size - 1
  ZIELGROESSE=VERLAUF.to_a[VERLAUF.size][1].to_i

  VORNAMEN = YAML.load_file("./config/vornamen.yml").split(" ")
  NACHNAMEN = YAML.load_file("./config/nachnamen.yml").split(" ")
  # Anzahl der Kunden mit Vertragsende vor Laufzeit
  VOLATIL = 25
end
