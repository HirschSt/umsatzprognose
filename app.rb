class App
  
  def self.main
    kx = []
    salden = [%w(MONAT ANZAHL_KUNDEN BETRAG UMLAGE SUMME)]

    CSV.parse(File.read("./kunden.csv"), headers: true).each do |e|
      id = e["ID"]
      von, bis = e["ZEITRAUM"].split("-")
      kx << ::Kunde.new(id, e["NAME"], e["PROFIL"].to_i, DateTime.parse(von), DateTime.parse(bis))
    end
    
    monate = (0..35)
    monate.each do |m|
      monatsabrechnung = [%w(MONAT NAME ANZAHL LEISTUNG LEISTUNGSID GESAMTPUNKTZAHL BETRAG UMLAGE SUMME)]
      rechnungen = {}
      monatsdatum = (DateTime.parse("1.8.2020") >> m)
      datum = monatsdatum.strftime("%d.%m.%Y")
      kundenanzahl = 0
      kx.each do |k|
        if k.aktiv?(datum)
          kundenanzahl += 1
          rechnungen.merge!({k.name => k.monatsrechnung(datum)})
        end
      end
      rechnungen.each do |k,v|
        v.each do |posten|
          monatsabrechnung << posten.to_a
        end
      end
      CSV.open("./export/monatsabrechnungen/#{monatsdatum.strftime("%Y-%m")}.csv", "w") do |csv|
        monatsabrechnung.each do |e|
          csv << e
        end
      end

      gesamt = ::Rechnung.monatsabrechnung(rechnungen.values.flatten) 
      salden << [datum[3..-1],kundenanzahl,"#{gesamt.betrag.round(2).co} €", "#{gesamt.pauschale.round(2).co} €","#{gesamt.summe.round(2).co} €"]
    end

    CSV.open("./export/salden.csv", "w") do |csv|
      salden.each do |e|
        csv << e
      end
    end

    CSV.open("./export/preisliste.csv", "w") do |csv|
      csv << %w(NUMMER NAME PREIS)
      ::Leistung.Preisliste.each do |e|
        csv << e
      end

    end
  end

end