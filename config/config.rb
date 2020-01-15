require 'date'
require 'yaml'
module Pflegedienst
  PUNKTWERT=0.049
  PUNKTWERTSTEIGERUNG=0.02
  INVESTITIONSPAUSCHALE=0.025
  AUSBILDUNGSUMLAGE=0.02
  STARTDATUM=DateTime.parse("1.8.2020")
  ZIELGROESSE=100
  NAMEN = YAML.load_file("./config/namen.yml")
end
