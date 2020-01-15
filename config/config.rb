require 'date'
require 'yaml'
module Pflegedienst
  PUNKTWERT=0.049
  PUNKTWERTSTEIGERUNG=0.02
  INVESTITIONSPAUSCHALE=0.025
  AUSBILDUNGSUMLAGE=0.02
  STARTDATUM=DateTime.parse("1.8.2020")
  ZIELGROESSE=100
  VORNAMEN = YAML.load_file("./config/vornamen.yml").split(" ")
  NACHNAMEN = YAML.load_file("./config/nachnamen.yml").split(" ")
end
