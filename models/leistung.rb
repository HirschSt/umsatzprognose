require 'yaml'
class Leistung

  def self.Grundpflege
    YAML.load_file('./leistungen/grundpflege.yml')
  end

  def self.Behandlung
    YAML.load_file('./leistungen/behandlung.yml')
  end

  def self.Igel
    YAML.load_file('./leistungen/igel.yml')
  end

  def self.BEL
    YAML.load_file('./leistungen/bel.yml')
  end

  def self.Pauschale
    YAML.load_file('./leistungen/pauschale.yml')
  end

  def self.Gesamt
    res = {}
    res.merge!(self.Grundpflege)
    res.merge!(self.Behandlung) 
    res.merge!(self.Igel)
    res.merge!(self.BEL)
    res.merge!(self.Pauschale)
    return res
  end

  def self.PUNKTWERT(startdatum, year)
    pw = Pflegedienst::PUNKTWERT * (1 + (((year.year - startdatum.year)) * Pflegedienst::PUNKTWERTSTEIGERUNG))
    (pw * 1000).round(2)/1000.0
  end

  def self.Katalog
    self.Gesamt.sort.each do |e|
      string = "#{e[0]}.#{e[1]["name"]}"
      if e[1]["leistungskomplex"]
       string += " LK #{e[1]["leistungskomplex"]}"
      end
      puts string
    end
    return nil
  end

  def self.Preisliste
    res = []
    self.Gesamt.sort.each do |e|
      if e[1]["punktzahl"]
        preis = (e[1]["punktzahl"] * Pflegedienst::PUNKTWERT).to_f
        preis += ((preis * Pflegedienst::INVESTITIONSPAUSCHALE) + (preis * Pflegedienst::AUSBILDUNGSUMLAGE)).round(2)
        res << [e[0], e[1]["name"], "#{preis.co}€"]
      elsif e[1]["preis"]
        res << [e[0], e[1]["name"], "#{(e[1]["preis"]).to_f.co}€"]
      end
    end
    return res
  end



end
