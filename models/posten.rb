class Posten

  attr_accessor :monat, :betrag, :pauschale, :leistungsid, :leistungsname, :anzahl, :name, :summe, :gesamtpunktzahl

  def initialize(monat, betrag, leistungsid, leistungsname, anzahl, name, gesamtpunktzahl)
    @monat = monat
    @betrag = betrag.round(2)
    @leistungsid = leistungsid
    @leistungsname = leistungsname
    @anzahl = anzahl
    @pauschale = ((@betrag * Leistung.CONST["investitionspauschale"]) + (@betrag * Leistung.CONST["ausbildungsumlage"])).round(2)
    @summe = (@betrag + @pauschale).round(2)
    @name = name
    @gesamtpunktzahl = gesamtpunktzahl
  end


  def self.Rechnung(postenliste)
    return Rechnung.new(postenliste)
  end

  def to_s
    "#{monat.strftime("%m/%Y")} #{name} | #{anzahl}x #{leistungsname}(#{leistungsid}): #{betrag}€ + umlagen #{pauschale}€ = SUMME #{summe} Gesamtpunktzahl: #{gesamtpunktzahl}"
  end

  def to_csv
    CSV.generate do |csv|
      csv << self.to_a
    end
  end

  def to_a
    [monat.strftime("%m/%Y"), name, anzahl, leistungsname, leistungsid, gesamtpunktzahl, "#{betrag.to_f.co} €", "#{pauschale.to_f.co} €", "#{summe.to_f.co} €"]
  end
end
