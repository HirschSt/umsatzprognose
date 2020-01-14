class Rechnung

  attr_accessor :betrag, :pauschale, :monat, :summe, :name
  def initialize(postenliste)
    @betrag = postenliste.map{|e| e.betrag}.sum
    @pauschale = postenliste.map{|e| e.pauschale}.sum
    @monat = postenliste.first.monat
    @summe = betrag + pauschale
    @name = postenliste.first.name
  end

  def self.monatsabrechnung(rechnungen)
    betrag = rechnungen.map{|e| e.betrag}.sum
    pauschale = rechnungen.map{|e| e.pauschale}.sum
    monat = rechnungen.first.monat
    summe = betrag + pauschale
    return OpenStruct.new({betrag: betrag, pauschale: pauschale, monat: monat, summe: summe})
  end
end
