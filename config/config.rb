require 'date'
require 'yaml'
require 'csv'

module Pflegedienst
  PUNKTWERT=0.049
  PUNKTWERTSTEIGERUNG=0.02
  INVESTITIONSPAUSCHALE=0.025
  AUSBILDUNGSUMLAGE=0.02
  VORNAMEN = YAML.load_file("./config/vornamen.yml").split(" ")
  NACHNAMEN = YAML.load_file("./config/nachnamen.yml").split(" ")
  # Anzahl der Kunden mit Vertragsende vor Laufzeit
  VOLATIL = 25
end
